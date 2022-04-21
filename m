Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039665095B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384060AbiDUEOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiDUEOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:14:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8FE0C7;
        Wed, 20 Apr 2022 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650514274; x=1682050274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJQlsZ2ZXiB1zgKGMVca5/jEboQna2tyetogXG0ZTxI=;
  b=sbyC+2ewThJnqjzAa8fD/dprKyx6vmFhWIcXjYzuIZIhoyZRlkB1fHpL
   kLLENjhXZI0JXj4i6P7Glh5xf5vzOAkM3O7zyqACenp0IC1wqSwrQN/e1
   bLp+imcXBVIVfmm99SESKrG3i7sh1GbhPIBSgmCx7Mqgv/wewRYuzC5fN
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2022 21:11:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 21:11:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 21:11:12 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 21:11:08 -0700
Date:   Thu, 21 Apr 2022 09:41:04 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v3 1/2] usb: host: xhci-plat: Add device property to set
 XHCI_SKIP_PHY_INIT quirk
Message-ID: <20220421041104.GF2627@hu-pkondeti-hyd.qualcomm.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649323888-12420-2-git-send-email-quic_c_sanm@quicinc.com>
 <YmAomYeH181GGSZc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YmAomYeH181GGSZc@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob Herring

On Wed, Apr 20, 2022 at 05:36:57PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 07, 2022 at 03:01:27PM +0530, Sandeep Maheswaram wrote:
> > Add device property usb-skip-phy-init to check and set XHCI_SKIP_PHY_INIT
> > quirk.
> > Runtime suspend of phy drivers was failing from DWC3 driver as
> > runtime usage value is 2 because the phy is initialized from
> > DWC3 core and HCD core.
> > Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> > This property can be set to avoid phy initialization in HCD core.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 649ffd8..7624ed9 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -305,6 +305,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
> >  			xhci->quirks |= XHCI_BROKEN_PORT_PED;
> >  
> > +		if (device_property_read_bool(tmpdev, "usb-skip-phy-init"))
> > +			xhci->quirks |= XHCI_SKIP_PHY_INIT;
> 
> You forgot to document this new property.  Without that, we can not
> accept this :(
> 

Thanks Greg for taking a look. This series has a device tree binding doc
update but got dropped after Rob's comment here.

https://lore.kernel.org/linux-usb/YY7vAzxj9aR%2FzBSB@robh.at.kernel.org/

Sandeep,

Since, we could not come up with a way to limit this to only dwc3/cdns3
controllers, please include the device tree binding doc and re-send the
series.

https://lore.kernel.org/linux-usb/f578947c-fb10-11b7-abe8-28b6b3f6bb0c@linux.intel.com/#t

has all the different options we dicussed and why we went with a dT param
for this.

Thanks,
Pavan
