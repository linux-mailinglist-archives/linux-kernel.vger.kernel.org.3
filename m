Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3584BF775
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiBVLss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBVLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:48:42 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF1115966
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:48:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r20so19108385ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaHg+5bsEnZMMhmYM3qeBR8KMyyKEUx8tISQuN+2AKA=;
        b=XgTjgfDW69WIcj14yfJMb06Z/Pqt44jazzokt2w3ELUN7m+ImDVdoCW/Es/J/k823D
         tBIjfMVIqM0JpngC3XQedrMdJJJkMyLf9Z1zFmissHu4CrfPH0RZOJyWebMuKu997XvJ
         49LOEWEo2SNc/GBYUBmt7cMXPzw33ri14ROMzQRnxa05GLwKOqxil3/ZZFjxtg3N3MJm
         BNvMDecNxApN78PRRq9hDTrwO9XUGkxeNuvHlbNQ9M6NVixYECQhZksE/Zxj14z1sfOG
         9ZliffP/qbI+4t22mWFBEffps7CUG5IrPNVHSvpY84ik+Wr/ILng/piuwHw8uCMsNxo5
         OItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CaHg+5bsEnZMMhmYM3qeBR8KMyyKEUx8tISQuN+2AKA=;
        b=eiHyjcR20mpXDW+X5/p6K+AFji0sTn5PGzArue63mWk5AQDG08dpo1824+CyPHqpvU
         w+OYV+vD4csGN2mT1j3L9pehaw1GCQU06wPANbGo9Pxs4Nn5x572P9NCo5+9XR5ouUoo
         hW+FcDUypir1DZMPCJ95kQPbQnsV71lcmXEWNZuimo601ykII8UDBuxUXU+LP3gb0Sm9
         d+D2208YvXdNNZ9ly+UT4s5q+fvJ+EdYW3A+oWPorq9YtspfbxKJv3NMWQw6YguQRFEk
         fRJ12YpgAAeosVTT4j8s3yGQdcatfvVc37PptoFxgC25VZ3t8faBHr1G9RbbsQZqar6u
         g5Xg==
X-Gm-Message-State: AOAM531OgqCdC63Av0a5NDjNZHPudmiNN7v2jI7gmIDf6tbW5y/Rrqtc
        s6PGDpUhyxguvceO3ShU24M=
X-Google-Smtp-Source: ABdhPJyqboSAlo/vEXXEZ0jii7CznTVa3VLASkjOpIOz4j7jq+eAHyaGdN9+zESTw6dqzxpPp3a6Sw==
X-Received: by 2002:a05:651c:307:b0:244:c6a1:167d with SMTP id a7-20020a05651c030700b00244c6a1167dmr17709820ljp.263.1645530495627;
        Tue, 22 Feb 2022 03:48:15 -0800 (PST)
Received: from esperanza ([2a00:1148:b0ba:16:6400:5eed:39b5:7c57])
        by smtp.gmail.com with ESMTPSA id j3sm1365132lfr.132.2022.02.22.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:48:15 -0800 (PST)
Date:   Tue, 22 Feb 2022 14:48:12 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer
Message-ID: <20220222114812.r6uil6lv2auxadsf@esperanza>
References: <20220221233951.659048-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233951.659048-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:39:51PM -0800, Roman Gushchin wrote:
> Add myself as a memcg co-maintainer. My primary focus over last few
> years was the kernel memory accounting stack, but I do work on some
> other parts of the memory controller as well.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66aa3a589f6a..ecdb90e99ba7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4991,6 +4991,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
>  M:	Vladimir Davydov <vdavydov.dev@gmail.com>

It's weird that I'm still on the list. AFAIR I sent a patch removing
myself from the list a couple of years ago...

Roman, could you please remove me from the list while you are at it?

Thanks,
Vladimir

> +M:	Roman Gushchin <roman.gushchin@linux.dev>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.35.1
> 
