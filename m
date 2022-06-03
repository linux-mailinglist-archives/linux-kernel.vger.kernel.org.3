Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576F53C8A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiFCK3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbiFCK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:28:58 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D22366B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:28:57 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30c1b401711so77838427b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC0gx01b2aNajXfhT3RxUnH0OHK3FMPo/gpngxGlMwo=;
        b=oG7zOFP1DbQh6Bo8e9Qpq/xhX0tcm0Z686SDBT7H504JhHxqE3dnOrHBJ6SB/2HSK4
         twuSJO1lPcK5rLD3Hh+gKG0l3jtSoA8EYExYCLiyANJoCWRY1XSu31iiJqtN8JeP4jR5
         KeCcRWNG8k0cKAwK+B8C+LiKyAUIyY35Rc2HDoJNL490sEJzAybFKJGosi2vB+5kM2fb
         CkFMly+sSSmDyfTmzvsm3PvJr8kwCzkRW05trOUye05ZR8AscObGzjpJwvBL/YOzAVbN
         0mw8bc8FHPkItci37uxaWwIcZPeZfUqrdb+ftP4a7ZovA0miQgbeVm9d2jAyuRTdKt0d
         Do2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC0gx01b2aNajXfhT3RxUnH0OHK3FMPo/gpngxGlMwo=;
        b=rsdBviTGntqOdiRzXZoVDEA2HjwRG5Pm89bIzIAYMNgfGAXIFVGcfLki2ziyw1zlQI
         BrowX/4WBt6cfh2/n7diTw/ueLy/KnVG6/qgpHUqqoMBH1fatBHOedny+ERDSDQDwjpj
         NNOeNJNBefD8EwE465O2VWfcWE4QerhDrk3ngCBFlrbsFbTk4aYMAgR6guOHoQ+N2hqe
         hVXQOi+zDONS7nFalbpk9D5K/dGbHiEIuBygIecQyrgdO6WHpXe+8iQob4xGbKn0O0Zo
         5ZPdw/ztk+AIW0K2odi0YcDbhJdVD+aChrmGBTAAYTb7swnxGTeJK21NoCvzMRSAb1Zy
         GCqg==
X-Gm-Message-State: AOAM530e3fU46l/mDGXT0PrIu24s12h7/8HAZJSrHIvlrBE6vwqgN+ss
        tKIDd5UOSMiAshHVjJ0OjfvsXjIjZdcy/fHdfj2ufQ==
X-Google-Smtp-Source: ABdhPJxdb0406KtQA0ekY0TlTv81qQUxI5O/FyeeUoVHX8/Ot2ByU9RnuJwh7E4wA3eNsSCbGkhyW44rUkeitrBqRsM=
X-Received: by 2002:a0d:e246:0:b0:30c:5e77:7104 with SMTP id
 l67-20020a0de246000000b0030c5e777104mr10997642ywe.448.1654252136425; Fri, 03
 Jun 2022 03:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <1654079415-26217-1-git-send-email-quic_srivasam@quicinc.com> <1654079415-26217-3-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1654079415-26217-3-git-send-email-quic_srivasam@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:28:45 +0200
Message-ID: <CACRpkdYQW7WByaGoSFKT91OwRao_jJdCAbL0pUuj3vdS6TdkQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: sc7280: Add lpi pinctrl variant
 data for adsp based targets
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 12:30 PM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:

So one way to just use a propert and avoid more compatible strings:

> Add compatible string and lpi pinctrl variant data structure for adsp
> enabled sc7280 platforms.
> This variant data structure rnd compatible name required for
> distingushing ADSP based platforms and ADSP bypass platforms.
> In case of ADSP enabled platforms, where audio is routed through ADSP
> macro and decodec GDSC Switches are triggered as clocks by pinctrl
> driver and ADSP firmware controls them. So It's mandatory to enable
> them in ADSP based solutions.
> In case of ADSP bypass platforms clock voting is optional as these macro
> and dcodec GDSC switches are maintained as power domains and operated from
> lpass clock drivers.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> index 2add9a4..c9e85d9 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> @@ -134,6 +134,16 @@ static const struct lpi_function sc7280_functions[] = {
>         LPI_FUNCTION(wsa_swr_data),
>  };
>
> +static const struct lpi_pinctrl_variant_data sc7280_adsp_lpi_data = {

Remove static and export this struct in drivers/pinctrl/qcom/pinctrl-lpass-lpi.h

> +       .pins = sc7280_lpi_pins,
> +       .npins = ARRAY_SIZE(sc7280_lpi_pins),
> +       .groups = sc7280_groups,
> +       .ngroups = ARRAY_SIZE(sc7280_groups),
> +       .functions = sc7280_functions,
> +       .nfunctions = ARRAY_SIZE(sc7280_functions),
> +       .is_clk_optional = false,
> +};


>  static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>         .pins = sc7280_lpi_pins,
>         .npins = ARRAY_SIZE(sc7280_lpi_pins),
> @@ -149,6 +159,10 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
>                .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
>                .data = &sc7280_lpi_data,
>         },
> +       {
> +               .compatible = "qcom,sc7280-lpass-adsp-lpi-pinctrl",
> +               .data = &sc7280_adsp_lpi_data,
> +       },

Drop this and instead add some code in the probe()
in drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
lines:

if (of_device_is_compatible(np, "qcom,sc7280-lpass-lpi-pinctrl") &&
of_property_read_bool(np, "qcom,adsp-mode))
     data = &sc7280_adsp_lpi_data;

Yours,
Linus Walleij
