Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818D4BD416
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbiBUDK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiBUDK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:10:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2884B1CF;
        Sun, 20 Feb 2022 19:10:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E79CB80DCD;
        Mon, 21 Feb 2022 03:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1739DC340F3;
        Mon, 21 Feb 2022 03:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413001;
        bh=PuyT7APWio8P93etsMf8oS9rRM1RfWl14IUngR7FUFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+VSjbqeco0Vx5CTucLBTEuWvE2Ma8aR65pJSxMEdul5NukRz4vL343WIs3e64+qH
         a4GzofI/zLOfe2UdNZzu6jgYkpF1lYnnBuT02lnY3/7F4vz5ic3OnUnmNXc5p1AQbA
         jnyKWDWCYvhw3uQ28J30loTLYC6jzTllYZWdOxcuCCBvulFtakOobFgOwS+W3P+RzY
         lQbv7OKudybCeuv/+bWth9UyUScUl9BXCgymTqubP850QH3ybHDD5YWF526qH3qz8Y
         DNzPzfGef4weS/ggn6pKdYk1axs7rx+qEE99IRUmpWVV4nmkX+PozmlE9M/HHF2p0m
         byRUqTi62dOwQ==
Date:   Mon, 21 Feb 2022 11:09:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] arm64: dts: imx8qm: add compatible string for
 usdhc3
Message-ID: <20220221030955.GC2249@dragon>
References: <20220209154223.15252-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209154223.15252-1-oliver.graute@kococonnector.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:42:23PM +0100, Oliver Graute wrote:
> add compatible string for usdhc3
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>

Applied, thanks!
