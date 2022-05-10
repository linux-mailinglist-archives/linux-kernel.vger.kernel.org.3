Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BA5213D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiEJLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiEJLfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:35:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0762F48888;
        Tue, 10 May 2022 04:31:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so32280798eja.11;
        Tue, 10 May 2022 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTvtYgLm5MJHzf3gzNp9ho+3ofo4le2oqFshMOa5STQ=;
        b=fQlovuz90WKzOAsBbHzy/qwjMKSYjxMAJ2+ahMWey3GsanO96epXMtNarlxL5cQeoi
         ZJPnEuJY3kHzAHx0+q2521qa0Y4mqIv8kHRRerIf14Kf1oPyTUkXCkZy6xACjsDlIEiP
         NP47T6v1MIYfs6/bxjnR3wM295wPShcFR6wbZEsgZdyUWTlcmrPWNpjBeIyAs5tiy933
         s4L2OjfnCZRNxwaHnWaKvoPROAgU9r9tjCOIgbDdRTgoq1agUljOWJkuhL+3OqrficmB
         hJyZf4rG6b0KDZIy/4NCXdnTCzbtmU7g3yj26i02rXGN5suxmvOe0S7KKyTizq9cWLiI
         o8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTvtYgLm5MJHzf3gzNp9ho+3ofo4le2oqFshMOa5STQ=;
        b=H9PfpRpTXAwk4HPatMcx+xI2Y79d0Rt6JMlh7Y/WIZn99rPLOgnUkybh68NLf2anFa
         8aOPbUyxSeXJowlVdEkzh1MiR5sKqRdX/SMWvpZJG7m3DyOziCtUFjsYg5Hncd4WzXLS
         FDQgD3tSRNBWMCo3D8FzCC/T9ESxMwfLaYXyURN65kVNz+0luYu1QT1TeDPe0qO1gGrK
         LJobHtX/gKjEZbWJhBxyf1y0bPV6FRZ59dg00LlAzEmx4zkyVd4X7412YzS9+861zMVm
         A8KsIVFZQJYd+J/boXxM5c+q5ls4spcTv95opPubemjulm5wccLZ/gR+TUV85WxXAWWL
         vNDg==
X-Gm-Message-State: AOAM532BhuMU2uYw4JWvBAjCM4ReZOIJ6dROVTCTierM0u8LzYbkvzXJ
        skSnNU6xSvMEMAQadRsxMfZjhkvKSfET7aOmBSI=
X-Google-Smtp-Source: ABdhPJxFgYA8S1lfcUFxI4IzhmrQkfm6J18L8ukXjafp7GnF1Rr861H0T89WJwOZHVSlVgDA/5Tb+acqVonWZpSzReE=
X-Received: by 2002:a17:906:58d4:b0:6f4:cebd:c4b with SMTP id
 e20-20020a17090658d400b006f4cebd0c4bmr18881145ejs.492.1652182295453; Tue, 10
 May 2022 04:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220510093946.335036-1-peng.fan@oss.nxp.com> <20220510093946.335036-4-peng.fan@oss.nxp.com>
In-Reply-To: <20220510093946.335036-4-peng.fan@oss.nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 May 2022 08:31:24 -0300
Message-ID: <CAOMZO5CG65aLB_qy28V8RbnJoSbzZ-skmdt00EGfswyVLBoE0Q@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] arm64: dts: freescale: add i.MX93 11x11 EVK basic support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
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

On Tue, May 10, 2022 at 6:38 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> +       pinctrl_uart2: uart2grp {
> +               fsl,pins = <
> +                       MX93_PAD_UART2_TXD__LPUART2_TX                  0x31e
> +                       MX93_PAD_UART2_RXD__LPUART2_RX                  0x31e
> +               >;
> +       };
> +
> +       pinctrl_uart5: uart5grp {
> +               fsl,pins = <
> +                       MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
> +                       MX93_PAD_DAP_TDI__LPUART5_RX            0x31e
> +                       MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B   0x31e
> +                       MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e

uart2 and uart5 are not described, so their pinctrl entries can be removed.
