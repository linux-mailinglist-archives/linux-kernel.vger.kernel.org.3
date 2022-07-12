Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BC57146A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiGLIWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiGLIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:22:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F908A2E7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:38 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp17so4836546lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4m5x/M7wGQTkuTGbBdHuRme2/Yx+q9GsoYsF12v1CVI=;
        b=F+ARLiDcoplhKI2zk+nSZ5iisWZ0PxkXbQSLJhE+LUzCaXzZli9YnUO6z9kwrqMwFT
         wyBKoU9an2npA+znUafUjy4tmqIuJUct9L52oDe0kXyZRHn5TdKFbAkDT7dEJaaLMdbl
         dIeCcNCoF37TelXox/1h6LVK5LaX+LJVOxGDNbkjCv+EY34n7yGOFEPdR5Sc779vdxsp
         kv3UC6IZkbBtdRLdKnnQwIv2+r3hymn/P9vGbL+MZcRyESp017V4bqhm+tPraC/qyBPc
         w84ncKgwWZMZmrltrUrXtY0yr6ADNjefY4krMUW/Fl6KU7Q0NNjIT8xEfl9mzHFjy3ra
         tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4m5x/M7wGQTkuTGbBdHuRme2/Yx+q9GsoYsF12v1CVI=;
        b=mrJV4BUmUJOpKnMrQHpjk7VR0MwM2jJqZHUwhA19vmCM+NvHPNrseZXTtLfuGxIf5+
         yiL5zv2iu+j95OAhC6bctmvXT188o61mxs7dKCWPPoZ8BFhkPeFYWMKfCy1oWDCyP6Vk
         cE9dwIEkqPXQnI0vn7jw7ciMn3WVAQRt2X0GbSYK3f60NBYXZ/WkMzYzallUUUmXDp5i
         hHsHdSTYEjEsPFtxqSl/9GCPuhV/gI7BtMmp4UzLmd2/RkIZupC783ukR9ZgKOq15vQC
         GccksQw1AhENpXHr0VYnAmd6Z8vAxWGP2r1kHYme4Gp+yd7Mt7KTrBBF1BrwWaa07wm5
         Kkxw==
X-Gm-Message-State: AJIora8HUCV/+CgL39Yi9h5FXHePZhVEYW3WGgLa9UaSugki7YCVvT5h
        WmLMUI8EUiIW066OWXS3DwNrbg==
X-Google-Smtp-Source: AGRyM1uqdiz6ijIGWQvUILsLAifSQrdupQ3XtTBaBLWmX31x+cxnVz0j0zB++DD78gS0F+am+JeVSQ==
X-Received: by 2002:a05:6512:1590:b0:47f:6e14:a782 with SMTP id bp16-20020a056512159000b0047f6e14a782mr14351434lfb.131.1657614096873;
        Tue, 12 Jul 2022 01:21:36 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2510a000000b0047f68e0ca8fsm2059353lfb.49.2022.07.12.01.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:36 -0700 (PDT)
Message-ID: <8614fd96-94ff-a04f-01a2-9f3b6337dcb6@linaro.org>
Date:   Tue, 12 Jul 2022 10:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
 <20220712082146.1192215-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712082146.1192215-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 10:21, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
> the i.MX8MM VPU blk ctrl yaml file.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml        | 17 ++++++++++++++---
>  include/dt-bindings/power/imx8mp-power.h        |  4 ++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> index 26487daa64d9..edbd267cdd67 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> @@ -4,20 +4,22 @@
>  $id: http://devicetree.org/schemas/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: NXP i.MX8MM VPU blk-ctrl
> +title: NXP i.MX8MM/P VPU blk-ctrl
>  
>  maintainers:
>    - Lucas Stach <l.stach@pengutronix.de>
>  
>  description:
> -  The i.MX8MM VPU blk-ctrl is a top-level peripheral providing access to
> +  The i.MX8MM/P VPU blk-ctrl is a top-level peripheral providing access to
>    the NoC and ensuring proper power sequencing of the VPU peripherals
>    located in the VPU domain of the SoC.
>  
>  properties:
>    compatible:
>      items:
> -      - const: fsl,imx8mm-vpu-blk-ctrl
> +      - enum:
> +          - fsl,imx8mm-vpu-blk-ctrl
> +          - fsl,imx8mp-vpu-blk-ctrl
>        - const: syscon
>  
>    reg:
> @@ -47,6 +49,15 @@ properties:
>        - const: g2
>        - const: h1
>  
> +  interconnects:
> +    maxItems: 3

You should describe the items, because g1/g2/h1 are quite cryptic.


Best regards,
Krzysztof
