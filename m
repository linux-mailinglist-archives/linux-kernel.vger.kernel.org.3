Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCA567485
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGEQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGEQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:37:47 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A21CC21;
        Tue,  5 Jul 2022 09:37:47 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id n7so1062920ioo.7;
        Tue, 05 Jul 2022 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c55GW3JhZSSyCs5z2S50t5xP4aI3+vGX0Hxqnl5VHBw=;
        b=J87nGFJ+CFcHxdhHFsw04/cV1jJirPSLEgTzw0yA4Gwh3BByqKS1PuL6EMXV11szcJ
         H37r4vXxtgvATUSVl9pT5n3s1Oybid864hD34l6aTvdDQtdzVQz/05vkZXKNdMInCSQa
         /S4PHWBwdIzKSY+wPOrihrzEjpm6eQ6v29ZyRJwMsdlvrUmAoKPmHmtz/vb6BLRob+Uv
         Yx4eNwCbXocBw87CjFCTSLgXrukU2ybM8HLwhadYIj41N9E0+q17PjWhlusjM/r6NYZ3
         5yOo4awm7MhSTON0KrQWOdt88Zem0Gg2SP3Wy6qgSKp1J2pcV9u/og7PXMOaut2TkJdW
         LGKw==
X-Gm-Message-State: AJIora+oq3BzB5GRxA7R1ApaAv6UTJ4ic5nr61eJ+OIjNhnjQfzl6rLs
        YnqUoFSn9/zwYc1Rb8L084dYitbtbg==
X-Google-Smtp-Source: AGRyM1vY4x7KgFkloP8FcLuexH2ZmYRLJDRXCJ33C28v5rVjyEV6dX4JIuxxIftRTQsK9XuPc/RFMA==
X-Received: by 2002:a6b:f20f:0:b0:675:5519:744b with SMTP id q15-20020a6bf20f000000b006755519744bmr18448319ioh.202.1657039066422;
        Tue, 05 Jul 2022 09:37:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m9-20020a02cdc9000000b00331fdc68ccesm14830816jap.140.2022.07.05.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:37:46 -0700 (PDT)
Received: (nullmailer pid 2234555 invoked by uid 1000);
        Tue, 05 Jul 2022 16:37:44 -0000
Date:   Tue, 5 Jul 2022 10:37:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-staging@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: media: sun6i-a31-csi: Add ISP output
 port
Message-ID: <20220705163744.GA2234496-robh@kernel.org>
References: <20220704173523.76729-1-paul.kocialkowski@bootlin.com>
 <20220704173523.76729-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704173523.76729-3-paul.kocialkowski@bootlin.com>
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

On Mon, 04 Jul 2022 19:35:19 +0200, Paul Kocialkowski wrote:
> Some Allwinner devices come with an Image Signal Processor (ISP) that
> allows processing camera data to produce good-looking images,
> especially from raw bayer representations.
> 
> The ISP does not have a dedicated capture path: it is fed directly by
> one of the CSI controllers, which can be selected at run-time.
> 
> Represent this possibility as a graph connection between the CSI
> controller and the ISP in the device-tree bindings.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
