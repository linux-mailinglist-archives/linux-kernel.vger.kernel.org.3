Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D084F5802
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiDFIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351777AbiDFI3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:29:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFD1B2C6C;
        Tue,  5 Apr 2022 19:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1024EB81FB5;
        Wed,  6 Apr 2022 02:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FB7C385A0;
        Wed,  6 Apr 2022 02:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211365;
        bh=HFUmutMpPclH6W3Ib5k9z/9xgPTS1ozGO4CtoNe7cLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3mmC5uozNJPRjpYnuEFfuRNyy23hI/lveEyZjC1kvZF9KHfnbBGd+SoUiWwwtYEo
         JvKGzib7NZHV1b6EH8GZNevmkByOKV2M2doW5nf8404TTxnqUQiIUiOe7CnS50i2Ux
         f9aQh7K3AD78LS7dq1EGK0Ypm2SMEh5XbbT4KLKJedN+nrPQ1Uxbz16Uo4EvqmApTR
         vcOw7IFuNmyIildCP2i7fpMFi9+id+OCfeyeWVlaDyBBYHUuR2mbYtSLgqA1rINNgy
         Z7l6D2Z7mApuxq62QeoPhaxm4Br481B6Oi2J1c2pQNnq72DjCCa7F5LN3EAIWrWzzK
         +CnaZAQs9kfSA==
Date:   Wed, 6 Apr 2022 10:15:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robin van der Gracht <robin@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 6/8] ARM: dts: imx6dl-victgo: Add interrupt-counter
 nodes
Message-ID: <20220406021557.GK129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-6-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:10AM +0100, Oleksij Rempel wrote:
> From: Robin van der Gracht <robin@protonic.nl>
> 
> Interrupt counter is mainlined, now we can add missing counter nodes.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
