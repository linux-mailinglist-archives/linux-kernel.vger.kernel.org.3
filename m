Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AE49F5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiA1I7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiA1I7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE224C06173B;
        Fri, 28 Jan 2022 00:59:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99832B81FAF;
        Fri, 28 Jan 2022 08:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1383BC340E6;
        Fri, 28 Jan 2022 08:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360378;
        bh=+fZaRlDISnUwuAYbeNy9KHqyt6UdQXHyFlLsTJdc2Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdbpl/5F+cbASbCES8lzbGtSgkS5aw6nocwSwYa0hej56KVFlMf8vK9MG8fphd9cH
         P8lo8gdFOFruscMirERgkLqbYDGVKyAscp70enZiCdEltPHnOZvwonK1lymvOIrUSB
         PGVtCTj1E3ggSdryn7n5bUElqB12WNp6qq9cjps1t1Zcl3vaD3ax4Nat6ne5hFMk4Y
         0rPBJotlQ9cOK6dzo3AgPWoiU5qe90MdTlFIl1pE+yK8q+bPuwTZSlxYTZNDZDoa5J
         qDulEmha90SBc11vlUphOG8gdD6vORppKEBjxFJMZ30vK7RR51ElbPMnK3XV9nz2fh
         SHGPKS+laVM/Q==
Date:   Fri, 28 Jan 2022 16:59:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8: add mu5/6 node
Message-ID: <20220128085932.GH4686@dragon>
References: <20220111062013.1027517-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111062013.1027517-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:20:13PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add mu5/6 for i.MX8QXP/QM, these two mu will be used for
> communicating with general purpose Cortex-M4 cores.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
