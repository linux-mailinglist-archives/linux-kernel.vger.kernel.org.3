Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF955C8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiF0NbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiF0NbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:31:15 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2D86457;
        Mon, 27 Jun 2022 06:31:14 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id p128so9567457iof.1;
        Mon, 27 Jun 2022 06:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QYhUBm2fDCk91Yu6XF3jkA7KmooMdeJ8YT8X3liUnpQ=;
        b=Sfyohu4QQ/fAryO/zwZnK5jzdVXMqYcVAuZL4ae6Z4/qdjCuYflnuQwG/2cA1aHISW
         AzuICHovEA+0EtY7lo5LhlOTd3k4UWsmuX68Y4h8alDICJBvlaQKnlyM4aKiflTPlBRY
         HJJqe2NWSEXWvEjfD/3FijzLSzWq4qDHyXZhu2X4iZdIu6A+dbBWh9mfNc/FNZCB3+Gk
         lfaD4mcZf+V+yWr5R/qUdB0/ma8pgYn8U7oHyyOElM15lbSnXhmXElya69LxtTO7tDSo
         mkfIo+mN3sHR6SkMPOpukEoEcnyb/vgE33IC7E+90IeljjSGvpZMp/5mddS/eKmESDYC
         tcNg==
X-Gm-Message-State: AJIora8AtCVnc94a2c1D04UNWmQYnNphS37kStvhGzPUVuWcL0l88Cyc
        excE1ANC//pkAVQPZlZdE88aNnzP2Q==
X-Google-Smtp-Source: AGRyM1t5LTyR7mVbDtnvxUaO7kFkqXlKaKnkl6jX5y381d5nO3LPJEow6rHeBCy77jwPiTpVZyN44Q==
X-Received: by 2002:a6b:d309:0:b0:664:716c:d758 with SMTP id s9-20020a6bd309000000b00664716cd758mr6604131iob.157.1656336673455;
        Mon, 27 Jun 2022 06:31:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d8041000000b00674f9fb1531sm5159907ior.30.2022.06.27.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:31:13 -0700 (PDT)
Received: (nullmailer pid 2285174 invoked by uid 1000);
        Mon, 27 Jun 2022 13:31:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shengjiu.wang@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com
In-Reply-To: <1656294613-27867-1-git-send-email-shengjiu.wang@nxp.com>
References: <1656294613-27867-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: fsl,micfil: Convert format to json-schema
Date:   Mon, 27 Jun 2022 07:31:09 -0600
Message-Id: <1656336669.670812.2285173.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 09:50:13 +0800, Shengjiu Wang wrote:
> Convert the NXP MICFIL binding to DT schema format using json-schema.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> - add decription of interrupts.
> 
>  .../devicetree/bindings/sound/fsl,micfil.txt  | 33 --------
>  .../devicetree/bindings/sound/fsl,micfil.yaml | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


audio-controller@30080000: clock-names: ['ipg_clk', 'ipg_clk_app', 'pll8k', 'pll11k', 'clkext3'] is too long
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb

audio-controller@30080000: clocks: [[2, 183], [2, 182], [2, 38], [2, 39], [2, 6]] is too long
	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb

audio-controller@30080000: clocks: [[2, 216], [2, 203], [2, 38], [2, 39], [2, 6]] is too long
	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb

