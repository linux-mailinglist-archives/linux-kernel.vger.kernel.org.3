Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568C9501C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbiDNUMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbiDNUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:12:04 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272720BF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:09:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t2so2572339qta.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ReqDmd11Qgyo4MjHseNTTTXBLwUHjD3S1/AvQ91EJkw=;
        b=TYUDXTfEPCi7/0qRwc3gBU1dXp9xf0PVKr/jLhnpt6/v/0w24wpKeoEKx6GZAfGum0
         AGM2n+Tweb64MgqiAEEiMfQwaupsr11dXfPX2sedINXcs5bmB1S/FyUVGcn56rjrUkyW
         Ji0CFco2+55pvR7xDFNkyDzndtMglDTXKn0fXNwSY6PH633AA8faphZ+mlyezEsmTHol
         vzF4O6Po6QJ7tTpBicXa8667/DpFbpG7OJgSlmzhBd3gLIeZFn3e8TI+M3jQKvZ/SZE6
         ebQ1eGAh7TaA+4c0EVYBo3BrI2kl6yScn1+Yn8B1/Ezk49Kql9lD08xRDXtiBjIQI9uW
         XHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReqDmd11Qgyo4MjHseNTTTXBLwUHjD3S1/AvQ91EJkw=;
        b=tPpfbXZ3bTblKEoxMTe2P2YH+ogYXOF414knNsNZRJpxJQBXSfEadWzA3+ZVgc3ev0
         YURw0joOWAKNONc2ZVExQnFQmsv4T8ZVZCwtPTps2fX367Noox6V9Pl/KOJgsdzJrAIU
         A2r2YZRBphyBUd0/VYVZ9Y49pXOgGBRtu4kh0SUCv47zFFSVhMKyPPQD+K+tOyKmGN8A
         coV6EHoQPYSs88YH+m/rmWOlJun5vzcQJ6PC2QRRdiGjNeEOQvDFqHaFphrxaFV/NA1/
         zB+RkquY8brMXvAXzh6B11OxGyAJNucupySVV68kjszqMjyA2jJvLhRdjKoRrrYWdhb2
         aORw==
X-Gm-Message-State: AOAM530ajlgbcMenaMjK2LFRtMn9Q1Wb3G0rlRvMNCHrdb7WgNs07YzG
        F6zuZVBCkRLKuCVdMR3BnEA=
X-Google-Smtp-Source: ABdhPJzTFrsxe5mcyPkZut2F5WgLLeSHMeHjmAsaz+ewerQn6zpI5K9ngj0rs2maGdN/hPc8JkCyCg==
X-Received: by 2002:a05:622a:6183:b0:2f1:3d3f:5bd6 with SMTP id hh3-20020a05622a618300b002f13d3f5bd6mr3170994qtb.393.1649966976773;
        Thu, 14 Apr 2022 13:09:36 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id bk6-20020a05620a1a0600b0069c6f52cba3sm1476232qkb.41.2022.04.14.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:09:36 -0700 (PDT)
Date:   Thu, 14 Apr 2022 16:09:32 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 2/2] staging: greybus: remove empty callback function
Message-ID: <20220414200932.GA4147124@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649824370.git.jhpark1013@gmail.com>
 <12037ae2502ad7d0311bcdf2178c3d2156293236.1649824370.git.jhpark1013@gmail.com>
 <a4e5c567-63dd-f7de-114b-a357075444a2@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e5c567-63dd-f7de-114b-a357075444a2@ieee.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 07:48:03AM -0500, Alex Elder wrote:
> On 4/12/22 11:38 PM, Jaehee Park wrote:
> > Remove the optional remove callback for the soc_codec_dev_gbaudio
> > structure. The only place it is referenced is
> > snd_soc_component_remove() which is only called if the sound_component
> > pointer is non-null. The null function pointers here can be optionally
> > ommitted. When a sound component is registered this way, the remove
> > callback is optional. We can safely remove the whole gbcodec_remove
> > function, which used to be an empty function with a void return type.
> 
> Now I think your description is a little long...  But that's OK.
> 
> This looks good to me.  Thank you for responding to all our
> feedback.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

hi Greg, I saw that this was past on to staging-next already. Is it too 
late to add Alex to the reviewed by? 

> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >   drivers/staging/greybus/audio_codec.c | 8 --------
> >   1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> > index 0f50d1e51e2c..dc030caa64ba 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -1029,12 +1029,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
> >   	return 0;
> >   }
> > -static void gbcodec_remove(struct snd_soc_component *comp)
> > -{
> > -	/* Empty function for now */
> > -	return;
> > -}
> > -
> >   static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
> >   			 unsigned int value)
> >   {
> > @@ -1049,8 +1043,6 @@ static unsigned int gbcodec_read(struct snd_soc_component *comp,
> >   static const struct snd_soc_component_driver soc_codec_dev_gbaudio = {
> >   	.probe	= gbcodec_probe,
> > -	.remove	= gbcodec_remove,
> > -
> >   	.read = gbcodec_read,
> >   	.write = gbcodec_write,
> >   };
> 
