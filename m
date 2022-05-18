Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909A52BF70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiERPpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiERPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:45:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB0104CB2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:45:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u23so4386613lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:reply-to:references:in-reply-to
         :content-transfer-encoding;
        bh=WFeKDO/VHFPn7sSKJvdp5rRQttV67/H6JQIVb2h+Lew=;
        b=FtJwEd5hZYGsYGXklHIsz4wUillFNlgExaPbFXh7Eu7rj5iGUqELqQcIahNvGQfuXN
         2ciMPRxfgBUABdXfjuOypcGm6fyupODT1heXwvf5ZcJKV31Pbi8D0j+JjwMUmw3GhdxU
         Do999nONM4wkEr/XQsQdaRy1cB3aJP6z2wKaFLEZnniZyniO6Vfpj/Y6kO0YoKELh65T
         IUvBFYtdqyXLN+fv2GishwxCEUW6/TJ8MsTp36zO0msGOlHWuE51ku2Ox4zUI556TU3h
         O+9pDEAQ7/0MV/2povvP2gHWnyzfeaomMsZjY6UgQwC0ihloUjToEzrrUUkUr2uBTPxY
         qz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:reply-to:references:in-reply-to
         :content-transfer-encoding;
        bh=WFeKDO/VHFPn7sSKJvdp5rRQttV67/H6JQIVb2h+Lew=;
        b=tXmO0tD8pp0Xw1n/WWGP6PzMHqH4ND2Vo7wPCLVKuMtwl0qmI/mNm5uD3x4vbJLNiD
         tqieZnF5ljJNqPkzCaL6ZKKCydlE3JtdggyF7tFZucnKGFpqcmcsgETwrGhEi8BvQjv/
         dFTcTadeAPXZsKNreXJPH93l629YrX/aaBIrdGoPdq6bQJZU0NSkTWJuMhiwgDAcupkt
         cm8zviV2pd/vtGCK3Eb2o45aGCNfHjWfsW5a6/uUlnVR1X7CN58Du+63itN/hMICcKku
         x/ToBn6+Iw7D0D5M8+IsAtXSaEn5IV2hZzzF5Nbyuc1/JJzF5SBOLoQGGN6gDJKuyYUr
         atIw==
X-Gm-Message-State: AOAM533gEzti3nMdpm4Eo3twhgr6gbT/769sO8VjQmEu52JgkJMO3JG0
        Hi/uo7zIQY6evIU86FAYkgAULQ==
X-Google-Smtp-Source: ABdhPJxEfW0QIGSFKHOrNYaqEQ/egx0URLtZZaAW315P4SG1tCIOZHy62LH+wcdfgD7PSfQ+XKHzuw==
X-Received: by 2002:a05:6512:2510:b0:474:2364:bf5e with SMTP id be16-20020a056512251000b004742364bf5emr73125lfb.323.1652888708015;
        Wed, 18 May 2022 08:45:08 -0700 (PDT)
Received: from [192.168.43.196] ([185.174.128.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a2eb4ac000000b00250749dab23sm250094ljm.99.2022.05.18.08.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 08:45:07 -0700 (PDT)
Message-ID: <fc0a8dc0-a150-441e-4882-fdddbf2033f0@openvz.org>
Date:   Wed, 18 May 2022 18:45:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Reply-To: YoPOhRctb8wwbmY5@carbon
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
In-Reply-To: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 09:24, Vasily Averin wrote:
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
> 
> This patch adds boolean "allocated" entry into trace output,

not "allocated" but "accounted"

> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>
