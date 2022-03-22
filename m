Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452934E4268
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiCVO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiCVO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:58:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE118A6F6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:57:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so36760153ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACAYSEDWD5ESysQrTVSpvpyNPWyQJYYphq3zGhfs3to=;
        b=F0ReZqpR0eJJZPfRXmhPfPYCxhdWLvBTWf7eDeWLT9YFSquqvtdNHw/ozPaJqFaDR9
         gmQM5CfhmW9wLZxMfAnahEQe2HP5+aaHoBax92QGuiJsWy9R6+CROEK0lfcH+ybs1Vnm
         8XQAGIJDgaKKzTbddoss7FjpTJFEAZoDR6VRhkefmZZPDF1xit626EYlBEoLipIS2jD1
         SzFpxP1OkMZ51M929ird0DSrUH90FNYDRKH1e271IfdNZuYFvJiSa6rjA4rPy7FndrJ+
         Rq7fmEVwG8L1DUZwYffdltMWeL8P2f1yDzkBXe4OSR+F+hNXXXL0gxbUwcDKwf1cEEjM
         QvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACAYSEDWD5ESysQrTVSpvpyNPWyQJYYphq3zGhfs3to=;
        b=VLYSEHfzQvHn/QETrBp65VSC1kUP/Ps3+2CJTzyqlMQZakLdC/+/TZDEJlojnjYT7J
         PQ8vY4RsB9/Gud1Qepx/s/DqL62vE3iUrNAQSDBH6M1FUbaJJNN7Q4lNYoSepdASOx/D
         K1IM8AnMREDFxMNf7a4akOR91WpKsu9gsQ1KBM8fhuCsbxyGRbyW9bS3vICatNudXB0V
         whVcs4n8B8B9n1vvPlGU1/ALE5MIqXuw/I96/m90UJBnfg7tXJzG+kehoCco2ilFM7pZ
         mvD3QbSPMj1rvJyw6+oXvuOvgt8XFMIuPc7vmbSzoRTsJLi6acoFXq45cqaUEE5DRsTg
         aH9Q==
X-Gm-Message-State: AOAM533A2gTbHei0ok1e/lDWfdtZzv6fTb3wHdoueqwW5N2Xfeyi8fv1
        APp1yuupEZcmt4O3q5Z2220EeoDe4kPReeUGLkNCXMo1RSI=
X-Google-Smtp-Source: ABdhPJxGpoDD8exbxrBLAL2GR7kH1USTNczC+C5/RJhxx+X8CsvaU7UFlUQyrXA/OHBAYTxz8GcGfhasnrDKwhxA1Ak=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr26321155ejc.132.1647961032695; Tue, 22
 Mar 2022 07:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220320064529.12827-1-sensor1010@163.com> <CAHp75VfkDbO3J=MgTdRF_UyMvZ9XCJEQcEOUEBuyqEwnrNwbsA@mail.gmail.com>
In-Reply-To: <CAHp75VfkDbO3J=MgTdRF_UyMvZ9XCJEQcEOUEBuyqEwnrNwbsA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:56:02 +0200
Message-ID: <CAHp75Vc5FZ-N68vDhyGhCObUdek6JFccotctH-C5KmZ_boL6Wg@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/brcmstb_gisb.c : Remove the
 suppress_bind_attrs attribute of the driver
To:     lizhe <sensor1010@163.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 4:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 22, 2022 at 12:41 AM lizhe <sensor1010@163.com> wrote:
> >
> > Even if platform_driver does not set suppress_bind_attrs attribute,
> > when registering with platform_driver_probe,  the value of
> > suppress_bind_attrs is still true, see __platform_driver_probe()
>
> Any reasons it can't be switched to builtin_platform_driver() macro
> and hence constification of the driver structure?

Ah, the patch that brought that assignment actually allows to built
the driver as a module, so, the correct patch would be to switch to
module_platform_driver() I suppose.

-- 
With Best Regards,
Andy Shevchenko
