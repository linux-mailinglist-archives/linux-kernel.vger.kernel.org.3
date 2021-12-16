Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46596476E51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLPJxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 04:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhLPJxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:53:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F04C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:53:08 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxnR9-0006Iz-Ek; Thu, 16 Dec 2021 10:52:31 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxnR6-0004Ru-Hc; Thu, 16 Dec 2021 10:52:28 +0100
Message-ID: <24b70c5a2fc2c475525f678d6c45a0d2c0c590a6.camel@pengutronix.de>
Subject: Re: [PATCH v6 04/10] reset: Add Sunplus SP7021 reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com
Date:   Thu, 16 Dec 2021 10:52:28 +0100
In-Reply-To: <9e081c98039518b36cf9a93d4aca66dc2efecdb2.1639560427.git.qinjian@cqplus1.com>
References: <cover.1639560427.git.qinjian@cqplus1.com>
         <9e081c98039518b36cf9a93d4aca66dc2efecdb2.1639560427.git.qinjian@cqplus1.com>
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

On Thu, 2021-12-16 at 15:08 +0800, Qin Jian wrote:
> Add reset driver for Sunplus SP7021 SoC.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Fix the comments from Philipp.

Looks good to me now,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>


regards
Philipp
