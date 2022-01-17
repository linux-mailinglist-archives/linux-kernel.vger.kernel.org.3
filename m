Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9149002D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiAQCYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiAQCYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:24:51 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B980C061574;
        Sun, 16 Jan 2022 18:24:51 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h15so13495549qtx.0;
        Sun, 16 Jan 2022 18:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SHEqK5JLEeu9SvzW1gebcOdXEXOC523/xTa7jp+gqf8=;
        b=TvemMbt1elmxONhCJ9bH+fFSahL1xeJY28RNaE6HHzLKPlbBCnEDGSMQjNtjjvXNgJ
         iYikFbnch4vVl6JJ7XKg/m4yQf7LuRmKV+zvXMOmcSE/h6x0/D5PbsFizFJCeC6G88Su
         Ui8z2hRE1LW2AZsGCVvRIWb2oYoHKh+tUeC3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHEqK5JLEeu9SvzW1gebcOdXEXOC523/xTa7jp+gqf8=;
        b=YfTL3PoP8zVX/gzgCUYFe1VLYscrGaNrkGZV1+QPvCo7mIbJ2wMjvfqiLfXxVKWVFH
         6lVohrkzn1ayv/3wCxAhMDNLGu7fFrq9T/pENKpwcw/z4ICwyXMrG3YbMO7IDXmFwSyW
         1wVl+nArrb1SNRU0Dx9kMHt9Qi6e6ZORzDBKky6vkLVMD8+ii7nfCjoxO/tHgZC3vf75
         OJALIOVdgXvWHPRe4ZFGkPhP3L1wQBMtI7wVE+v+DtoCUwUZb0DvoRd0rS855BmIxgqw
         ioQnBPSmldKSBR8yI+gJnsUjFRvFRQRufdqB14LlmWiy7ayAZGj+mt2G/ghVgFhdY1DE
         Z34g==
X-Gm-Message-State: AOAM533ozr/pvbb91aNggZ8ll4bHaaua2JLeOHqESAkzchWVQMTsoEts
        q6xY9H8v0FOxyYz5LnjQgtVBn0r8fYqCjcc0ZIc=
X-Google-Smtp-Source: ABdhPJz8JBgHOfrwZOtiSMxcwxbBOgBqdYtj7KzYp4bLd6Rg5DcQyjzHbwHoY68mX+g481LUhrQs/hy8EQVUxZt1ibw=
X-Received: by 2002:a05:622a:1a89:: with SMTP id s9mr10025191qtc.625.1642386290551;
 Sun, 16 Jan 2022 18:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
 <20211224012738.1551-2-jammy_huang@aspeedtech.com> <703ff71e-c76a-9df1-c644-04efed0199ca@xs4all.nl>
 <609cfe9e-2fd8-b31a-9d71-b83d61693f84@aspeedtech.com>
In-Reply-To: <609cfe9e-2fd8-b31a-9d71-b83d61693f84@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 17 Jan 2022 02:24:38 +0000
Message-ID: <CACPK8XeJQHLWfVbBjArxV_QMDDnRXfccOeXdsn6aBEG7gd8yvw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] media: v4l: Add definition for the Aspeed JPEG format
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 at 02:00, Jammy Huang <jammy_huang@aspeedtech.com> wrot=
e:
>
> Hi Hans,
>
> On 2022/1/14 =E4=B8=8B=E5=8D=88 04:11, Hans Verkuil wrote:
> > On 24/12/2021 02:27, Jammy Huang wrote:
> >> This introduces support for the Aspeed JPEG format, where the new fram=
e
> >> can refer to previous frame to reduce the amount of compressed data. T=
he
> >> concept is similar to I/P frame of video compression. It will compare =
the
> >> new frame with previous one to decide which macroblock's data is
> >> changed, and only the changed macroblocks will be compressed.
> >>
> >> This Aspeed JPEG format is used by the video engine on Aspeed platform=
s,
> >> which is generally adapted for remote KVM.
> >>
> >> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> >> ---
> >> v8:
> >>    - Add decoder information for aspeed-jpeg
> >> v7:
> >>    - Add more information for aspeed-jpeg
> >> v6:
> >>    - Update description for new format, aspeed-jpeg, in Documentation.
> >> v5:
> >>    - no update
> >> v4:
> >>    - new
> >> ---
> >>   .../media/uapi/v4l/pixfmt-reserved.rst          | 17 +++++++++++++++=
++
> >>   drivers/media/v4l2-core/v4l2-ioctl.c            |  1 +
> >>   include/uapi/linux/videodev2.h                  |  1 +
> >>   3 files changed, 19 insertions(+)
> >>
> >> diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Docume=
ntation/media/uapi/v4l/pixfmt-reserved.rst
> > This is the wrong file! It should be:
> >
> > Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>
> Thanks, I just used git format-patch to generate the cover-letter and
> didn't notice this.
>
> It looks like the file, pixfmt-reserved.rst, has different path in
> different Linux kernel,
>
> * 5.4:           Documentation/media/uapi/v4l/pixfmt-reserved.rst
>
> * 5.10/5.15: Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>
> 5.4 is the one I based to submit the patches.
>
> Could you suggest the kernel that I should based to submit these patches?=
?

