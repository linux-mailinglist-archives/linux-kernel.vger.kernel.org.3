Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A156988E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiGGDDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiGGDDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:03:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB92F666;
        Wed,  6 Jul 2022 20:03:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b9so655007pfp.10;
        Wed, 06 Jul 2022 20:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cm71KbLuMVqZ7FKRzHT6BD+Pl+HC7ern6DfnF1bDLJQ=;
        b=KVXW3OumOnJbeLogsywoMxN4p4EmHqwXs28To7S4ROeXyfH97KXUXnfPkhq8JbtiJP
         5n/587SyzpnvjykQDEvGdW6wjLPe5J9AeJWWs3AIRpjecNp2Tpg36RGoyrRHBdCogpDF
         49EpoI5zmqIK4yUhf7s93I918UAWG3EZnnxoQMd4RiEYRwAm1BrzzaWtvtb7faAL+2ib
         joWJo1Lw4pjsJeSS4BjQbz9M+W18dfXRZqi6YenK5ymnkNSuxTzlLbNPS5ju1rHOxTaQ
         JT817hBHUDwNOA6DoYgMtkoratohNcL7bu3PQo5DqlAknDBSIJeP4qun5ec2oRF6pI9B
         dqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cm71KbLuMVqZ7FKRzHT6BD+Pl+HC7ern6DfnF1bDLJQ=;
        b=Tf+YU1VQTAbww9BbPU3+x3wQQc900FQdcEmV8l30jWnisQ+TCOmJ8Vg6GjT7lkTCJq
         R3cPxwXcED3TqtwTJO1pVew3aIRN3naejdl558n8KOsNBO+6HGdFLH5hVX15bd/BKVhQ
         6kectHpMb3kooBNx+eNzsr9wuPVqI0j0OiVIji3oIKNjWsx7Xc+7WDps8uzPkS30FcRn
         vQ9MuI68jGrxzSXMzPOc/Ggm7cjclE6+ZoOVVCXTjMg5FBAJtmjUjlWC0VDe4r7XCpUi
         xd1FtxnMS0OMtSu0/iHvNmDY63fkDoYrtsxxm8kKTcLQvuW4aguA/t3bAxvMoZ7SrQyI
         bKfQ==
X-Gm-Message-State: AJIora80ScxUJNJsNsHOAXUZvpTqe9Ynl1taA8UBf+9bQWUfeYb5CgFu
        ow2G/bX3IY9pJgDFqKA5udI=
X-Google-Smtp-Source: AGRyM1tXupxGgWc7dT/0pADwuodIexQi9+URlAkOMGyJGP9CzF4XEhpV5GjaObJxIyg/vx7zBVqs4A==
X-Received: by 2002:a17:90b:1b0e:b0:1ec:e2f6:349e with SMTP id nu14-20020a17090b1b0e00b001ece2f6349emr2357257pjb.14.1657163021494;
        Wed, 06 Jul 2022 20:03:41 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b0016bf24611e7sm4723218plh.5.2022.07.06.20.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 20:03:40 -0700 (PDT)
Message-ID: <c576d1cc-9f67-4cf7-a851-48bc0e9f0082@gmail.com>
Date:   Thu, 7 Jul 2022 10:03:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 00/14] Multi-Gen LRU Framework
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com
References: <20220706220022.968789-1-yuzhao@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220706220022.968789-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 05:00, Yu Zhao wrote:
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.
> 

On what tree this series is based on? I tried to apply on top of mm-everything
tree but it didn't apply cleanly, so I had to abort.

-- 
An old man doll... just what I always wanted! - Clara
