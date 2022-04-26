Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536850F2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbiDZHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbiDZHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:51:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471E19C0A;
        Tue, 26 Apr 2022 00:48:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kd11so3786138qvb.2;
        Tue, 26 Apr 2022 00:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HcCRayH9FTvIwf3k7iht/16cHP0/OgYGNAx63jifwo=;
        b=jRjeVcvB/mmRTgRdYmmLAsqhC0yzA6XYr+l5q2xLmoUl0OenzntsQIssNLWoDXUlBV
         dgRrMC+GN1GJvW04yGM5WLaISJcHJPuf52nyd7JjtqvCTW6Bazy+gqfeMOK/5TaK7uMZ
         yGZlP3Xcn/+sON/SwOZVACCenROtT/G03iqiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HcCRayH9FTvIwf3k7iht/16cHP0/OgYGNAx63jifwo=;
        b=AaJOSSIj1vf9ELonCE2YQtd4Usx38AsKxMQ7PWkL6En2zcvM6sHakIMX4Tf7u/3u0b
         gnE3bM4smNud8CrsJE8wOLvtMXf0U44m448EcTniYpKrOlezCrnlUlOnG2c/hhj9NSFk
         ElTF81dnyLtm9KtL/CRRl/S4NGbelcJYg7vigZhvcc5FhKD3uv3UMNXwzDRLW5QAbdiT
         aJ77DmyhxJ0RLYAICxuv5CdiWCFUZmdZ+klnkvvy8MSGp6IbskqqrLccRdDat7atNMq6
         kXT1N+tBoPwiQByloF463wUe9AZ/ftO1LgYOWS/NUrhuf5F8Bz6A/kPtnf7EMgI4A2MD
         ghYw==
X-Gm-Message-State: AOAM531EYofqZ6wAovZ8FyZlopm9JTDm5h2M8F0ahetBnbvTu+wdQDDr
        a4UJs8XO/EfedLX4qQiPCfvU60EfiNNEroKD1f8I1Is9
X-Google-Smtp-Source: ABdhPJykzCFSUPtDPLs6rZ2wQSHdoWgRVitQaTZVkCsoG5s+fBHsIlRpGH0AZ3D+cG+gYZMqtockZmxk3lfWlcVEou8=
X-Received: by 2002:ad4:53c5:0:b0:42d:7bb4:a8e8 with SMTP id
 k5-20020ad453c5000000b0042d7bb4a8e8mr15099369qvv.8.1650959287059; Tue, 26 Apr
 2022 00:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220304063137.12970-1-tommy_huang@aspeedtech.com> <20220304063137.12970-3-tommy_huang@aspeedtech.com>
In-Reply-To: <20220304063137.12970-3-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 26 Apr 2022 07:47:55 +0000
Message-ID: <CACPK8XfeRGU4ZySfO8vMf71wy-=PcdetvFAwAE9gaSz-NPK6Fg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/aspeed: Add 1024x768 mode for AST2600
To:     Tommy Haung <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 06:32, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
>
> Update the aspeed_gfx_set_clk with display width.
> At AST2600, the display clock could be coming from
> HPLL clock / 16 = 75MHz. It would fit 1024x768@70Hz.
> Another chip will still keep 800x600.
>
> Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx.h      | 12 ++++++----
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 29 ++++++++++++++++++++----
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 16 +++++++++++--
>  drivers/gpu/drm/aspeed/aspeed_gfx_out.c  | 14 +++++++++++-
>  4 files changed, 60 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> index eb4c267cde5e..c7aefee0657a 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> @@ -109,11 +109,15 @@ int aspeed_gfx_create_output(struct drm_device *drm);
>  #define CRT_THROD_HIGH(x)              ((x) << 8)
>
>  /* SCU control */
> -#define SCU_G6_CLK_COURCE              0x300
> +#define G6_CLK_SOURCE                  0x300
> +#define G6_CLK_SOURCE_MASK             (BIT(8) | BIT(9) | BIT(10))
> +#define G6_CLK_SOURCE_HPLL             (BIT(8) | BIT(9) | BIT(10))
> +#define G6_CLK_SOURCE_USB              BIT(9)
> +#define G6_CLK_SEL3                    0x308
> +#define G6_CLK_DIV_MASK                        0x3F000

This register is defined in the data sheet as:

17:12 SOC Display clock selection when source is from DisplayPort PHY

That doesn't match with what the code is doing. Can you clarify the
register definition?

