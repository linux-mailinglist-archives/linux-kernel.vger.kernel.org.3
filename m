Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADA4C7213
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiB1RCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiB1RCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:02:46 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A786E0F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:02:06 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a1so13551590qvl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y9cZVaut3aLdlKX+slS0PsytKlmPKaShOXQetxBEnLs=;
        b=RWahVHidsmUKk3zmU4u+GXNAQsPIO4fG+FWWtFLwh/nIJSVim2DRTMT+dtX8WkXnNw
         IhLL4C1HcJ9ZDzbcAYB1aCCOT3FAMdOlWQIR3BBfX/MfsCGxMk4tisEiRuqi6TuyNCSf
         fBYFIesGaDPEnn1TYpMJJTswWKjm+RtORcQOwTZFeT3QdpqpLHMeudiuIWfQsTYU0437
         Pi1+oFeFvCH2Diy8u1i22uQajV/YXRjXV3bwVdIFb+oScDEvFIPnjxKdB4/90MLk1imj
         iHRrkReVr4m6Z/SLB/qIhO18kTkqzsJx7zFvyvWA3udBE+sywy8GuIo2uGsBc3yBFJ0w
         4lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Y9cZVaut3aLdlKX+slS0PsytKlmPKaShOXQetxBEnLs=;
        b=laCrlfcDcD9vOlYl0eZFazdTh4xVUkz0xLz69ttZKfRV/s4klAn0gP68TgOmaIbLxw
         JO0bcV1GVplxP3IlvuVTYGNoReTXD8gdGq/2UfLz/XgwjbxrBKkJ19pwbLmQ6XvKvAqC
         PJKnZvsqQN85bJyg72r/R9tPAgwgpjFjPd/kbccuCv5wAqDK5Ldy4/H72w8MkVJ7L+RE
         WfUeCdvfx9FE/bke8GTbSK8jKc2iqc0zxfjMFUYvKeZJF6YZY3r97ptUDnITOzRrR+VE
         66P3HaTkqUU5mXEj64hAq89VoqeYqVyLwyDDfDLl9qETixq+/FBQovIZ914Yjmejb0NL
         tnNQ==
X-Gm-Message-State: AOAM532xwKMJPD+dO1VuZjtKwq1Ib222AlHi+jHcln+W4BBro1vWndmG
        /naHSD4g4VZFgyJOgoXfAI7Jow==
X-Google-Smtp-Source: ABdhPJwnakSt4EAfE7IsVjU7wlxEV+JgWuYIQRAupe57mnq3QS7Jav+/osBrc1CyPEkT1Hqcy4qtRw==
X-Received: by 2002:ad4:5605:0:b0:432:e77e:8023 with SMTP id ca5-20020ad45605000000b00432e77e8023mr7904254qvb.8.1646067726011;
        Mon, 28 Feb 2022 09:02:06 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm7506949qtp.1.2022.02.28.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:02:05 -0800 (PST)
Message-ID: <73f460d843cee2781c9d08cdc421f0fd64f9ccc7.camel@ndufresne.ca>
Subject: Re: Re: [RFC PATCH 2/8] media: Add P010 format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Mon, 28 Feb 2022 12:02:04 -0500
In-Reply-To: <5696849.MhkbZ0Pkbq@kista>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
         <20220227144926.3006585-3-jernej.skrabec@gmail.com>
         <1b2ce01fb04f29cca58d40bd81d9f4cc46dcebf8.camel@ndufresne.ca>
         <5696849.MhkbZ0Pkbq@kista>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 28 février 2022 à 17:32 +0100, Jernej Škrabec a écrit :
> Dne ponedeljek, 28. februar 2022 ob 13:48:53 CET je Nicolas Dufresne 
> napisal(a):
> > Le dimanche 27 février 2022 à 15:49 +0100, Jernej Skrabec a écrit :
> > > Add P010 format, which is commonly used for 10-bit videos.
> > 
> > There is a much more complete patch that was sent previously (with 
> documentation
> > and all):
> > 
> > https://patchwork.kernel.org/project/linux-rockchip/patch/
> 20210618131526.566762-5-benjamin.gaignard@collabora.com/
> 
> Great, I'll take it for next revision. Although I'm not sure what "much more 
> complete" means. Only additional thing is documentation.

When adding uAPI, doc is really important, so having the format documented means
the other patch is "much more" ready to be merged.

cheers,
Nicolas

> 
> Best regards,
> Jernej
> 
> > 
> > regards,
> > Nicolas
> > 
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-common.c | 2 ++
> > >  drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
> > >  include/uapi/linux/videodev2.h        | 1 +
> > >  3 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-
> core/v4l2-common.c
> > > index 1db0020e08c0..4ede36546e9c 100644
> > > --- a/drivers/media/v4l2-core/v4l2-common.c
> > > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > > @@ -275,6 +275,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 
> format)
> > >  		{ .format = V4L2_PIX_FMT_YUV422P, .pixel_enc = 
> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, 
> .hdiv = 2, .vdiv = 1 },
> > >  		{ .format = V4L2_PIX_FMT_GREY,    .pixel_enc = 
> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, 
> .hdiv = 1, .vdiv = 1 },
> > >  
> > > +		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = 
> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, 
> .hdiv = 2, .vdiv = 2 },
> > > +
> > >  		/* Tiled YUV formats */
> > >  		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = 
> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, 
> .hdiv = 2, .vdiv = 2 },
> > >  		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = 
> V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, 
> .hdiv = 2, .vdiv = 2 },
> > > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-
> core/v4l2-ioctl.c
> > > index 048f326c57b9..a8d999e23e5b 100644
> > > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > > @@ -1295,6 +1295,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc 
> *fmt)
> > >  	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 
> (M420)"; break;
> > >  	case V4L2_PIX_FMT_NV12:		descr = "Y/CbCr 4:2:0"; break;
> > >  	case V4L2_PIX_FMT_NV21:		descr = "Y/CrCb 4:2:0"; break;
> > > +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; 
> break;
> > >  	case V4L2_PIX_FMT_NV16:		descr = "Y/CbCr 4:2:2"; break;
> > >  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
> > >  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/
> videodev2.h
> > > index 772dbadd1a24..211bc11a48cb 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -597,6 +597,7 @@ struct v4l2_pix_format {
> > >  /* two planes -- one Y, one Cr + Cb interleaved  */
> > >  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 
> 4:2:0  */
> > >  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 
> 4:2:0  */
> > > +#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 
> 4:2:0 10-bit */
> > >  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 
> 4:2:2  */
> > >  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 
> 4:2:2  */
> > >  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 
> 4:4:4  */
> > 
> > 
> 
> 

