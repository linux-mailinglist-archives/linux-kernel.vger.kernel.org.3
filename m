Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490D54FE94B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiDLUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDLUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:08:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98E4BBBC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:02:26 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c1so3319712qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mimD/qtnByUgFcn0cB8f/8cZYicL+2+zJ6czmpHJvo8=;
        b=dN9a2qERqiJodagN+p0JnNAnJvIgdnzwuskkMdZQEoyL0RKjcsg4pduh6bJ+vxWXmL
         4YYy4nxhiPsFu+iA6AY1DHtyaK2SDu/KflTieqjkOZhwPDORcpVizXPeN8YsEWWqiYSI
         6cgIfpbtNTNZ0yBZujSg+Jd3ErwoV1Y14JXtrLp5TG+AVp5+hyHfo/q29i6H6HiuTM6w
         4X0uQ24bc2K28beKap8u6Z17KguGMhvNMteYzpOgnoXWkAeptXGj/U7FM4AuihCb6VOL
         qNrKbE2H5DcecADJUweUumwm8RTD8CRLzxRycQgDKMrJa6EOOi2pGYLy1raVFOlu69PN
         Lizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mimD/qtnByUgFcn0cB8f/8cZYicL+2+zJ6czmpHJvo8=;
        b=w21/y1tccqRqPazVtDR6efMdhFTNrWNi1ToefZjLRrZ94bq+eY/vKLcc1+JYm08vaU
         9lEQ/eJ2GXTjsdLeh61lrKPfybaSPFVZTUNCE0s6CxutAS7YBD6QD9gAyf4AuZ9ARxm4
         AUgP72lPiAjRhjB8xsw/6F/SVn4vLvHwNc+sniwjBqOj+8uIGBMjFl8NYZLxsVM0RUQV
         VRUELLX+ieKMRzGhSKDmHixNI+d7NQL5Bs//YbfMQQtdcbCZ7uVw02t9DKeGl4dx6Als
         N9vx5oFBDSeY4IfldNIh8e8o+9QyWfxXo8Cx2XBBXngMVxoRtJsY+O+BiirWVwXmvBAh
         AJLg==
X-Gm-Message-State: AOAM530bcpI/GoolIGvE/dtBd/e0RPNduZzP5Jmq90vxmuh9gqXw8XND
        h6azrldg2CjtX0nUrH+0xAg=
X-Google-Smtp-Source: ABdhPJzTudbgBWQMI8u2i3+eIL6rcXdJ+Ov/vuzIQE0BpF8XVhH5HJ5VKEoxqgZy1WhUQnQKZiGE7Q==
X-Received: by 2002:a05:620a:4445:b0:67e:aaab:837e with SMTP id w5-20020a05620a444500b0067eaaab837emr4191436qkp.403.1649793745572;
        Tue, 12 Apr 2022 13:02:25 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a166500b0069c02f6f056sm6253589qko.19.2022.04.12.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:02:24 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:02:20 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: greybus: remove return in an empty void
 function
Message-ID: <20220412200220.GA2963810@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649712572.git.jhpark1013@gmail.com>
 <eaf51ac31d264179298cb24c91f05a14e3651bda.1649712572.git.jhpark1013@gmail.com>
 <alpine.DEB.2.22.394.2204120901380.3122@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204120901380.3122@hadrien>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:04:08AM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 11 Apr 2022, Jaehee Park wrote:
> 
> > Issue found by checkpatch:
> > WARNING: void function return statements are not generally useful
> 
> Even for a simple change, it wouldbe better to follow the model that the
> subject line should concisely orient the reader (eg "remove unneeded
> return") and the log message should give a more complete description.
> Simply repeating what checkpatch tells you is rarely a good idea.  It says
> what the problem is in a general way, whereas you should be explaining the
> reasoning behind your fix in a specific case.  Here you could say that an
> empty function with void return type does not need an explicit return, and
> that the problem was detected with checkpatch.
> 
> julia
> 

Thank you for your edits. I've submitted version 2 of the patchset just
now.

> >
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/greybus/audio_codec.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> > index 0f50d1e51e2c..3e3a16568def 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
> >  static void gbcodec_remove(struct snd_soc_component *comp)
> >  {
> >  	/* Empty function for now */
> > -	return;
> >  }
> >
> >  static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
> > --
> > 2.25.1
> >
> >
> >
