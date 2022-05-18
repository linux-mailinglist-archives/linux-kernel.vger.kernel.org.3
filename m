Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6113B52B085
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiERCpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiERCpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:45:19 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705572D1E9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:45:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k25-20020a056830169900b00605f215e55dso432880otr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ipYbvzexcv7XtY/Yu2sKOh1CMDyAt1T6/X2Tz2fcto=;
        b=idcC1LURCDwEko153njg3xNwrZXzbIPgSCIH/Dhb5fJ0HwTiL6hLpiasLU54D3icib
         0VbaJXj+7TU23ztvFSyCAV+/L3TC/0XeAEadN0mdhz0OQFeOIXRz9EIFezJxe09VpJcG
         TFzHxBVPeD7PHCPkm20ZuXVmyT6XxD8hUYIY4R9wcRBX3r9voZjE1FIOt/OVg4cZKQw0
         y6umdEcvvSVos1ciZuyThdVT9oZc+Kqkq3tUd1KL7yoUMT2fQxFt72jLZua4d7x+l+Ph
         BkL+0qn/wnJEInBcOudsb8H7u6UTVMY3OCLuWOV4EObDTtz1PV1hLGSQo4xeNoniigb5
         3Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ipYbvzexcv7XtY/Yu2sKOh1CMDyAt1T6/X2Tz2fcto=;
        b=ABoMoNa5w9aFzbY2lIzrMoSZEBB1sXoIj6lO0vTJfz4l7YaOaK71yJ8P6vm2DqXJtu
         sBAUKIZsXk6hJjVDfuJe5DHNxuVEf0OaGccMrZVK1Q4VH3WNzZXHUjfH4CpFuwY8dySS
         PySxmUG4u4X9bRtlDhy8XGZa+2etC+KhE5ntKIHb7xzyuh/SRQJJJFUF3cVLc+NyLisT
         xXtoFJX7xtxQ+d0gNr7hwg1cEkq5G01m10bwB6SHHrQXE+WFP50MTjXWYOStr4tWS//C
         XbwBol4Vl5qeY6SMOLDieUl9flr3PJ61Rmv+EoNQGjZx818YQhfIxQ2JF++W+ZF+EV4M
         Qcmg==
X-Gm-Message-State: AOAM532KHr9juu3J9q2kAY5zwJ2iw3Khb2AgAzlqsTVHBljT9o6r0kF0
        ufj9/xyfaabiywYfLjtZWb9mt5NCA2BRoDdWy+A=
X-Google-Smtp-Source: ABdhPJz0m47+RvXiN6uqtInONM6WedQgxN1EUMFCz62Gj7yqybRXimUeMn+xZpyFjNiFsoTKZmcB7g==
X-Received: by 2002:a05:6830:418b:b0:606:1307:974f with SMTP id r11-20020a056830418b00b006061307974fmr9531545otu.263.1652841917775;
        Tue, 17 May 2022 19:45:17 -0700 (PDT)
Received: from box ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id s185-20020acaa9c2000000b00325d7b6cab8sm419519oie.16.2022.05.17.19.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 19:45:17 -0700 (PDT)
Date:   Wed, 18 May 2022 10:45:15 +0800
From:   FanJun Kong <bh1scw@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg reviewer
Message-ID: <20220518024515.mafizzgw5atz2ejr@box>
References: <20220517143320.99649-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517143320.99649-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 22 ◦ 22:33, Muchun Song wrote:
> I have been focusing on mm for the past two years. e.g. developing,
> fixing bugs, reviewing.  I have fixed lots of races (including memcg).
> I would like to help people working on memcg or related by reviewing
> their work.  Let me be Cc'd on patches related to memcg.
> 
I vote for Muchun, not only because he helped me with kernel patch
reviewing/suggesting, but because of his influence and contribution
in the open source community.

He is very patient and skilled(memcg, list_lru, etc),
and is very friendly in the community to answer questions.

Thanks

Fanjun Kong

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce78f2275dc..0d5de0c553aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5057,6 +5057,7 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
>  M:	Roman Gushchin <roman.gushchin@linux.dev>
>  M:	Shakeel Butt <shakeelb@google.com>
> +R:	Muchun Song <songmuchun@bytedance.com>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.11.0
> 
