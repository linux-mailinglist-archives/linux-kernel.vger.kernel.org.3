Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18E595EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiHPPFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHPPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:05:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94184EFB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:02:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oNy4w-0000Sj-T5; Tue, 16 Aug 2022 17:02:02 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oNy4v-0005Bt-Vv; Tue, 16 Aug 2022 17:02:01 +0200
Date:   Tue, 16 Aug 2022 17:02:01 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: imx: support protected-clocks
Message-ID: <20220816150201.GS2387@pengutronix.de>
References: <20220816130327.2987710-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130327.2987710-1-peng.fan@oss.nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:59:46 up 139 days,  3:29, 84 users,  load average: 0.17, 0.13,
 0.10
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:03:27PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> For the clocks listed in protected-clocks, enable them to avoid
> Linux disable them. This will benifit root Linux and inmate cell run
> on top of Jailhouse hypervisor, and benifit the other case(
> A53 Linux run together with M7 RTOS).
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Per Sascha, use common protected-clocks property.

See my mail to v1. I did not request that you should use the
protected-clocks property:

> There were cases when a property first started with a "soc," prefix and
> later when people realized that it could be useful for other
> drivers/SoCs as well, the prefix was removed. With that in mind I
> would expect that a "fsl,protected-clocks" property behaves the same
> as a "protected-clocks" property without the prefix.
> 
> If it doesn't please pick a different name. I didn't want to suggest
> to just drop the "fsl," prefix and to use the generic property name
> when the properties have a different meaning.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
