Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA0549C94E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiAZMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:09:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiAZMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:09:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1805B81CBB;
        Wed, 26 Jan 2022 12:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5D7C340E3;
        Wed, 26 Jan 2022 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643198963;
        bh=qP/fP13bd/g7DaZCJDNkqqQ0E9aN6lHiozEe0AOVbHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNpaT7n6fMX037HLwzJw7tksl2/dQoNWFIgD7JSyDEO8pgrfwi2qiI2GNFq5x4YqB
         2hHlyAdI0bwkAYcMZOHT2HJUbyAG8RpQ49XDJbziuiDY3R5FeouKeapJF5IsN3DN/r
         lZkS3cCXoooFqSXUFmRRGXNNPAdJjk/7ZWyfXETQNmcYT1ivzJzUDPFMayHdwHRCqn
         /nGWl6mePSmSa0z0gpoTNjQgOtNQW60AIJ+gVqpjASrscCva8H+RzcHrcIUf3dc3b9
         yqdycoCmvOGWxTpq8pMjIxAB/MyGHSqjLu84zufwHts9AFYx3uhxSTlb/KOrBSt93e
         MaqTtC53bhLHw==
Date:   Wed, 26 Jan 2022 20:09:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8qm: Drop CPU 'arm,armv8' compatible
Message-ID: <20220126120914.GN4686@dragon>
References: <20211217173908.3201517-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217173908.3201517-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:39:08AM -0600, Rob Herring wrote:
> The CPU 'arm,armv8' compatible is only for s/w models, so remove it from
> i.MX8QM CPU nodes.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
