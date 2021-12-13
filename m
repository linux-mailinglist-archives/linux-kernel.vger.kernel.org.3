Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81739472394
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhLMJQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Dec 2021 04:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLMJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:16:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:16:18 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mwhRL-0005mf-Sp; Mon, 13 Dec 2021 10:16:11 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mwhRK-0005HR-Vz; Mon, 13 Dec 2021 10:16:10 +0100
Message-ID: <d1be20fb0e724598d697fba97f79d75b8646b7ee.camel@pengutronix.de>
Subject: Re: [PATCH v5 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared
 reset controller use
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, khilman@baylibre.com
Cc:     balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 13 Dec 2021 10:16:10 +0100
In-Reply-To: <20211212201844.114949-2-aouledameur@baylibre.com>
References: <20211212201844.114949-1-aouledameur@baylibre.com>
         <20211212201844.114949-2-aouledameur@baylibre.com>
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

On Sun, 2021-12-12 at 21:18 +0100, Amjad Ouled-Ameur wrote:
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
> 
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
