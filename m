Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9750CF04
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiDXDlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiDXDlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:41:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805626FB;
        Sat, 23 Apr 2022 20:38:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so4839612plg.4;
        Sat, 23 Apr 2022 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=nGMc+Z22AXUnC+pCn5jAPVEn9ljsBIe0MBnGTXohsCg=;
        b=HevHAIoIufDAkmbDUiJyea4LZ411BtHC1g9Z+0bknJ7VB+kgepu70ImFX/DFiEq+Gp
         O2sKW6BHe9ApjEduYLp96JKsywmVbyeQLn2YkLZbkKuZrV9VAUGMvOFFpMYo7ii/hTNj
         F3GmJnTMfxXCf9QzHkaZza1vtNGrPjNZC21vFWI5092hYagk4hk7JKVkkC4mdmD+RIA+
         NHA7eQTlbuh0O/0NleWxx0eeynrOlWBtMo/8w4z7McqospSSbsjgL5zoo0VrMgXcOi5F
         LzaZHip/Kykt5AjWcEJS4vqSy8onEBkiHtf3HEQkpCux0wK8y/LOdIwGypgfjsI+AZA4
         G6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=nGMc+Z22AXUnC+pCn5jAPVEn9ljsBIe0MBnGTXohsCg=;
        b=sDV73ePyTfIR52SVuc1IJXuC6biBs7FJL98EHaQcXeac5lJErrEVpgKq0J34ocv7er
         632JJiWkQsYV1FOVCEOQ1X8lwoqClLYcbfei19tRF+FeV/BAZvDy7p2GOMY+WLX07FCw
         4SiV6E8/eYJj1e/3fN0RpTpnGJkQo4Cq62wlT3BcqmJ0eMNrNatRFiqu+ESFchq14wGX
         +XnAMALAgQY5UsHTbwo/twfP3avILwKrifpodeobq/zofFpHi4iio6gNVV9CFVFepgW8
         WPzCrhCxzQKUQO3es/r/EZOiM48BJpocClTsu42r/Pkbe2h4kJRFKgdAcZj2trXBB0hH
         XyMA==
X-Gm-Message-State: AOAM533Lh+4BMEqzypn/SLCgeILmr/06jDCRD+AJK+mfEW79Ma53Hkne
        8iwKnfqzril0IAMrqqU8qjs=
X-Google-Smtp-Source: ABdhPJznANpdO/h8c2xYNCXXhfqwXvCdFcaQb/J6/UnoprwsCE+Udlz/pc5ksWseLaC8iwhWQlmxVg==
X-Received: by 2002:a17:90a:c002:b0:1d9:250a:73c8 with SMTP id p2-20020a17090ac00200b001d9250a73c8mr7657096pjt.133.1650771496841;
        Sat, 23 Apr 2022 20:38:16 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ei12-20020a17090ae54c00b001d952b8f728sm953593pjb.2.2022.04.23.20.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 20:38:16 -0700 (PDT)
Message-ID: <3ce4feb9-5477-e7fb-e98c-3d6342ddc7b5@gmail.com>
Date:   Sun, 24 Apr 2022 12:38:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     baihaowen@meizu.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, seakeel@gmail.com,
        siyanteng01@gmail.com, siyanteng@loongson.cn
References: <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Wed, 20 Apr 2022 11:06:56 +0800,
baihaowen wrote:
> After make htmldocs, the table which is made of tab will
> display all by one line. so we make a standard table for STANDARD
> FORMAT SPECIFIERS description.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  Documentation/vm/page_owner.rst | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 422d5fa99e84..a8505e3a3044 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -174,22 +174,28 @@ STANDARD FORMAT SPECIFIERS
>  
>  For --sort option:
>  
> -	KEY		LONG		DESCRIPTION
> -	p		pid		process ID
> -	tg		tgid		thread group ID
> -	n		name		task command name
> -	st		stacktrace	stack trace of the page allocation
> -	T		txt		full text of block
> -	ft		free_ts		timestamp of the page when it was released
> -	at		alloc_ts	timestamp of the page when it was allocated
> +        ====            ==========      ============================================
> +        KEY             LONG            DESCRIPTION
> +        ====            ==========      ============================================
> +        p               pid             process ID
> +        tg              tgid            thread group ID
> +        n               name            task command name
> +        st              stacktrace      stack trace of the page allocation
> +        T               txt             full text of block
> +        ft              free_ts         timestamp of the page when it was released
> +        at              alloc_ts        timestamp of the page when it was allocated
>          ator            allocator       memory allocator for pages
> +        ====            ==========      ============================================
>  
>  For --curl option:
>  
> -	KEY		LONG		DESCRIPTION
> -	p		pid		process ID
> -	tg		tgid		thread group ID
> -	n		name		task command name
> -	f		free		whether the page has been released or not
> -	st		stacktrace	stack trace of the page allocation
> +        ====            ===========     ============================================
> +        KEY             LONG            DESCRIPTION
> +        ====            ===========     ============================================
> +        p               pid             process ID
> +        tg              tgid            thread group ID
> +        n               name            task command name
> +        f               free            whether the page has been released or not
> +        st              stacktrace      stack trace of the page allocation
>          ator            allocator       memory allocator for pages
> +        ====            ===========     ============================================

This patch looks like against akpm's tree (or linux-next).
So it is not applicable to docs-next of Jonathan's tree at the
moment.

You need to wait until docs-next catches up akpm's tree.

Patch 1/2 should wait until the English doc is updated,
I suppose.

By the way, I don't think the list of options need tables.
Literal blocks should suffice.

I mean, How about the simpler changes:

>  For --sort option:
   For --sort option::

>  For --curl option:
   For --curl option::

Thoughts?

       Thanks, Akira

> -- 
> 2.7.4

