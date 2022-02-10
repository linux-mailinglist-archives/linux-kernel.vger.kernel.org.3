Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCBF4B0341
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiBJCVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:21:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiBJCVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:21:00 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15922BC0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:20:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g145so3504828qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 18:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kxPpYOr9fMCpJd7sCfUn04qJNkl4bMWZoTA8Ys3By8k=;
        b=BxDabmfDoaUDg1dIy4jDTq+JM5s/45/glUofZdZQaH0DIPhWoBB6gHmDiT2A8DFOva
         G32ykwm4JiumAeBLNmVBsH3T1FvUvgNfX9W1gelGS4ABinKosCLgG0inBLbTYGLz8uHV
         /qjKuiTneFLu4RNVWZErq28gjv6qydN2NGQVMd5wNwjeyuC3AeOV5F+X5jMibsRfFJQo
         AZGztqAZ0+9r1GtckwGOODMrVKec6y1LAdVFCSg6CfzrhO8R5VKvl0F7z1lezAYhBQ0X
         tYlhMTzDKAFaTDfcajRq4HtNPIMYyxIIOY8054YxUH0GqhY1GsoaRhLaJtl6GfEA3xQP
         vo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kxPpYOr9fMCpJd7sCfUn04qJNkl4bMWZoTA8Ys3By8k=;
        b=TJBuDwJI3zPA5Gy5W+qBS7IcZyt9DWXgNVvhLNUKp0VRzZPCZaNSqCUrP3cDVMFuhR
         2679ED0WpVoQtfaqZHQno+8X2PneqIGU3BtHCro4SQ5026xLbCsRCZ5nmzKR9Rc146o+
         jhNAam4WRHd2JI+4u+1dsY/4lfHy2DQl8tEW95i84yZeOI4fJn4E+hl9naDrI0fymITj
         AUYToH5bCRfX96l2/1M/eY9dVh82N+YaYxltJXfg0Z1dE7EjJIUnGkEUbC0zJ9gHREyD
         sfU1Vj+wKJ4DJ902lNapZhY2QTOjWJFK0hLMSOiI17Wq/ZQ6lwvxYuXEbChI1ftZDF29
         BgKA==
X-Gm-Message-State: AOAM5326qxRW61ZZrZOlAZtaElwfhGmLzbElRtTOsw1LzENnizWI1UBY
        g7vRTzwGgG2ywCMHvKc1o7K4aQ==
X-Google-Smtp-Source: ABdhPJz7jqG0d7JGpbU68kibD9jbvyBU3iduP2od/KjZDE0+g8Vn/9ABBS1tr25xGzStG9SpUY1rQg==
X-Received: by 2002:a05:620a:2904:: with SMTP id m4mr2721558qkp.479.1644459658987;
        Wed, 09 Feb 2022 18:20:58 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 16sm10185035qty.86.2022.02.09.18.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:20:58 -0800 (PST)
Date:   Wed, 9 Feb 2022 18:20:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Li <yang.lee@linux.alibaba.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -next] mm/munlock: Fix kernel-doc formatting issues
In-Reply-To: <20220210004849.69017-1-yang.lee@linux.alibaba.com>
Message-ID: <9eceb01a-4a62-985f-52c-266cabc156f9@google.com>
References: <20220210004849.69017-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022, Yang Li wrote:

> Some functions had kernel-doc that used a hash instead of a colon to
> separate the parameter name from the one line description.
> 
> Replacing them to remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> mm/mlock.c:218: warning: Function parameter or member 'page' not
> described in 'mlock_page'
> mm/mlock.c:240: warning: Function parameter or member 'page' not
> described in 'mlock_new_page'
> mm/mlock.c:260: warning: Function parameter or member 'page' not
> described in 'munlock_page'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Oh, great, thanks.  I thought I was just following what was already
there, but now I look closer, yes, the ones with "/*" at the top had
dashes and the ones with "/**" at the top had colons: apparently I fell
for the wrong combination - sorry.

Hugh

> ---
>  mm/mlock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index d50d48961b22..7fb97e1242f1 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -212,7 +212,7 @@ bool need_mlock_page_drain(int cpu)
>  
>  /**
>   * mlock_page - mlock a page already on (or temporarily off) LRU
> - * @page - page to be mlocked, either a normal page or a THP head.
> + * @page: page to be mlocked, either a normal page or a THP head.
>   */
>  void mlock_page(struct page *page)
>  {
> @@ -234,7 +234,7 @@ void mlock_page(struct page *page)
>  
>  /**
>   * mlock_new_page - mlock a newly allocated page not yet on LRU
> - * @page - page to be mlocked, either a normal page or a THP head.
> + * @page: page to be mlocked, either a normal page or a THP head.
>   */
>  void mlock_new_page(struct page *page)
>  {
> @@ -254,7 +254,7 @@ void mlock_new_page(struct page *page)
>  
>  /**
>   * munlock_page - munlock a page
> - * @page - page to be munlocked, either a normal page or a THP head.
> + * @page: page to be munlocked, either a normal page or a THP head.
>   */
>  void munlock_page(struct page *page)
>  {
> -- 
> 2.20.1.7.g153144c
