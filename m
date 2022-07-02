Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD84563F1C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiGBIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:41:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EF1758F;
        Sat,  2 Jul 2022 01:41:39 -0700 (PDT)
X-UUID: ba75ed63f65b405296e4e46d91d4a0d4-20220702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:7bb2a622-aaa9-4e81-9748-fe952e890322,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.7,REQID:7bb2a622-aaa9-4e81-9748-fe952e890322,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:87442a2,CLOUDID:febd6ad6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:3378c9d810bb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ba75ed63f65b405296e4e46d91d4a0d4-20220702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 171830191; Sat, 02 Jul 2022 16:41:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 2 Jul 2022 16:41:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 2 Jul 2022 16:41:32 +0800
Message-ID: <df7a6c412d6b96e5fd7bed8973d57b9214d4f590.camel@mediatek.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac1: add interface association
 descriptor
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Hofman <pavel.hofman@ivitera.com>,
        Julian Scheel <julian@jusst.de>,
        Yunhao Tian <t123yh.xyz@gmail.com>,
        xin lin <xin.lin@mediatek.com>,
        "Linux USB" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sat, 2 Jul 2022 16:41:32 +0800
In-Reply-To: <CAB=otbQ3L0G6NYvFwBe268auGG3iS6shk9z+SpgKrkLthn-qGg@mail.gmail.com>
References: <20220629021304.21725-1-chunfeng.yun@mediatek.com>
         <CAB=otbQ3L0G6NYvFwBe268auGG3iS6shk9z+SpgKrkLthn-qGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-29 at 12:46 +0300, Ruslan Bilovol wrote:
>  On Wed, Jun 29, 2022 at 5:13 AM Chunfeng Yun <
> chunfeng.yun@mediatek.com> wrote:
> > 
> > From: xin lin <xin.lin@mediatek.com>
> > 
> > When we want to use a composite device that supports UVC, UAC1 and
> > ADB at the same time, encounter that UAC1 can't work when connected
> > to windows 10 system.
> > From the online documents of microsoft, "overview of enumeration of
> > interface collections on usb composite devices", it recommends that
> > vendors use IADs (interface association descriptor) to define
> > interface collections.
> > After addding IAD, we can fix the issue.
> 
> It is incorrect to add Interface Association Descriptor to the UAC1
> function.
> The UAC1 specification was developed much earlier than IAD was
> invented, and it
> implements this functionality in another way - by describing number
> of
> associated
> interfaces and interface numbers on Class-Specific AC Interface
> Descriptor level;
> see *bInCollection* and *baInterfaceNr* fields of UAC1 Class-Specific
> AC Interface
> Header Descriptor in 4.3.2 section of UAC1 specification.
> 
> This is already implemented in f_uac1.c (see where *bInCollection*
> and
> *baInterfaceNr*
> are updated), along with support of dynamic capture/playback
> endpoints
> enablement.
> Adding IAD to the UAC1 driver is duplicating that functionality and
> isn't supported
> by UAC1 spec.
Ok, seems win10 don't support this way.

Abandon this patch.

> 
> On the other hand, the USB orgcommittee switched the approach of
> interface collection
> definition from a class-specific descriptors level to IAD in the UAC2
> spec.
> So why not use UAC2 function for the same purpose, it already has IAD
> implemented
> and is supported by Win10?
unfortunately, also encounter enumeration issues on some versions of
win10.

Thanks

