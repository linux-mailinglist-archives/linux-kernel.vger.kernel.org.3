Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3C56CC61
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGJCV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:21:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DC2496C;
        Sat,  9 Jul 2022 19:21:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l12so1787759plk.13;
        Sat, 09 Jul 2022 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZlKUbM7taPYwA2QJB6xuqDO4kfQ1tX0E5DhsBeXBePk=;
        b=Q6/hidf96cnh0bHovF+9avDw+gHX9U4hdCWCsLmxH6xRsrF/Yd27VaAjXODOW5sSpX
         VRKXXkutzPIQE/rAtKrCDV8L9iJ+9FluXOA9cBS1+71NFIaPBsbGQZY4vkjci0g7RXnD
         yXB2yWUISz6y+JUKCldQzbsF+Sy0Kg8RS2ftGTBOmHwq7SgjWsZyqanuO0APhGIa7BZK
         6djI/sCqtvyuxjuI/4P+wC3A19bsp91R3NnUQHm63J7wPlMhgqSrlaeZ8/NFz2pXptB5
         eNYaSy1jBrpfGFh+ItrQd1c0CAT+AHJrB7iBpcCU3dx6S07L4gH+x/IGqokBrYsfYsi4
         aIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZlKUbM7taPYwA2QJB6xuqDO4kfQ1tX0E5DhsBeXBePk=;
        b=n1AhYUeNM2RjhuwNLcW6fgaf/blovqQdvCZvQiuTSw6V96Z25T6wHgexmCBNwIAWOt
         17ZfJxsV2LdAzgOw1n98VsfEQOXm0y5U5T3d/+VJLLrh0y6ZSuTVJ5jE6WsaN2pTx7p1
         /zT8a0/vGzoqOBUlfG2yV3M43SuyqxgFGOU8iLXzD12jhKILnjIg3uUaGmw1qI7mRRGX
         JCXI5IDANbAY/9kzpIk73QrHOYx4F0x+Sim9YnTCgThgjOTC2zBMP+k8dyIPldzklW02
         eFw9U+06ZhIdva2SncoeY0+zQTuPxUoi4HscivBnjKpzOTNieb5g2qLFcZwdc2RrxoiK
         RRuQ==
X-Gm-Message-State: AJIora8PBZYfD4niRDlzHskOcBPTdJLITYkJ27fBgoH5Gvqb9QcEDp23
        O7vf4/Ct/PxChoX1TyduAwM=
X-Google-Smtp-Source: AGRyM1ulhJBq/HMMYp/UkYSWjJb3v0BHhTgessx/GQV71tikgEWpbFPJvUDyo2hcqGSO+FEqtwb/aA==
X-Received: by 2002:a17:902:6503:b0:16a:4db1:8d5a with SMTP id b3-20020a170902650300b0016a4db18d5amr11788942plk.133.1657419682872;
        Sat, 09 Jul 2022 19:21:22 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id q4-20020aa79604000000b0052ab54a4711sm2103153pfg.150.2022.07.09.19.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 19:21:22 -0700 (PDT)
Message-ID: <459c061f-74fd-a9b5-2132-bbf9064daa47@gmail.com>
Date:   Sun, 10 Jul 2022 09:21:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 14/14] mm: multi-gen LRU: design doc
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
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
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
References: <20220706220022.968789-1-yuzhao@google.com>
 <20220706220022.968789-15-yuzhao@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220706220022.968789-15-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 05:00, Yu Zhao wrote:
> Add a design doc.
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

The documentation looks OK (no new warnings).

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
