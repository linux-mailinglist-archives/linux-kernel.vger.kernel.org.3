Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C115B162F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIHIDf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Sep 2022 04:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiIHID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:03:29 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1BCEB0E;
        Thu,  8 Sep 2022 01:03:27 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DD9CE20000C;
        Thu,  8 Sep 2022 08:03:24 +0000 (UTC)
Message-ID: <8081fcd13d0aeef26adc51018b7f31a8882dc08c.camel@hadess.net>
Subject: Re: [v4 1/5] HID: core: Export hid_match_id()
From:   Bastien Nocera <hadess@hadess.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Thu, 08 Sep 2022 10:03:24 +0200
In-Reply-To: <nycvar.YFH.7.76.2209072208490.19850@cbobk.fhfr.pm>
References: <20220830132549.7240-1-hadess@hadess.net>
         <e907c9240fb2cc0c1e60e3610cfae15ff8125c49.camel@hadess.net>
         <nycvar.YFH.7.76.2209072208490.19850@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-07 at 22:09 +0200, Jiri Kosina wrote:
> On Wed, 7 Sep 2022, Bastien Nocera wrote:
> 
> > > Export hid_match_id() so it can be used in device-specific
> > > drivers to
> > > implement their own matching with open-coding a match function.
> > > 
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  drivers/hid/hid-core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index b7f5566e338d..72f8d8835b34 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -2088,6 +2088,7 @@ const struct hid_device_id
> > > *hid_match_id(const
> > > struct hid_device *hdev,
> > >  
> > >         return NULL;
> > >  }
> > > +EXPORT_SYMBOL_GPL(hid_match_id);
> > >  
> > >  static const struct hid_device_id hid_hiddev_list[] = {
> > >         { HID_USB_DEVICE(USB_VENDOR_ID_MGE,
> > > USB_DEVICE_ID_MGE_UPS) },
> > 
> > If those patches look good to you, would be great to get merged.
> > Benjamin doesn't have the bandwidth to test the patches on his own
> > test
> > hardware right now, but I've been using them daily for a week now.
> 
> Alright, I was waiting for Ack from Benjamin, but based on this, and
> due 
> to the fact that I don't see any issue with it myself, I've now
> applied 
> the series to for-6.1/logitech branch so that it gets as much linux-
> next 
> exposure as possible.

Great, thanks!

Peter, if there were any other bugs in the hid-logitech-hidpp
implementation that needed handling, please file them at
bugzilla.kernel.org so they don't get lost.
