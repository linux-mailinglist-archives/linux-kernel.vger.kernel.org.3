Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED155B17DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIHI6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIHI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:58:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84FF7754
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:58:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso1687297pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Yl5dH+M1AECal4jvUQOuJGxEpqBdOe/+ieXwhwCLcIA=;
        b=i7a4sZP3FnbyUkKT8FkldgTI3hWplhLrLiEqax5uxxwsoWP9gf6N8hignXexdO56pf
         pGRznxBg49yjvlJfo/HQhepEoRNmt2PklxkaZltRNoZRv7vkHdewQrt5raOfqgQ6cOFI
         gdzdwvfK402rUb0U2/WrsE2L4kUCkF8RcaStsRL4fj49KYiZvEigyA67txy8eh/bF0pW
         9nimlMXCSUuv2GHDtWudZDol02Re3+hW96qW1kNULY93AbUvnGhKMK6TrCwc4NarqSwc
         9fUYIWLkCDHA4VgVNqCkjhe5MPCWVj0WRCZhbm0j7GmpF+32EAP+H62hXYo4LPVmd+vS
         MeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Yl5dH+M1AECal4jvUQOuJGxEpqBdOe/+ieXwhwCLcIA=;
        b=lFLsZzI4PzCzaKY3lb5dv7VfRlhSOudok9IptBIeGwBSDLXNv/8btfDl9hqKkZBAVN
         aSfvJZiSED2D+GMHwNBvsgiaA8ga6VdlrdXsxUX91SgcJ9NONPlgcA7m1uvQqROwoyLL
         BdHcrRI1po3Uarj4o+gFnLB3D664D58tqimd08K51BA9pzJ782pwCW2LKTMSzkv5rHsl
         D71iK9AbJGLzSo0YYgXFX4QPT4KoNbawCwENEB56QHy+dptv5/f4xbhLP+Caonq5RlSe
         DktfrNkbKfvEoGx2rNBuhLS4V2LNdstWaiRQQOoi7iHH9fnPEUrB1hF8EZboBba4uidU
         901Q==
X-Gm-Message-State: ACgBeo1hjLx1u9YO29VaeaXOmefUEpiJX8HZcY3wS9cmZJm3zt3qqf9d
        FC6TymiJjYVbR7MwskT6yW6b3P39aav7QzOgna0=
X-Google-Smtp-Source: AA6agR6XeTaZhnOJWL11eg9HSVayAiNW4O8VHX0b67jvxaqgJXn+KJvwQDYiFLbuRwb9ORorqH1jT+y4at5YZYtWEgg=
X-Received: by 2002:a17:90b:3b81:b0:202:597a:c71d with SMTP id
 pc1-20020a17090b3b8100b00202597ac71dmr2997392pjb.105.1662627487826; Thu, 08
 Sep 2022 01:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <1662622316-23426-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1662622316-23426-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 8 Sep 2022 11:57:55 +0300
Message-ID: <CAEnQRZCz_qKUMPqQgADszu_DvBEqNYRqm-wgfiYYEbRfvUEkng@mail.gmail.com>
Subject: Re: [PATCH] ASoC: ak4458: Remove component probe() and remove()
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
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

On Thu, Sep 8, 2022 at 11:03 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Most function in ak4458_probe() and ak4458_remove() are
> duplicate with dai ops, so remove them and move dsd_path
> setting to dai ops.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/ak4458.c | 53 ++++++---------------------------------
>  1 file changed, 7 insertions(+), 46 deletions(-)
>
> diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
> index ea33cc83c86c..b534212096ee 100644
> --- a/sound/soc/codecs/ak4458.c
> +++ b/sound/soc/codecs/ak4458.c
> @@ -447,6 +447,13 @@ static int ak4458_hw_params(struct snd_pcm_substream *substream,
>         snd_soc_component_update_bits(component, AK4458_0B_CONTROL7,
>                                       AK4458_DCHAIN_MASK, dchn);
>
> +       if (ak4458->drvdata->type == AK4497) {
> +               ret = snd_soc_component_update_bits(component, AK4458_09_DSD2,
> +                                                   0x4, (ak4458->dsd_path << 2));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
>         ret = ak4458_rstn_control(component, 0);
>         if (ret)
>                 return ret;
> @@ -629,48 +636,6 @@ static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
>         }
>  }
>
> -static int ak4458_init(struct snd_soc_component *component)
> -{
> -       struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
> -       int ret;
> -
> -       /* External Mute ON */
> -       if (ak4458->mute_gpiod)
> -               gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
> -
> -       ak4458_reset(ak4458, false);
> -
> -       ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
> -                           0x80, 0x80);   /* ACKS bit = 1; 10000000 */
> -       if (ret < 0)
> -               return ret;
> -
> -       if (ak4458->drvdata->type == AK4497) {
> -               ret = snd_soc_component_update_bits(component, AK4458_09_DSD2,
> -                                                   0x4, (ak4458->dsd_path << 2));
> -               if (ret < 0)
> -                       return ret;
> -       }
> -
> -       return ak4458_rstn_control(component, 1);
> -}
> -
> -static int ak4458_probe(struct snd_soc_component *component)
> -{
> -       struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
> -
> -       ak4458->fs = 48000;
> -
> -       return ak4458_init(component);
> -}
> -
> -static void ak4458_remove(struct snd_soc_component *component)
> -{
> -       struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
> -
> -       ak4458_reset(ak4458, true);
> -}
> -
>  #ifdef CONFIG_PM
>  static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
>  {
> @@ -714,8 +679,6 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
>  #endif /* CONFIG_PM */
>
>  static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
> -       .probe                  = ak4458_probe,
> -       .remove                 = ak4458_remove,
>         .controls               = ak4458_snd_controls,
>         .num_controls           = ARRAY_SIZE(ak4458_snd_controls),
>         .dapm_widgets           = ak4458_dapm_widgets,
> @@ -728,8 +691,6 @@ static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
>  };
>
>  static const struct snd_soc_component_driver soc_codec_dev_ak4497 = {
> -       .probe                  = ak4458_probe,
> -       .remove                 = ak4458_remove,
>         .controls               = ak4497_snd_controls,
>         .num_controls           = ARRAY_SIZE(ak4497_snd_controls),
>         .dapm_widgets           = ak4497_dapm_widgets,
> --
> 2.34.1
>
