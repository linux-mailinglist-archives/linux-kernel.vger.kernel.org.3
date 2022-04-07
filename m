Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A24F7F53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiDGMnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiDGMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:43:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3E710D3;
        Thu,  7 Apr 2022 05:41:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o10so4755400ple.7;
        Thu, 07 Apr 2022 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jaS/JBzZIALs0V9KDtw1yoad9JspSw+l403SD4bkN2Y=;
        b=csa4nRm//K/WesvietmNCQ7jO89ExyPjth+tiggaLztdkYkL68+d6Z8tIhmfcwT5m2
         zMhxPDUf5wRP15CBsCQQSJX6yRKsyzu8ZxK5lvqzx3BGvdXVS386y5ZmVJ8s5UMbCh20
         cypwRbMzWvFHm6gYfXmh6A1p//xZqpyVPe7OYonq9XF2LeXLhXdgFh6L6vrzxT0F56cQ
         GfewVc9ngo9vM5yPlyiR3xJ3cLmzfUIL8Afs0TYUvRvZommKcj4xjy/+Hg1sexQcdwvz
         QaX7Cf3q20aciYDYLh3uDVQD6zcuS1f7+jD9P0XFhf+XzFdydGopOtOdmvXcid81NTsR
         cI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jaS/JBzZIALs0V9KDtw1yoad9JspSw+l403SD4bkN2Y=;
        b=Kjkk3ziXVpx0nb2QIff698WaNRijXfVzsUvCQct40eZKzy0OFnZV3ILU4UT4h3HatJ
         XFf02IGzKe/zi8Pud9JVfvzfhKf5d1QfKT8I6UkVjGFeML4TFx9j1cgCqVTgbIPfxdZF
         N6YWEdy1jZXLOt3C/J/bUfV21J4sxapH/TQ2UoF5rTuPZ0t9Sm6SkAAXkALVvE5YdSxm
         ZA0C12yfunEJ+Bp08NqL6p9CIA9JHfqR339ewFki//1TUgRo4n4e0Elxdsupyvym9XPu
         0rCAzh3w5+aOkrsZt6qK2v/4683DlwlMD3fAj5EjN886if4qs/6t55tQ309goenPBpCr
         VPBA==
X-Gm-Message-State: AOAM533+jt/nMnZfvyEzTv74q0sw408j1/RlXqqgn0ZHFL20X7vh2oQt
        lGlx89B/r7Y4YauAtlDnnwI=
X-Google-Smtp-Source: ABdhPJzigotG3p4Oe0PfSY+DQUikEALOqVHzbWgFp/MNP47LORXbE4OsEkfHv75JzUQXpuGQspiUfQ==
X-Received: by 2002:a17:902:f64f:b0:156:f1cc:b284 with SMTP id m15-20020a170902f64f00b00156f1ccb284mr6413155plg.147.1649335281157;
        Thu, 07 Apr 2022 05:41:21 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm22640511pfg.89.2022.04.07.05.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:41:20 -0700 (PDT)
Message-ID: <fde38982-a816-567a-3abb-370ec294b2c9@gmail.com>
Date:   Thu, 7 Apr 2022 19:41:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 13/14] mm: multi-gen LRU: admin guide
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Stephen Rothwell <sfr@rothwell.id.au>,
        linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-14-yuzhao@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220407031525.2368067-14-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/22 10.15, Yu Zhao wrote:
> Add an admin guide.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Why this documentation be added to admin-guide?

-- 
An old man doll... just what I always wanted! - Clara
