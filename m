Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08644BA498
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiBQPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:40:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiBQPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:40:23 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20592B2E38
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:07 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b38so8922638ljr.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QQBoXxNzNE8ywxlHFFfAWGomixHy2u6zilUaFbuhmE=;
        b=RrJjmHuXVzVPtammx2PWFkPzYxa0sp+CIs+a7p1reY0HA9oZgI6A2REIXw9b8X87aw
         7pc9oqYfh2pWUeDGPUC+sYPFiWy5TmNtt0N8Yk45gdx5bEQCumDai+PpoJesoGcTvHkK
         3DRBdvC49FrGQhrxOH/yH4nzcpoghoBj2cAkf/i7i2WMNp/JuYdHrXjA+/5A//mRpxy8
         kkUCQyA6YybDATTmZeDwQT8wppphoA7p08DHO0KUt+BMuEQXgDCFQhQosH1H2P+Ws4dH
         xyth298pl5lKvbRhwd5OOQ3S2/WTqa0/tqOiawymfYhfgUwa3YDahOFTXQbXp+jgr+f4
         kkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QQBoXxNzNE8ywxlHFFfAWGomixHy2u6zilUaFbuhmE=;
        b=V837OE/ML2yMvYRGzJCZHYNSLb5t5LigUKvsLSqyQqgFQJJxQvWdTzVrNWzUMM4uYq
         k2O4A15/0xDAr2tl+D60bbETkzqWDoFw9GcQzXHOjS1ueuld8O9vIDmWKovBD07PxBrD
         J7IAGnQCkiQZCwmvJlxnzHu1YbX3unyZ/k+pjvLOh7YOl4O1AxOZ/uR0ezvs7upVHzU+
         NGkyyPmpUzfDd4VyV+Z6RDHR4zEaDPqSxt3SVVb6CkjpEDuo737sO6VppjdnakjtWZBG
         i+wMAef1OK68MV/IZqs9YKR3X2kpRnhLCVfKe8DweHhwxWKWdQLPOX74QboqUtDiz5Tg
         lccw==
X-Gm-Message-State: AOAM531MojpB6/dVywrmdaz1hWChyrYWGYJ/CUY3E3d9nDu8BKUSVqBi
        sdK1sIp7GcnTK+18hTK5uQ8auvsd1IE3u5JuIhhwnA==
X-Google-Smtp-Source: ABdhPJz/2VHYH9XfV+9CZAADf8Qh3/CV94aravtyvXjpcx8p81PXfewRvi4Izfd3VQLRzuBPEmKSwtVVgXuWCGv7jDM=
X-Received: by 2002:a2e:8603:0:b0:246:24c:b79c with SMTP id
 a3-20020a2e8603000000b00246024cb79cmr2624384lji.367.1645112406253; Thu, 17
 Feb 2022 07:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20220215081502.789067-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220215081502.789067-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:30 +0100
Message-ID: <CAPDyKFpkBGyxNxi3uYyYRrgh=itNf69-Xe9gwJktoE0p9yj74A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: imx-esdhc: Add imx93 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, Kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
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

On Tue, 15 Feb 2022 at 09:15, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add i.MX93 compatible string, it uses two compatible strings.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 17acbc665f5a..7dbbcae9485c 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -47,6 +47,7 @@ properties:
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> +              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
>            - const: fsl,imx8mm-usdhc
>
> --
> 2.25.1
>
