Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66058BBB3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiHGPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHGPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 11:51:11 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD871007
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 08:51:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id w6so4990736qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nkv33rM5bmdNEyiokQITMMenNJf0ZK/C1WG5jagJWl8=;
        b=qQTSaug/8ns4P1eNLWB3vLIRlvgIjNsNn1T76yNxmZUBo452XSihwv41+ExCQ48wig
         Z6de0hXvxexf02fVsyCAYaow7BwxEW+rCyGWgoOo06UOfnkvQ25ttE+PXLWiF/S2Olrb
         wI31+OEPtAtMDwHFBTfRUdVUjCVTrQRtcvou/jAkbjs6+Oll834xThEt1TGzTPVUKpLe
         PxaU3pxNxX/TCvVhIAGnNjkMGseWYKsCvcrC/YxabKTzMNrpv5HrFv8GAHiD/iBTjtkk
         K7XO875uYauESJTnhUCYmtsHLxeuNRZME0JEl1l1vXux3BPTsbbX82XyJklsiv0hiv1n
         aOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nkv33rM5bmdNEyiokQITMMenNJf0ZK/C1WG5jagJWl8=;
        b=WLl0cFBPUG5xKJld61qfqBibFStxQ0xMozO550Cm0lE1RGDDUHOgyNqXba69Sc3qO/
         Y03FASkhs+CNCrcG0q5r/uL9sQ6XbE9O9zZhsds3CXbcTwiTrMj1QXWcGHKqBz7nH8pu
         t6Q4nvIFKHSCCHTsDxM9cnI3tRjSf1+829vg8q0p3PKEFE5oKKRG3D4pqjW3ZYYvWbaj
         +miBgEMncvkXfFvdw+XHhR4ienuqrpn3PXzYki9NaN850bSRnhYcnbtG/bFL7vgTsNJK
         OX6xt4SHZjsxeC+TlGo6wqr5XH/umKqa88NbciYUr688gYRurwR8MljjA6ydurYOMrnH
         eyQA==
X-Gm-Message-State: ACgBeo3XVE3byL6E3ycSlkoLAcicr5HofI1rMZM4HRjxVxkxtEYDqeIc
        tcL+XxhVhPz/VGIzCXCa74jU07Yi9kSBmmnYVC0=
X-Google-Smtp-Source: AA6agR4pGvsasAQ2KVI6Zutq7/PZAbeJ4HpBX9gPPTSAJRHldpPcV+2NToynZ6OF4+IWYrAS8bNDWbFu0uqWeiLNrEc=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr11927322qkp.734.1659887469022; Sun, 07
 Aug 2022 08:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220807145247.46107-1-paul@crapouillou.net> <20220807145247.46107-12-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-12-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Aug 2022 17:50:32 +0200
Message-ID: <CAHp75Vf1jfgshfw1ymXu9AHrNy1SUmVRDvDLUYbYKFSrhQq44A@mail.gmail.com>
Subject: Re: [PATCH 11/28] mfd: intel_soc_pmic: Remove #ifdef guards for PM
 related functions
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
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

On Sun, Aug 7, 2022 at 4:53 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
>
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
>
> The advantage is then that these functions are now always compiled

is that

> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.

...

>  drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
>  drivers/mfd/intel_soc_pmic_core.c  | 8 +++-----

1. These are two different drivers, the patch needs to be split.
2. The Broxton Whiskey Cove should have a similar change. Which base
have you used for your patch? Please, rebase on top of for-mfd-next.
3. The PMIC core actually is Crystal Cove driver and I have a pending
series for that and I guess you know about it. Have you seen what have
been done there?

-- 
With Best Regards,
Andy Shevchenko
