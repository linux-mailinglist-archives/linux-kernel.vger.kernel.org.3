Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34C578A75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiGRTP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiGRTPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:15:19 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087282ED5D;
        Mon, 18 Jul 2022 12:15:19 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id r4so2360779ilb.10;
        Mon, 18 Jul 2022 12:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OQ2q0XPtbhdDAfmXDFLPzNTItqEfIgwYo8BHW9R3MfY=;
        b=nCSWnvWblYNNu6yYonySioD6wPbBLTHKxDB3wEAiFfg7b8PSqL/AdjcjkdiO4qJnGS
         qbNuAIrDUM87hO3FOfrD8m7b+DBClUV9L7yT5oqim04ARBZX0vwMt2BrmrkeGOAL3LXf
         y/ynkZ/phW3G+lQE+ic5rEVOa1IYnJg/ClDnUIQKOUZgl/fKUszfxT6+3rKAPAkD8FI2
         9VEeoNtctp0EK9fv28pFuGBRvuC/rQRnyGq7kxTKL5ls9J0pC+RtxiPrEES2UzkhlJBr
         VmsgybcHHe/FlZ7GMyovVL3qRtYNY8vipr4yMG1YhXlS2ZbM0YMl9fU7Opkad2uI66m1
         9LXA==
X-Gm-Message-State: AJIora/HZn3lYMopIpNQRHQWr+QuT1xAtXr3pK6G4cnaJ47ebA+FBGuG
        g5l4gPLRGjpeAVu4GJh8bA==
X-Google-Smtp-Source: AGRyM1ve70yIXqMpeLWi7yVQdpteGvqMDlMDjRmArBpu+KPLnLSj++gQ5cq8zqeU4X5SbM+lo0rYmg==
X-Received: by 2002:a05:6e02:180f:b0:2dc:7a7d:54e1 with SMTP id a15-20020a056e02180f00b002dc7a7d54e1mr14296819ilv.15.1658171718316;
        Mon, 18 Jul 2022 12:15:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o15-20020a056602124f00b0067c291212e9sm308126iou.9.2022.07.18.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:15:17 -0700 (PDT)
Received: (nullmailer pid 3375662 invoked by uid 1000);
        Mon, 18 Jul 2022 19:15:16 -0000
Date:   Mon, 18 Jul 2022 13:15:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mtd: partitions: add binding for U-Boot
 bootloader
Message-ID: <20220718191516.GA3375625-robh@kernel.org>
References: <20220711153041.6036-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220711153041.6036-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 17:30:40 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Right now there is no (known) real reason for a custom binding for
> standard U-Boot partitions. Broadcom's U-Boot however requires extra
> handling - looking for environment variables subblocks. This commit adds
> Broadcom specific binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/mtd/partitions/u-boot.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
