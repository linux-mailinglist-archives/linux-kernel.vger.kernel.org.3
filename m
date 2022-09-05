Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202445AC8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiIECNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIECNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEBA21E3F;
        Sun,  4 Sep 2022 19:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4A161074;
        Mon,  5 Sep 2022 02:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDF3C433D6;
        Mon,  5 Sep 2022 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662344008;
        bh=o3EvOFGLfgY+DdoQ9bNy26IsU0VEMoE+5gbAWp/Pq3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrJqXth0GQiXR0/n5wkJ7pPKyVtejSY4TYuQ5OIDeQEY/l8JDLGAytnIGvZnHgQUL
         yCVgZYpV+IaYw0rFstpxS3hTs54J6aHad9+vDGDSczgk4g/HItvht5qUlcLRh2nBEp
         YFFllmynz6s4fYOx6GKZKt0F4jXEqlexjltnjjRCdqspsaKZ4LvUtukxMNVqu1Yi76
         LiwCtvH9w/vK6gmKFl+DdLn4cfD3IS38IXIZJ+JGhHx3yubo0sHFQ+/T9sFyfMmoDX
         ZS9db5287K04OqWlgZwDUFNfcE1TmyJrYiKiqrleVv4w5qGMvB0QqBl0kCsCiuMi2I
         iNOLpzTtdBtCQ==
Date:   Mon, 5 Sep 2022 10:13:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: imx6: skov: migrate to
 resistive-adc-touch
Message-ID: <20220905021322.GA1728671@dragon>
References: <20220830112121.2059062-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830112121.2059062-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:21:21PM +0200, Oleksij Rempel wrote:
> Start to use more generic resistive-adc-touch node. ti,tsc2046 is an ADC
> controller used for resistive touchscreen. So, define it as ADC and
> attach resistive-adc-touch to it.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
