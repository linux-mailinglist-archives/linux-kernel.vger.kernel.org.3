Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D54EB784
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiC3Atu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiC3Ats (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:49:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63837182D8A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:48:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j83so20680129oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/Z+SxVbLz6ou3wwMOlt3AaF7PE4HzKd6bt7UJffX70=;
        b=dK3yx5gryzNDPyAAOCVtVbTt6MA3aToJUg/XKmbY9u6v6CDKkg97/nXMI3XNohXqul
         +odZD9TcwzPCqy0FeM4nvrkc0knqqsdrl7BB9x0QGMI8V09xjhhEOnFD/yz8QQqucqpf
         PTRspLJIkr2jx2pFIj8KDj7cKxiya5Smh063hd2565QZyZnPgmzq/cDauruSVSuXQfNu
         0lcjfZKCqricvN3VhZV2/rSX2M7jUb6aEjN8Pa2kI/8CZqTNxjXM8DrYSFxsGlha5Tjw
         mfxLeXGutfy9L88MiD2lbvCFR6hjYb8AeMzoju847wZxeBYIBP5COfOlzzYQW8ChYzwe
         1bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/Z+SxVbLz6ou3wwMOlt3AaF7PE4HzKd6bt7UJffX70=;
        b=miB8IA3/iVPUY8nGXN2pc7CBN2K5C1wosfXaWuWohlLeW5Usg7x4+f3yfoKvOo1Nww
         5hMfvNyzTAnd+KHvQELJvnwrKdpkZggVPDkXk3h6ZvTmAPIr/pPqj6Jcl1HUBQcoJw8l
         zUDaQ81/QmetpPo4u6ry01naXmkuTlQincbItKbItTIXX9q/355lhCrOf9kTly4SwcKo
         ngWEr/TX1dg7AWeU6uv+fzLzMziih7X+oxKmJFWgiYDQDBlg5tfe825DFrZtU9CrX3ZF
         seQEbTY8vUYHzznvLPAG9UIuUEs2PNdShh+6Wqt60C/VGwy3cpiK/75puaU/Bzi7vrBc
         /bQg==
X-Gm-Message-State: AOAM532519L3rHGnjQodIPTF+z8AFFMUU1t/QxhTMhxmqxHR/c0VeCh3
        ewLVk8rZDZ1vVV0YqEIxzTA=
X-Google-Smtp-Source: ABdhPJz+BEqfvl9GbjQHynhZTbgEuZapz+Az1wHFJL6oeHdaNVucltGFv4oWTtKFblHw9u4FSRzlLQ==
X-Received: by 2002:a05:6808:8c7:b0:2ee:f75b:bc20 with SMTP id k7-20020a05680808c700b002eef75bbc20mr812170oij.44.1648601284654;
        Tue, 29 Mar 2022 17:48:04 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id u16-20020a056808151000b002f734da0881sm7604064oiw.57.2022.03.29.17.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:48:04 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:48:03 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: fix suspect code indent for
 conditional statements
Message-ID: <YkOowzOkAE5Fr1dW@bertie>
References: <YkK7ABTVt0TCbd18@bertie>
 <20220329161632.GA1169956@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329161632.GA1169956@alison-desk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:16:32AM -0700, Alison Schofield wrote:
> On Tue, Mar 29, 2022 at 02:53:36AM -0500, Rebecca Mckeever wrote:
> > Align the if and else if branches of the conditional statement
> > to improve readability. Prevent bugs that could be introduced
> > if developers misread the code. Issue found by checkpatch.
> 
> Thanks for the patch Rebecca!
> 
> Lots of stuff done right - passes chkp, compiles, patch is sent to
> correct recipients, the commit message follows the format of the file.
> 
> Let's set a pattern here for all checkpatch related cleanups,
> for you and others that follow.(Thanks for being the first ;))
> 
> Commit msg says 'what'. Commit log says 'why'. Acknowledge that
> it was found using checkpatch in the commit log also. (In the future
> you may be acknowledging use of other tools like sparse, coccinelle.)
> 
> Note that the 'why' is never that a tool reported an error. The 'why'
> for these checkpatch reports is usually to follow the Linux Kernel
> Coding Style.
> 
> 'Fix' in the commit message is needlessly generic. Perhaps:
> [PATCH] staging: r8188eu: align both branches of a conditional statement
> 
> Commit log: (what you have is fine in the log)
> I usually paste in the checkpatch error explicitly so it can be grep'd
> for. Something like:
> 
> Issue found by checkpatch:
> WARNING: suspect code indent for conditional statements

There was a section of https://kernelnewbies.org/PatchPhilosophy that suggested
putting the warning message in the subject line. I thought it would be
redundant to also put it in the body. Is it a good practice to include the
warning message in both places?

> 
> Thanks,
> Alison
> 
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index 6eca30124ee8..ccc43c0ba433 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -1408,7 +1408,7 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
> >  		/* TODO: cancel timer and do timeout handler directly... */
> >  		/* need to make timeout handlerOS independent */
> >  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> > -		} else if (pcmd->res != H2C_SUCCESS) {
> > +	} else if (pcmd->res != H2C_SUCCESS) {
> >  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> >  	}
> >  
> > -- 
> > 2.32.0
> > 
> > 
> 

Thanks,
Rebecca
