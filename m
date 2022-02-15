Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238A94B5FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiBOBKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiBOBKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:10:40 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337CD1088
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:10:30 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so21422717oor.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ifGbg82ymBEfPdZo3oeoqJubchOD7aHMGI+CCM/6VeI=;
        b=JzfqXRBdTeWFxtrsMjScRtFzmZW7lSKyEy50rmc0dSZv5O/+iCf5iJDvrvV9zCI6kB
         GQVBY7mZcCF5POUCKH7krqOiAFTUj/eW6g2spxpsuqoo/Mj3yBjcdfFfIga//wboSLgn
         CLOy+TDL29LexsBAUajcqmrLl5yPq5VWv+Wm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ifGbg82ymBEfPdZo3oeoqJubchOD7aHMGI+CCM/6VeI=;
        b=soYjrzhLjGnQni9scfU6A8URL/u0lFfp+4dbWRuudhyBDr4MX+sBHkQqrCjFgk15Cb
         MexRnp45arljPr+kBy1Oe90koru8UoPxVWAONBB4S8NGYfkFq8S1MaOtt8p3IIuM9K45
         dRGHrgGk8U7x4b0ZhpkPynENjoBLBUJlnGf6HRWqTmrlWDd/FEBJzT+EKTT9ZMrd/4pp
         XS2zzoJYz+bi+LJun8JIeNw+dbBVXhdCRrfi8dy+uK4zojDqNODNnBFfdj3MbkOhsGla
         Wkn2uIaH6ZCNk+CD4msQ6GpbPd2tZsSkNXA+BxeeFQviFID60f5ETDtWpuaEBalH8GDj
         I0EQ==
X-Gm-Message-State: AOAM531QYrM63UviYh+aSTi17ldjuuKTiGgNnVIiZOhYHUW8y5VJSenG
        Es6fGGzcKg3+s2OMxSWNh0MPe0D9OxayLHDq6ddlRg==
X-Google-Smtp-Source: ABdhPJwigiiW4fBvsZ0I8ihR5uCpy6DMum+AGLTc9gc9XbYvRSjnadspyKecplQizwXnkD5dQ9nFVSV+Wr5HQ2YmwB8=
X-Received: by 2002:a05:6870:1209:: with SMTP id 9mr565635oan.8.1644887430198;
 Mon, 14 Feb 2022 17:10:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Feb 2022 17:10:29 -0800
MIME-Version: 1.0
In-Reply-To: <1644850708-11099-5-git-send-email-quic_srivasam@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com> <1644850708-11099-5-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 14 Feb 2022 17:10:29 -0800
Message-ID: <CAE-0n504R0avU9Ybj68jxqDRH-Ya5ro0hPo5GJ=2zC6p2SZ_=g@mail.gmail.com>
Subject: Re: [RESEND v13 04/10] ASoC: qcom: Add helper function to get dma
 control and lpaif handle
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:22)
> Add support function to get dma control and lpaif handle to avoid
> repeated code in platform driver
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-platform.c | 113 +++++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 47 deletions(-)
>
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index a44162c..5d77240 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -177,6 +177,49 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
>         return 0;
>  }
>
> +static void __lpass_get_lpaif_handle(struct snd_pcm_substream *substream,

const?

> +                                    struct snd_soc_component *component,

const?

> +                                    struct lpaif_dmactl **dmactl, int *id, struct regmap **map)
> +{
> +       struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +       struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
> +       struct snd_pcm_runtime *rt = substream->runtime;
> +       struct lpass_pcm_data *pcm_data = rt->private_data;
> +       struct lpass_variant *v = drvdata->variant;
> +       int dir = substream->stream;
> +       unsigned int dai_id = cpu_dai->driver->id;
> +       struct lpaif_dmactl *l_dmactl = NULL;
> +       struct regmap *l_map = NULL;
> +       int l_id = 0;
> +
> +       switch (dai_id) {
> +       case MI2S_PRIMARY ... MI2S_QUINARY:
> +               if (dir == SNDRV_PCM_STREAM_PLAYBACK) {

Please write if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) and
drop 'dir' local variable.

> +                       l_id = pcm_data->dma_ch;
> +                       l_dmactl = drvdata->rd_dmactl;
> +               } else {
> +                       l_dmactl = drvdata->wr_dmactl;
> +                       l_id = pcm_data->dma_ch - v->wrdma_channel_start;
> +               }
> +               l_map = drvdata->lpaif_map;
> +               break;
> +       case LPASS_DP_RX:
> +               l_id = pcm_data->dma_ch;
> +               l_dmactl = drvdata->hdmi_rd_dmactl;
> +               l_map = drvdata->hdmiif_map;
> +               break;
> +       default:
> +               break;
> +       }
> +       if (dmactl)
> +               *dmactl = l_dmactl;
> +       if (id)
> +               *id = l_id;
> +       if (map)
> +               *map = l_map;

