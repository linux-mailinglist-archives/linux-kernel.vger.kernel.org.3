Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBC5A8371
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiHaQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiHaQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:46:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E9D83E7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:46:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so13973820pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=SJCs+zrxY5DpXGitGn76vX0CELQw1pNbtUtNVrBLdOU=;
        b=wMacyl36WAEo0AtT4AtI+EXWpdWwqkk25xy3wZzMH3h/+BSD4YjLg/n60+tfdQ+3+K
         i2I7XBlF/1rR9OQNQs8I4LPpJTgQKoCUkA+aqzj4vEIZAmFbOMr95XPtKg4lghRU62PN
         C7p/vH6t8izDWJYlyheurHuPKzwW/U52i65bHHdaIxhsLjBg4jcacWYfJcGxmgRmTFTa
         czgixQLOXDOjAb4WEsgWe6/AGxGCyJ/MWHIvduGxb6ToLehe0wkuJZVFtBPFGFQiVXB+
         dR/upGc/MzJr6zEPMFMoh+WSt1Y+Tck/7/7skyNtOCChrK0FFASzl/yW9dL0T+GDmp38
         uEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SJCs+zrxY5DpXGitGn76vX0CELQw1pNbtUtNVrBLdOU=;
        b=aPemILHRPaKb8MTbeFq2LQcJwS1WPeQDsTvAS+w0oTteunPg7Tfv2GgJQl4wJrvJYY
         BOl20n4bxbC+L9MWD1FW9CmwlRZIMbXrSGZjpie6c9JCk1DLuX8iFnBrTNOFlJU7etoO
         f2D737Sp7TgH2FNj73D7RwzOS0PCvQemN3yM85ZxJjKG/C38e3ubg2Q13I9KWNxnaZ6V
         A+XMKUBBpVC8duQEwJlD1pZlHtLlTrzwjPJYFLmsUVQOLIzBiXErFr4vCb8oyFpZxwiM
         sZzV6Zg0t5oy3YOcHfjbY7SIxLNhvmmV7nf78cc8ftYeLveb4eYmmY/CPskeCXykkBPp
         NRjA==
X-Gm-Message-State: ACgBeo0wsW2CiFXlGCuRXt6LdYE8X7XCEosEvLhRjX9EvpwrfG0be9a7
        ifBTSYhxJd06AoN60khvt1N3ZA==
X-Google-Smtp-Source: AA6agR6fkZMt73sieSqzi6umyc41MUl5fXDPsH4JeaX9QXNMq9ImVUzt9Z/JpwEBqUxhvzOTb4hAlg==
X-Received: by 2002:a63:4802:0:b0:41c:ac9e:1950 with SMTP id v2-20020a634802000000b0041cac9e1950mr23084860pga.376.1661964395560;
        Wed, 31 Aug 2022 09:46:35 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j18-20020a635952000000b0042b5b036da4sm3518356pgm.68.2022.08.31.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:46:34 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:46:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     cgel.zte@gmail.com
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] rpmsg: char: Remove the unneeded result
 variable
Message-ID: <20220831164632.GA217472@p14s>
References: <20220826071954.252485-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826071954.252485-1-ye.xingchen@zte.com.cn>
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

I am fine with the patch but I need to understand who is "cgel.zte" - are we
talking about a person or an automated bot.  In case of the former than an SoB
from that person needs to be on this patch.  If an automated bot, than that
needs to be changed to someone accountable for the code that can put an SoB on
the patch.

Thanks,
Mathieu

On Fri, Aug 26, 2022 at 07:19:54AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value rpmsg_chrdev_eptdev_add() directly instead of storing it
> in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/rpmsg/rpmsg_char.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4f2189111494..0850ae34fb88 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -424,15 +424,12 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  			       struct rpmsg_channel_info chinfo)
>  {
>  	struct rpmsg_eptdev *eptdev;
> -	int ret;
>  
>  	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, parent);
>  	if (IS_ERR(eptdev))
>  		return PTR_ERR(eptdev);
>  
> -	ret = rpmsg_chrdev_eptdev_add(eptdev, chinfo);
> -
> -	return ret;
> +	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
> -- 
> 2.25.1
