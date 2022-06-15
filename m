Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7444F54C758
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiFOLW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbiFOLWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:22:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA945220;
        Wed, 15 Jun 2022 04:22:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n10so22557910ejk.5;
        Wed, 15 Jun 2022 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yS4AEQhVOxYtw9bkG8bQ5OUIdbAZ8lf4Xr7hDzTTOJM=;
        b=Ukb88aqEEeeeaHcbY7m5Yr493yWZYALiPv7J935rjlqmAkTRvWBSLWYid+GWmUtZay
         9qgRnoYrTB/T1cZVFUrYv+iPpMQQGHv1/DZkDWzbCKXxqoe9auDAOMubA9OoogE8Fcke
         h9eOcqRDKr339Mth5LsC8YXDbLmlAbpx3C1WTw068dDJJNn81mcHEa/kLF2bzVZ/YSDQ
         HP/K+L3oswilfZRHy9tjMktcoPBBxdjWKRJWcCoBTrVUbOcyvkxz1d7E3w+r3jEaOMxP
         NqEXRziLhZiDj/3GIO8YI8nZMaufL3i0vbRSfzlkkEKKW2Ky8N2y+ihLdgOg3HHAD/dJ
         T0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS4AEQhVOxYtw9bkG8bQ5OUIdbAZ8lf4Xr7hDzTTOJM=;
        b=z3jJ5fKIPg1gXLYkzVnRZbDoIC4CXC8GDNMWFSJaymOM9SfkfqT28ltQZrxLchgnxv
         01L2mlCiSzveOkjjo07xDtf7TOcW4MIXlmfuh/O4VWjNIqSej9T5LN3b2YgQrdzxBmjW
         NrpGNCnyyxgg5k1WnXxcBijQrgMyeQqrUmEojdehoj+XvDCIW12mIJDXks43eaEFvLon
         lCPoTwE5z8cV/SWBt+vWY+TJr3XJif6QDx7AHi6Ht/WFDEzZ8ivrZEStQ1i8GoPlTFll
         rJckCLIGZW0s0NYa0AmUfwdX6clpeFxlTKhDt8gb/o2lHFzlu4kvfv8BaPsCf+Ft7J5p
         WOUQ==
X-Gm-Message-State: AOAM530GeZDoZ61S6IDoltwECC7oIAECeTBKhihfyxVzK0mCjQR/FxWT
        BBkQgqIMKJG+G74qk51qwLSGlezojE+wjx8T6erm7j4YHU3OPg==
X-Google-Smtp-Source: ABdhPJwnjrX0McnQqoik8S22Pbe+lTRpbNgs0SpPLmlzTwjVkQ+QwjnzpUyYdGKwU1/RfSbNzO80TTZZZRgIndreomE=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr8469334eja.44.1655292144186; Wed, 15
 Jun 2022 04:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
In-Reply-To: <20220612090507.20648-3-stefan.seyfried@googlemail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 13:21:46 +0200
Message-ID: <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     stefan.seyfried@googlemail.com
Cc:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sun, Jun 12, 2022 at 3:54 PM <stefan.seyfried@googlemail.com> wrote:
>
> From: Stefan Seyfried <seife+kernel@b1-systems.com>
>
> commit ed83c9171829 broke the hotkeys on my Toughbook CF-51.

The commit

> I'm questioning the general validity of that commit, but as I only
> have a single machine to test, add a module parameter to allow making
> it work at runtime.

Thanks for the report and the fix, my comments below.

> +static bool hotkey_input;
> +module_param(hotkey_input, bool, 0644);
> +MODULE_PARM_DESC(hotkey_input, "Send all hotkeys to the input subsystem");

We usually add module options in very bad cases where it's very useful
for debugging or when some devices require the opposite settings while
can't be distinguished automatically. Here I do not see either of such
cases. Hence, I would prefer to see a DMI based quirk as it's done a
lot in the PDx86 drivers. Can you do that?

-- 
With Best Regards,
Andy Shevchenko
