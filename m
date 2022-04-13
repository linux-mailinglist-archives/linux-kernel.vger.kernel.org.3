Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B14FEE58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiDMEqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDMEp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:45:58 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107C31DDD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:43:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x20so767255qvl.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnkQTImgRI33ZK9OLchOQ7aSmw/PhVSRrhu3fSy1iZg=;
        b=ZbhMUPy/EyrDGrM+JVic57mbguSyqn8G8Rwc7zn8E61maWR3oiagoyf8rAjX/7Uozl
         Cd1EiMK4VDMIbXIUwW6x8t+LF8rsPa0TN5D7EfHBT/Tz//MiFlPESnttplGTxEP+ywUf
         7RzqyzMDpLCJ0Ljh+ygk7+RpUeYxt5FS7p+fxmP0cjRhdwcvN4o2eqL8LlwN/jg28Epc
         tI0xiSnl0uPkK5uJdeukoRYwdcleTChcRrpCFR2hMyLgKuc8S9rsnf51euicPsxb6GGQ
         Rqz6FuiNXgSz8/d2WXTpgKfqZ7syScZWjjopuL0Ddz+VsKc6FpWg1y2htQww0gPUurNE
         mvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnkQTImgRI33ZK9OLchOQ7aSmw/PhVSRrhu3fSy1iZg=;
        b=ivcf2ZBaYdcZL5i5SLqpDkmgu+Ymk0SqFHY0309FgOZoQmvc0lQFY3Byoy8PYqfip5
         PqrDF5fcIYJZs3Uzyju08aiTCZZwQSqOjDFypHRIsd9JY8qWdMSnZ/b9/dwiIUYOPUis
         zCIGSS2fSDdQJu4418j7Cq1F3RAbug4j8QHF+gceEpgANcJReQsH5byQ10KP4cbh5szw
         1EnRbJ9xv+xHKFHPAycJLj5thi0R43GRRd+ei1WMq0O4tZkev51jpRsl6PFUt5mOBeZj
         fXHX03Nz+hxOPrTXtQ7VJf8DG3OjHXN19iru4WK4wuOOMWGCvQMjcObfeI+eSMnACUl3
         JSXA==
X-Gm-Message-State: AOAM530nFaRBrdCCFQb4jz9q6u6z/Zw59HPV+W2IKvOC4N+Mz9Zc7cV+
        gb/fEBHNz9JrhEkxWAE6DzA=
X-Google-Smtp-Source: ABdhPJxs+8h3Jgf+36tQgod98PKxWlqrNNYr9BXOcfCTtP13Z6w5QMYbD22papvqA3pMx8K6v0z7Mg==
X-Received: by 2002:ad4:4ee3:0:b0:444:3496:67cb with SMTP id dv3-20020ad44ee3000000b00444349667cbmr15826834qvb.91.1649825018242;
        Tue, 12 Apr 2022 21:43:38 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:5e57:caff:f44b:33f4])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm28423346qtj.33.2022.04.12.21.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:43:37 -0700 (PDT)
Date:   Wed, 13 Apr 2022 00:43:34 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: greybus: remove unneeded return
Message-ID: <20220413044334.GA3357359@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649793138.git.jhpark1013@gmail.com>
 <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
 <a509099e-2b19-7a27-693c-b418bd2f7b28@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a509099e-2b19-7a27-693c-b418bd2f7b28@ieee.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:35:04PM -0500, Alex Elder wrote:
> On 4/12/22 2:59 PM, Jaehee Park wrote:
> > An empty function with void return type does not need an explicit
> > return. Issue found by checkpatch.
> > 
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> 
> Dan's suggestion here was to simply remove this function
> entirely.  It is only used as the ->remove callback
> for the soc_codec_dev_gbaudio structure.
> 
> You can see that soc_codec_dev_gbaudio is only used in the
> call to devm_snd_soc_register_component() near the end of
> "audio_codec.c".  When a sound component is registered
> that way, the ->remove callback is optional.  You can see
> that because the only place in "sound/soc/soc-component.c"
> that it is referenced is snd_soc_component_remove() (as
> Dan said), and it only calls the function if it the pointer
> is non-null.  Allowing null function pointers in places
> like this. to allow them to be optionally omitted is not
> an uncommon pattern you'll see in the kernel.
> 
> Anyway, please don't just add another small patch to remove
> the function.  Just replace *this* patch with one that
> removes the function, and omits the assignment if its
> address to soc_codec_dev_gbaudio->remove.
> 
> 					-Alex

Hi Alex, Thank you for explaining where the functions are called from!
It makes a lot more sense now. I've used your explanation for my patch
log. Please let me know if I'm misunderstanding things. I've sent patch 
v3 for your review. The first patch (typo patch) already has your 
"review-by" -- thank you for the advice.
 
Thanks,
Jaehee
> 
> > ---
> >   drivers/staging/greybus/audio_codec.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> > index 0f50d1e51e2c..3e3a16568def 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component *comp)
> >   static void gbcodec_remove(struct snd_soc_component *comp)
> >   {
> >   	/* Empty function for now */
> > -	return;
> >   }
> >   static int gbcodec_write(struct snd_soc_component *comp, unsigned int reg,
> 
