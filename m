Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4994DBE81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiCQFhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCQFhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:37:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909125C59B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:06:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id q6so3005938ilv.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LXoLnjwxSlPNGSA5zh0OpIA+iiWRj8YF0MzPfCriXc8=;
        b=wKQGRcurH4zTYCuwo/f3x7mP/xwNAggL2rhbTWzvKOxhJyhgWFWaOV2odkDKLMNddX
         VyCUHR3v6JEQDF0t1+2UaBiJbArH8BhRlyS8qsvgeiW3SYsBLqqco/OibbwCiDmYOeUN
         L/VQdEHSie8In5gz1lOsm09GVY9wMCTipJnU6tBdh5vJg/vDAgHVUffgooyFBOFxQS7B
         fEw+U2JnjsLx96dFyF7yyHEuwwwBHSXxVXzcp/Mmq8rPi9jv29MPLpqqLErYGa8G7DiY
         04HTHeVwQjipxWGDWOxGgYRVNjO+crmj3AE6n4TeJH6URbiQrHA04wt4RANBFZ7TpsWW
         olBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXoLnjwxSlPNGSA5zh0OpIA+iiWRj8YF0MzPfCriXc8=;
        b=2zfMKTEt9mdImQyz/qbfARqAvk2+byYOCmI8JTNgiAZNGvyudq4KUbw5lmgn2eamR3
         cnMFs0cJ4o5VKZlw92LQCQuKo7lHMbxOEQQhy2ErTidFvgZT9Ui1c+UVSaTva1niIDfj
         faD/AK+RR54ckfRVq3H38tZCyUdhX01Av1oDk+qapczZOmHLRw7iwBumHxg9eQHoHQNz
         8Ao7X2YZMyCQgfTDeNIG71ulptILKpIun+3t62K/fT8BBHiROMhxxMm2+DYDGF38UVgM
         lS1ZDcRXFLs0craPL8AkQcQ6cdQZFzQCLbNR/vclWUbedIZ5IkTEPbKhZS/fxnuwYoZ1
         nTag==
X-Gm-Message-State: AOAM532zJJstLgTDfuzQVQOxzmS4q1yMpJviJlXO3Orwvv0PKnjla8wG
        uqqQbDZQzMChuAdw4lePp+Tl/2wQcC1z
X-Google-Smtp-Source: ABdhPJw0kwIBHNqT5D5lW8bdrLrJuEraZy2WOuuoaQ+KAV6kQ7WJsCVMjzSiZFVJyr2WBw3T6uaeaQ==
X-Received: by 2002:a63:f12:0:b0:381:d61:afc9 with SMTP id e18-20020a630f12000000b003810d61afc9mr2276457pgl.237.1647492513241;
        Wed, 16 Mar 2022 21:48:33 -0700 (PDT)
Received: from thinkpad ([27.111.75.157])
        by smtp.gmail.com with ESMTPSA id s30-20020a056a001c5e00b004f73f27aa40sm4771490pfw.161.2022.03.16.21.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 21:48:32 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:18:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     linux-kernel@vger.kernel.org, liwei391@huawei.com
Subject: Re: [PATCH -next] bus: mhi: ep: remove useless judgement in
 mhi_ep_ring_add_element
Message-ID: <20220317044829.GA6627@thinkpad>
References: <20220317033117.367027-1-liaoyu15@huawei.com>
 <ef12136f-fc4d-05c5-a7bd-66ade28957e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef12136f-fc4d-05c5-a7bd-66ade28957e4@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 11:52:32AM +0800, Yu Liao wrote:
> Hi Manivannan, I found that 'ret = ' has been removed. If this is intentional,
> the check of 'ret' is redundant.
>

That's not intentional, thanks for finding it out. I've updated the patch.
Since the patches are under development, I've squashed the change with the
initial patch.

Thanks,
Mani
 
> Thanks,
> 
> Yu
> On 2022/3/17 11:31, Yu Liao wrote:
> > Remove the check of 'ret' that is impossible to be non-zero.
> > 
> > Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> > ---
> >  drivers/bus/mhi/ep/ring.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
> > index ac2043e71943..161505cd628f 100644
> > --- a/drivers/bus/mhi/ep/ring.c
> > +++ b/drivers/bus/mhi/ep/ring.c
> > @@ -131,8 +131,6 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
> >  
> >  	mhi_cntrl->write_to_host(mhi_cntrl, (void __iomem *)el, ring->rbase + (old_offset *
> >  				 sizeof(*el)), sizeof(*el));
> > -	if (ret < 0)
> > -		return ret;
> >  
> >  	return 0;
> >  }
