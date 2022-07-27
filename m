Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3E5822E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiG0JOv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jul 2022 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiG0JOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:14:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968FCF79
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:13:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oGd6M-0002GS-78; Wed, 27 Jul 2022 11:13:10 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oGd6L-0004W1-DD; Wed, 27 Jul 2022 11:13:09 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oGd6K-0004jc-L2; Wed, 27 Jul 2022 11:13:08 +0200
Message-ID: <a1f170aae331e0ad9694ad99451bfb06098d9965.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] reset: tps380x: Add TPS380x device driver supprt
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Wed, 27 Jul 2022 11:13:08 +0200
In-Reply-To: <20220726084518.qmb2wjcazi3djcqr@pengutronix.de>
References: <20220530092226.748644-1-m.felsch@pengutronix.de>
         <20220530092226.748644-2-m.felsch@pengutronix.de>
         <20220726084518.qmb2wjcazi3djcqr@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Di, 2022-07-26 at 10:45 +0200, Marco Felsch wrote:
> Hi Philipp,
> 
> gentle ping.

Applied to reset/next.

I've taken liberty to remove the TODO comment, see below:

> On 22-05-30, Marco Felsch wrote:
[...]
> > +	/*
> > +	 * Todo:
> > +	 * Add firmware handling to switch between min/typ/max reset time
> > +	 */

I've dropped this because I think waiting for max reset time is the
only way to guarantee correctness, if we expect that tps3801 delay
times actually vary between min and max reset time (whether that is due
to production variance or temperature sensitivity).

If a board vendor can guarantee that the actual max delay on a given
board is less than the specified max reset time, this could be handled
via an optional device tree parameter to overrride the delay.

regards
Philipp
> 
