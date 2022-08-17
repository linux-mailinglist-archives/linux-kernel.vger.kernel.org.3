Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F3596C27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiHQJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiHQJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:35:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611C06B142;
        Wed, 17 Aug 2022 02:35:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2C9249C;
        Wed, 17 Aug 2022 11:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660728938;
        bh=ch0XKWzLiRaFfgM41mqOEv9fgmU7v79rn2K6o1977D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1bSvX1wd6w6Z7bcQEstSFebr8Vqou89bXXk5ZsMNsD5Lshacg7jbrm0hrM37mYTe
         LFsdTRd2mg76Y+gZaN7CmjLEK14ybuY8RaKVUZXfhoSsmYqONoHAaPgFjMl1W1vs8t
         kVxuasNnXHn9Ff6fmRhmr/FRYgMYV9ksaNdJLVWA=
Date:   Wed, 17 Aug 2022 12:35:24 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: [External] Re: Missing MIPI IPU6 camera driver for Intel Alder
 Lake laptops
Message-ID: <Yvy2XMjdje5uc32P@pendragon.ideasonboard.com>
References: <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
 <YvnwtN1SwQjilJ97@google.com>
 <YvnybHVFmpUJs4qi@kroah.com>
 <Yvn0o96K8j5gRaWM@google.com>
 <Yvn4aiVLzFMneZCc@pendragon.ideasonboard.com>
 <9a396cc3-5b0f-6db3-bad5-b4d81ecdf834@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a396cc3-5b0f-6db3-bad5-b4d81ecdf834@lenovo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Aug 15, 2022 at 11:14:52AM -0400, Mark Pearson wrote:
> On 8/15/22 03:40, Laurent Pinchart wrote:
> > On Mon, Aug 15, 2022 at 04:24:19PM +0900, Sergey Senozhatsky wrote:
> >> On (22/08/15 09:14), Greg KH wrote:
> >>>> Definitely not today. Someday, for sure :)
> >>>>
> >>>> I don't want to promise any timelines. But we are certainly not
> >>>> talking "weeks", we are talking "months". Several months is a
> >>>> realistic timeline.
> >>>
> >>> Ok, so getting this merged is a good year out at the best, realisticly 2
> >>> years given that once you submit the first version for review, the real
> >>> work will start happening.
> >>
> >> Well, nothing is really set in stone here. We may revisit our strategy,
> >> say turn it upside down, and hit upstream mailing list as soon as possible
> >> instead.
> >>
> >>> So I'll stick with my original statement, don't buy this hardware
> >>   ... if you plan on running vanilla kernel. Otherwise do buy :)
> > 
> > If you want to run a proprietary OS.
> > 
> Not sure where best to jump in...but just to add some perspective from a
> Lenovo perspective.
> 
> 100% agreed - don't buy the platforms (X1 Carbon G10, X1 Yoga G7, X1
> Nano G2) with the MIPI camera (called 'computer vision' on the Lenovo
> site) if you plan to run Linux. We are disabling that config on our
> Linux preload.
> 
> From the 'reaching out to the community' perspective that was flagged
> earlier in the thread - I've been discussing MIPI with Red Hat,
> Canonical and Intel for a year now. We knew it was going to be a problem
> and in fairness to Intel they've been very clear that initially the
> 'workaround' was going to be available and that the full solution will
> be coming later. I've had some disappointments with progress but I also
> don't have the expertise to be able to solve it myself and fully
> appreciate these things don't happen overnight. Intel have been working
> with us on this and I appreciate their support.
> 
> If there are people I should be engaged with let me know and we can
> discuss offline. Going forward - I guess the good news is we have some
> platforms with MIPI on to work with....having HW usually helps. I'm also
> very open to any ideas of suggestions for accelerating getting this done
> and where Lenovo can help. We're limited on a technical resource side of
> things, but we do have HW :)

Thank you for the insight.

Focussing on the IPU6, we need two things: an upstream kernel driver,
and corresponding support in the libcamera project (if you're familiar
with the Linux display stack, that would be the equivalent of a DRM
driver and corresponding support in Mesa for a GPU).

The kernel driver likely needs to come first, and there we have two
options. The first one is implementing a V4L2 driver, as that's the
camera API in the Linux kernel today. As mentioned by Sakari, it can be
done, but isn't a great match due to the IPU6 hardware complexity. V4L2
is generally considered as a dead end for recent ISPs, it may still be
able to cover that space for some time, but its days are counted (in
this area only, the API works fine for lots of other use cases).

The second option is to create a better kernel API, and then implement
an IPU6 driver for it. Ideas have been brainstormed for a few years now,
and the Google Chrome OS proposal that was unveiled by Ricardo at the
Kernel Recipes conference in June is one particular embodiment of this.
There is however no consensus on that proposal (that may be the biggest
euphemism I've ever made).

-- 
Regards,

Laurent Pinchart
