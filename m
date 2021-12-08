Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CD46D33F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhLHM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:29:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9923C061746;
        Wed,  8 Dec 2021 04:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3A661CE1EC7;
        Wed,  8 Dec 2021 12:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04BEC00446;
        Wed,  8 Dec 2021 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638966350;
        bh=AwNlKNs1o1R/cPh2iXFM9XUEhK9Xrwq6BwJUnSoKZuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0GZGrdd+EOOVhOEGW4olK3AWSdS29U6DZc5HJimnjiEU1BtHB55EPbqgFn+M/Nn9
         mQCZi2O3kNaU1uSkj7BrRw8gWCCEPEnpqi04yMnxPH2KwT+biKCPf0Z17XRtlxZBWk
         rPnfFA5qiMiFsjvgXAh8b0qjATSXlOUBV8zapWYayVrxky4HR+PhHsDZhcqS88ol/F
         ZtL857YzRi7NFSnhUX7JIqXewtsbZPLqivTxh55y51CdTsZAHffHwKRdX7rgmp0Fnk
         8WkLw5slyMRtxZMHC1/JMGynGdznFuTzI0AL8p+R0FvzB2OwVHht31OzwSbuwkDOIN
         gVWIOecj/Mb4Q==
Date:   Wed, 8 Dec 2021 20:25:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: imx8mn-evk: add hardware reset for FEC
 PHY
Message-ID: <20211208122544.GH4216@dragon>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123080506.21424-2-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:05:00PM +0800, Joakim Zhang wrote:
> Add hardware reset for FEC PHY.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied all, thanks!
