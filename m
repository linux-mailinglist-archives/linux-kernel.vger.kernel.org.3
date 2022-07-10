Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BD56CC21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGJBJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:09:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF579F581;
        Sat,  9 Jul 2022 18:09:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f11so1748268plr.4;
        Sat, 09 Jul 2022 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r5jc2nEo8bPKdDmH/H54BQ/Opl9OOO6xZc/Wuy7HkMw=;
        b=JeFsBZtY/xigvdDMsTfmVcwpogqPlv0O8/hpQaoEvjjo0IArbvipd5tpl/ZgGE/FcH
         trmdZAFdTr/2b+1wFAAr6EiFKxYQgiHHAD2Dnrkmk+wvKu8VubJHhJKaUrqYfGzV6PsI
         HlH9WzU9hItxUF16wUlIOLBWfrmvyxDsMheQW63dPKH2QyV9ROdHDPYAgrTFFuIAb32E
         MYiDhagitGHlZ63onZzjkjNs8v4fIAohY34K9EbbyISHc5I4OYuiFG98hqrBHJUSv4Ha
         tojG+08gVYwyYrrqo394SzZIL1JJnIcazrf/GOpZQNhWG6HZF/yWy8yPkfejf/mVupYB
         IZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r5jc2nEo8bPKdDmH/H54BQ/Opl9OOO6xZc/Wuy7HkMw=;
        b=JFLJrdbEFUTHjMJDU4ebpDYh+IazSQOzAvb4jpbtv5hxBc8e98du2Qqn/7AX2M2IF3
         hhmHaeRpsmATXOLGPTCNc1E3om4+hfxqR/x9nf+RhgoAH5tf2UNHL3jUn8nmU1th3QbS
         6XS30i0DQ/w0F6IyKqExlfTtV/dXEVW5feCKYlA5i0UWAahBmaIDw0L6/fhh2rYfYJ1I
         humFq/fdJPsalGvq4HfzHQj9jb2SAVgWg1z6PdMcqGrzOC9dFhRIC+O8dc7cWgT2YBEd
         k4+J3QGqXLDuSS6v5G43Y7M5bDDar/Eexvq3QXyqKIMSh7eE6UHXb390w6ipyMNZDFVZ
         G5oQ==
X-Gm-Message-State: AJIora/PgNhCABXdBZxEfUK0wOyzO3BUlGlxK7OlcJB8Si5TodONVVxM
        xlrQt1Utep+57Z6pjy1uGoI=
X-Google-Smtp-Source: AGRyM1u0K4+UXqxpDbEfF/pxtOesHa+Ys+8HaGFSfguhd6WUGiPfpJA/RshLwZmbxMkvIuDQAOvLzg==
X-Received: by 2002:a17:90a:9d8a:b0:1ef:7a8d:1808 with SMTP id k10-20020a17090a9d8a00b001ef7a8d1808mr9221394pjp.135.1657415373004;
        Sat, 09 Jul 2022 18:09:33 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id x24-20020aa78f18000000b0052ab6590290sm2065137pfr.88.2022.07.09.18.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 18:09:32 -0700 (PDT)
Message-ID: <954ed2c8-9e1b-e8f9-bf07-6248dc6ff954@gmail.com>
Date:   Sun, 10 Jul 2022 08:09:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 00/14] Multi-Gen LRU Framework
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
References: <20220706220022.968789-1-yuzhao@google.com>
 <c576d1cc-9f67-4cf7-a851-48bc0e9f0082@gmail.com>
 <CAOUHufbhmma8phX4arNwF10xBf7as=gtc1Y7k01f6CD3v04-QQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAOUHufbhmma8phX4arNwF10xBf7as=gtc1Y7k01f6CD3v04-QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 02:31, Yu Zhao wrote:
> 
> If you are on the latest mm-unstable, then please
> git pull https://github.com/yuzhaogoogle/linux.git
> for-mm-unstable-2022-07-09-03-05

Fetched, thanks.

I think in the next reroll, specify --base to git-format-patch(1),
and also mention base tree for this series.

-- 
An old man doll... just what I always wanted! - Clara
