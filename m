Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326E504FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiDRMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiDRMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:09:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B6A1A2;
        Mon, 18 Apr 2022 05:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 902E3CE1084;
        Mon, 18 Apr 2022 12:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4BAC385A1;
        Mon, 18 Apr 2022 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650283624;
        bh=nVW4LayyYgoOgbe9+Cz7WSs8QUHwVnSEbWBpCgfOQTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFamS6hD9udGUTmfJMD/PPXpXHph9g96XNrR5uFjTQU9lBrYkIumvzNov7WMWaBGu
         Z2kK15+RLpgzUt4WyfKbsqO+CmoBHJ3tfn3OhJfhlMDwawXq5ELBO27cj0LninbEET
         PYr5r6lQ9hd+g7ey+JGz58hzpAgof1zTAQnnkO40zOKMrcBEMWuFReQ7mjF0QioHT0
         cxIdRYu93XwxZZc9IanoBfSZpI1LzIsKRMAGikjWjwbJM2yAy9Bt+TICEb8JJVqM8y
         a3py2xsmTifwo24bQyftI/zZxiZ4tFOvYzTLpkmTaIr6qJOvbYvGXihB4q19mTOuNK
         QxgZdiT9c1Rkg==
Date:   Mon, 18 Apr 2022 20:06:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] arm64: dts: imx8mn: add 8MNANOD3L-EVK device tree
Message-ID: <20220418120657.GK391514@dragon>
References: <20220412143238.1925059-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412143238.1925059-1-michael@walle.cc>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:32:36PM +0200, Michael Walle wrote:
> Add support for the 8MNANOD3L-EVK which features a NXP IMX8MN SoC.
> 
> Patch 1 was formerly postet separately, but never picked up. So I've bumped
> its version and added the actual device tree. Please note, there wasn't a
> v1 nor a v2 of patch 2.
> 
> Michael Walle (2):
>   dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
>   arm64: dts: imx8mn: add 8MNANOD3L-EVK device tree

Applied both, thanks!
