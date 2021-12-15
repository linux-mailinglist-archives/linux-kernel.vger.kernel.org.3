Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561B04758AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhLOMSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLOMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:18:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:18:03 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxTEP-0003Lz-Tm; Wed, 15 Dec 2021 13:18:01 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxTEP-000JGu-1c; Wed, 15 Dec 2021 13:18:01 +0100
Message-ID: <706efb449e965976bd2d821f075f168826113a51.camel@pengutronix.de>
Subject: Re: [PATCH] reset: renesas: Check return value of
 reset_control_deassert()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Dec 2021 13:18:00 +0100
In-Reply-To: <b2131908-0110-006b-862f-080517f3e2d8@gmail.com>
References: <b2131908-0110-006b-862f-080517f3e2d8@gmail.com>
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

On Wed, 2021-12-15 at 11:25 +0100, Heiner Kallweit wrote:
> Deasserting the reset is vital, therefore bail out in case of error.
> 
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thank you, applied to reset/next.

regards
Philipp
