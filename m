Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C798653BB3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbiFBOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiFBOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:51:09 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211DF2ACB52;
        Thu,  2 Jun 2022 07:51:08 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id s4-20020a4ac804000000b0040e93a35508so943839ooq.8;
        Thu, 02 Jun 2022 07:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1E/3KWBubmd3TEa7PIO3GoA5fzjc3dGvE7ZiPQxDE7c=;
        b=vOL+7uqhWMR0krL/ctUnR2jXSDCWmY1sie+ZyI8dvKCVDE2/NXkeGxRWRRgcsQ52Vi
         GVz3Eml3La6DqIjXKaXpylQC+Ag19iuiBR1C7LES+eG1Hr92gnZo5yFNH+XhdsjVi64t
         m3+oQeCaFqvVvBHicT2qsBeiSDDGBWgwwexVOoluQpXzQfmifpTkTwu4fdExoagkc/jH
         IQIRM31CFBqIbwgHI86WdCKp5ZItk9MSRikPjnxMjxkIrGG09PdLo4mKYzzSOLgj6lhz
         V/0OiJj+WUNbk+mkbwzMS67gwqwOmXR41cAi4JkAhQIww72XJSdeSWF62tHCOQqh9NSl
         QTgA==
X-Gm-Message-State: AOAM5316Yn84lqPNQZVCIk1Fmo2nEF8ilka1D4EWwiVU8hsCbfBwjQL0
        ojGukbb/Llq8pWfN0mj4Xg==
X-Google-Smtp-Source: ABdhPJx/W2nQKKhkMKZ/abujq/Z3ImQBTqczfZI8YQDqn9Fpzc1f8SxvzBCup7RNWtudJZXcjiRXyg==
X-Received: by 2002:a4a:97c3:0:b0:35b:29f9:a212 with SMTP id x3-20020a4a97c3000000b0035b29f9a212mr2200527ooi.50.1654181467373;
        Thu, 02 Jun 2022 07:51:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a4a94c3000000b0040e5ff4a737sm2325045ooi.26.2022.06.02.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:51:06 -0700 (PDT)
Received: (nullmailer pid 2299234 invoked by uid 1000);
        Thu, 02 Jun 2022 14:51:05 -0000
Date:   Thu, 2 Jun 2022 09:51:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <20220602145105.GA2298322-robh@kernel.org>
References: <20220525191026.696636-1-paul.kocialkowski@bootlin.com>
 <20220525191026.696636-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525191026.696636-2-paul.kocialkowski@bootlin.com>
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

On Wed, May 25, 2022 at 09:10:21PM +0200, Paul Kocialkowski wrote:
> This introduces YAML bindings documentation for the Allwinner A31 Image
> Signal Processor (ISP).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/allwinner,sun6i-a31-isp.yaml        | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml

With the indentation fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
