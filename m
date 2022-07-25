Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742C7580253
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiGYPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiGYPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:55:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE159DEE1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:55:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y15so10772298plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NtXt1fqMhxY7S9E5N6yiBe6FcJHGjWg4dbfkFH+sRaE=;
        b=t8nZV0z4cpklnicYwLqA+SEGThFWFft3qhjCxEd769DNOqRsduwhCaibPAI/fkCJPI
         +aCeEV224t9kodPLSZUpRF8P8gch7roSvYeeVlsHBJLiXw2jUOi/r2t14I3WXTYMS9dk
         H/7B9fRgfGv9TpCDRZ8EQTlHfJRIVNhEyxtul9mtJ5eEtiRft1W05BuxEEuoTT4tP57D
         yaboWf3kXL1Zdi0jJneS74HdjHYJ5wbUywqf5KhI0x2cHy98AbHzkanGjFGRsO1XFtaW
         01wVyY16N6LcTr7wIMcO1pkvnF+8NOMxzJgZ2Z9U20UZUcGA4XRoJZrAsEtLgfoWvlnW
         ZsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NtXt1fqMhxY7S9E5N6yiBe6FcJHGjWg4dbfkFH+sRaE=;
        b=dg13uz+HkRyHMv9lY6bewouHkfayHdTefp9aHN8qrxgNlTgNqNcGv3ESqU1qS/lXha
         4Bu+14+lGZOuGGNX8IaxDOdf7npP+cLgKtBLqanb/plyg/0icjjYNPp4+F4PqbNW4tL7
         LJzbDcRBauJbCMIIGc/vc/F26CDZVevyOEoUHgw6Pz2nuK6RixHB1DJ0O/DSifltDDje
         xoty+vCHMBXB4EL4f/6mGq0wZ4iO2zGmF4LPMMREQ8Xx4Ox9SfarePX0bTGdZ9lOCN9C
         9rU/8+xpq9RdDlYpgqc78SBg2GCk6XQaCU9aoujSY/bjcDfe5KwOK9IXN1V2pwSX2JpM
         oy+A==
X-Gm-Message-State: AJIora8dycIV0eZ/mSPkrAOg1voXV2/mnBfkCmpV5uSKAN2h6jqsDRGV
        1wr/baJ2FLfiCgFeZ9vOd1k0OQ==
X-Google-Smtp-Source: AGRyM1uKgUtEqZsNJSsLBPI08/F3o9VPfBhyb0m3DCAuwuM/d8G8pXGRFxs82RH3vf871q9N02TgqQ==
X-Received: by 2002:a17:90a:e7c2:b0:1ef:8acb:5ff with SMTP id kb2-20020a17090ae7c200b001ef8acb05ffmr15486713pjb.146.1658764541483;
        Mon, 25 Jul 2022 08:55:41 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c20-20020a624e14000000b0052b11fdb353sm9723530pfb.125.2022.07.25.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:55:40 -0700 (PDT)
Date:   Mon, 25 Jul 2022 09:55:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/remoteproc: fix repeated words in comments
Message-ID: <20220725155538.GA4113688@p14s>
References: <20220724073418.15793-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724073418.15793-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 03:34:18PM +0800, wangjianli wrote:
>  Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 02a04ab34a23..e3e68b5051bb 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -970,7 +970,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  		return 0;
>  	}
>  
> -	/* Register carveout in in list */
> +	/* Register carveout in list */

Applied.

Thanks,
Mathieu

>  	carveout = rproc_mem_entry_init(dev, NULL, 0, rsc->len, rsc->da,
>  					rproc_alloc_carveout,
>  					rproc_release_carveout, rsc->name);
> -- 
> 2.36.1
> 
