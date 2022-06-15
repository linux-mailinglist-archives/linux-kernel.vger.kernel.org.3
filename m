Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7154C68D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiFOKyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiFOKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:54:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE0B522CC;
        Wed, 15 Jun 2022 03:54:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so22419155ejk.5;
        Wed, 15 Jun 2022 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvMKd4KKRKUMir0Cr403t8MbrCd1Ebi5CzetpJyqwmk=;
        b=ZNvLP6IHrqVdFY3IjQ/DXgKkdf/o6QPFiEhs9XBpiDx/cg+mFrkcEY2/wj4q7Yjy7Q
         NQZKPEhh1bfnic6ztJsfARTmk5XkQznDD6ixRqviVECVIBZeN+p3NySev8u1Nvn3iLXy
         aBa6suCcTktw0V6DewfH+zfxdKcR/XvWIvT8qHdM1DxPilxbscG0g/iXCe5Hyjdij5tb
         L/zsIYL+9whzJ04F8rcFhNlwOk1C0WJ2NndUyEEgf2UCC/8/W/kV8BukZwViai0SKBnY
         Fe8JILq424z/wNbtR/g1KVAT5Tut7Tgy1QCop9Y1LjxmxtPRk6MY8IR9O0dtGmSPb3rV
         wOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvMKd4KKRKUMir0Cr403t8MbrCd1Ebi5CzetpJyqwmk=;
        b=ezxbIu4yOWJIn6ftXE94NxZUwFq1ix6bts6DOc+YoAA0OSroyq+6gpypwpeY40Syzi
         jKYcNRYyHIt67lI+u705oQJikd7ryPMmz38AJ/auRSm01UZlQRKeTW6pe1bT3cH2vxXH
         6c78OYNjFQCytt4X3qDSe/ct8/2PQnwC0lihHqOIt66NoemvqT09F05lQ3h3D9penlD7
         MrgLrPChyqhbn599PFhfhUICkH663gZjf4B6JdRL4yPL0BL5+OV03CJTghTdBKp5+Sry
         AMKgKTnyO8Q1RoZwxUaiUGaCHjaOj15xlDcH7lgQghk71x5Mpwy8hZk/I/i3R9+5b3E8
         dxmw==
X-Gm-Message-State: AOAM530vHjpAWLFSVivG/A29tviB/IGsljLqvBpDKTwJqQOhHavKS3l6
        23RIxqh8RUOOWAmNLHgdwdxpHrfw8mgVQgGRGBrHl0RWXoNUTg==
X-Google-Smtp-Source: AGRyM1sfDJWK0pt/4Gdwh45Wsy2UAp27zdAMS37AdAo5twCBdpgKzBsztxZO7KUaHq9wCFPtSHHeSyqQoEpWnqzEfqo=
X-Received: by 2002:a17:906:a202:b0:711:29a:c96c with SMTP id
 r2-20020a170906a20200b00711029ac96cmr8495653ejy.407.1655290471155; Wed, 15
 Jun 2022 03:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
In-Reply-To: <20220612090507.20648-3-stefan.seyfried@googlemail.com>
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
Date:   Wed, 15 Jun 2022 18:53:52 +0800
Message-ID: <CAPqSeKuubG0Q2BhsYz+MbLi_ViU97whTzwVaUQOf7OvLSb4bFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     stefan.seyfried@googlemail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending it due to reported spam. I forgot to turn off HTML
formatting. My bad.

Thanks for the patches.

> From: Stefan Seyfried <seife+kernel@b1-systems.com>
>
> commit ed83c9171829 broke the hotkeys on my Toughbook CF-51.
> I'm questioning the general validity of that commit, but as I only
> have a single machine to test, add a module parameter to allow making
> it work at runtime.

I can confirm that as soon as the hotkey_input option is enabled (at
least on my aged CF-W5) it reports the ACPI event twice. Unfortunately
it's the only machine I have for testing. Unless we have a bigger
sample base, making it a module_param is a safe choice.

Otherwise the patches look good to me.

Reviewed-by: Kenneth Chan <kenneth.t.chan@gmail.com>

--
Kenneth
