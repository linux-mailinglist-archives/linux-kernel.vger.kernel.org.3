Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808E4F6450
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiDFP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiDFP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A0147513;
        Wed,  6 Apr 2022 06:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF886142F;
        Wed,  6 Apr 2022 13:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E26C385A3;
        Wed,  6 Apr 2022 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251263;
        bh=ViYRsF890RbISR0gDdLtC5jAvfvnM2EN5LeAZe+XYW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGbW0mAy7/Fe/+/3EP9kURYuQpgSYTJd7TIw+HTx6WN82Wz3s+/U9ElV+3iO4j7dB
         iW06PKf0HHRelYYrfmcwfWZb9cMp755kbYv/m6DglZ+0UV/onFn+wpgf8qA7mRjKYX
         Ck4LXsLEUnp9JVTsJfrma2QwUfR6farHS1A2wBQrjbJ5MubYy5hgWdv4y/ax9/M33i
         goAk/2bV+PhqZFyNfLpRcDHLW59mmceDIbr6GNFw0JpwccoO0ZjcLWwzU6AqhzCTyc
         FsFuykkIzX9hUGRZjjxyJ+hSrjJMWGMGYoZrG6e+aXPRIfd3auTVJ8yGi+Jxs34Alk
         W4l/BgI78ooKQ==
Date:   Wed, 6 Apr 2022 21:20:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, heiko.thiery@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC
 outputs
Message-ID: <20220406132056.GR129381@dragon>
References: <20220224103030.2040048-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224103030.2040048-1-michael@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:30:29AM +0100, Michael Walle wrote:
> Use the power signal names as given in the schematics of the reference
> board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied both, thanks!
