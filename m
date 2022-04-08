Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DEC4F9468
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiDHLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiDHLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE061CB142;
        Fri,  8 Apr 2022 04:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D975762021;
        Fri,  8 Apr 2022 11:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D5C385A3;
        Fri,  8 Apr 2022 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418246;
        bh=3Kul2wzQtsB35iEOBFbQYyIbEh9+IstWKxxpGQnGGtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux4sDwkTHqmfSx44F/w1VTmBoYIT9wzmqMBtsqvwVOpoqvnbSHsNSUmdgxFSKIx5f
         G62/pe0F1SIx3grxriLFSpgMpr3x3MMuPVk9dPal2tLWwIv6OwQ7P5r6/XEZkCyIMH
         kIyY3qd8dpoWrxsZO8l7KWzzdYjX2SDkR9IPQU+HCAxMeOc4sK7JHv6IG/gPhRBfwt
         PwqR9M4wNmgJn3PPaLv1jfI9+PTYiko5YfCL1QBH4cxQfVdRZGBwcSm9HKDgDDcI7G
         PVlJAPt5vwaMlsf9t5vtnefLXwKfJ8ckOCEgZb1dtkBAHITsUOBYrINiRbo9YEwtz8
         pdM+1scHZh4Jg==
Date:   Fri, 8 Apr 2022 19:43:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: add QSPI flash
Message-ID: <20220408114358.GV129381@dragon>
References: <20220228132523.2679099-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228132523.2679099-1-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:25:23PM +0100, Michael Walle wrote:
> There is a 32MiB Micron MT25QU256ABA1 serial NOR flash on the EVK board.
> Add a device tree node for it.
> 
> Tested on a 8MNANOD3L-EVK.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
