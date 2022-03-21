Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8307B4E2364
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbiCUJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiCUJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EC5D1A3;
        Mon, 21 Mar 2022 02:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4480B61257;
        Mon, 21 Mar 2022 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD68C340E8;
        Mon, 21 Mar 2022 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647855258;
        bh=KAy+HX7RT4vropER51g7vnunFx9E0IYtS6S7s/kOnVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=az+y/cewf7KdP2kFF8wkWZlGQo6+2T0eMChPcWVGvVoP+lO8Yj59G2Yd/icvGqv39
         aF55PvwTgY4UbH4mLJ/RQZwnFdT1tjW5COWkzOn+M6kOmTwVGZVRMToe5McDTInUCb
         tVUEmR4Tt5g3BnBbyT1VpGTdCW1U4bLfuETqjQSI=
Date:   Mon, 21 Mar 2022 10:34:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v2 2/3] usb: xhci: Remove unwanted header inclusion
Message-ID: <YjhGmJYbATchV+Zs@kroah.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646130507-26796-3-git-send-email-quic_c_sanm@quicinc.com>
 <YjR0gNPdeI5FTBGs@kroah.com>
 <adb12afc-4591-4a96-9988-e0d6a2ceb060@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb12afc-4591-4a96-9988-e0d6a2ceb060@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:47:08PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Greg,
> 
> On 3/18/2022 5:31 PM, Greg Kroah-Hartman wrote:
> > On Tue, Mar 01, 2022 at 03:58:26PM +0530, Sandeep Maheswaram wrote:
> > > Remove the header file and forward declare struct usb_hcd.
> > Why?
> 
> This was done to address below comment in previous version
> 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com/#24739885

Then EXPLAIN THAT in the changelog text.  Don't make us guess.

Please read the kernel documentation for how to write a good changelog
text.  This single sentance does not follow the guidelines at all.

> 
> 
> > 
> > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > ---
> > >   include/linux/usb/xhci-plat.h | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
> > > index 906e907..576e400 100644
> > > --- a/include/linux/usb/xhci-plat.h
> > > +++ b/include/linux/usb/xhci-plat.h
> > > @@ -9,7 +9,8 @@
> > >   #define _XHCI_PLAT_H
> > >   #include <linux/types.h>
> > > -#include <linux/usb/hcd.h>
> > > +
> > > +struct usb_hcd;
> > >   struct xhci_plat_priv {
> > >   	const char *firmware_name;
> > > -- 
> > > 2.7.4
> > > 
> > Where did this come from?  Is this fixing a build breakage from a
> > previous patch?  If not, why is this needed?
> > 
> > confused,
> > 
> > greg k-h
> 
> There wasn't any build breakage.
> 
> This was done to address below comment in previous version
> 
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1644949454-814-2-git-send-email-quic_c_sanm@quicinc.com/#24739885

Again, how were we supposed to know any of this?

Please read the documentation again for how to do this properly.

thanks,

greg k-h
