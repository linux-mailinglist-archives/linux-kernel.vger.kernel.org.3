Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30D4C4004
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiBYIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiBYIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:24:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252761FE559;
        Fri, 25 Feb 2022 00:24:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9189C61C2C;
        Fri, 25 Feb 2022 08:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFAC340E7;
        Fri, 25 Feb 2022 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645777452;
        bh=wUTRPoZn8BBAycadtcQaV6M3VNL/c4t5P7L45uO3280=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1O9sO5wWbnSx3EvC2Z4tnYFNbOV5Q7hLiP08crAOSllI0TO/SUTUSRSWk+MSIWxB
         KqVrA5RiWqGTQhe7zKDuRk3KKUlPACENjLk2UQEqjgF/Q4ZfJ/WXwqdmS3nWVazfGo
         V8gpaasvP0cZ/VnwSPd8Q3dr7DrkLp/cIHDzzpsQWnZy2SO2HHN0Sp3pOq0I1M+P61
         NeyDcKuAfqftetN8bMsSgzVUXeHHjbvcSB+jRTFyXRAPsWaJ8Qi5uprYIi63GY/5Hc
         8WmphOFf8jn/QnBzzcp8PuLMocxWhibDRCt/fdPoOnBnnbKd5qRtxxeEsqyyc++6Tm
         /Kx0oXkuJNmgA==
Date:   Fri, 25 Feb 2022 13:54:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: Add compatible for D1 USB PHY
Message-ID: <YhiSJw1fhuyQF2Lg@matsya>
References: <20220203013558.11490-1-samuel@sholland.org>
 <YhiRyq7k5jtSKlni@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhiRyq7k5jtSKlni@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-22, 13:52, Vinod Koul wrote:
> On 02-02-22, 19:35, Samuel Holland wrote:
> > D1 features one OTG port and one host port, like the A64 SoC, so its
> > USB PHY supports the same set of properties. Add the new compatible to
> > the existing binding.
> 
> Rob?

Never mind, b4 found it... Somehow my inbox doesnt show it... 

-- 
~Vinod
