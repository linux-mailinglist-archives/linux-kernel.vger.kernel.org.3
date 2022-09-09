Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288555B2B83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIIBZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIIBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:25:41 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED296752;
        Thu,  8 Sep 2022 18:25:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 861BF5C009B;
        Thu,  8 Sep 2022 21:25:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Sep 2022 21:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662686737; x=1662773137; bh=LIj6b6sZa4
        8PCHZciLTQDkkYz7hIF6a4cRxP68uo4GM=; b=Bov7VnH9NjJq3Zd8PzfnirBNL3
        xdCy2YxL/fRCA1BYGzxxzCU2stJRBbsxVcBaoIe8fH4xPqx47LKKlbE4LpNPOygi
        BjFU6TQRc2lPOBsZ7UCKsic8RDUTQKhYWsD+rWut4QWNY6hZB8dDN1opsOc6wo96
        ou1d1RV+vzUhvjesNiFhhj/qRT+JsEv6vwczcZJF4fI7bNldXLp9GKoRr02aVodL
        NzOVHfn/3SQjf4PcgJymcqt3TWjuKUl5GUusnj/91zXITyv72kGUS2vs7LBmAwjk
        TcmW+b6myH4IDGpNe/lv4Riu65t7e4ieEuCM2PPouEfY9zgZ4RHRPmaOHo3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662686737; x=1662773137; bh=LIj6b6sZa48PCHZciLTQDkkYz7hI
        F6a4cRxP68uo4GM=; b=Meydom+OXcPCP+g32zRbgh/ZtFmVaLRcNPOLdZkS4U5L
        gAel1f6KMbwEbnO719jRqAf4uMnC4sRtYqfS03QjFV/zjKhHrjKtMQhyNhtlHHuV
        eRjyJpPt5E/yqWcxGbnWxwBB6bP7b9TkwQcLvFkZVHPeSWmDgqiGCytKqetr7Nkp
        wXky6SMl+MsEjv3p0jq1LtkBDilbtZ6AUMKQWkgHUDzqoJf3Z3ZKT5T8dUKJSZSH
        gmpgX0PKG97U0veXeTVSwPLnoTiTKLNgsWgR474jby3eFqxqCYZJrKBq8IL45x6D
        Sq5XFTLs5WdLJJ+oYD/Lpm0RcwcPiolv2eIKkrCRSw==
X-ME-Sender: <xms:EZYaY6fzyQX0JqhpE-rP-Kr3K8MDTy_eY96ffG_7o4tPoZGVvqoAQg>
    <xme:EZYaY0Pkzp9S4TYvjPmHz3FKgJNb6mAoLzKNPM5reuJkTrmqoYKPgYuQZ9ebsK9-U
    VBWekV8c0gWN-Cy4KU>
X-ME-Received: <xmr:EZYaY7i6T2syUrUu5Z1CNhKhYgXOqhFxmowQfumF8QHbsJwQFWmv2VANoFJNKnYhx-9gbSbnBxByuEGW5DCi-UTjECYBk5Qasw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:EZYaY388N0kJmRqfQZjTSFTMRUbysHsgIyhrbGMnRxTnfyFZtxl8Wg>
    <xmx:EZYaY2ugNvCrw_9940EUpLpc0o67vF6mBTqxJ9ICc5J5BuUakYXo_Q>
    <xmx:EZYaY-EL7YiAM6pc0VDVGuaw152VitLQpp_TaWfg0q9TEgsLjGGj9w>
    <xmx:EZYaY4KsOkJmgs_maowhLdo8QzTl25SmlRigIJ9fTLMcAJq1SeS7bg>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 21:25:35 -0400 (EDT)
Date:   Fri, 9 Sep 2022 11:25:30 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Nate Yocom <nate@yocom.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] Input: joystick: xpad: Add ABS_PROFILE axis value
 to uapi
Message-ID: <YxqWCrWzuTMDaK47@quokka>
References: <20220825222420.6833-1-nate@yocom.org>
 <20220825222420.6833-3-nate@yocom.org>
 <3e48ef8d13337ce1c3ec68baffc612fde4740b0e.camel@hadess.net>
 <Yw0OjoVzKV3QOYah@ghaven-kernel>
 <661ee8227c96aeba7aae9fff6ac9a73f1d81e765.camel@hadess.net>
 <Yxl/YxSRtV9Hv271@google.com>
 <CAO-hwJLYSG=AT0CyputHBWNexV3NtFpvfu=jM2Fp60=3s4wauQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJLYSG=AT0CyputHBWNexV3NtFpvfu=jM2Fp60=3s4wauQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:51:57AM +0200, Benjamin Tissoires wrote:
> On Thu, Sep 8, 2022 at 7:36 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Sep 07, 2022 at 05:41:08PM +0200, Bastien Nocera wrote:
> > > On Mon, 2022-08-29 at 12:07 -0700, Nate Yocom wrote:
> > > > On Sat, Aug 27, 2022 at 12:40:46PM +0200, Bastien Nocera wrote:
> > > > > On Thu, 2022-08-25 at 15:24 -0700, Nate Yocom wrote:
> > > > > > Add an ABS_PROFILE axis for input devices which need it, e.g. X-
> > > > > > Box
> > > > > > Adaptive Controller and X-Box Elite 2.
> > > > > > ---
> > > > > >  include/uapi/linux/input-event-codes.h | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/input-event-codes.h
> > > > > > b/include/uapi/linux/input-event-codes.h
> > > > > > index dff8e7f17074..7ad931a32970 100644
> > > > > > --- a/include/uapi/linux/input-event-codes.h
> > > > > > +++ b/include/uapi/linux/input-event-codes.h
> > > > > > @@ -862,6 +862,7 @@
> > > > > >  #define ABS_TOOL_WIDTH         0x1c
> > > > > >
> > > > > >  #define ABS_VOLUME             0x20
> > > > > > +#define ABS_PROFILE            0x21
> > > > > >
> > > > > >  #define ABS_MISC               0x28
> > > > > >
> > > > >
> > > > >
> > > > > You probably also want to add it to the absolutes array in
> > > > > drivers/hid/hid-debug.c.
> > > >
> > > > doh, roger.
> > > >
> > > > > Again, you might want to wait for confirmation from Dmitry that
> > > > > this is
> > > > > the right way to do this for the profiles.
> > > >
> > > > Makes sense.  Dmitry?
> > >
> > > Dmitry, could you please confirm whether ABS_PROFILE definition is
> > > correct?
> >
> > Yes, I think this makes sense. Do we have a buy in from userspace folks
> > (Peter H, etc) for this?
> 
> AFAICT, libinput wouldn't use that new axis, simply because it doesn't
> care about game controllers.

yep, that's pretty much the summary from my side so ACK from me.

Cheers,
  Peter

> So it all comes down to game users to validate this (and probably only
> android is now the main consumer of these given that SDL and Steam are
> directly using hidraw or libusb to talk to controllers).
> 
> Cheers,
> Benjamin
> 
> >
> > I'd like some documentation added to Documentation/input/event-codes.rst
> > and potentially to Documentation/input/gamepad.rst even though profile
> > does not have to be gamepad specific event.
> >
> > Thanks.
> >
> > --
> > Dmitry
> >
> 
