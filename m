Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792CF5256CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358595AbiELVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354024AbiELVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:00:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9464B27BC59;
        Thu, 12 May 2022 14:00:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so8884086wrb.6;
        Thu, 12 May 2022 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqN3G6XVwdxZfDbmYzg8BPW+axymx4TeLkZiEffytt0=;
        b=Z+RsYcD1DIETN6iZQQK21CozQi6aatU3Egl0Sk5oiK3otFDyxEvQsnYyxlTiRI1vJ9
         oWzIxgbMGDfAlMIxg+m6mfz9nirh5pSRcSu+1A8umvcZvq01MkJE7mOA1OvU0ENYTscC
         +DMWUcKA2yHY+zKRaVZxOU0XX8l2SNUtZ2lAI3fBwmjMgxHXNjAoGOvLO2HXZucMzDlD
         X9STyFe/pq7niyKKuXt0yllTQQ1BwZ2w6OO6ue5nXdpuE8oKVvpZAXZZpv7pLOY8VuCp
         Va5yQ7l9v6xr8pueyG6Y5b9yg1Hd/VeMyMEJ4KbgWZhVgWRaxHo/9hiaSOwyVrCqS6LK
         9Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqN3G6XVwdxZfDbmYzg8BPW+axymx4TeLkZiEffytt0=;
        b=bloYcb//uGJhUVrI3VvFkGIaH2AFHVH7I3tpAzXM+JY+9e+PAwvbipHK0JOt1aCh86
         YxRHY7iEdgo6PaFu0dJMUK7EvjHalrBhu+R5TN9410ld3WHsywVH1JaB+tTTqkUeQop9
         4Fut9/sDzGwvu7g2DrwxBx+o3HQWigrNbTYQjY3aGuwsLe/vYgnZDffWHFN7546wwLT9
         zbel2skN3VLn5Ov9Xxua6xPUQH0UXUZIgj3KiBYL/ZCCt0enRGzcjrVa+0C6iDloX27g
         4YJ0GQ49urTebTD4eNNqh76IBL+c1Q/JLN+vypIZgX0cLr8U4AXimhW9MjI9YO7o3oc3
         w0WQ==
X-Gm-Message-State: AOAM5320nnIGTLyYducWagKYgpIMHGA4AXLEMm1I2LWgEC4aO4RnbNMD
        wpzsbX2jahR7r2LjNpSKPuk=
X-Google-Smtp-Source: ABdhPJwZo3wubUHqgCp3lo8BhRNjCBI2d1bC/xZdxOqW9MZKdJWPi9R9+34hriJKwKvjUlPtNbVUJw==
X-Received: by 2002:a5d:6481:0:b0:20c:6b71:211f with SMTP id o1-20020a5d6481000000b0020c6b71211fmr1175845wri.666.1652389203019;
        Thu, 12 May 2022 14:00:03 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h16-20020adfaa90000000b0020c5253d8d4sm456182wrc.32.2022.05.12.13.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 14:00:02 -0700 (PDT)
Date:   Thu, 12 May 2022 22:59:52 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Status on hid xppen patch
Message-ID: <20220512205952.GA8936@elementary>
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
 <20220423172330.32585-1-jose.exposito89@gmail.com>
 <95576534-1f5e-c2e3-4f73-c1b0a8300b56@gmail.com>
 <20220424093239.GA4380@elementary>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424093239.GA4380@elementary>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

A quick update on my work on XP-PEN tablets.

> > nice hearing from you. I was actually thinking of just asking if you
> > want to take my patch under your wing, since you seem to be doing a lot
> > of uclogic related work. But your idea is even better, just submitting  
> > my patch once everything has settled down seems to be the way to go.
> 
> Cool, let's do that. I'll cc you on the last batch of patches so you
> get notified when they get merged.

As promised, I cc'ed you on the last patchset, which has been merged
already.
At this point, the kernel and DIGImend have the same code.
  
In the meantime, in order to make the driver code as generic as
possible, I bought a couple of XP-PEN tablets. 

The tablets are the Deco Mini 4 and the Deco L, both of them are UGEE
tablets. I already had a UGEE Parblo A610 Pro tablet and after having a
look to the Windows driver traffic, I found out that after sending a
chunk of magic data to enable the tablet, it requests a string
descriptor ("uclogic_params_get_str_desc" can be used here) and the
tablets respond with their parameters.

The information is encoded, in bytes, as:

 02 + 03 - UCLOGIC_RDESC_PEN_PH_ID_X_LM
 04 + 05 - UCLOGIC_RDESC_PEN_PH_ID_Y_LM
 06      - Number of buttons
 07      - Dial present or not
 08 + 09 - UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM
 10 + 11 - Resolution

Bytes 12 and 13 are present but set to 0, probably indicating my
tablets are lacking some feature.

Could you confirm that your tablet returns similar information, please?

In case you want to have a look to the implementation, I'm working on
this branch:
https://github.com/JoseExposito/linux/commits/patch-xppen-deco-l

I had to introduce new functionalities to the templating system of the
driver, that's the reason for the KUnit tests.
The last patch is work in progress (hopefully I'll have time to finish
it this weekend), only the HID descriptors are missing.

I'll cc you when in the patchset so you can add your IDs :)

Best wishes,
Jose
