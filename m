Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB95A3084
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344922AbiHZUh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbiHZUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:37:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40FDC1234
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:37:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w197so3356525oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u92nc+ilzmDmZ8KhgDmgn0xXKF9o01Oqnx4iuFaYN8c=;
        b=cKJIdZEfyQWsXVZ3GjN13n5C1BB7pQuL9RV5kZCYHWKP48enpjshNdQW23PxzIzIcL
         slXOSsPpIH5IEiuC5spoSh9Rn4Mcr7eh8c7U5hZMhS0t4Y6lDScTJqVqGrUfXBbumqEy
         +es7X2sP56w1Wc6pQ8rRh/pNcGqGuxySH0YWTMuZPAsJs1YzMpZvQQm9ijtqZe5veOGy
         7Fh1qzGygsue0/TrH4XKBs3QW5H/YOBBe/SqHrc9s4A6vBJF8yaFNN35SJEVmhaYqg9G
         AnoocxHvnlBbh6k0nVSy5k694F4ITMm0UbLEKvAhx04JruUXmPsNgpWotFOQis8puogk
         GQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u92nc+ilzmDmZ8KhgDmgn0xXKF9o01Oqnx4iuFaYN8c=;
        b=afGkimZerz7uGpZv2ZBMCwvYmCoyN/Hp0ylxdZHNKtqTUUMMc9Yn81MSTSMQst0rmF
         5UFGD8i++AvJGx9GdjyavOBCO6bAlR187u7sdMb1DnG3VBFJ2A9yK/fHohxIsK+rxU2p
         A6wZ/mZx2xDfx+vsJjwigbq/BFQztn7jjihPH4bYdpyxa3PZwNC/q1Yf/tvecSAFTBwJ
         2UllkGx4GTS6sQkUpK4wbNr5daPn3WdE0eEslioFGHLzzrqs3kGzo/O7tHxRTZQYxKln
         v7lc8cbxaOgUUPNAGad28zDB/yegI4cxSH5FSuRyU+XiyYfeZFosSRK1brHyipM5pMow
         F+SQ==
X-Gm-Message-State: ACgBeo0CHYDGjheijiX5KeLHzZTA9vjnWm9ch+v6QbJ6hoqsIViB/2AA
        dT0WtGVb7maPp1xyUvaQ1dpc3DWAnEkN02lxFtF3j/63
X-Google-Smtp-Source: AA6agR7ML20OfIMq+WgdppsSjJ35BwJNnV8hzve1HccmNoAAik00V72mVU4PZG3qOJgb6N3OGz/6mK/JeDoDUcwmdp4=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr2539548oib.46.1661546241204; Fri, 26
 Aug 2022 13:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220826100052.22945-16-jmaselbas@kalray.eu>
In-Reply-To: <20220826100052.22945-16-jmaselbas@kalray.eu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Aug 2022 16:37:09 -0400
Message-ID: <CADnq5_Pp+0-PNgXvmdiYJjCF=NQAvzz1=ydJO+Deg4Pp8jA2Ng@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix repeated word in comments
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
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

On Fri, Aug 26, 2022 at 10:03 AM Jules Maselbas <jmaselbas@kalray.eu> wrote:
>
> Remove redundant words `the` and `this`.
>
> CC: David Airlie <airlied@linux.ie>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Thomas Zimmermann <tzimmermann@suse.de>
> CC: amd-gfx@lists.freedesktop.org
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>

Please split this up per driver.

Thanks!

Alex

> ---
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h | 2 +-
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h   | 2 +-
>  drivers/gpu/drm/display/drm_dp_helper.c                         | 2 +-
>  drivers/gpu/drm/drm_panel_orientation_quirks.c                  | 2 +-
>  drivers/gpu/drm/i915/gvt/scheduler.c                            | 2 +-
>  drivers/gpu/drm/i915/i915_irq.c                                 | 2 +-
>  drivers/gpu/drm/panel/panel-novatek-nt35510.c                   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> index 43d43d6addc0..4164da83380f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_arcturus.h
> @@ -486,7 +486,7 @@ typedef struct {
>    uint16_t Tvr_socLimit;            // Celcius
>    uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
>
> -  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
> +  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
>    uint16_t PpmTemperatureThreshold;
>
>    // SECTION: Throttler settings
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> index 04752ade1016..ba7c68a20425 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_navi10.h
> @@ -544,7 +544,7 @@ typedef struct {
>    uint16_t TplxLimit;               // Celcius
>    uint32_t FitLimit;                // Failures in time (failures per million parts over the defined lifetime)
>
> -  uint16_t PpmPowerLimit;           // Switch this this power limit when temperature is above PpmTempThreshold
> +  uint16_t PpmPowerLimit;           // Switch this power limit when temperature is above PpmTempThreshold
>    uint16_t PpmTemperatureThreshold;
>
>    // SECTION: Throttler settings
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e5bab236b3ae..32b295003f49 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
>
>  /*
>   * Calculate the length of the i2c transfer in usec, assuming
> - * the i2c bus speed is as specified. Gives the the "worst"
> + * the i2c bus speed is as specified. Gives the "worst"
>   * case estimate, ie. successful while as long as possible.
>   * Doesn't account the "MOT" bit, and instead assumes each
>   * message includes a START, ADDRESS and STOP. Neither does it
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index fc1728d46ac2..dde2f4c4c6cb 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -349,7 +349,7 @@ static const struct dmi_system_id orientation_data[] = {
>   * resolution expected by the quirk-table entry.
>   *
>   * Note this function is also used outside of the drm-subsys, by for example
> - * the efifb code. Because of this this function gets compiled into its own
> + * the efifb code. Because of this function gets compiled into its own
>   * kernel-module when built as a module.
>   *
>   * Returns:
> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
> index d6fe94cd0fdb..7670ae4dd8fa 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -193,7 +193,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
>                         workload->ring_context_gpa);
>
>         /* only need to ensure this context is not pinned/unpinned during the
> -        * period from last submission to this this submission.
> +        * period from last submission to this submission.
>          * Upon reaching this function, the currently submitted context is not
>          * supposed to get unpinned. If a misbehaving guest driver ever does
>          * this, it would corrupt itself.
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index 73cebc6aa650..783a6ca41a61 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -65,7 +65,7 @@
>
>  /*
>   * Interrupt statistic for PMU. Increments the counter only if the
> - * interrupt originated from the the GPU so interrupts from a device which
> + * interrupt originated from the GPU so interrupts from a device which
>   * shares the interrupt line are not accounted.
>   */
>  static inline void pmu_irq_stats(struct drm_i915_private *i915,
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> index 40ea41b0a5dd..4085822f619a 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -231,7 +231,7 @@ struct nt35510_config {
>          * bits 0..2 in the lower nibble controls HCK, the booster clock
>          * frequency, the values are the same as for PCK in @bt1ctr.
>          * bits 4..5 in the upper nibble controls BTH, the boosting
> -        * amplification for the the step-up circuit.
> +        * amplification for the step-up circuit.
>          * 0 = AVDD + VDDB
>          * 1 = AVDD - AVEE
>          * 2 = AVDD - AVEE + VDDB
> --
> 2.17.1
>
