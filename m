Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B206347546B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhLOImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:42:37 -0500
Received: from muru.com ([72.249.23.125]:38704 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhLOImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:42:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7097580C1;
        Wed, 15 Dec 2021 08:43:17 +0000 (UTC)
Date:   Wed, 15 Dec 2021 10:42:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] pmic-cpcap: add motorola,droid3 compatible
Message-ID: <YbmqeZhaqibbQZEG@atomide.com>
References: <20211212230459.13579-1-merlijn@wizzup.org>
 <20211212230459.13579-2-merlijn@wizzup.org>
 <Ybbg3GNwST5Cr9Br@atomide.com>
 <a89e329c-af4e-53ec-fdf1-77f3727a4376@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89e329c-af4e-53ec-fdf1-77f3727a4376@wizzup.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Merlijn Wajer <merlijn@wizzup.org> [211213 10:33]:
> On 13/12/2021 06:57, Tony Lindgren wrote:
> > Looks OK to me, however we should also add all the mapphones to the
> > Documentation/devicetree/bindings/arm/omap/omap.txt so we can avoid
> > dtb check warnings. Care to also do a patch for that? Looks like the
> > others are missing too.
> 
> Sure, I'll do that and add the others too while at it. Shall I add those
> to this patch, or make a separate patch?

Please add a separate binding patch and Cc the devicetree mailing list.

Thanks,

Tony
