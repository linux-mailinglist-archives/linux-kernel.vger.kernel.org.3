Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD69580819
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiGYXW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiGYXW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:22:56 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B8020BD2;
        Mon, 25 Jul 2022 16:22:56 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id j1-20020a4ab1c1000000b0043576bcb9b1so2436910ooo.10;
        Mon, 25 Jul 2022 16:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnn8K18mvq88VYab55+0JoG29eJ64x7NZ09brZ97iMs=;
        b=Wnm+0MTcfjc1l2GFXMyijHXAcO71v0TGbJs5TAP02iGE6V2GQUXGpS78Jy4ZGP22mK
         A0Ehurg5b4A4oSe2ywQX/gyfJs13+bYFYcSfpxC4Ufq8thZAudR2DIv2LxHBgITsOzoa
         VNRxCZlNr/TnBa9oO9kwmOYSmo638anlxZCNs3cL1LzakblmQZXYE5wJhkZcqXS4+JX1
         fDcXFrYtg3Ae4K6ifTY8ul3LAzfOAjycufSytofgW3libaAKr7f8BO/EZwBm6ZCNXrRc
         ke2NwEqhxfbVcwGkupymsgpv7FRw1eFquySNl9Q8yHbCv1cL6M/0pwLOHCoVogug9FyW
         XvCg==
X-Gm-Message-State: AJIora9qxQ/Pd5IMdPoKZ8zp9CHLRmSmhTGgSxjNzTRWPTNuJ+ks59ZK
        N7NY2ZNjdOpU0Bmo6old2LcruehGDg==
X-Google-Smtp-Source: AGRyM1sWz6zGppOlb8sjeJsLDzij2mDLJErZyrCFpYJJBGl27Fpm9cDgcuNW5I603e9dGuNzUkhz9Q==
X-Received: by 2002:a4a:d621:0:b0:435:d6cc:b2e1 with SMTP id n1-20020a4ad621000000b00435d6ccb2e1mr4977300oon.88.1658791375666;
        Mon, 25 Jul 2022 16:22:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q17-20020a056830441100b00616e2d2204csm5585759otv.21.2022.07.25.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:22:55 -0700 (PDT)
Received: (nullmailer pid 2946562 invoked by uid 1000);
        Mon, 25 Jul 2022 23:22:53 -0000
Date:   Mon, 25 Jul 2022 17:22:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        linux-gpio@vger.kernel.org, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com
Subject: Re: [PATCH 8/9] dt-bindings: pinctrl: imx: scu: correct example
Message-ID: <20220725232253.GA2946504-robh@kernel.org>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
 <20220723094335.3577048-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723094335.3577048-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 17:43:34 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The fsl,pins use uint32-matrix type, but the example is uint32-array,
> correct the example.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml       | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
