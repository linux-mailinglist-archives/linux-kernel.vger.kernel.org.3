Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C384571822
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGLLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGLLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:10:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C967B0F99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e28so9756884lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIxn205KIvmS9VSb5lDf2UBPI0iYaOAaJ1A1MJqqVxk=;
        b=FNUE2acQhszuFh5gwSVw+Rwn9vCbiz5eeW9tj0ulcEp5CB+CXfZNt8End8wSLExYwg
         4MO0Xl4cRWRKs5XBHGbmhjPB/i1vtyPNV90bz1iw4x++t5iu24KV5R6FJi7W09ebLp9x
         S7wFe2tgt8oEN1HIukddBfHCiZO3jZmcu5z3d3BrD2zxyY2u0qHd++sqPDQ+kzN2tovj
         3q8HBg3/FmHKaEXwYT4Dfqb+TnqK4st+QY5oGz7HEfCyVhDwcVT+XW8TO0xoa0lPVoEs
         iojT44I21fzo9Uf3MJBs0yP9F1SVii8xWazC9xjcbn2X5a0LWztVRBgtuz01spJQs9uV
         WKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIxn205KIvmS9VSb5lDf2UBPI0iYaOAaJ1A1MJqqVxk=;
        b=uvtsSvCkwB0L8DgBy0h96EDVAT49ppHchFk9/YRHowtvLUPXHXc0oxaCOa8P0LhDMs
         IGZ4h/jbN+5ZVqorhC+MJJxz2TzGL4SqqHAz21GfVSrnygsAK/VDSoZ/g9QNOt1rGPGm
         BHA8VvR9tIFtCOORTINL6qUX1IHbTIf1HJqPVGkXCJS6bkemBoFfAA0G+/0D5eh+rFI7
         BU9yXSK4BfRKlK1d+TjhyOmPBgRdEQy0cTpPD3/2sreVdM6YkD3NuMkvb6Phy9EG1boX
         1Vgx+ncs4lO8jHwFgn5fCwzObdf0FPRWqhLQbBJx0NthirhqLGbNK6tRO8hj6Tkc4nBE
         Id1w==
X-Gm-Message-State: AJIora8065yrbgd+8ylX80MHS+UEMcfUx6IceCtaVnesQ8X2wThBY22x
        q3qUHWS3veA0m709yC+e2VV6pPvN5GN2sAdB8Xj76w==
X-Google-Smtp-Source: AGRyM1tW9I2SNwUkOEFsvNntEhlOoXvMH17jCpZPzFWoPNjDoKFFg72huJu8nMkwl68VqtR7rGwljMo7GbdaofhPCqM=
X-Received: by 2002:a05:6512:3d03:b0:47f:7023:2c57 with SMTP id
 d3-20020a0565123d0300b0047f70232c57mr14045143lfv.254.1657624215580; Tue, 12
 Jul 2022 04:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220708114747.13878-1-johnson.wang@mediatek.com>
In-Reply-To: <20220708114747.13878-1-johnson.wang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:39 +0200
Message-ID: <CAPDyKFqcP69cBEKDx1Uu0BKGOA6s1U+Suiz1KXDXtwn8Qj8kBA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Add compatible for MediaTek MT8188
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
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

On Fri, 8 Jul 2022 at 13:47, Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> This commit adds dt-binding documentation of mmc for MediaTek MT8188 SoC
> platform.
>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..be366cefffc2 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -30,13 +30,11 @@ properties:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
>        - items:
> -          - const: mediatek,mt8186-mmc
> -          - const: mediatek,mt8183-mmc
> -      - items:
> -          - const: mediatek,mt8192-mmc
> -          - const: mediatek,mt8183-mmc
> -      - items:
> -          - const: mediatek,mt8195-mmc
> +          - enum:
> +              - mediatek,mt8186-mmc
> +              - mediatek,mt8188-mmc
> +              - mediatek,mt8192-mmc
> +              - mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
>    reg:
> --
> 2.18.0
>
