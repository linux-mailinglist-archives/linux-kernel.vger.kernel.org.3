Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAE4BD48F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbiBUEHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:07:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiBUEHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:07:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB013E0EF;
        Sun, 20 Feb 2022 20:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C91CB80CF9;
        Mon, 21 Feb 2022 04:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CAAC340E9;
        Mon, 21 Feb 2022 04:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645416435;
        bh=/pMLcwxS55vkdNjjkIVbj3/i1HM4NDob3DVeTZUMjJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIFH3ne72jgkpQRwFFYo44Md6hqYoMYdOXOUDckWzQuTDuopQ4PaiLJTAvIK15dFz
         HVfHnZ599W7oZ5/kEzR9YecAYlvGrBTYfiGvPr1WoLXw4V3mn7Bvy6jQBB6JSTfI25
         XqvhOroioyZ60V2DXZ7V12ntW7LmTZvsIKe3I+m46lhseGZK1XP32ON6I4x63e4k38
         8a0gjcsu4qs3IPP+qmgCrOTen2urS+uRxXx8oLxabZ2XI/H6rkm3dFrT2C7fkvwXox
         8wtqjeRLsBUqsEtGx6ZWIdNi4GuAcv61+s9gdag3BtbBS8qa2AXVCa2j4kz60Nc05v
         u39ekNCYHisEQ==
Date:   Mon, 21 Feb 2022 12:07:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: add imx8mm gw7903 support
Message-ID: <20220221040709.GJ2249@dragon>
References: <20220211190418.11870-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211190418.11870-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:04:17AM -0800, Tim Harvey wrote:
> The GW7903 is based on the i.MX 8M Mini SoC featuring:
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - microSD connector with UHS support
>  - LIS2DE12 3-axis accelerometer
>  - Gateworks System Controller
>  - IMX8M FEC
>  - software selectable RS232/RS485/RS422 serial transceiver
>  - PMIC
>  - 2x off-board bi-directional opto-isolated digital I/O
>  - 1x M.2 A-E Key Socket and 1x MiniPCIe socket with USB2.0 and PCIe
>  (resistor loading to route PCIe/USB2 between M.2 and MiniPCIe socket)
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied both, thanks!
