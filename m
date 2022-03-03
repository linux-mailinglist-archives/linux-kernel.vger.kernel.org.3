Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC654CBF17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiCCNpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:45:28 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B3518A7A0;
        Thu,  3 Mar 2022 05:44:43 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id j2so4818946oie.7;
        Thu, 03 Mar 2022 05:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=v44qDax9KEdYLRCIw5soHVCzl51dh0SIKoJV0wM0I0I=;
        b=OkA6Y6gMRKlGNHC4ZCPrmmJH4+hSiFQ29bsCoI8lk6HLU3tJICD4pxbOc9noPkO8Ey
         ScKjz2FQCmqXFNNM52TLdBPMQsNhjMKk9uElds9rCzWNvndMnKXCbFoylyI2rWMa2aK3
         St7eKQyGLObR56+1XAKQJDhkRiCK8knL8XwwutzwilSPJqGVYxRqzoPUHdh4hdPynZ0R
         D6oafSwZZelR3R3mGszil7HPEUVJZAz2N8dgQIH5VW9y4K9cMIDO1UQBfxw6L2eYTTve
         dNl+h6SSvkpfu2Q1s3zUiIFGoP3dGthV17Cd4FdUJdQ61jCp6oB0pj2+iDw5ecHH2mdu
         V2ww==
X-Gm-Message-State: AOAM530beMcVPIDUCXGYYU30nx7k55ilYsi5X+nH06ISGqXYH1dfFSsO
        Wl8hA0dP7qXfL6koaVQmaYMSNy9xZA==
X-Google-Smtp-Source: ABdhPJzn31TBcNmGDsK1JV7b+U+3AzzWAVgACRgHF4lqaMW3Q7MxwOp88OaXLDAQFSwz+6Z4Nw7nKA==
X-Received: by 2002:aca:502:0:b0:2cd:c24:278f with SMTP id 2-20020aca0502000000b002cd0c24278fmr4457068oif.150.1646315081264;
        Thu, 03 Mar 2022 05:44:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808065900b002d97bda386esm980555oih.51.2022.03.03.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:44:40 -0800 (PST)
Received: (nullmailer pid 1495431 invoked by uid 1000);
        Thu, 03 Mar 2022 13:44:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, Yong Deng <yong.deng@magewell.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20220302220739.144303-4-paul.kocialkowski@bootlin.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com> <20220302220739.144303-4-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: media: sun6i-a31-csi: Add MIPI CSI-2 input port
Date:   Thu, 03 Mar 2022 07:44:38 -0600
Message-Id: <1646315078.961128.1495430.nullmailer@robh.at.kernel.org>
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

On Wed, 02 Mar 2022 23:07:33 +0100, Paul Kocialkowski wrote:
> The A31 CSI controller supports two distinct input interfaces:
> parallel and an external MIPI CSI-2 bridge. The parallel interface
> is often connected to a set of hardware pins while the MIPI CSI-2
> bridge is an internal FIFO-ish link. As a result, these two inputs
> are distinguished as two different ports.
> 
> Note that only one of the two may be present on a controller instance.
> For example, the V3s has one controller dedicated to MIPI-CSI2 and one
> dedicated to parallel.
> 
> Update the binding with an explicit ports node that holds two distinct
> port nodes: one for parallel input and one for MIPI CSI-2.
> 
> This is backward-compatible with the single-port approach that was
> previously taken for representing the parallel interface port, which
> stays enumerated as fwnode port 0.
> 
> Note that additional ports may be added in the future, especially to
> support feeding the CSI controller's output to the ISP.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../media/allwinner,sun6i-a31-csi.yaml        | 66 +++++++++++++++----
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml:88:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml:90:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml:102:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml:104:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.example.dt.yaml: csi@1cb4000: ports:port@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1600105

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

