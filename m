Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A898509C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387603AbiDUJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386678AbiDUJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:27:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC026559;
        Thu, 21 Apr 2022 02:24:13 -0700 (PDT)
X-UUID: 8ecf84722b734c3d831912b379c54374-20220421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c0f75f04-f49e-4cf9-9299-68a3c21f5a64,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:28,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:8
X-CID-INFO: VERSION:1.1.4,REQID:c0f75f04-f49e-4cf9-9299-68a3c21f5a64,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:28,FILE:0,RULE:Release_UHam,AC
        TION:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:d75f79f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:12|15|28|100|16|18|48|101,TC:nil,Content:0,EDM:-3
        ,File:nil,QS:0,BEC:nil
X-UUID: 8ecf84722b734c3d831912b379c54374-20220421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ping-lei.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 421263202; Thu, 21 Apr 2022 17:24:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Apr 2022 17:24:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Apr 2022 17:24:05 +0800
From:   James_Lin <Ping-lei.Lin@mediatek.com>
To:     <nicolas@ndufresne.ca>
CC:     <Ping-lei.Lin@mediatek.com>, <acourbot@chromium.org>,
        <arnd@arndb.de>, <ezequiel@vanguardiasur.com.ar>,
        <hverkuil-cisco@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <max.yan@mediatek.com>, <mchehab@kernel.org>,
        <ribalda@chromium.org>, <sakari.ailus@linux.intel.com>,
        <senozhatsky@chromium.org>, <sherlock.chang@mediatek.com>,
        <tm.wu@mediatek.com>
Subject: Re: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
Date:   Thu, 21 Apr 2022 17:23:54 +0800
Message-ID: <20220421092354.16774-1-Ping-lei.Lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <4b6b65e72b3f3cd74af5a3f0069838c86a6725e9.camel@ndufresne.ca>
References: <4b6b65e72b3f3cd74af5a3f0069838c86a6725e9.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Do I need to add the comment 
"some cameras represent hevc as h265"
at /drivers/media/usb/uvc/uvc_driver.c ?
Also, is there anything else that needs to be modified?

Or can it move to queue on next merged window?
thanks for your reply

Best regards,
James_Lin

On WED, 20 Apr 2022 at 01:37, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> Le mardi 19 avril 2022 à 14:18 +0200, Ricardo Ribalda a écrit :
> > On Tue, 19 Apr 2022 at 14:17, Laurent Pinchart 
> > <laurent.pinchart@ideasonboard.com> wrote:
> > > 
> > > Hello,
> > > 
> > > On Tue, Apr 19, 2022 at 01:46:15PM +0200, Ricardo Ribalda wrote:
> > > > On Mon, 18 Apr 2022 at 11:07, James_Lin <Ping-lei.Lin@mediatek.com> wrote:
> > > > > 
> > > > > This patch aims to add UVC_GUID_FORMAT_H265 High Efficiency 
> > > > > Video Coding (HEVC), also known as H.265 and MPEG-H Part 2.
> > > > > They describe the same video encoding method.
> > > > > So for handling their behavior is the same.
> > > > > However, when external camera device describes this encoding 
> > > > > method, some use hevc, some use h265.
> > > > > There is no uniform specification to describe this encoding method.
> > > > > So if an external camera device use h265 to describe this 
> > > > > encoding method, driver will not recognize it.
> > > > > Therefore, this patch is to enable driver to read HEVC/H265 and 
> > > > > convert it to V4L2_PIX_FMT_HEVC.
> > > > > 
> > > > > Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> > > > 
> > > > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
> > > > >  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
> > > > >  2 files changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c 
> > > > > b/drivers/media/usb/uvc/uvc_driver.c
> > > > > index dda0f0aa78b8..e437e9f95890 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > > @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] = {
> > > > >                 .guid           = UVC_GUID_FORMAT_H264,
> > > > >                 .fcc            = V4L2_PIX_FMT_H264,
> > > > >         },
> > > > 
> > > > Maybe I would add a comment here saying that some cameras 
> > > > represent hevc as h265.
> > > 
> > > I wish there would be a 4CC and GUID standard with a centralized 
> > > registry...
> > 
> > Thought that was the kernel codebase :)
> 
> You'll find multiple fourcc for the same thing in the linux kernel ;-P
> 
> > 
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > > > +       {
> > > > > +               .name           = "H.265",
> > > > > +               .guid           = UVC_GUID_FORMAT_H265,
> > > > > +               .fcc            = V4L2_PIX_FMT_HEVC,
> > > > > +       },
> > > > >         {
> > > > >                 .name           = "Greyscale 8 L/R (Y8I)",
> > > > >                 .guid           = UVC_GUID_FORMAT_Y8I,
> > > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h 
> > > > > b/drivers/media/usb/uvc/uvcvideo.h
> > > > > index 143230b3275b..41f4d8c33f2a 100644
> > > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > > @@ -139,6 +139,9 @@
> > > > >  #define UVC_GUID_FORMAT_H264 \
> > > > >         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> > > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > > > +#define UVC_GUID_FORMAT_H265 \
> > > > > +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> > > > > +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > > >  #define UVC_GUID_FORMAT_Y8I \
> > > > >         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> > > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > 
> > > --
> > > Regards,
> > > 
> > > Laurent Pinchart
> > 
> > 
> > 
