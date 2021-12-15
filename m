Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD8475624
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhLOKVT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Dec 2021 05:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhLOKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:21:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C14C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:21:18 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxRPQ-00080T-7Q; Wed, 15 Dec 2021 11:21:16 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mxRPP-000Ef6-L5; Wed, 15 Dec 2021 11:21:15 +0100
Message-ID: <0aaf9792fad706519da3c0177151dc2316882706.camel@pengutronix.de>
Subject: Re: [PATCH resend v3] reset: renesas: Fix Runtime PM usage
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Dec 2021 11:21:15 +0100
In-Reply-To: <OS0PR01MB592202E7612FF6C0F0FCE76086769@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <ec24e13f-0530-b091-7a08-864577b9b3be@gmail.com>
         <OS0PR01MB592202E7612FF6C0F0FCE76086769@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On Wed, 2021-12-15 at 10:18 +0000, Biju Das wrote:
> Hi Heiner,
> 
> Thanks for the patch.
> 
> > Subject: [PATCH resend v3] reset: renesas: Fix Runtime PM usage
> > 
> > If pm_runtime_resume_and_get() fails then it returns w/o the RPM usage
> > counter being incremented. In this case call pm_runtime_put() in
> > remove() will result in a usage counter imbalance. Therefore check the
> > return code of pm_runtime_resume_and_get() and bail out in case of error.
> > 
> > Fixes: bee08559701f ("reset: renesas: Add RZ/G2L usbphy control driver")
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thank you both, applied to reset/fixes.

regards
Philipp
