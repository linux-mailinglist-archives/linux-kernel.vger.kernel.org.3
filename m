Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017FA5A3EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiH1RIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH1RIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:08:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A33137E;
        Sun, 28 Aug 2022 10:08:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56896E5;
        Sun, 28 Aug 2022 19:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661706514;
        bh=vhgmM53K9Y+jvkYIFiuLg/mUaZWx/0ij7HFPaGKbUM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQiNJnJOQpGPUe21RK766ReECSJvXsiZnDSvEUkf6u6x1d9/nZFneS+mtBIST+Jch
         8Rrs+j9UNxjOBQufNtkROwjLe/rP0nG6NPpq0V2tplm3eTFXMX+2M5wbc9Bsnp5W4Q
         un8X6xT8uWXKM23c1XhJl/SmNjLu+BfNTk0jIPaE=
Date:   Sun, 28 Aug 2022 20:08:26 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "nanxin.qin@amlogic.com" <nanxin.qin@amlogic.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "hao.shi" <hao.shi@amlogic.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mchehab <mchehab@kernel.org>,
        "hans.verkuil" <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        ezequiel <ezequiel@vanguardiasur.com.ar>,
        "sakari.ailus" <sakari.ailus@linux.intel.com>,
        ribalda <ribalda@chromium.org>,
        "stanimir.varbanov" <stanimir.varbanov@linaro.org>,
        "Hui.Zhang@amlogic.com" <Hui.Zhang@amlogic.com>
Subject: Re: Re: [PATCH] [media] v4l2: Add AV1, AVS and AVS2 format
Message-ID: <YwuhCkhuXpgpTC/W@pendragon.ideasonboard.com>
References: <20220826030003.1066976-1-hao.shi@amlogic.com>
 <YwiPMOyfXKM8lxIR@pendragon.ideasonboard.com>
 <0099cb36956090f7c5f3058b353d3555870aea32.camel@ndufresne.ca>
 <202208271409184370088@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202208271409184370088@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 02:09:18PM +0800, nanxin.qin@amlogic.com wrote:
> Dear Nicolas
> 
> Thanks for the review of our CL, we found that AV1 has not been submitted to
> the kernel tree. Due to the urgency of the project, we intend to submit the public
> changes to the kernel mainline. However, it may be more suitable for the coding
> protocol working group to submit. 
> 
> I have a doubt about the reply, can we just add a description of AV1
> in pixfmt-compressed.rst? Just like declaring vp9.

Referring to the corresponding standard is fine. If the standard, or the
V4L2 API, supports multiple formats (e.g. H.264 with or without start
codes, or formats that contain different metadata for stateful or
stateless codecs), the documentation should also indicate which variant
the format refers to.

> In addition, avs and avs2 are Chinese audio and video coding standards, 
> which are mandatory for TV set-top boxes sold in China. I think it is necessary
> to submit them to the main branch. 
> 
> Then there is whether it is appropriate to submit AV1 and AVS together. 
> If it is not good, we can submit it separately. 
> 
> Please correct me if you have any suggestions or comments. thanks.
> 
> nanxin.qin@amlogic.com
>  
> From: Nicolas Dufresne
> Date: 2022-08-27 02:12
> To: Laurent Pinchart; Shi Hao
> CC: linux-media; linux-kernel; mchehab; hans.verkuil; hverkuil-cisco; ezequiel; sakari.ailus; ribalda; stanimir.varbanov; nanxin.qin
> Subject: Re: [PATCH] [media] v4l2: Add AV1, AVS and AVS2 format
> [ EXTERNAL EMAIL ]
>  
> Le vendredi 26 août 2022 à 12:15 +0300, Laurent Pinchart a écrit :
> > Hello Shi,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Aug 26, 2022 at 11:00:03AM +0800, Shi Hao wrote:
> > > From: "hao.shi" <hao.shi@amlogic.com>
> > > 
> > > Add AV1, AVS and AVS2 compressed pixel formats. They are
> > > the more common formats.
> > > 
> > > Signed-off-by: Shi Hao <hao.shi@amlogic.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-ioctl.c | 3 +++
> > >  include/uapi/linux/videodev2.h       | 3 +++
> > 
> > The patch also needs to document the formats, in
> > Documentation/userspace-api/media/v4l/.
> > 
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > index c314025d977e..7b102c2f59b1 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1497,6 +1497,9 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> > >  case V4L2_PIX_FMT_MT21C: descr = "Mediatek Compressed Format"; break;
> > >  case V4L2_PIX_FMT_QC08C: descr = "QCOM Compressed 8-bit Format"; break;
> > >  case V4L2_PIX_FMT_QC10C: descr = "QCOM Compressed 10-bit Format"; break;
> > > + case V4L2_PIX_FMT_AV1: descr = "AV1"; break;
>  
> A recommendation while adding proper spec/doc. AV1 have multiple representation,
> the exact expected representation should be specified in the doc. This will
> avoid similar issues we had with H.264 (Annex B. vs AVCc formats).
>  
> > > + case V4L2_PIX_FMT_AVS: descr = "AVS"; break;
> > > + case V4L2_PIX_FMT_AVS2: descr = "AVS2"; break;
>  
> Same things should be checked for these two, they aren't very common outside of
> China, at least I didn't had a chance to play with these so far.
>  
> cheers,
> Nicolas
>  
> > >  default:
> > >  if (fmt->description[0])
> > >  return;
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > > index 01e630f2ec78..fa8ec0ddde3d 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -738,6 +738,9 @@ struct v4l2_pix_format {
> > >  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
> > >  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> > >  #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
> > > +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
> > > +#define V4L2_PIX_FMT_AVS      v4l2_fourcc('A', 'V', 'S', '0') /* AVS */
> > > +#define V4L2_PIX_FMT_AVS2     v4l2_fourcc('A', 'V', 'S', '2') /* AVS2 */
> > >  
> > >  /*  Vendor-specific formats   */
> > >  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
> > > 
> > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

-- 
Regards,

Laurent Pinchart
