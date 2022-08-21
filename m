Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3E59B2A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiHUH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:56:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4768F1208B;
        Sun, 21 Aug 2022 00:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02509B80B94;
        Sun, 21 Aug 2022 07:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C55C433D6;
        Sun, 21 Aug 2022 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661068597;
        bh=0EzxQArM4C2tBHDkO9PFJGht9KV40rau3p+yNlF/i5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+6PMXWApH4gNDTOfA4sshlnWU516A/2AuyXJxSTcfQwq58RVvRWvAEMeKx0YqU/b
         vDPUor7NDorVA9GNnZDSWqSI3GsuEzRO/hVtIYuXWrvi/iXspv4k1jqKXM281GP+/z
         AU4EKVQsvpJbVuR06OePSIoI0nIfrYokageYSxc60ECKioJfgfyWNjmq78pI+QOn/Q
         jdbeXJfrCgsl7Sv/NY4kVQ5fxGs2E/bV/xAYlqibSMDWeX8pGsFOGfFPitTBS4rsxe
         SXEi6qwnYWy/G/ZtXKibOtky5iPA2p3nNaPLf9Ig74rn6/3NKEKgXELmSMhdXdeMcs
         xHA8NqQvrAewg==
Date:   Sun, 21 Aug 2022 15:56:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, tharvey@gateworks.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings
Message-ID: <20220821075631.GQ149610@dragon>
References: <20220723105005.3583860-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723105005.3583860-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 06:50:05PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The pad settings are missed, add them
> 
> Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
