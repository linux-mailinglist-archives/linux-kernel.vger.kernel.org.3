Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E25AC92C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiIEDjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13097D112;
        Sun,  4 Sep 2022 20:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35A861088;
        Mon,  5 Sep 2022 03:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BE7C433C1;
        Mon,  5 Sep 2022 03:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662349181;
        bh=B7ikVDUbWjcsfehJT3oE4acWaQQawgQ2xaEcNCkq18k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ8GtqFUUjs8gzD5aSZM81b8HkI4qjYoPPCCy6TjJMhFnuRtwQ/twFXv1EDz/yRp4
         V2iGZfcjq6ij6gaGTB4bx8O77Qb9zqQZYi9kZMxxEVH+x50pMR5kejz0FeBGJI4/0y
         mkm/6+Sj5rO5awK8vL4v4S0UIQGhSEovTzBhfZpNvUDG9FCqtk3WMyVziyVqByBcJV
         QW1LvYHA/4oSaUaB5eNWuI2aqV4ty59N621B1O8kejDJJvfupors+8HYyOqHDjZyKm
         AjPNu83pXaKNXZhQlKiT4hd1Ug828R3KpOK4ceDmOUjDSNJM+bfj70zt1SSchHDuod
         yzYU2x0D6nPmg==
Date:   Mon, 5 Sep 2022 11:39:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/6] arm64: dts: imx8ulp: several updates
Message-ID: <20220905033934.GK1728671@dragon>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:25:46PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Drop 'status = "okay"' and blank line in patch 5
> 
> Update cgc/sram/pcc node to match binding doc
> Add pmu/mailbox node
> Increase lpspi clock
> 
> Clark Wang (1):
>   arm64: dts: imx8ulp: increase the clock speed of LPSPI
> 
> Peng Fan (5):
>   arm64: dts: imx8ulp: drop undocumented property in cgc
>   arm64: dts: imx8ulp: correct the scmi sram node name
>   arm64: dts: imx8ulp: add #reset-cells for pcc
>   arm64: dts: imx8ulp: add pmu node
>   arm64: dts: imx8ulp: add mailbox node

Applied all, thanks!