> 
> Thanks,
> Ruslan
> 
> > 
> > Signed-off-by: xin lin <xin.lin@mediatek.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: modify commit log suggested by Greg
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
> > +       .bLength = sizeof(iad_desc),
> > +       .bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
> > +
> > +       .bFirstInterface = 0,
> > +       .bInterfaceCount = 3,
> > +       .bFunctionClass = USB_CLASS_AUDIO,
> > +       .bFunctionSubClass = 0,
> > +       .bFunctionProtocol = UAC_VERSION_1,
> > +};
> > +
> >  /* B.3.1  Standard AC Interface Descriptor */
> >  static struct usb_interface_descriptor ac_interface_desc = {
> >         .bLength =              USB_DT_INTERFACE_SIZE,
> > @@ -259,6 +270,7 @@ static struct uac_iso_endpoint_descriptor
> > as_iso_in_desc = {
> >  };
> > 
> >  static struct usb_descriptor_header *f_audio_desc[] = {
> > +       (struct usb_descriptor_header *)&iad_desc,
> >         (struct usb_descriptor_header *)&ac_interface_desc,
> >         (struct usb_descriptor_header *)&ac_header_desc,
> > 
> > @@ -293,6 +305,7 @@ static struct usb_descriptor_header
> > *f_audio_desc[] = {
> >  };
> > 
> >  enum {
> > +       STR_ASSOC,
> >         STR_AC_IF,
> >         STR_USB_OUT_IT,
> >         STR_USB_OUT_IT_CH_NAMES,
> > @@ -310,6 +323,7 @@ enum {
> > 
> >  static struct usb_string strings_uac1[] = {
> >         /* [STR_AC_IF].s = DYNAMIC, */
> > +       [STR_ASSOC].s = "Source/Sink",
> >         [STR_USB_OUT_IT].s = "Playback Input terminal",
> >         [STR_USB_OUT_IT_CH_NAMES].s = "Playback Channels",
> >         [STR_IO_OUT_OT].s = "Playback Output terminal",
> > @@ -1058,6 +1072,7 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >         as_out_header_desc.bTerminalLink =
> > usb_out_it_desc.bTerminalID;
> >         as_in_header_desc.bTerminalLink =
> > usb_in_ot_desc.bTerminalID;
> > 
> > +       iad_desc.bInterfaceCount = 1;
> >         ac_header_desc->wTotalLength = cpu_to_le16(ac_header_desc-
> > >bLength);
> > 
> >         if (EPIN_EN(opts)) {
> > @@ -1068,6 +1083,7 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >                 if (FUIN_EN(opts))
> >                         len += in_feature_unit_desc->bLength;
> >                 ac_header_desc->wTotalLength = cpu_to_le16(len);
> > +               iad_desc.bInterfaceCount++;
> >         }
> >         if (EPOUT_EN(opts)) {
> >                 u16 len = le16_to_cpu(ac_header_desc-
> > >wTotalLength);
> > @@ -1077,9 +1093,11 @@ static void setup_descriptor(struct
> > f_uac1_opts *opts)
> >                 if (FUOUT_EN(opts))
> >                         len += out_feature_unit_desc->bLength;
> >                 ac_header_desc->wTotalLength = cpu_to_le16(len);
> > +               iad_desc.bInterfaceCount++;
> >         }
> > 
> >         i = 0;
> > +       f_audio_desc[i++] = USBDHDR(&iad_desc);
> >         f_audio_desc[i++] = USBDHDR(&ac_interface_desc);
> >         f_audio_desc[i++] = USBDHDR(ac_header_desc);
> > 
> > @@ -1217,6 +1235,7 @@ static int f_audio_bind(struct
> > usb_configuration *c, struct usb_function *f)
> >                 }
> >         }
> > 
> > +       iad_desc.iFunction = us[STR_ASSOC].id;
> >         ac_interface_desc.iInterface = us[STR_AC_IF].id;
> >         usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
> >         usb_out_it_desc.iChannelNames =
> > us[STR_USB_OUT_IT_CH_NAMES].id;
> > @@ -1302,6 +1321,8 @@ static int f_audio_bind(struct
> > usb_configuration *c, struct usb_function *f)
> >         status = usb_interface_id(c, f);
> >         if (status < 0)
> >                 goto err_free_fu;
> > +
> > +       iad_desc.bFirstInterface = status;
> >         ac_interface_desc.bInterfaceNumber = status;
> >         uac1->ac_intf = status;
> >         uac1->ac_alt = 0;
> > --
> > 2.18.0
> > 

