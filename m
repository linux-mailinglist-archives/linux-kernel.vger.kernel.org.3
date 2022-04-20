Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729005081D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359627AbiDTHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiDTHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:18:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827633A70C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:15:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so1274776lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MODDWI+HfoPK9lIyAcgwx5GSaCBcVEwXRi8dUwmNBI=;
        b=IacOp5E5Javc2SmI5ta0K1OCZftmWFYKH0H6REUXcJo2Soa3mGtGqUuKFzSQx5dBfN
         kLOgC/fzWdzOK1VUQu+YZ0wbLGMvYXwBQc4vyy10bwCKGaawBQ93sk9Du17iyy6Dvi6b
         wX0zBecfgVvB6GllHNntMnAeKJNYZgNnRp6bgmQxRA56lHHZNM0CI+h5xTFDBNXTAze8
         8j1Bl5fhxGbb8oVgz/Bkl0QpA3ZZ/qEpRvetU8R6fgTAWg9pFw3m9qx/0zYXmpNgJoTC
         KpmP5+8ej0zq+JiaXiy7ZEZW5eiEJZC4BtA7BhpPJ5C2RINNiKNzC182Vcd/5rG0oPW2
         +tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MODDWI+HfoPK9lIyAcgwx5GSaCBcVEwXRi8dUwmNBI=;
        b=rAsFkPWlUndPmg4QUnlmgJPZGFI1EUvQpmnnD7Hn2v4Iqx1OZ3Gf17iHtIk7mVTUza
         WlimfTmawrPKRwCXcBEOKlqKpgBt/RTjvawVXkMdvnkViVH6V9iuixUTxG/vcxGmpMhd
         Y9VX8NWCjGoZY/477QzcI5gPWhlvqvwr7lNcHyqvE/QonzWJR+TYg93WwY8oFTzZ46VU
         EEO+A05DH1EzfdmJx3oJQ3xLUxWTzveLDOlBqSdIdjnGWz/R2BV1JAKRma0g+YbKHMSK
         a45LNssEZSHeQI8HNC36mEi9RhvvfJsScXn5xsy8Tt6QO/Fpvl+Up4ftHrZQ9oe5lZ2N
         EuWg==
X-Gm-Message-State: AOAM530TkBBcsajNNHVEfr0tgW40PPOBFHaqs/Zc1WRwYmp3lutx7FcB
        xQiyrhHf8QEdtd4l2WDhgZdbzKwdyXOGbNnFQWUgr2WVrgiuFw==
X-Google-Smtp-Source: ABdhPJz/Ij6MAIafqtcIpXVRbQAxzTDKxG9R2To0aKL+ku5TGGFx2Dv5EVFLTzNUBdrcnXB1vbTjUjeSCUZ3L6bOrl4=
X-Received: by 2002:a05:6512:b0b:b0:44a:f4a5:b519 with SMTP id
 w11-20020a0565120b0b00b0044af4a5b519mr14090877lfu.287.1650438948512; Wed, 20
 Apr 2022 00:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220418212016.2669086-1-jstultz@google.com>
In-Reply-To: <20220418212016.2669086-1-jstultz@google.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 20 Apr 2022 12:45:37 +0530
Message-ID: <CAO_48GEpCZbX9He+i8FKPb9_7B4_91NT+6DG4DQzgCes9j48EQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email address for John Stultz
To:     John Stultz <jstultz@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xinliang Liu <xinliang.liu@linaro.org>
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

Hello John,

fwiw, feel free to add my:

On Tue, 19 Apr 2022 at 02:50, John Stultz <jstultz@google.com> wrote:
>
> I've switched jobs, so update my email address in MAINTAINERS
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: John Stultz <jstultz@google.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..adb35fee2294 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5913,7 +5913,7 @@ R:        Benjamin Gaignard <benjamin.gaignard@collabora.com>
>  R:     Liam Mark <lmark@codeaurora.org>
>  R:     Laura Abbott <labbott@redhat.com>
>  R:     Brian Starkey <Brian.Starkey@arm.com>
> -R:     John Stultz <john.stultz@linaro.org>
> +R:     John Stultz <jstultz@google.com>
>  L:     linux-media@vger.kernel.org
>  L:     dri-devel@lists.freedesktop.org
>  L:     linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> @@ -6583,7 +6583,7 @@ F:        drivers/gpu/drm/gma500/
>  DRM DRIVERS FOR HISILICON
>  M:     Xinliang Liu <xinliang.liu@linaro.org>
>  M:     Tian Tao  <tiantao6@hisilicon.com>
> -R:     John Stultz <john.stultz@linaro.org>
> +R:     John Stultz <jstultz@google.com>
>  R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
>  R:     Chen Feng <puck.chen@hisilicon.com>
>  L:     dri-devel@lists.freedesktop.org
> @@ -8844,7 +8844,7 @@ F:        Documentation/devicetree/bindings/net/hisilicon*.txt
>  F:     drivers/net/ethernet/hisilicon/
>
>  HIKEY960 ONBOARD USB GPIO HUB DRIVER
> -M:     John Stultz <john.stultz@linaro.org>
> +M:     John Stultz <jstultz@google.com>
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
>  F:     drivers/misc/hisi_hikey_usb.c
> @@ -19782,7 +19782,7 @@ F:      drivers/net/wireless/ti/
>  F:     include/linux/wl12xx.h
>
>  TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
> -M:     John Stultz <john.stultz@linaro.org>
> +M:     John Stultz <jstultz@google.com>
>  M:     Thomas Gleixner <tglx@linutronix.de>
>  R:     Stephen Boyd <sboyd@kernel.org>
>  L:     linux-kernel@vger.kernel.org
> --
> 2.36.0.rc0.470.gd361397f0d-goog
>

Best,
Sumit.
