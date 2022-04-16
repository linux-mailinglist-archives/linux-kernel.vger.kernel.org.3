Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196915045A0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiDPWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDPWUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:20:14 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E9E6D;
        Sat, 16 Apr 2022 15:17:41 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e5bdd14b59so1531796fac.11;
        Sat, 16 Apr 2022 15:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7dPcFs565C9c1WFXikvbzN8qlHn8qJL0dUAk+7Q/+p0=;
        b=TLa8UZ+sDlYr2yJBFVXvUBIghsB7i2bPqTGG1iR/sCGk4iZ2FkeCD+NfOv2EHeIJqZ
         iQy25dTUbdizs7rTfsbnWCg1MqeR+MtYE1KQGh8NqsRFP4hb3+g/H7IyaKbdVUok6B74
         vAA2IRQiCSSaY4ISdvhU0M48IK2EV6sRyT4KuZcGU+T9f/+XdjC5pTDoC+RiIQoO0KhX
         iBKoBHkU5dZHStc1GcaOQkYKlY1tjaHcsAD/su3T49L3smtpEa10rRpfwnG1rkAqM5Xo
         6KhPQ8bZw7/ayxE7eLA7RDpcw90s9AJa+lN8CgTNeG92Zp070zEi5nFCA2NS91k1mAaC
         8fUw==
X-Gm-Message-State: AOAM533j8tJmKmRHusEarV5p/Uj79+/Jtcf0fcX7fZfawBgc4wYjKxm6
        Ozx//qzQPv2PJvI6Wdrl1w==
X-Google-Smtp-Source: ABdhPJzcOBOFLYRBnjRkFKYm36bRA1+9aCycXC6AAhf5bxP7oOLONMn2t+h7bqsghdRFSNm7zPU0jg==
X-Received: by 2002:a05:6871:58c:b0:e3:25e9:6792 with SMTP id u12-20020a056871058c00b000e325e96792mr3791936oan.147.1650147460477;
        Sat, 16 Apr 2022 15:17:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id os2-20020a0568707d0200b000e42ef7cff2sm2727982oab.43.2022.04.16.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:17:40 -0700 (PDT)
Received: (nullmailer pid 3544946 invoked by uid 1000);
        Sat, 16 Apr 2022 22:17:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
In-Reply-To: <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com> <20220415153708.637804-2-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add Allwinner A31 ISP bindings documentation
Date:   Sat, 16 Apr 2022 17:17:39 -0500
Message-Id: <1650147459.143664.3544945.nullmailer@robh.at.kernel.org>
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

On Fri, 15 Apr 2022 17:37:05 +0200, Paul Kocialkowski wrote:
> This introduces YAML bindings documentation for the Allwinner A31 Image
> Signal Processor (ISP).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/allwinner,sun6i-a31-isp.yaml        | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml:73:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml:75:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

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

