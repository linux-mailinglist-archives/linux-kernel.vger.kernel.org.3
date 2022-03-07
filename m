Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356F4D0BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbiCGXW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbiCGXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:22:54 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A249C87;
        Mon,  7 Mar 2022 15:21:58 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id z7so17060824oid.4;
        Mon, 07 Mar 2022 15:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7qb95iWDy4CrMuix2n1CWTaNA8dbLvS/zT6J6EUQCm8=;
        b=7ewHDt8/1gXIU8PdAXUZXR6oDjenE/ZVJDtfKkx0AKxboIDXbrk6MNE3T/1GlSQS3U
         7zhRj3YJpApUVzl/mKYdiri/Vs4m+qC1TXfBLEnqBVxsSuczMbZxdQOfbgVyL3fpcugx
         ode/MgmCjPS8tFuS24iH1TlVAZZIaupBLlVX0Tm1OpPRquq9bn4jVMcZuQ3HV9JVlqsg
         SaFY5hB7Q8lRcka3AeK2W51zW64GQWLjrBIiTyMzBcxld5NYK4ZkQYUp3FGyxEXDJYJ1
         +zWHFkS5UdcqBwFDNe0wsO1yHjl6mlIn8HqEjkV2khIKRsQdXtpQ4ClooWvJLq47KFli
         gAiw==
X-Gm-Message-State: AOAM531Xhh5TPbeilGvu+uN9gX2PHRQwdnbDRw2g/dfwT5Ndj0TMRfaI
        bDvtBG9DInWPOuvOdCSFQw==
X-Google-Smtp-Source: ABdhPJxGLJw+PA8u5LjczII+zDnGfV83d44pnqceSKY4k47PR7tDdc9dcTlVcPdn5qROrtXm2/yckg==
X-Received: by 2002:a05:6808:2c4:b0:2d7:968c:dd37 with SMTP id a4-20020a05680802c400b002d7968cdd37mr939881oid.146.1646695317419;
        Mon, 07 Mar 2022 15:21:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p67-20020acabf46000000b002d97bda3868sm7117107oif.45.2022.03.07.15.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:21:56 -0800 (PST)
Received: (nullmailer pid 3453919 invoked by uid 1000);
        Mon, 07 Mar 2022 23:21:55 -0000
Date:   Mon, 7 Mar 2022 17:21:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: interconnect: sunxi: Add V3s mbus
 compatible
Message-ID: <YiaTk5h1n0ifNAj6@robh.at.kernel.org>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-3-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302211100.65264-3-paul.kocialkowski@bootlin.com>
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

On Wed, 02 Mar 2022 22:10:54 +0100, Paul Kocialkowski wrote:
> Since the V3s uses the internal mbus for DMA with multimedia devices,
> document its compatible in accordance with the extended mbus binding.
> 
> This will enable adding support for the V3s in the full-fledged
> devfreq driver eventually.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
