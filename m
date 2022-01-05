Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96D485152
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiAEKn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jan 2022 05:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiAEKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:43:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8AFC061784
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:43:51 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n53la-0006nF-P5; Wed, 05 Jan 2022 11:43:38 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1n53lX-00BCdk-3W; Wed, 05 Jan 2022 11:43:35 +0100
Message-ID: <13c43c38b8494d374e204c4fa43f160770e7b662.camel@pengutronix.de>
Subject: Re: [PATCH v7 3/4] phy: rockchip: add naneng combo phy for RK3568
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com
Date:   Wed, 05 Jan 2022 11:43:35 +0100
In-Reply-To: <20211230084815.28110-4-yifeng.zhao@rock-chips.com>
References: <20211230084815.28110-1-yifeng.zhao@rock-chips.com>
         <20211230084815.28110-4-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-30 at 16:48 +0800, Yifeng Zhao wrote:
[...]
> +static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy_priv *priv)
> +{
[...]
> +	priv->phy_rst = devm_reset_control_array_get(dev, false, false);

Please use devm_reset_control_array_get_exclusive() instead.

regards
Philipp
