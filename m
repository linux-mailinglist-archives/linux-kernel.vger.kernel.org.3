Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46AC5AC89C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiIEBxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiIEBxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:53:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F02655F;
        Sun,  4 Sep 2022 18:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 814ECCE0FA6;
        Mon,  5 Sep 2022 01:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5F8C433C1;
        Mon,  5 Sep 2022 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662342807;
        bh=wPHLx31DZ8Gzk3CWQi3zedrQ5AUV+nO51KWBELB2RE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxJCeZNVzVmukHrFhOJZFu1RDZZvZiMlYJPD8dLuZQmuMivJGDXgUVC4tLwVkDeL+
         +lj9qoeQeQLSaIO/CLOVRo86YAqUBG7jq5a1BYY9SiAfCUSVafZ4R7EBQ4v/fnrT1q
         yglQBKlmEo7Tp1YlvHFNzA3ok3CSzxheHO+/8792cbWv4Yy3HlHPzBVflZ9faLBvTd
         HrzZKgFPtNygjkmkVCYjzLL3QIbhcwc6eyBVFU8sNO3l8ZgtMDwtwiudD9MAaYJpTZ
         CI5ocpgeoUhdREIWiqr+Czbwduv5X5OQ2vaPmamCrNunGISRXBwbRPURIc0l27iQob
         RLtd+yoNVL/iw==
Date:   Mon, 5 Sep 2022 09:53:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] arm64: dts: imx8ulp: no executable source file
 permission
Message-ID: <20220905015320.GW1728671@dragon>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826192252.794651-4-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:22:50PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error:
> 
> arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h: error: do not set
>  execute permissions for source files
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
