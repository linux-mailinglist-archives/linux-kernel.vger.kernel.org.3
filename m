Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C01500586
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiDNFkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiDNFkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8E3CFE6;
        Wed, 13 Apr 2022 22:37:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DE461E49;
        Thu, 14 Apr 2022 05:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4D6C385A1;
        Thu, 14 Apr 2022 05:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649914669;
        bh=OvCUBTX1ZAgB8ToDSbNbmHnIQ8kXnV7+uWxjqjVKne4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvF5esoQdpTyrqK52quS/FxxjB6PsrHksGx2OwyQ32LgEPhrRjWvKRZApfVZzXLzw
         mA/YzjocNeAB361OfVk1iLricCnMsGhmKaQQqqMfLFpVUocSK4EhKtAscdPfSwqhrq
         61hU3bfa98o3jlZ/v1AgXq1C3TVpQ0yveoZNwhXTnKyverfK8/aZ5gQ+2fv5F/6Yha
         f763hQHqXQoT1EGd9LR0VdPPty+PIp2BUpsTOsGjGR8Te7nd4gHYNJPOaRk/g7SOWW
         4zLCRUHSSRU7olwtqyyhe8J0FK1EaMKmywiIk1SaQ+5kZ5/lRPH3EdDz8v3kaL4BRH
         l0m1h0e63GeeQ==
Date:   Thu, 14 Apr 2022 11:07:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        robh+dt@kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        agx@sigxcpu.org, robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: Re: [PATCH v6 resend 2/5] phy: Add LVDS configuration options
Message-ID: <YlezKAw+W8HOa322@matsya>
References: <20220402052451.2517469-1-victor.liu@nxp.com>
 <20220402052451.2517469-3-victor.liu@nxp.com>
 <YlZpnrKt9NbHZv26@matsya>
 <d77b41d911e126331138ddaca146a581d316bd09.camel@nxp.com>
 <YlaqwoFCfusFgIIe@matsya>
 <a2731b2d77f9bf2adf36f0c05cb5e3b14a5a91a9.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2731b2d77f9bf2adf36f0c05cb5e3b14a5a91a9.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-22, 20:39, Liu Ying wrote:
> On Wed, 2022-04-13 at 16:19 +0530, Vinod Koul wrote:
> > On 13-04-22, 18:04, Liu Ying wrote:
> > > Hi Vinod,
> > > 
> > > On Wed, 2022-04-13 at 11:41 +0530, Vinod Koul wrote:
> > > > On 02-04-22, 13:24, Liu Ying wrote:
> > > > > This patch allows LVDS PHYs to be configured through
> > > > > the generic functions and through a custom structure
> > > > > added to the generic union.
> > > > > 
> > > > > The parameters added here are based on common LVDS PHY
> > > > > implementation practices.  The set of parameters
> > > > > should cover all potential users.
> > > > > 
> > > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > > Cc: NXP Linux Team <linux-imx@nxp.com>
> > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > ---
> 
> [...]
> 
> > > > > + */
> > > > > +
> > > > > +#ifndef __PHY_LVDS_H_
> > > > > +#define __PHY_LVDS_H_
> > > > > +
> > > > > +/**
> > > > > + * struct phy_configure_opts_lvds - LVDS configuration set
> > > > > + * @bits_per_lane_and_dclk_cycle:	Number of bits per data
> > > > > lane
> > > > > and
> > > > > + *					differential clock
> > > > > cycle.
> > > > 
> > > > What does it mean by bits per data lane and differential clock
> > > > cycle?
> > > 
> > > Please check
> > > Documentation/devicetree/bindings/display/panel/lvds.yaml.
> > > lvds.yaml metions slot.  'bits_per_lane_and_dclk_cycle' means the
> > > number of slots.  But, I don't find the word 'slot' in my lvds
> > > relevant
> > > specs which mentioned in lvds.yaml, so 'slots' is probably not a
> > > generic name(lvds.yaml is for display panel).  So, I use
> > > 'bits_per_lane_and_dclk_cycle' as the name tells what it means.
> > 
> > variable name is fine, explanation for bit per lane and differential
> > clock cycle didnt help, maybe add better explanation of what this
> > variable means
> 
> I may add an example diagram as below...

Not really a diagram, you can add if you like.. But something which
explains in a sentence or few about the variable.

bits per lane per differential clock cycle ?

-- 
~Vinod
