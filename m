Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED62534853
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiEZBqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiEZBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:46:47 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9218DDD2;
        Wed, 25 May 2022 18:46:46 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-f2a4c51c45so642179fac.9;
        Wed, 25 May 2022 18:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6furrOjrDUV85XtAuBJ6m/tHv7Cr2IP2D70aDr3j5Hs=;
        b=CX0a9LX9eNGbMICfAvHZvynpch4OdwE6wbsOCKp6eQiv5LXl1T5dKjAFX5GaRI1ypS
         mIlaw+nsowbj4bXrm+41PcgQiI/b0GJXAMsC8DrSNL6lXWDsqQGoDg8eHO1FXAwufNrX
         D1/FDvVHohuc5u3uO8L2gE20tRi+ym8OtVplIpwcoqDp9B7XnXX8nE9sIl/Ko5BLnyeX
         N7LsVxgg3/SDo+qt5/ssxRsMXZ+EFv014rGlix4RGDbAeDYqk4ZVgdKDKfps6puY76Aw
         zt8dtftXD96gF9F6zCFNkZxtn4OeldQl73wG8aqwArqbi50jggjmqZg4Car8nCOK0jZV
         HPLQ==
X-Gm-Message-State: AOAM531BsSxauEd+lV2FPNgdQNpt2qzgdFlBUjKPVXiwxX0rpiOMxTgr
        02pl+Gk/ov7eN2Q/3YPR4ysc0TGV8Q==
X-Google-Smtp-Source: ABdhPJw0MqIKEAYGSj8vFkwsSBLltgN0uJecV7/4E3iNGQwDikRJ1m1S3Ib8YDRu6U6xOvZfW4rMOA==
X-Received: by 2002:a05:6870:b609:b0:f2:74e7:9bf1 with SMTP id cm9-20020a056870b60900b000f274e79bf1mr4887oab.141.1653529605213;
        Wed, 25 May 2022 18:46:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a4ad645000000b0040e5ff4a737sm141390oos.26.2022.05.25.18.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:46:44 -0700 (PDT)
Received: (nullmailer pid 2880899 invoked by uid 1000);
        Thu, 26 May 2022 01:46:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
In-Reply-To: <20220525191026.696636-2-paul.kocialkowski@bootlin.com>
References: <20220525191026.696636-1-paul.kocialkowski@bootlin.com> <20220525191026.696636-2-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: media: Add Allwinner A31 ISP bindings documentation
Date:   Wed, 25 May 2022 20:46:43 -0500
Message-Id: <1653529603.421651.2880898.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 21:10:21 +0200, Paul Kocialkowski wrote:
> This introduces YAML bindings documentation for the Allwinner A31 Image
> Signal Processor (ISP).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/allwinner,sun6i-a31-isp.yaml        | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml:53:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml:55:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

