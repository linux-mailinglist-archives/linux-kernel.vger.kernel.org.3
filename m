Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6E5160D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiD3Wpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3Wpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:45:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141943EFD;
        Sat, 30 Apr 2022 15:42:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6so9950842pjm.1;
        Sat, 30 Apr 2022 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJxFKc3A4Q9u6UxRnvbPf1GtP9CvKofvMElbwbfkYlU=;
        b=hU9KYocbJP8ZgH5JGVJtzDFNO2/V3wwkem7+7q9zcyQgl2iEtRpVfuNHiVgNQvQrvY
         k+2J6GniT4XopabxoTjeH42Ah1zM1y7fUCt1S4WV0gDdWqbvgEDtM6AIO1v4dDDi2aFd
         +dMthd7vh2JvpwmVOI2ltPrMcEjiui9GuQSHBGL/OVz1GgVcYMJrlPWVirIP57yHvL/v
         VViY6janCln0lpKwFgsaENdHmIzM1Yf7a3jIrfNNy91pYnQd8EKAwDb0rDBBIOfR2Tun
         bwL4A2rXVHEwmFpLGjTEznP5u2wvG5+mb82hLJFlaO4Y5/DQVjCFWA87p9gcPT4GZFNq
         B90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJxFKc3A4Q9u6UxRnvbPf1GtP9CvKofvMElbwbfkYlU=;
        b=sj27csRyuu7hSUANuhNjhxEQoaVC3JlZvKhpCAis3TfcUFc1KZb89XHTXz7WpWOkoC
         mOvJfmTbGnfjKaRYlmCowespfWe24SBVKeaFRMrb4pbvkvcpCu/UCu8zOfSsdB2sELex
         x97QFCRycB/skZKy6fjp18yUDRUkBRbIJTKOncrbMprMRIuwC3GUKBpWJrgZa/levV7w
         wI65FqO1TV6PmUDVb93dci2EVEynyJaQ0vL+ZeDC9hWI1Yo2BQ+SLFsW31GE3336/C1U
         595zxex+8pyQhdgf+WtuHG3M276XAoxWWAwd7EQfmcJu/o9JX50v17AkgXspK27FueoA
         sqNA==
X-Gm-Message-State: AOAM532JTJUTBIIwJNMsE+M0F9AnQngDjep6VuAK0wWdqojkebKUDhxo
        p9kO53WjZvfieVVDiu8X/XE=
X-Google-Smtp-Source: ABdhPJxb9q9pIxCM+xqqQt0tHc+/wHxrUhjCJfX3mXD9c8/sSrw130lPFO1ZYm8656VSeK1FzKBPMg==
X-Received: by 2002:a17:902:cecb:b0:15e:8ddd:c7b1 with SMTP id d11-20020a170902cecb00b0015e8dddc7b1mr4126145plg.105.1651358531738;
        Sat, 30 Apr 2022 15:42:11 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090270c800b0015e8d4eb1e9sm597974plt.51.2022.04.30.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:42:10 -0700 (PDT)
Date:   Sun, 1 May 2022 07:42:09 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Jonas Bonn <jonas@southpole.se>, kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: fix typos in comments
Message-ID: <Ym27QcSo/U6xSIQc@antec>
References: <20220430191122.8667-8-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430191122.8667-8-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 09:11:22PM +0200, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/openrisc/mm/tlb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
> index 2b6feabf6381..e2f2a3c3bb22 100644
> --- a/arch/openrisc/mm/tlb.c
> +++ b/arch/openrisc/mm/tlb.c
> @@ -128,7 +128,7 @@ void local_flush_tlb_mm(struct mm_struct *mm)
>  
>  	/* Was seeing bugs with the mm struct passed to us. Scrapped most of
>  	   this function. */
> -	/* Several architctures do this */
> +	/* Several architectures do this */
>  	local_flush_tlb_all();
>  }

Thanks I have queued this for 5.19.

-Stafford
