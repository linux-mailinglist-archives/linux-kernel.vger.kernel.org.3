Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071D468E99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLFBl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:41:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37180 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhLFBl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:41:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BCC9B80EED;
        Mon,  6 Dec 2021 01:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322DBC00446;
        Mon,  6 Dec 2021 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638754707;
        bh=hZuhU08ezLjW8vgcoOFx4ydzIqhWviatMdzqDVBQ7eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlDMzDKuERCExvaO9g6dXym+ZF6IVwQyy3eoA50Vt9ia0atnYl/Kw9n4bL4CTbauQ
         w1w5vyJmt+qds3KT44cD4qCBPvEZWRbqT8yBRqcjoN/8wvfEfGNvvGTBcFhYTcnE2W
         HUyY9TkVCCRWQXEfzQVY7t2OS2Sfwz4KtPL0eYLgWr5WlKIYG4wgwDYvx7dvhvGNoY
         qR3unXRVz362Fb8n0kqYa/0skGDy0kB0p2E5L2qLjpII4XVaOhCWYCZyTY8mnUw86Z
         pW0fi21zY9oX29LtBYmLaP6WQMOfP5+xUI0QpHhVxQrrK/ZjJqfx8S7vbHgo+ViKkj
         1UNn57/xjkSPA==
Date:   Mon, 6 Dec 2021 09:38:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, Abel Vesa <abel.vesa@nxp.com>,
        kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: remove interconnect property from
 lcdif
Message-ID: <20211206013821.GP4216@dragon>
References: <20211124083703.730243-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124083703.730243-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Abel

On Wed, Nov 24, 2021 at 09:37:03AM +0100, Martin Kepplinger wrote:
> The mxsfb driver handling imx8mq lcdif doesn't yet request the
> interconnect bandwidth that's needed at runtime when the description is
> present in the DT node.
> 
> So remove that description and bring it back when it's supported.
> 
> Fixes: ad1abc8a03fd ("arm64: dts: imx8mq: Add interconnect for lcdif")
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied, thanks.

> ---
> 
> revision history
> ----------------
> this patch replaces the wrong 1:1 revert previously sent:
> https://lore.kernel.org/linux-arm-kernel/20211123114545.411787-1-martin.kepplinger@puri.sm/
> 
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 972766b67a15..71bf497f99c2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -524,8 +524,6 @@ lcdif: lcd-controller@30320000 {
>  						  <&clk IMX8MQ_VIDEO_PLL1>,
>  						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
>  				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
> -				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> -				interconnect-names = "dram";
>  				status = "disabled";
>  
>  				port@0 {
> -- 
> 2.30.2
> 
