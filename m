Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917B59BAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiHVHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiHVHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:54:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BF2A71F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:54:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2GR-0001n0-BC; Mon, 22 Aug 2022 09:54:27 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oQ2GQ-0006Af-Ue; Mon, 22 Aug 2022 09:54:26 +0200
Date:   Mon, 22 Aug 2022 09:54:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] media: mt9m111: fix device power usage
Message-ID: <20220822075426.qjgxue7sjehazga4@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-3-m.felsch@pengutronix.de>
 <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwMix1+Bm1jEbWqv@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 22-08-22, Sakari Ailus wrote:
> Hi Marco,
> 
> On Thu, Aug 18, 2022 at 04:47:11PM +0200, Marco Felsch wrote:
> > Currently the driver turn off the power after probe and toggle it during
> > .stream by using the .s_power callback. This is problematic since other
> > callbacks like .set_fmt accessing the hardware as well which will fail.
> > So in the end the default format is the only supported format.
> 
> It'd be much better to add runtime PM support to the driver instead.

I got your point, but didn't have the time for it right now, I will drop
the patch from my v2.

Regards,
  Marco

> 
> -- 
> Sakari Ailus
> 
