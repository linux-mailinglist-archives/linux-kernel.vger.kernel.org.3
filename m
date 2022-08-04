Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5419658A195
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiHDTvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbiHDTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:51:14 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA316593;
        Thu,  4 Aug 2022 12:50:45 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h138so462509iof.12;
        Thu, 04 Aug 2022 12:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=VfcXQX2iRG7E6MWpE8aWtWjOWzDlHACnvOKDvtpAZuk=;
        b=HROCspu8Cb9ilK7VMYe7Pl55gC5pDpNyEI8QELyf3KCPqz2JTzjpbNCJIpqED4yjLb
         wtD8TW49gEvwpX6udPc9WTtP2Dk9HhKSJr9PJdEXpvpGfnLWYbJ4t3M4SQKR43WOnqzF
         ZeV1y8h5VRuvMMqecmbVE8d5k5C8opZzkmvLb/Np1/9iD2CyBnDM25If9EAASptkLdYU
         RvzVXDlLwNVKHumk4V4ehFzo9NvZFeKuf8lZpIntWoc61Hyg/Yi2psmOefbdl29KzB0f
         WxYDQ+yekQolOnayE7gcTCgoyZimm3k67uxjxHUus1mLR6z7QYXbKz1WLFG4ccsYAWzB
         vMww==
X-Gm-Message-State: ACgBeo2JLHE24UpQLVHbBl3/eSOHfqJnKJMaivHnvmdnu37ys8bAuzef
        anv/aISPa8+ILioJghiyxg==
X-Google-Smtp-Source: AA6agR6uPDT96u8m5bxWMZ1urtuQfrAc4Xhd6x4d32l32wWs7f6kpjJA1wdL+wfyJNC/pu7a0igxng==
X-Received: by 2002:a02:9408:0:b0:342:834c:6b1f with SMTP id a8-20020a029408000000b00342834c6b1fmr1535870jai.0.1659642643535;
        Thu, 04 Aug 2022 12:50:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q10-20020a02b04a000000b0033f4a1114a6sm805653jah.178.2022.08.04.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:50:43 -0700 (PDT)
Received: (nullmailer pid 259298 invoked by uid 1000);
        Thu, 04 Aug 2022 19:50:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com, linux-gpio@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, brgl@bgdev.pl, s.hauer@pengutronix.de,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
In-Reply-To: <20220804184908.470216-2-shenwei.wang@nxp.com>
References: <20220804184908.470216-1-shenwei.wang@nxp.com> <20220804184908.470216-2-shenwei.wang@nxp.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: gpio: Add imx-scu gpio driver bindings
Date:   Thu, 04 Aug 2022 13:50:38 -0600
Message-Id: <1659642638.751216.259297.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Aug 2022 13:49:06 -0500, Shenwei Wang wrote:
> Add binding document for the imx-scu gpio driver.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  .../bindings/gpio/fsl,imx8-scu-gpio.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/gpio/fsl,imx8-scu-gpio.example.dts:18.18-22.11: Warning (unit_address_vs_reg): /example-0/gpio@scu: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

