Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1B59AEB6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbiHTOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbiHTOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 10:36:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703A4E613
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:36:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3321c2a8d4cso188842647b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TZVv6t/Vb50UGFw4xrEvLnKQQHc/AlCgbJyFx+UnJqE=;
        b=cGICaOE/bOr2oM0atOdLA9KTFAOhyW+1lHEZwl2kkxFa3MLPRJQsXq16Dg3NgvnDjt
         lBOA51KpZbhSIMgdg0LN3clVYiyYLj3aTae7ZRYSjv3fvGbmn9pC2RQau3cMxw9jzYna
         bJM3Ttxbhx3MdCRyfdmY68P9t0TTwQeuCdw3mlTbtX5z0lj+XAcXaGWUwMv+13QTIPe2
         e1E5WprAKL2uSFU77p629z21i76Y8KyZPkmM0tN49iwday+3MbUMEeUkISbBH1nv4MVO
         +ElqbU8Dlt6xKAnmw+tACxXFmIefDGsL+LdefANKg1KgnOZL0piAcRpLP6x4ABsgNuhQ
         eHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TZVv6t/Vb50UGFw4xrEvLnKQQHc/AlCgbJyFx+UnJqE=;
        b=3c3p3Sb9Cpp6n29IqmeasWcY6R65XykeXaVmkHn4n/A7Ws2Y24OKQY4tOHyES7D74z
         gjAZoGRQt8gFWPdO5vSkDLh6FdoeNaQE6spRR1ALJEK/M3SoAKcV7l+ANj77wtKxe4rT
         Cfx//sBqITPLXyMgz3nYuXKGxpA8XsJyrbmDjpakG808hqDe4+EuUl3Iy8bydzT40ni7
         jzlvtykbD8Xsa3ycfRT7XaHRtrrG9jx1vJAEWEBIhll3ZpEQHbN/+TCjAUfAMjcVUlj2
         avVxe/uvw668Xe3h7Zw4JptYIQD8Mz0djGRdY5iudM9cBoKEN4T+BKOK8KHeSO70W6Lc
         xcqw==
X-Gm-Message-State: ACgBeo0SxcHlJjTLn40Q8lhEO6+pRr64cqvf1Hdi6tL+g11jGzHziiTD
        ac2bQrsW389EI8kKRDNsDiPfBqDkFNHBonLaKYk=
X-Google-Smtp-Source: AA6agR5+SUbdeY4HNkDjvLbuHYOCjU4m86Q1e/NPaMcn3cOS8nUx1XqdEddQ0bbLe8WWs0m1racOsm2b4HSgLD/U1kE=
X-Received: by 2002:a81:7c5:0:b0:338:8d4d:41ca with SMTP id
 188-20020a8107c5000000b003388d4d41camr6173755ywh.393.1661006161685; Sat, 20
 Aug 2022 07:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <202208200447.kdEhBy9a-lkp@intel.com> <cover.1660977535.git.namcaov@gmail.com>
 <63626444-a7ee-a0c4-ec0a-f44a810e25ea@redhat.com>
In-Reply-To: <63626444-a7ee-a0c4-ec0a-f44a810e25ea@redhat.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Sat, 20 Aug 2022 16:35:50 +0200
Message-ID: <CA+sZ8B8ouMSMmArTVzbkqeWQx4Zqg2=gPaviTrkOFvBoswv_Jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] remove useless files
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     lkp@intel.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
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

Hi

On Sat, Aug 20, 2022 at 2:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> Patch 1/4 seems to be missing?

Patch 1/4 is there:
https://lore.kernel.org/linux-staging/46d73e331bae2192a328f6691763f39ea6c18b08.1660977536.git.namcaov@gmail.com/

>
> Also please squash patches 3 and 4:
>
>    staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
>    staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
>
> together. Ion other words remove both the files and the Makefile
> target in a single patch please.

Sorry but I am not sure what I am supposed to do with kernel test bot.
I agree that it makes sense to squash these 2 commits together. However,
I separated them because I want to have 1 patch addressing the problem reported
by the bot, so that I can put the "Reported-by" line to this patch.

If I squash them, should I still put in the "Reported-by" line, despite the
commit not exactly fixing the reported error. Or should I just leave it out?

>
> Regards,
>
> Hans
>

Thanks for spending time reviewing.

Best regards,

Nam
