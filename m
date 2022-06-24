Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02C559F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiFXRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiFXRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:04:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174547AFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:04:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 9so2952392pgd.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=px0NDP+xMP/FC6x3oq/ZqsG3as1hiZ0Zx10SR0gFPhw=;
        b=Kfjbdfkm0W6Zdy+6MK69FVKokZMdg9L72sU5ZFsa3Erau208+5AqAmdwvFMsFY55I+
         s/scJ1Bj7SkUJSLUVnKzH+nf0Vclteum+FaY3IvrLOvQlNoTvkZ+dKuuKLhfm254o0iL
         Fy3Oy5yEY20TL784MKYQC2IZOxnrb+OgU/TBvKGOS8n6HcIu4fM97s1Q4RjevgLokS16
         yDaTUEX/MqXSl+En9pAv1A2/V8fehscmUhps2kAEf5p8CFQ9EfZnqVij1IuMdFrWMNd+
         wLlHqBOOZZrlZ3JqsHL7dQfmilNLsCTrnlhbEQRmr1lRCp0pZluh6lYDpkAnSFk1t9Eb
         0r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=px0NDP+xMP/FC6x3oq/ZqsG3as1hiZ0Zx10SR0gFPhw=;
        b=fZs7RwFZ1GDbsw0aUqiDvL+X6Ul7lnoQBikFcu6J3C29PySSviw8R7GhMBHjbpOYOD
         5lGAmTr8DSquX/JzYCJf1+k1S08OjYpaL1QlhijsoyOGCOpg+uZsiNB3UwOt4/jACpaZ
         38SCRXLhCyRcLXfCEFyLHb4S6kkh+QugoDpoEc3a7Wh2w/7pyCJuNnkaFCM/Y/g9zWWg
         WiEkLFHS5OebIhF5s6wcI3+wnvkdJwiaPc7iNR0LLmHHcuyTUKL01mlNyhN+ndazD49B
         RgecDzxt6R2r0fSjxbREoLJ44bx+xb6qJk//8a2/BkvTFkxrhlOT1vCUiEXVCMaykGPa
         5M3g==
X-Gm-Message-State: AJIora/AqtRjbt3lwuA99OM6s5X+7OM7W+5nby4Jc/6eq3a+1c2Z7C9X
        2ktWPofsvvmPLy7FISWR2HsC9w==
X-Google-Smtp-Source: AGRyM1sOrG404HSLruVfY9X5ggzvzt4b2Sj0s8owzQLffqnbgAWCJjQShwdIzThq4iEnPG37oxJ3SQ==
X-Received: by 2002:a62:4ed3:0:b0:525:5a10:d5ac with SMTP id c202-20020a624ed3000000b005255a10d5acmr8721428pfb.65.1656090255892;
        Fri, 24 Jun 2022 10:04:15 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k63-20020a632442000000b003fd3a3db089sm1839687pgk.11.2022.06.24.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:04:11 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:04:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: Fix parameter naming for announce_create/destroy
 ops.
Message-ID: <20220624170407.GB1736477@p14s>
References: <20220425071723.774050-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425071723.774050-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:17:23AM +0200, Arnaud Pouliquen wrote:
> The parameter associated to the announce_create and
> announce_destroy ops functions is not an endpoint but a rpmsg device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> No fixed sha1 indicated in commit message as issue is present since a
> while, it does not fix a specific sha1.
> 
> git blame highlight the sha1 [1], but issue was present before.
> The commit [1] just moves declaration from rpmsg.h to rpmsg_internal.
> 
> [1] fade037e0fd5 ("rpmsg: Hide rpmsg indirection tables")

This patch is not a candidate for the stable kernel and as such a "Fixes" tag
isn't needed.

> ---
>  drivers/rpmsg/rpmsg_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index d4b23fd019a8..ff0b12122235 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -41,8 +41,8 @@ struct rpmsg_device_ops {
>  					    rpmsg_rx_cb_t cb, void *priv,
>  					    struct rpmsg_channel_info chinfo);
>  
> -	int (*announce_create)(struct rpmsg_device *ept);
> -	int (*announce_destroy)(struct rpmsg_device *ept);
> +	int (*announce_create)(struct rpmsg_device *rpdev);
> +	int (*announce_destroy)(struct rpmsg_device *rpdev);

I have applied this patch.

Thanks,
Mathieu

>  };
>  
>  /**
> -- 
> 2.24.3
> 
