Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA8478389
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhLQDNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:13:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40524 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLQDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:13:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3086B826B4;
        Fri, 17 Dec 2021 03:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCAC36AE2;
        Fri, 17 Dec 2021 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639710792;
        bh=N9CLs8I9WOC2vbdpo/1uW3XV3nxIXFCS40NEUMpas94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ed/kRkuWSZyGKDZ1wt07+nPb5oMe3TU0sG0qt6hbN80pTd9kexyRzJssEVuPH9omW
         w+psmxpuva6OIA3jBAx25Vuef8XJPA2mkTsppGex5akUw+EcFHVlHsFcMCJFzBT9jk
         +iWLYz90kdTBjc1NrAyvsQMInfMQ76Xv09wOYW2n0rgHqwnbuNkulQ5I1ZQIb8iDjS
         xFaFx1srs1lIZEvRR+C9/ej/j5nJ+cc9O4WHVqdQVfAg8xYl8XIPHybMQhiyj2BjaM
         oSpBK6hYrkiGl7bUqesyhhUsdYxgW8uXozE30creTbJSs/x2aXUkb50JDwfzBN9ruk
         tSJ/yWV207SVw==
Date:   Fri, 17 Dec 2021 11:13:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, michael@amarulasolutions.com,
        jagan@amarulasolutions.com, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Message-ID: <20211217031305.GP4216@dragon>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:46:17PM -0600, Adam Ford wrote:
> The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> different in others.  With the blk-ctrl driver for Mini in place,
> this series expands the blk-ctrl driver to support the Nano which
> opens the door for additional functions in the future.  As part of
> this series, it also addresses some issues in the GPCv2 driver and
> finally adds support for enabling USB and GPU.
> 
> V5:  Clean up the GPU clock assignments.
> V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
>      and add the same fixes for CSI and DSI to the Nano
> V3:  Fixes an the yaml example
> V2:  Fixes the clock count in the blk-ctrl
> 
> [1] - https://www.spinics.net/lists/arm-kernel/msg936266.html
> 
> Adam Ford (9):
>   soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
>   soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
>   dt-bindings: power: imx8mn: add defines for DISP blk-ctrl domains
>   dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
>   soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
>   arm64: dts: imx8mn: add GPC node
>   arm64: dts: imx8mn: put USB controller into power-domains
>   arm64: dts: imx8mn: add DISP blk-ctrl
>   arm64: dts: imx8mn: Enable GPU

The series introduces hard dependency between different branches.  To
ease the merge process, let's postpone the DTS patches to the next
cycle.

Shawn
