Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EED4B2625
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbiBKMpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:45:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350233AbiBKMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:45:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F7F75;
        Fri, 11 Feb 2022 04:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CC85B829FD;
        Fri, 11 Feb 2022 12:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB3C340E9;
        Fri, 11 Feb 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644583511;
        bh=2BfqHuVw1A2QuXdm7z/xYnSnSo8VKbIjp88GJ1BzrCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIkBD1N8qtO+iCqmvNb9Q2HuAYDIMyRPyFyzAHGKbyx6HI2OxNz6NRM3sD73SFTrc
         zKJSqzU0mxlByV7EyEk2yMWsLSOHhL8A5737PeUVHIMtX+P+18A2SRrdo/UVfVWTKm
         hUfdMAyaASkhFZA09q1YDdf8Cu9A3t2tMjNpAUC6VslOybMZ+bbJnZQduczf+Us5rP
         GesC7RdS/0bN2LKo68zdn6HgIMKVKgoYx6xrAudy9GkKaUOhQ6/Ql358qxrTKvYF8b
         UJPTieY6soAZa/QodJIzcFpcB/dp0AqN7XUKv5tgNNP91o4J+f605vLkYmJfb7mABu
         X/gU6V1FuUEEA==
Date:   Fri, 11 Feb 2022 20:45:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/12] dt-bindings: arm: fsl: add
 toradex,verdin-imx8mm et al.
Message-ID: <20220211124503.GU4909@dragon>
References: <20220211092322.287487-1-marcel@ziswiler.com>
 <20220211092322.287487-12-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211092322.287487-12-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:23:21AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,verdin-imx8mm for our new Verdin iMX8M Mini modules, its
> nonwifi and wifi variants and the carrier boards (both Dahlia and the
> Verdin Development Board) they may be mated in.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!
