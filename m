Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62E4D8F95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245612AbiCNWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiCNWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:31:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B23E5CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:30:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id u61so33703391ybi.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlBHR6usH1gSHtmofP4iSUiv99gPnLLBTvpyEYcoxh4=;
        b=MvZ5uReWaLRuWb0aH67AkF8JXHm7LrqmDeZ87wUAEhFFqRt4AtOVbqoF7LXc4pck9C
         x/XcAXC6IUmfpQ3WpMrQjy48OPWQq0hR71Eydu9NZL/t8rCnaW2QkAZ5ObBUae/kJkpZ
         GTz4pUarx7Es/H9FYJWZoMiHHoIitGnXQ7fMyRhvBXYGQYub7QfSA12MGB5TT7qKDkV2
         /esAqJbA+TTWuD08RAVUg94hta61Z06RKT0HyVR3RzaCAHk7ppzA2+cFoIQnTotmqNXI
         rpE7L17xwj9XtaKWdiYtiZaqy3hNvQZvIQr/S1aIBX+yQGjbLvVww1yZ39Xqihkj0HPs
         kqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlBHR6usH1gSHtmofP4iSUiv99gPnLLBTvpyEYcoxh4=;
        b=M9XdlpDJL6gWgvGW46WnHo6LtuYCqRLppS4XC6OBiFcXqQ6ANMpXOd6tFFZwMsUa8p
         kO/1Tbz4Ml30QvAv0YNAgHuiqvmoW4pLJ8wZx9PJRGb2gCadAuJMVftg0OigdNa6vlea
         bgBgBimzBymLOjrRvBTE/uYcyBmxBRlwmNV/qimpAEokAXNom71auOYHSWwq4xGwr1nr
         epa2AMuoxAT9jD6H4xyJGg/nYDvAy76B/rmkhKwCHh/piCT+kIc6t8C2t78IvtgXe0Gp
         UVw9yUALMcq2CxBKtiEtZwxBbn6KH02ciMoJSK/41TcmAfdMRQdu3ydrCVHWjtT2GVeI
         sZfQ==
X-Gm-Message-State: AOAM532EA1Y3j6+PsowqbzD+k3P5o0lj1DYbN5caNvZnxoURSKCzeBgt
        FQbtneR8hX8PdAQUvgy5q9aLMKkZdwipVkVF1kVOBg==
X-Google-Smtp-Source: ABdhPJw4ajnPMAp2l22VE4wgnTHI7XHy1g/O2oEHoRMaFMihH5016jGC2cLdkd8irDT+QCje4jTuRpl7cLtaWwFyAtQ=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr20723906ybs.533.1647297033601; Mon, 14
 Mar 2022 15:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220311145209.17346-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220311145209.17346-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:30:22 +0100
Message-ID: <CACRpkdbjy2Cpzs7j6=iWw+wnJxBHkaxgcO2SOx6DeTLeF4ogPw@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500: clean up definitions in header after debugfs removal
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 3:52 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 3d4d1266597c ("mfd: ab8500: Drop debugfs module") removes the config
> AB8500_DEBUG in drivers/mfd/Kconfig, but missed a reference to this config
> in include/linux/mfd/abx500/ab8500.h.
>
> The functions ab8500_dump_all_banks() and ab8500_debug_register_interrupt()
> in the ab8500 header, previously with definitions conditioned on
> AB8500_DEBUG, are now completely needless to define and handle at all.
>
> The function ab8500_debug_register_interrupt() is not used at all and can
> just be removed.
>
> The function ab8500_dump_all_banks() is just registered in the abx500_ops
> struct in the dump_all_banks field, but this is then not further referenced
> anywhere else at all. So, safely drop the dump_all_banks field from
> abx500_ops and delete the ab8500_dump_all_banks() definition.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Linus, Lee, please pick this clean-up on top of the commit above.

With Lee's requested one-character fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
