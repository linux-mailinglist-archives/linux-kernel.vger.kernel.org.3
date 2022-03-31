Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B684ED945
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiCaMIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiCaMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:07:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962E1CABE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so24984108oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XUYGC/MdNC/QqLiDIIOH17Fg3yzA6z93mDMspfC2XaQ=;
        b=ddKq2q3GyR8sFIXGUgmNi3oXOBB72Xs9tG83/2jymJ6saS+DmSitBcCsgPZovTXmoj
         fdkHFNdbr0Y/8p4YzxLf12jy+9uRUenoC1q69G7eM2SWzzYtITHrrTzjTgOmgXQGZwik
         /k/xAbrK2jfpwtn9iPxbuf1H9Y19x32ZAtVP6mDU9Cpn30A23idfmjc6LxHC4U7Y8bui
         0UtcyIT/B7b/pCFkmcEVBvzvvYZrDj9hCB90XU3ykhBgNCcQyeQCqG6mv0DAvQvip0Sx
         uwqJLxujMwMHQdifm+du9W+iTrVULqPtPvf08BCHnXwReBaUJfJxV/3pbWnpqIL4Muql
         qf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XUYGC/MdNC/QqLiDIIOH17Fg3yzA6z93mDMspfC2XaQ=;
        b=1nNxHiaMT8OTErTSHP/shxKP54taD5gUfzHzlmVv2moZExYUb70xk6isFPJLyFzv9t
         9N7CuROklu+sRiwtQK+jceSdfpreggX5IT/sz9ZW1AKDXIUDyCh2xy3vP7KgW1h2A1cS
         HVJx5STWqViDXaJwfn+RuyPxqXCehTK4F4q55R4b/gPTNDWC2FYm09eDQMH6HtncryHr
         zqT8wKT1QtxQXkAkDpLBi/xFJOJ2NYqS8ITCDC1OWvwo6Jd2nN/9xo95YKH30kpVo37b
         1PM8QsbhRpdFSCR0Kbb3wzivEozxe4aZHNUps641UK5dtoui1YtTGF+eMVHHszcyQlqA
         ceVA==
X-Gm-Message-State: AOAM531UbfvWEr6k0PBWHRz9w5o6t3W1+0NLz8Awg0FJhn2pNk2tCYxM
        ZaMLQxhgpsK5+59hCGn8JNU=
X-Google-Smtp-Source: ABdhPJwPeUCR7dZ0ZNy9Z6Z4+gWzjpXEMiYmvnVekMgG7S8j/XpHIN3LixCKkM0Ny3Ya1/1xVWna2Q==
X-Received: by 2002:a54:478e:0:b0:2ec:c28d:8930 with SMTP id o14-20020a54478e000000b002ecc28d8930mr2503337oic.162.1648728362311;
        Thu, 31 Mar 2022 05:06:02 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a03c1000000b003240492fc15sm11729175ooi.36.2022.03.31.05.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:06:01 -0700 (PDT)
Date:   Thu, 31 Mar 2022 07:06:00 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: fix suspect code indent for
 conditional statements
Message-ID: <YkWZKOvThq5paUi3@bertie>
References: <YkK7ABTVt0TCbd18@bertie>
 <20220329161632.GA1169956@alison-desk>
 <20220330062829.GF3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330062829.GF3293@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Mar 30, 2022 at 09:28:29AM +0300, Dan Carpenter wrote:
> I don't really like the focus on commit message minutia...  :/
> Basically everyone can understand the commit message.  There are one or
> two maintainers who will fly into a rage when they see the word "fix"
> in a commit message but I have a simple solution where I just never
> email them again.  My time is too valuable for that nonsense.
> 
> We would have applied this patch as is.  Or I would normally have
> written it like this:
> 
> [PATCH] staging: r8188eu: Delete a stray tab in rtw_survey_cmd_callback()
> 
> This code works fine, but the line is indented too far so it's confusing.
> Delete a tab.
> 
> Signed-off-by: ...
> 
> I had reviewed this patch earlier and almost pointed out that both sides
> of the if statement are the same except for the comment.  The "need to
> make timeout handlerOS independent" comment is wrong.  I have not looked
> at the details of the other comment.
> 
> I did not send my review comments because the patch was fine.  But what
> we want is for the code to look more like this.
> 
> regards,
> dan carpenter
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 6eca30124ee8..dcf7b24f95a8 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1404,11 +1404,8 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  {
>  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	if (pcmd->res == H2C_DROPPED) {
> +	if (pcmd->res != H2C_SUCCESS) {
>  		/* TODO: cancel timer and do timeout handler directly... */
> -		/* need to make timeout handlerOS independent */
> -		_set_timer(&pmlmepriv->scan_to_timer, 1);
> -		} else if (pcmd->res != H2C_SUCCESS) {
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
>  	}
>  

Is it okay if I submit a patch to implement your suggestion? I would
include a "Suggested-by" tag.

Thanks,
Rebecca
