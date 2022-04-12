Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41304FE955
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiDLULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiDLUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:10:55 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2D1261A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:05:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bk12so14661348qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TIso7zjRvJ6JFk0OKYu4b1IOgyo67qS8pjQR4R1CTwU=;
        b=O5W4FURXIk/koR1AiziVbc22Jnz6VO50RBwFh9m5NvNBjxPTrsut/JMndhOuajYrEr
         DS3Bfb/M0PKvcXMOloWcp45H7AWwSVNV7WhKHgYjYQe0EBX17sW8SUPNkdRtDhRbChI+
         Xou3ENfTd/zd1DO4d47KFUSvcE+AHTk2eWFk6gk68h4EL+I/CSI9xd7VWAmA3LL+Mgce
         y2M75ohA+irDdOoOuILSb7EnlP+uVmz3/J7duDnsfcl1X7J09qzSf4FcdqSf2VqEekp6
         FZnmpGhpXfnuMckGAsrIF7Wv5GfjtYKJRxM4p/KWyTb49PrG/N8R7LFhbzsnqOiLbdt0
         iZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIso7zjRvJ6JFk0OKYu4b1IOgyo67qS8pjQR4R1CTwU=;
        b=lsiwEan3GYdIFlMNekNMBfOkST6EFzRVMrj0bRayTx35ZSEK8Y2lNR8CXXcyAnPRnD
         8n12Bp0thX6SfVCwD91iwKXgdi7BdxZkwzC+ErfBChu1rdgaQqPrUMHRC6IXOUHwZ1NA
         8b3NpWS0DjB/IYyoGJT25Q8yRu6Gvqmt1ZoWHrpdJV7i7tbO3ciVek7slPOOwyecYjla
         OFhYJpfZqbXd0Z/2VxLs0dnnZbaQymRZMGTsULfbgiWhgITbH+3GDGs7oFdOzpAiUNTc
         1PxHpM5ClHrsR4d4+XYmRm/Sj3fhhYEM1bJIA+jC7q7hGig7yRps9/rWKWdbptp/KaSM
         kn1w==
X-Gm-Message-State: AOAM532WHnjiQrwnmk6iV6ZoW5upOWG5lcADE8f3NswyPVfnESzpT/et
        TYcRGYwbQ4Wg5mDnQBRyQ5A=
X-Google-Smtp-Source: ABdhPJxN1K0eq7eseLiEBRiBDNhG1W+9Hx7k7WhgiWKwhUnqlLh1wfTMx7styNeT3Vbbkg7YLGFOjg==
X-Received: by 2002:a05:620a:4151:b0:69c:216f:f6f7 with SMTP id k17-20020a05620a415100b0069c216ff6f7mr4412625qko.444.1649793808257;
        Tue, 12 Apr 2022 13:03:28 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a048300b0069c52ee270csm140606qkr.89.2022.04.12.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 13:03:27 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:03:23 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: greybus: remove return in an empty void
 function
Message-ID: <20220412200323.GB2963810@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649712572.git.jhpark1013@gmail.com>
 <eaf51ac31d264179298cb24c91f05a14e3651bda.1649712572.git.jhpark1013@gmail.com>
 <20220412072843.GD3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412072843.GD3293@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:28:43AM +0300, Dan Carpenter wrote:
> On Mon, Apr 11, 2022 at 09:50:22PM -0400, Jaehee Park wrote:
> > Issue found by checkpatch:
> > WARNING: void function return statements are not generally useful
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
> 
> This function is called from snd_soc_component_remove().  You can safely
> remove the whole function.  We do not like empty stub functions.

I'll make this into another patch. Thank you for your suggestion.

> 
> regards,
> dan carpenter
> 
