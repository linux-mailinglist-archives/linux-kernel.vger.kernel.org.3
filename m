Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8465056CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiDRNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242966AbiDRNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F836B7C;
        Mon, 18 Apr 2022 05:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C418AB80D9C;
        Mon, 18 Apr 2022 12:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EE0C385BA;
        Mon, 18 Apr 2022 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650286136;
        bh=ihICU86jZLqrg+rCTyEXVS33fBSPZSaeOuWzRAs+kM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UZl9Lrgko67ZlcWXKE5gdGvcXe4FnFDT8gmOCIofeja06AOJWoc7OrUoFesMhYCWa
         AZutFRknK1RO3nNQMq1ffWeiJ62N0kRXFX8zg3ZcWk/O41r2pq8vdqMoYQ8J6jC8OS
         GeP4FBiPyw1Lo0bmjWfupiReQG0G1NFjoFdtztBA8gt39b5/c9Rndx9FHn2przlBFG
         wArvdPg7SH3SxT4KiUfvYa1ZOP6T34ij6qvEORwVy0FeeaJKxzo3eCjPKo2UvYQiPi
         UeJ3s2RxLcj8aV56TJMpVqlFJLi4+b9/+TFBaZLSNMQWlCW+NojdqTvR/nM9Fl52Uv
         LiZ1nDimSK4Pw==
Date:   Mon, 18 Apr 2022 20:48:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add i.MX8M Plus Gateworks
 GW74xx board
Message-ID: <20220418124850.GP391514@dragon>
References: <20220414161505.15524-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414161505.15524-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:15:04AM -0700, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Plus based Gateworks GW74xx board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>

Applied both, thanks!
