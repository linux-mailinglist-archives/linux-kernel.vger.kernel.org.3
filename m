Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B457E6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiGVTCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:02:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BAA0245
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:02:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w12so6863080edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avUZAWhiQeTD+s8eqp0tD4ouniDUp1tW0xSwM3iWcgw=;
        b=LQvK3/tRTOcgvuVGh+M5/GehEEKi8faPfo/xJ6f9D43mmpKXwOaISdjz4xj7ofQ3yW
         nPB0jd/IGzNmmADKc5f/o8Z1yT3yJ4Ca3eSheu30Eeovk4IgF8opO+bA5YqMns9iiHfR
         WMJs/ryDGoq7evSTWEfckh14Ncv8IdNXpgMI9u6EJSwT7BzPgKPloTVj3HFFgeZvQmYU
         e7nW2VAIZGhmkFVSt0X5l5kmtmuporEn8F86CAraj11WA4xluBQ1+iXMZ2A2ycS+rcv7
         Df9OlLO/B/s+Fo55AAmrAiuWWwOFeveMF6OGRk1yl4jArlzvpo39JhK5fc1Fvg3aqT/c
         b4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avUZAWhiQeTD+s8eqp0tD4ouniDUp1tW0xSwM3iWcgw=;
        b=jc2+vYbAPY8qAGk3uRG7Y/tvyCZE0NMo5Vfk23O9xZTkzbkM7Z4kNLxBkBemUa5Zok
         wKvLgDxUxbTdYi3IQR3NHmmSm5JZLfM2wcmUHsR0FdJRlQiKFjxfx1NRFbuQShiQWj1R
         ZWvp3z2LDvlzXDMzvpRrkNFw3Ag/ozXaXi/LLe1aOe0zrO+fYmWbJUHKyf5/M7lUD7iK
         0HidxURCesyZcPBtuFYPrA5b/PZ/+255d/OUjWQ+fbCo/ogNh8MJuYTx1i+XDvwEV32n
         Am0SLQyNC2Okj2Ifpo0QUANobc4M5G1SS0DhkejXBGh7Bb+fUgr4QCd7YjoTMQ0hWGHI
         vqvw==
X-Gm-Message-State: AJIora8aaPoyI4KDLBMZq8yMEHJ//UToDCh38+dbUWSwt8kUsORebZBs
        ak0DGy2pHQem1ll5/eWHllUHlQ43zwq4gqXQW1Y=
X-Google-Smtp-Source: AGRyM1vcdXkBOl/stulqTvLKIOZCE184bWWQit0ItjjwTNQf2Kc3Skz6cCZYUoQ9QmLUBeWNcN0z7ZoFi4KRjDqiH38=
X-Received: by 2002:a05:6402:d0a:b0:437:f9a1:8493 with SMTP id
 eb10-20020a0564020d0a00b00437f9a18493mr1289163edb.226.1658516549449; Fri, 22
 Jul 2022 12:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220721060946.46462-1-slark_xiao@163.com>
In-Reply-To: <20220721060946.46462-1-slark_xiao@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Jul 2022 15:02:17 -0400
Message-ID: <CADnq5_PXyhGrU-XixQqDv+mdNU0rAqnGsVp2b_tfu=7h0COihA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix typo 'the the' in comment
To:     Slark Xiao <slark_xiao@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Jul 21, 2022 at 3:26 AM Slark Xiao <slark_xiao@163.com> wrote:
>
> Replace 'the the' with 'the' in the comment.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>  drivers/gpu/drm/amd/include/atombios.h    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index ff659d4f772b..8adeb7469f1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -47,7 +47,7 @@
>   * for GPU/CPU synchronization.  When the fence is written,
>   * it is expected that all buffers associated with that fence
>   * are no longer in use by the associated ring on the GPU and
> - * that the the relevant GPU caches have been flushed.
> + * that the relevant GPU caches have been flushed.
>   */
>
>  struct amdgpu_fence {
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index 1f9df4e7509b..15943bc21bc5 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -3255,8 +3255,8 @@ ucMaxNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of  t
>  ucMinNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of the value for the min voltage.Set this one to 0x00 if VC without PWM or no VC at all.
>
>
> -usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
> -usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
> +usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
> +usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
>  */
>
>
> --
> 2.25.1
>