Why not 'return 0' here and return -EINVAL in the default case above? Then
we can skip the checks for !map or !dmactl below and simply bail out if
it failed with an error value.

> +}
> +
>  static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
>                                            struct snd_pcm_substream *substream,
>                                            struct snd_pcm_hw_params *params)
> @@ -191,21 +234,15 @@ static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
>         unsigned int channels = params_channels(params);
>         unsigned int regval;
>         struct lpaif_dmactl *dmactl;
> -       int id, dir = substream->stream;
> +       int id;
>         int bitwidth;
>         int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
>         unsigned int dai_id = cpu_dai->driver->id;
>
> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
> -               id = pcm_data->dma_ch;
> -               if (dai_id == LPASS_DP_RX)
> -                       dmactl = drvdata->hdmi_rd_dmactl;
> -               else
> -                       dmactl = drvdata->rd_dmactl;
> -
> -       } else {
> -               dmactl = drvdata->wr_dmactl;
> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, NULL);
> +       if (!dmactl) {
> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +               return -EINVAL;
>         }
>
>         bitwidth = snd_pcm_format_width(format);
> @@ -350,10 +387,11 @@ static int lpass_platform_pcmops_hw_free(struct snd_soc_component *component,
>         struct regmap *map;
>         unsigned int dai_id = cpu_dai->driver->id;
>
> -       if (dai_id == LPASS_DP_RX)
> -               map = drvdata->hdmiif_map;
> -       else
> -               map = drvdata->lpaif_map;
> +       __lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
> +       if (!map) {
> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +               return -EINVAL;
> +       }
>
>         reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream, dai_id);
>         ret = regmap_write(map, reg, 0);
> @@ -379,22 +417,12 @@ static int lpass_platform_pcmops_prepare(struct snd_soc_component *component,
>         int ret, id, ch, dir = substream->stream;
>         unsigned int dai_id = cpu_dai->driver->id;
>
> -
>         ch = pcm_data->dma_ch;
> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
> -               if (dai_id == LPASS_DP_RX) {
> -                       dmactl = drvdata->hdmi_rd_dmactl;
> -                       map = drvdata->hdmiif_map;
> -               } else {
> -                       dmactl = drvdata->rd_dmactl;
> -                       map = drvdata->lpaif_map;
> -               }
>
> -               id = pcm_data->dma_ch;
> -       } else {
> -               dmactl = drvdata->wr_dmactl;
> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
> -               map = drvdata->lpaif_map;
> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
> +       if (!dmactl) {
> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +               return -EINVAL;
>         }
>
>         ret = regmap_write(map, LPAIF_DMABASE_REG(v, ch, dir, dai_id),
> @@ -444,25 +472,15 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
>         struct lpaif_dmactl *dmactl;
>         struct regmap *map;
>         int ret, ch, id;
> -       int dir = substream->stream;
>         unsigned int reg_irqclr = 0, val_irqclr = 0;
>         unsigned int  reg_irqen = 0, val_irqen = 0, val_mask = 0;
>         unsigned int dai_id = cpu_dai->driver->id;
>
>         ch = pcm_data->dma_ch;
> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
> -               id = pcm_data->dma_ch;
> -               if (dai_id == LPASS_DP_RX) {
> -                       dmactl = drvdata->hdmi_rd_dmactl;
> -                       map = drvdata->hdmiif_map;
> -               } else {
> -                       dmactl = drvdata->rd_dmactl;
> -                       map = drvdata->lpaif_map;
> -               }
> -       } else {
> -               dmactl = drvdata->wr_dmactl;
> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
> -               map = drvdata->lpaif_map;
> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
> +       if (!dmactl) {
> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +               return -EINVAL;
>         }
>
>         switch (cmd) {
> @@ -597,10 +615,11 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
>         struct regmap *map;
>         unsigned int dai_id = cpu_dai->driver->id;
>
> -       if (dai_id == LPASS_DP_RX)
> -               map = drvdata->hdmiif_map;
> -       else
> -               map = drvdata->lpaif_map;
> +       __lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
> +       if (!map) {
> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
> +               return -EINVAL;
> +       }
>
>         ch = pcm_data->dma_ch;
>
> --
> 2.7.4
>
