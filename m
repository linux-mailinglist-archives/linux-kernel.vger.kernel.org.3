Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A04E255B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiCULmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiCULmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:42:19 -0400
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EAD1CC0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:40:52 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id c2afb48c-a90b-11ec-8da1-0050568c148b;
        Mon, 21 Mar 2022 11:40:51 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 75829194B42;
        Mon, 21 Mar 2022 12:40:52 +0100 (CET)
Date:   Mon, 21 Mar 2022 12:40:46 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] drm/panel: Add panel driver for NewVision NV3052C
 based LCDs
Message-ID: <YjhkPnr46IOy5iS+@ravnborg.org>
References: <20220311170240.173846-1-cbranchereau@gmail.com>
 <20220311170240.173846-3-cbranchereau@gmail.com>
 <YjD1rl7jSxLvJhfL@ravnborg.org>
 <CAFsFa87NBB8VFFHJKjyPi+A255i9dyE-xxTggz3kLcEXmSWJXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFsFa87NBB8VFFHJKjyPi+A255i9dyE-xxTggz3kLcEXmSWJXg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> > > +     { 0x0d, 0x58 },
> > > +     { 0x0e, 0x48 },
> > > +     { 0x0f, 0x38 },
> > > +     { 0x10, 0x2b },
> > > +
> > > +     { 0xff, 0x30 },
> > > +     { 0xff, 0x52 },
> > > +     { 0xff, 0x00 },
> > > +     { 0x36, 0x0a },
> > > +};
> > There are some random (?) empty lines.
> > If they have any significance then a short comment would be nice.
> > If not, then drop the empty lines.
> >
> 
> The empty lines are not random no, to access a different page in the
> init, one must write i.e.   { 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff,
> 0x02 }, to access page 2, so they add a little bit of readability.
Then I suggest to just say what page is is like:

	/* Page 1 */
	{ 0xff, 0x30 },
	...

Etc. then it is obvious this is page boundaries.

	Sam
