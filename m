Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB94BFC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiBVPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBVPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:17:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA6AE53;
        Tue, 22 Feb 2022 07:16:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so33919799wra.12;
        Tue, 22 Feb 2022 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Xxj1ephrofWa18acovB/xXK0BSIpcA0u+PZS1W0btg=;
        b=N/lnlsscdcE0PaM6lCz+OBJsJNfVYEfzXRYGoCP2WsRtHPJOI0UrRVg3WXkZgtsLO7
         qRk/flJmSeYt+1pqJTFLFa0IC+AM285qCu+MGOzssoWj3OgEPmwFjOXA9uG8qGPbhjYP
         DRdtTRT+UcFiZHOX6j2iMLIPk9WYfccGmULRZwPb3JVMQDHbF7F+iNA/CXbD0n0+8QbQ
         Bdv3MDg6fgZHaqLsk9yFGVDlcR6KNQ7IrU/FTCUZVm4H60hZNlR4xFN0TnZTB+mdg3Rt
         c+WrjFM63YmZ0ErsRvFP8XnC9pBRFkw7d/DEWVzsAh3yvPliKny91DffpRzOcHnaMCNj
         RSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Xxj1ephrofWa18acovB/xXK0BSIpcA0u+PZS1W0btg=;
        b=u2L7Yax5ZeqE5OfVrkZpVnkNhbiC9n9FtbKTeZ2bd0PVmUkbfC5DZafM0q05eQopJd
         FKmlFgnY9bjY4mD11jnFYt+jvOiQhzlHfYRZq/xouiQAhCgvC0mvpcKtS87mGWQvEW0t
         Wl6mgoIZt1LQvFTg/OpP9in4wKGQpbvcTZy6IvW5nQ2vTipKMBnPEkP0gFlrYrnIxmYO
         lLZJ90xdzz3cmuIT1F4VFmunta5t1XemIRnHdfeFttdy3scjfS+NIGRKbceukphQfAsT
         DTTHwJcTeMABNpiH9ywlF9+31fxG5raocWg6tZ0v/3ECVwr7s8YxDeNTfVi7Vnv8W14m
         J1HA==
X-Gm-Message-State: AOAM532YZDcFgVJaDf2Ch0VOPrdZ798XOzsToBDJeutpj/CXq2Jm7v/0
        S3NMklMqSyuk8okGpyXIU2i6Cp9B1F3KPh2SB/WY+3Ip0Y8=
X-Google-Smtp-Source: ABdhPJx9lgwLRb2ha6aRWJDdJQXCfNSBbYdDUiqyo/LX5KabZmZUM9EOVDC1tnECSzjofHjqWa3j73D+cGiuQAMbjzU=
X-Received: by 2002:a05:6000:15c4:b0:1ea:80f8:dfee with SMTP id
 y4-20020a05600015c400b001ea80f8dfeemr3958538wry.542.1645542995136; Tue, 22
 Feb 2022 07:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20220222151357.1710503-1-michael@walle.cc>
In-Reply-To: <20220222151357.1710503-1-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 22 Feb 2022 16:16:23 +0100
Message-ID: <CAEyMn7avcFD55+aEnX+jqym_f0q-p9DD5pgTC8WeaO27HUCCsg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
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

Hi,

Am Di., 22. Feb. 2022 um 16:14 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Add a new compatible string for that eval board. It features an IMX8MN
> UltraLite and has DDR3L RAM. The product part number is 8MNANOD3L-EVK.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 23e678232451..e11ffaa8721e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -834,6 +834,7 @@ properties:
>                - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
>                - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
>                - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
> +              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK Board
>                - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
>                - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
>            - const: fsl,imx8mn
> --
> 2.30.2
>