> +#define G6_CLK_DIV_16                  (BIT(16)|BIT(15)|BIT(13)|BIT(12))
> +#define G6_USB_40_CLK                  BIT(9)
>
>  /* GFX FLAGS */
>  #define CLK_MASK                       BIT(0)
>  #define CLK_G6                         BIT(0)
> -
> -#define G6_CLK_MASK                    (BIT(8) | BIT(9) | BIT(10))
> -#define G6_USB_40_CLK                  BIT(9)
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> index a24fab22eac4..5829be9c7c67 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> @@ -23,6 +23,28 @@ drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
>         return container_of(pipe, struct aspeed_gfx, pipe);
>  }
>
> +static void aspeed_gfx_set_clock_source(struct aspeed_gfx *priv, int mode_width)
> +{
> +       regmap_update_bits(priv->scu, G6_CLK_SOURCE, G6_CLK_SOURCE_MASK, 0x0);
> +       regmap_update_bits(priv->scu, G6_CLK_SEL3, G6_CLK_DIV_MASK, 0x0);
> +
> +       switch (mode_width) {
> +       case 1024:
> +               /* hpll div 16 = 75Mhz */
> +               regmap_update_bits(priv->scu, G6_CLK_SOURCE,
> +               G6_CLK_SOURCE_MASK, G6_CLK_SOURCE_HPLL);
> +               regmap_update_bits(priv->scu, G6_CLK_SEL3,
> +               G6_CLK_DIV_MASK, G6_CLK_DIV_16);
> +               break;
> +       case 800:
> +       default:
> +               /* usb 40Mhz */
> +               regmap_update_bits(priv->scu, G6_CLK_SOURCE,
> +               G6_CLK_SOURCE_MASK, G6_CLK_SOURCE_USB);
> +               break;
> +       }
> +}
> +
>  static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
>  {
>         struct drm_crtc *crtc = &priv->pipe.crtc;
> @@ -77,12 +99,11 @@ static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
>         regmap_update_bits(priv->scu, priv->dac_reg, BIT(16), 0);
>  }
>
> -static void aspeed_gfx_set_clk(struct aspeed_gfx *priv)
> +static void aspeed_gfx_set_clk(struct aspeed_gfx *priv, int mode_width)
>  {
>         switch (priv->flags & CLK_MASK) {
>         case CLK_G6:
> -               regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE, G6_CLK_MASK, 0x0);
> -               regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE, G6_CLK_MASK, G6_USB_40_CLK);
> +               aspeed_gfx_set_clock_source(priv, mode_width);
>                 break;
>         default:
>                 break;
> @@ -99,7 +120,7 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
>         if (err)
>                 return;
>
> -       aspeed_gfx_set_clk(priv);
> +       aspeed_gfx_set_clk(priv, m->hdisplay);
>
>  #if 0
>         /* TODO: we have only been able to test with the 40MHz USB clock. The
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index af56ffdccc65..e1a814aebc2d 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -110,6 +110,7 @@ static const struct drm_mode_config_funcs aspeed_gfx_mode_config_funcs = {
>
>  static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
>  {
> +       struct aspeed_gfx *priv = to_aspeed_gfx(drm);
>         int ret;
>
>         ret = drmm_mode_config_init(drm);
> @@ -118,8 +119,18 @@ static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
>
>         drm->mode_config.min_width = 0;
>         drm->mode_config.min_height = 0;
> -       drm->mode_config.max_width = 800;
> -       drm->mode_config.max_height = 600;
> +
> +       switch (priv->flags & CLK_MASK) {
> +       case CLK_G6:
> +               drm->mode_config.max_width = 1024;
> +               drm->mode_config.max_height = 768;
> +               break;
> +       default:
> +               drm->mode_config.max_width = 800;
> +               drm->mode_config.max_height = 600;
> +               break;
> +       }
> +
>         drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
>
>         return ret;
> @@ -167,6 +178,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
>         priv->vga_scratch_reg = config->vga_scratch_reg;
>         priv->throd_val = config->throd_val;
>         priv->scan_line_max = config->scan_line_max;
> +       priv->flags = config->gfx_flags;
>
>         priv->scu = syscon_regmap_lookup_by_phandle(np, "syscon");
>         if (IS_ERR(priv->scu)) {
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> index 6759cb88415a..5d5e04f15c59 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> @@ -10,7 +10,19 @@
>
>  static int aspeed_gfx_get_modes(struct drm_connector *connector)
>  {
> -       return drm_add_modes_noedid(connector, 800, 600);
> +       struct aspeed_gfx *priv = container_of(connector, struct aspeed_gfx, connector);
> +       int mode_count = 0;
> +
> +       switch (priv->flags & CLK_MASK) {
> +       case CLK_G6:
> +               mode_count = drm_add_modes_noedid(connector, 1024, 768);
> +               break;
> +       default:
> +               mode_count = drm_add_modes_noedid(connector, 800, 600);
> +               break;
> +       }
> +
> +       return mode_count;
>  }
>
>  static const struct
> --
> 2.17.1
>
