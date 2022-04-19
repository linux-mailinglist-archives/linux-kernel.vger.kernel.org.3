Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65F5076AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348064AbiDSRjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDSRjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:39:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB104275CC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:36:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x12so1616948qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=drE3Vvgc/V+fnpihrYOc9KMqNg1xdJOT7Hgu1lLOYXU=;
        b=VNn55YznefnmFxbiHeFybFRRx10q4N3WTgm8faUA9fqMHT+kESq+EtXlHOqGO7ztG7
         rfE/DMNA86nYIOWkCHqeYgSCZmxu2D41dL5JKAGJcEmSTzQHh/35AuzT+sCBnH+DWsUD
         lBlNCL65a0dorLVD6Oy4LUMbr++3kxyIWjC8OxiGBuDWf8X9OXJ3/BdnDWPAxr/MjnN6
         QB1dvv6lyaJgcQRpfZnvj0ZWkalUqHvHQy+JLy6VrQnnjrxy0+WsLkVeLOGHR1TRjl3n
         +u02J2wpzF5x9MQk3tj2enbSMxmhyl7W6LIeBRYsloK1+gPSKB5TjzMDUXefmph2Js//
         sOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=drE3Vvgc/V+fnpihrYOc9KMqNg1xdJOT7Hgu1lLOYXU=;
        b=LcG5vNlCIk9ahf7+OuU6nT/rVfsGFahCo/aGqUnbFTJtCDmdI2aIqEd3Y98mNnM/tu
         bQAROcDI5jGZHSM6nsM9zHYjDxI+v/QbpY9k+5Lt5Bz0RARss8IUQFMlJhQNBtwo32Cg
         g8eIn50kTfmK5UG8681a/wJ1bgXAqXByUKxDQAW1QAgHjbBwVctn6R+LVEdIDK/DSDV3
         GNPPwKseHxPahAwOSSB1+bzr6yd2a5mqtsERs1ODYOSoEioALzUMH+9pxD0HCNgdjX1G
         xff0kungIcipWdcPaKCtWxK9cVs2dvBZbH7c2P2+/doXaJ92nWMmw5XwFGTnjTEW4swU
         ubXg==
X-Gm-Message-State: AOAM5319xP8XYnwuzd5wxqkFG2rQtSxRmbf3jbHGRxmiFl7z0rfuxTM6
        9QVRICIj4Xot2855aa4b22964g==
X-Google-Smtp-Source: ABdhPJxnMU9m4mjCO6v+7IT7ueE/RLpN6eOxn8O3dDrOEvFY/F3Y84Lri4r/GTIDQkSg80Gu/bD0cQ==
X-Received: by 2002:a05:622a:408f:b0:2ed:12b7:2e9c with SMTP id cg15-20020a05622a408f00b002ed12b72e9cmr11075993qtb.309.1650389814938;
        Tue, 19 Apr 2022 10:36:54 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a16b100b0069eb1eb06b7sm290943qkj.131.2022.04.19.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:36:54 -0700 (PDT)
Message-ID: <4b6b65e72b3f3cd74af5a3f0069838c86a6725e9.camel@ndufresne.ca>
Subject: Re: [PATCH v3] media: usb: uvc: Add UVC_GUID_FORMAT_H265
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     James_Lin <Ping-lei.Lin@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sherlock.chang@mediatek.com,
        lecopzer.chen@mediatek.com, max.yan@mediatek.com,
        tm.wu@mediatek.com
Date:   Tue, 19 Apr 2022 13:36:53 -0400
In-Reply-To: <CANiDSCv0BA5C8ijO-T_3c2rxGD_yC0LGuG77THkC7_52GZ-dtA@mail.gmail.com>
References: <20220418090652.3156-1-Ping-lei.Lin@mediatek.com>
         <CANiDSCvLb785H7qyAzSfTSBRpO2eM-oJFF5SgVHXdL1O-GusLA@mail.gmail.com>
         <Yl6oYlv+t63+5dVP@pendragon.ideasonboard.com>
         <CANiDSCv0BA5C8ijO-T_3c2rxGD_yC0LGuG77THkC7_52GZ-dtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 19 avril 2022 =C3=A0 14:18 +0200, Ricardo Ribalda a =C3=A9crit=C2=
=A0:
> On Tue, 19 Apr 2022 at 14:17, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >=20
> > Hello,
> >=20
> > On Tue, Apr 19, 2022 at 01:46:15PM +0200, Ricardo Ribalda wrote:
> > > On Mon, 18 Apr 2022 at 11:07, James_Lin <Ping-lei.Lin@mediatek.com> w=
rote:
> > > >=20
> > > > This patch aims to add UVC_GUID_FORMAT_H265
> > > > High Efficiency Video Coding (HEVC), also known as H.265 and MPEG-H=
 Part 2.
> > > > They describe the same video encoding method.
> > > > So for handling their behavior is the same.
> > > > However, when external camera device describes this encoding method=
,
> > > > some use hevc, some use h265.
> > > > There is no uniform specification to describe this encoding method.
> > > > So if an external camera device use h265 to describe this encoding =
method,
> > > > driver will not recognize it.
> > > > Therefore, this patch is to enable driver to read HEVC/H265
> > > > and convert it to V4L2_PIX_FMT_HEVC.
> > > >=20
> > > > Signed-off-by: James_Lin <Ping-lei.Lin@mediatek.com>
> > >=20
> > > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c | 5 +++++
> > > >  drivers/media/usb/uvc/uvcvideo.h   | 3 +++
> > > >  2 files changed, 8 insertions(+)
> > > >=20
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb=
/uvc/uvc_driver.c
> > > > index dda0f0aa78b8..e437e9f95890 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -154,6 +154,11 @@ static struct uvc_format_desc uvc_fmts[] =3D {
> > > >                 .guid           =3D UVC_GUID_FORMAT_H264,
> > > >                 .fcc            =3D V4L2_PIX_FMT_H264,
> > > >         },
> > >=20
> > > Maybe I would add a comment here saying that some cameras represent
> > > hevc as h265.
> >=20
> > I wish there would be a 4CC and GUID standard with a centralized
> > registry...
>=20
> Thought that was the kernel codebase :)

You'll find multiple fourcc for the same thing in the linux kernel ;-P

>=20
> >=20
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >=20
> > > > +       {
> > > > +               .name           =3D "H.265",
> > > > +               .guid           =3D UVC_GUID_FORMAT_H265,
> > > > +               .fcc            =3D V4L2_PIX_FMT_HEVC,
> > > > +       },
> > > >         {
> > > >                 .name           =3D "Greyscale 8 L/R (Y8I)",
> > > >                 .guid           =3D UVC_GUID_FORMAT_Y8I,
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/u=
vc/uvcvideo.h
> > > > index 143230b3275b..41f4d8c33f2a 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -139,6 +139,9 @@
> > > >  #define UVC_GUID_FORMAT_H264 \
> > > >         { 'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00, \
> > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > > +#define UVC_GUID_FORMAT_H265 \
> > > > +       { 'H',  '2',  '6',  '5', 0x00, 0x00, 0x10, 0x00, \
> > > > +        0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> > > >  #define UVC_GUID_FORMAT_Y8I \
> > > >         { 'Y',  '8',  'I',  ' ', 0x00, 0x00, 0x10, 0x00, \
> > > >          0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71}
> >=20
> > --
> > Regards,
> >=20
> > Laurent Pinchart
>=20
>=20
>=20

