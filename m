Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AE4B28A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiBKPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:03:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351238AbiBKPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:03:13 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128EFF;
        Fri, 11 Feb 2022 07:03:11 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id l14so9228183qtp.7;
        Fri, 11 Feb 2022 07:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ku3rnuhABpjmC2Eeug92tBeXyU5N8pEMH3pcJ24UQk=;
        b=fQt0OsntoYdlJrqEnT3PqAEP46ktAuNSBmLyqFISEfrkrm2SpotyZXRXitn36q1gV4
         NldueAQeKly5dhupkRH57LhtqOb5ZA9uPgxROYb3gm+D/VdgWzVRTkKqLxzZi3NTXKdN
         9tVD+3LvLE6UnvtkXRdM+bZzCfYxdSpJB2al2cnFE6aWn1ZVe/LUtfVqEjiSL40rGNa/
         ZIkwuMZj8jRBuQBGtaGlfqrpWDacgRRrOujoQVy/Nw/PtLRgF62mXts5zStWA+VMy16A
         9VvsIgCm196ZgnThWhrgRtQQ80pNlZY6+R0SQCoFxdUQehmGpv0uJRtESm8OF3zH4Y2M
         J//w==
X-Gm-Message-State: AOAM531AdXo/E4j2TncHA9dOyEMihGII0glwBp89JoY9k9oEbcpnWsHi
        mjTfdf1fWL5ntOBfQWdV6Q==
X-Google-Smtp-Source: ABdhPJxaSWsNdORxuo8Y8BQZfEAbE5cAgspJtSvjyPmVmHhgld8W3y5Q7hYinuqmx2N65aqAF01blQ==
X-Received: by 2002:a05:622a:1006:: with SMTP id d6mr1373542qte.575.1644591790918;
        Fri, 11 Feb 2022 07:03:10 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id u17sm11056272qkj.44.2022.02.11.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:03:09 -0800 (PST)
Received: (nullmailer pid 363394 invoked by uid 1000);
        Fri, 11 Feb 2022 15:03:06 -0000
Date:   Fri, 11 Feb 2022 09:03:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 05/66] dt-bindings: sun6i-a31-mipi-dphy: Add optional
 direction property
Message-ID: <YgZ6qsdO+SfTemPZ@robh.at.kernel.org>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-6-paul.kocialkowski@bootlin.com>
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

On Sat, Feb 05, 2022 at 07:53:28PM +0100, Paul Kocialkowski wrote:
> The Allwinner A31 MIPI D-PHY block supports both tx and rx directions,
> although each instance of the block is meant to be used in one
> direction only. There will typically be one instance for MIPI DSI and
> one for MIPI CSI-2 (it seems unlikely to ever see a shared instance).
> 
> Describe the direction with a new allwinner,direction property.
> For backwards compatibility, the property is optional and tx mode
> should be assumed by default.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> index d0b541a461f3..22636c9fdab8 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> @@ -37,6 +37,18 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  allwinner,direction:
> +    $ref: '/schemas/types.yaml#/definitions/string'
> +    description: |
> +      Direction of the D-PHY:
> +      - "rx" for receiving (e.g. when used with MIPI CSI-2);
> +      - "tx" for transmitting (e.g. when used with MIPI DSI).
> +
> +    enum:
> +      - tx
> +      - rx
> +    default: tx

Can you the phy mode to imply the direction?

Rob