You should always submit based on the latest release.

There are sometimes exceptions where you will base your patches on
something even newer, but generally you should grab the latest.

Be sure to re-test on the latest kernel before submitting.

Cheers,

Joel

>
> I will need to change the number of V4L2_CID_USER_ASPEED_BASE per differe=
nt
>
> linux kernel as well.
>
> >
> > Regards,
> >
> >       Hans
> >
> >> index b2cd155e691b..1d0dc8d86ed7 100644
> >> --- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
> >> +++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
> >> @@ -264,6 +264,23 @@ please make a proposal on the linux-media mailing=
 list.
> >>      of tiles, resulting in 32-aligned resolutions for the luminance p=
lane
> >>      and 16-aligned resolutions for the chrominance plane (with 2x2
> >>      subsampling).
> >> +    * .. _V4L2-PIX-FMT-AJPG:
> >> +
> >> +      - ``V4L2_PIX_FMT_AJPG``
> >> +      - 'AJPG'
> >> +      - ASPEED JPEG format used by the aspeed-video driver on Aspeed =
platforms,
> >> +        which is generally adapted for remote KVM.
> >> +        On each frame compression, I will compare the new frame with =
previous
> >> +        one to decide which macroblock's data is changed, and only th=
e changed
> >> +        macroblocks will be compressed.
> >> +
> >> +        The implementation is based on AST2600 A3 datasheet, revision=
 0.9, which
> >> +        is not publicly available. Or you can reference Video stream =
data format
> >> +        =E2=80=93 ASPEED mode compression of SDK_User_Guide which ava=
ilable on
> >> +        AspeedTech-BMC/openbmc/releases.
> >> +
> >> +        Decoder's implementation can be found here,
> >> +        `https://github.com/AspeedTech-BMC/aspeed_codec/ <https://git=
hub.com/AspeedTech-BMC/aspeed_codec/>`__
> >>
> >>   .. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2=
-core/v4l2-ioctl.c
> >> index 24db33f803c0..00dde01d2f97 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> @@ -1378,6 +1378,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc=
 *fmt)
> >>              case V4L2_PIX_FMT_S5C_UYVY_JPG: descr =3D "S5C73MX interl=
eaved UYVY/JPEG"; break;
> >>              case V4L2_PIX_FMT_MT21C:        descr =3D "Mediatek Compr=
essed Format"; break;
> >>              case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr =3D "Sunxi Tile=
d NV12 Format"; break;
> >> +            case V4L2_PIX_FMT_AJPG:         descr =3D "Aspeed JPEG"; =
break;
> >>              default:
> >>                      if (fmt->description[0])
> >>                              return;
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/video=
dev2.h
> >> index 3210b3c82a4a..994eb6155ea9 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -726,6 +726,7 @@ struct v4l2_pix_format {
> >>   #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Int=
el Planar Greyscale 10-bit and Depth 16-bit */
> >>   #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2'=
) /* Sunxi Tiled NV12 Format */
> >>   #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Int=
el 4-bit packed depth confidence information */
> >> +#define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspe=
ed JPEG */
> >>
> >>   /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 =
bits unused */
> >>   #define V4L2_PIX_FMT_IPU3_SBGGR10  v4l2_fourcc('i', 'p', '3', 'b') /=
* IPU3 packed 10-bit BGGR bayer */
>
> --
> Best Regards
> Jammy
>
