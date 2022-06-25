Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118C955A6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiFYDnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFYDnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:43:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4713F62;
        Fri, 24 Jun 2022 20:43:05 -0700 (PDT)
X-UUID: d3528aa41f1e4062b45d413fc9c3860d-20220625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b31e0792-f028-4a94-85fa-ad233c9808bf,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.6,REQID:b31e0792-f028-4a94-85fa-ad233c9808bf,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:b14ad71,CLOUDID:e65378ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:03d3e511f511,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d3528aa41f1e4062b45d413fc9c3860d-20220625
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 783343857; Sat, 25 Jun 2022 11:42:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 25 Jun 2022 11:42:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Jun 2022 11:42:57 +0800
Message-ID: <4efb47b5323891c72dd0341f911ced74f39bfb07.camel@mediatek.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add IAD descriptor
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        "Julian Scheel" <julian@jusst.de>, xin lin <xin.lin@mediatek.com>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Sat, 25 Jun 2022 11:42:57 +0800
In-Reply-To: <YrWif4oeelZrctmr@kroah.com>
References: <20220622085757.23437-1-chunfeng.yun@mediatek.com>
         <YrWif4oeelZrctmr@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 13:39 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 22, 2022 at 04:57:57PM +0800, Chunfeng Yun wrote:
> > From: xin lin <xin.lin@mediatek.com>
> > 
> > Win10 can not enumerate composite device of UVC+UAC1+ADB without
> > IAD descriptor
> > in uac1.0, so add it.
> 
> I do not know what this means at all, sorry.  Can you please provide
> a
> better changelog text that describes what all of this is in more
> detail?
Ok, will add it in next version

> 
> 
> 
> > 
> > Signed-off-by: xin lin <xin.lin@mediatek.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/gadget/function/f_uac1.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/f_uac1.c
> > b/drivers/usb/gadget/function/f_uac1.c
> > index 6f0e1d803dc2..8390207bc513 100644
> > --- a/drivers/usb/gadget/function/f_uac1.c
> > +++ b/drivers/usb/gadget/function/f_uac1.c
> > @@ -71,6 +71,17 @@ static inline struct f_uac1_opts
> > *g_audio_to_uac1_opts(struct g_audio *audio)
> >   * ALSA_Playback -> IT_3 -> OT_4 -> USB-IN
> >   */
> >  
> > +static struct usb_interface_assoc_descriptor iad_desc = {
> > +	.bLength = sizeof(iad_desc),
> > +	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
> > +
> > +	.bFirstInterface = 0,
> > +	.bInterfaceCount = 3,
> > +	.bFunctionClass = USB_CLASS_AUDIO,
> > +	.bFunctionSubClass = 0,
> > +	.bFunctionProtocol = UAC_VERSION_1,
> > +};
> > +
> >  /* B.3.1  Standard AC Interface Descriptor */
> >  static struct usb_interface_descriptor ac_interface_desc = {
> >  	.bLength =		USB_DT_INTERFACE_SIZE,
> > @@ -259,6 +270,7 @@ static struct uac_iso_endpoint_descriptor
> > as_iso_in_desc = {
> >  };
> >  
> >  static struct usb_descriptor_header *f_audio_desc[] = {
> > +	(struct usb_descriptor_header *)&iad_desc,
> 
> Why put this first?  Is that a requirement?
Yes, it's a requirement,
Interface Association Descriptor ECN:
"An interface association descriptor must be located before the set of
interface descriptors (including all alternate settings) for the
interfaces it associates."

> 
> >  	(struct usb_descriptor_header *)&ac_interface_desc,
> >  	(struct usb_descriptor_header *)&ac_header_desc,
> >  
> > @@ -293,6 +305,7 @@ static struct usb_descriptor_header
> > *f_audio_desc[] = {
> >  };
> >  
> >  enum {
> > +	STR_ASSOC,
> 
> Again, why first?
follow uac2 driver
> 
> >  	STR_AC_IF,
> >  	STR_USB_OUT_IT,
> >  	STR_USB_OUT_IT_CH_NAMES,
> > @@ -310,6 +323,7 @@ enum {
> >  
> >  static struct usb_string strings_uac1[] = {
> >  	/* [STR_AC_IF].s = DYNAMIC, */
> > +	[STR_ASSOC].s = "Source/Sink",
> >  	[STR_USB_OUT_IT].s = "Playback Input terminal",
> >  	[STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
> >  	[STR_IO_OUT_OT].s = "Playback Output terminal",
> > @@ -1058,6 +1072,7 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >  	as_out_header_desc.bTerminalLink = usb_out_it_desc.bTerminalID;
> >  	as_in_header_desc.bTerminalLink = usb_in_ot_desc.bTerminalID;
> >  
> > +	iad_desc.bInterfaceCount = 1;
> 
> Why this change?
FS, HS may be different, count up them again.

> 
> 
> >  	ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc-
> > >bLength);
> >  
> >  	if (EPIN_EN(opts)) {
> > @@ -1068,6 +1083,7 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >  		if (FUIN_EN(opts))
> >  			len += in_feature_unit_desc->bLength;
> >  		ac_header_desc->wTotalLength = cpu_to_le16(len);
> > +		iad_desc.bInterfaceCount++;
> >  	}
> >  	if (EPOUT_EN(opts)) {
> >  		u16 len = le16_to_cpu(ac_header_desc->wTotalLength);
> > @@ -1077,9 +1093,11 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >  		if (FUOUT_EN(opts))
> >  			len += out_feature_unit_desc->bLength;
> >  		ac_header_desc->wTotalLength = cpu_to_le16(len);
> > +		iad_desc.bInterfaceCount++;
> >  	}
> >  
> >  	i = 0;
> > +	f_audio_desc[i++] = USBDHDR(&iad_desc);
> 
> Again, why first?
It is a requirement as ECN says.

> 
> >  	f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
> >  	f_audio_desc[i++] = USBDHDR(ac_header_desc);
> >  
> > @@ -1217,6 +1235,7 @@ static int f_audio_bind(struct
> > usb_configuration *c, struct usb_function *f)
> >  		}
> >  	}
> >  
> > +	iad_desc.iFunction = us[STR_ASSOC].id;
> >  	ac_interface_desc.iInterface = us[STR_AC_IF].id;
> >  	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
> >  	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id;
> > @@ -1302,6 +1321,8 @@ static int f_audio_bind(struct
> > usb_configuration *c, struct usb_function *f)
> >  	status = usb_interface_id(c, f);
> >  	if (status < 0)
> >  		goto err_free_fu;
> > +
> > +	iad_desc.bFirstInterface = status;
> 
> Shouldn't this be needed without your change?
Need update, it's not always 0.

Thanks a lot

> 
> thanks,
> 
> greg k-h

