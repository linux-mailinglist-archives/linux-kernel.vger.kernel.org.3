Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3A571987
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGLML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiGLMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:11:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EAA2EFD;
        Tue, 12 Jul 2022 05:11:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bp15so3667654ejb.6;
        Tue, 12 Jul 2022 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUup2uDXZ8o0p1sWQoMcoPhfIwXCF5ZE26LejT9YLSI=;
        b=L01G/T8HvUDMaO5oB3F7fjPfeCZcHuQ87OMVJ5n5Z7U+PRPu6Afna1h7Y9DH2C/LkF
         30nQ0GpWPRXviqZ6N7EvWZvZZVvuyZhRzbBjY+h42xIFEKMFseb0BcSZvAsGRQJb8jYT
         B4S+yspb9IA94KnJ+i4Y4Ld4xQmoFhGg0N3omjLf13yxgg01lbvz59yGnW5E6QxPaTq9
         1vkGK2bgVvwiVaBm1RXa/elbPFSXntWFsBt8yXAxGJW1K4Q/MLmhZVvJHLAT/Ej/gfuK
         /mimE2QW9y89PSnKRUhdeW4w7U8UHKRtpElE1MQAoRZezYtqbnGtdb4mK9Fu5wTmjQbS
         35Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUup2uDXZ8o0p1sWQoMcoPhfIwXCF5ZE26LejT9YLSI=;
        b=mOqcdj7VwAaoImxiexh1yC3pbfan3eNjLaHTyPdFirCmI0bfEp6f2QoryLeensNBu1
         f3uZgCVyHf2XrPIVscKoWlFAo0Bov3qksRbXWSNGwvzafYEi+bzjVIfkP0mQNbxBY26g
         kr3AyeK5T/wlCYRw1BgMAw7vUcHLn4tk+46shaaepX2iEFasnuumyzC8w1lXFcu7Q9QR
         SSmYsPDHCbsFZNdrShS34ETryzNjptkxQBbQebLwi1umjMBKlumHHW5fI15GbaSIZ+8Q
         yE1HfxwFFWpoj842ilsWReWiqqtqo/LuHqiHWOaJoRgnRRxBwTDpyy6yUEtxnnm007M8
         wdAw==
X-Gm-Message-State: AJIora+/5ZAriMyUlnjQgGwWOpGsQsssB4SxqC95RAhFPIfj4eX5EfLR
        Q/zyOx+cFmAvx6kqFc8m0F1ZI2SJ5Bgzd/kfkUw=
X-Google-Smtp-Source: AGRyM1sSFVDbDH06DtJDlcsIYdLZJAcNINyNcdyUrh6tJPGsBlmIB44bi9Qwv4B+3NVBe7/GScLQREPobt/sEFSXyeQ=
X-Received: by 2002:a17:906:6d91:b0:715:7d4e:84a2 with SMTP id
 h17-20020a1709066d9100b007157d4e84a2mr22498321ejt.504.1657627909594; Tue, 12
 Jul 2022 05:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com> <20220712082146.1192215-3-peng.fan@oss.nxp.com>
In-Reply-To: <20220712082146.1192215-3-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 12 Jul 2022 07:11:38 -0500
Message-ID: <CAHCN7xLhSKQa3-ueiOz4ptg7Sp1vF3rmN5JRzqA+euVKYbZoOQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, paul.elder@ideasonboard.com,
        Markus.Niebel@ew.tq-group.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 3:20 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
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
> +
> +  interconnect-names:
> +    items:
> +      - const: g1
> +      - const: g2
> +      - const: h1
> +
>  required:
>    - compatible
>    - reg
> diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
> index 14b9c5ac9c82..11d43fc7a18e 100644
> --- a/include/dt-bindings/power/imx8mp-power.h
> +++ b/include/dt-bindings/power/imx8mp-power.h
> @@ -52,4 +52,8 @@
>  #define IMX8MP_HDMIBLK_PD_HDCP                         7
>  #define IMX8MP_HDMIBLK_PD_HRV                          8
>
> +#define IMX8MP_VPUBLK_PD_G1                            0
> +#define IMX8MP_VPUBLK_PD_G2                            1
> +#define IMX8MP_VPUBLK_PD_H1                            2

Is H1 even correct for 8MP? The TRM calls the encoder a VC800E.  Since
the Encoder on the 8MM is a Hantro H1, this might add confusion if
people start thinking they are the same.
> +
>  #endif
> --
> 2.25.1
>
