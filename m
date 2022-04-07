Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6C4F7F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbiDGMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiDGMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:44:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7C7B11E;
        Thu,  7 Apr 2022 05:42:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso6383718pjb.0;
        Thu, 07 Apr 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mB8SsRiMpROsDXNQItiMSlnh+Lyw1uf41AvKn9tE3dU=;
        b=oxzclEJzWFrYJnCBAIhhbeRMs7tHHrALQRomPVvNE1RkyO5yDBKwD6gPeVAQuevj/D
         qxYvUsv+NVVR+k3Y3sVcaQL9gXMoc8kNtwmJkohZoC9kEtGNAhaznveNOeATAeBzs/5I
         bDIu8jCWibokzkSIM6Mdi/cOosuZUmbdtgmjWH4WtzL8wt/NsX8UzmY1Hg9HzFCQkXEH
         +AA9Eth9cVfxFuqeuyHxXYhvfyIT4hGFl3cl++XamiCshB3taPMSAD4zj7HKXHhlO6hV
         dNXpJOU0vPIxn95dZuCu+hDsYCIILYSG15SL6pwL54CLEHU+lhwvoCW6LWxi6cVtJfCk
         h/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mB8SsRiMpROsDXNQItiMSlnh+Lyw1uf41AvKn9tE3dU=;
        b=AO9U6G7ttnmiPAcYXKALGSv7vFw8ZTOQfZR5T3sPgeNfy/tVukr8N4ZmeKaxEfV36s
         AwfyvDksET3bgLudhoH7twRSChgbt0aUcWsZGilTgIcwzB37SQde6CcpTbhnPu5sLaJg
         S1hgpn9MH9uDP9gkVzT7g0yRaozSs3KmagnkfNhNyl1AKvWqM2H5aOLOZc7PntIpyVUI
         RZ5k0h8mV5N6UpB+sieCwhmLE6Ce4MPvHsn1F8AqN6I7klHbqwvkmFVL1sbidYe4N0lz
         1fX1KWC651t2NyTS7mQ8C2YrM2H33BS/oO6jF61YZwQD3S6RELRCFn1V2fg4kDsr7piK
         JTCQ==
X-Gm-Message-State: AOAM531N+L1zkxs4Pw4WDh3TzVzsQ6cpTl4MeSRidPGBcKDd6VN6LVSQ
        k5PdTQFjukJVbq0so9EmHAI+PyLBWcHwsuE2
X-Google-Smtp-Source: ABdhPJzWmt8WRjQU499EV+dELfJK/w4qDUfFpTg8LsS0VN/D9hqOLaRttBxaJO+s8N4e0wyRQXYQcA==
X-Received: by 2002:a17:902:b092:b0:156:a40f:f716 with SMTP id p18-20020a170902b09200b00156a40ff716mr13682902plr.72.1649335333331;
        Thu, 07 Apr 2022 05:42:13 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b004faac109225sm24507168pfa.179.2022.04.07.05.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:42:13 -0700 (PDT)
Message-ID: <5ea69d84-be0c-2e9b-02b5-92d9442c8aff@gmail.com>
Date:   Thu, 7 Apr 2022 19:41:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
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
 <20220407031525.2368067-15-yuzhao@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220407031525.2368067-15-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Add a design doc.
> 

Why is this design documentation added?

-- 
An old man doll... just what I always wanted! - Clara
