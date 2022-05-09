Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB94B51F544
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiEIHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiEIHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:10:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79A3129C46;
        Mon,  9 May 2022 00:06:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so13020782plg.5;
        Mon, 09 May 2022 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TpYwJcXRaIAY1k5rPDvLOqhWDmi+BbqeQlb+s24HDcw=;
        b=Vis/qG7syPrRj7MJmr6XusGF1w0FsYmjRQUKo6AxzIX9iTBhKUjgYVt9/JJ5VKV5OB
         dhGhVmgLhyzSqajb4MCy+yNTpoOYteyKktq+Q47v2xLAo9dskJU6W2j5Bl8jSLm1cGKw
         i+PxumYQ+2RGd7w6j12wwg5S8balfnuUsBxjDB52+olz7KM8lC43LRUpxBSm6ligrDSO
         He3RCMi36ZQgrys5AK2JZusAfQzytIywDuKyKcLA/6ErbTVVX3LjLkMqlEn1i8XHQAOJ
         9mksis1hjztmQy7GTasflBTkR5t2yxS3qOO2asvVYuJRwZpkiA02sZBhfIggI4cIpBI2
         Rs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TpYwJcXRaIAY1k5rPDvLOqhWDmi+BbqeQlb+s24HDcw=;
        b=aObjCDqQZ/sQEk6BFpA0w5z4qWurcWW+brXEBW7Tr3Ub5fEjzpF8P4hKeS1E2isA5x
         UcqyB+P8JUXyMEjjngk5tVWpQhMyv41tO3TfuMVZvtrW1/2GkeaYz0gmtkTkVU2Qk8QO
         JdDIzbCfffJtsGmekPkq5Buq9sgnDlkcnCkWSYoYU1LBS2hceWAXlzetnRMFoe9kjN8L
         AtPUDjTxKgUwmA+VRyMVYb1HV6rcysqw7EJNiFT7T7XsHa8264HXaOAt/4AJfBQkTa1U
         j0sLomTvsovSpb0OJsYtLPE7wuEERa5IDGfKlsaPDwl1YLExGbJulFvCF5ozZEIKTA4I
         eG9w==
X-Gm-Message-State: AOAM531k2Y4ATqjOM6QUktIzrTfxScCFZCndwBuFAkxED+x5qriQGM4K
        dL4FExeYXRLNzCNnfRbv00Q=
X-Google-Smtp-Source: ABdhPJwMFMWeKl+V8HsC0r0UdnVtNqwrvhckrl6oIpafBmg/UzA8AVCYLe6eHSuPGqYHGYs8PBntSA==
X-Received: by 2002:a17:90b:3686:b0:1dd:1c31:50cb with SMTP id mj6-20020a17090b368600b001dd1c3150cbmr3286453pjb.203.1652079941283;
        Mon, 09 May 2022 00:05:41 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.86])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902cf0600b0015e8d4eb2e1sm6250768plg.299.2022.05.09.00.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:05:40 -0700 (PDT)
Message-ID: <c313e9c9-97eb-8273-5bb7-553692e8e2f5@gmail.com>
Date:   Mon, 9 May 2022 15:05:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 5/7] perf/x86/amd/core: Add PerfMonV2 counter control
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, eranian@google.com,
        puwen@hygon.cn, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org
References: <cover.1651058600.git.sandipan.das@amd.com>
 <5c30d99af03fff90e2fc3165755d18d14bdb229f.1651058600.git.sandipan.das@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <5c30d99af03fff90e2fc3165755d18d14bdb229f.1651058600.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/4/2022 7:31 pm, Sandipan Das wrote:

>   static void amd_pmu_add_event(struct perf_event *event)
>   {
>   	if (needs_branch_stack(event))
> @@ -1216,6 +1251,11 @@ static int __init amd_core_pmu_init(void)
>   		x86_pmu.num_counters = ebx.split.num_core_pmc;
>   
>   		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
> +
> +		/* Update PMC handling functions */
> +		x86_pmu.enable_all = amd_pmu_v2_enable_all;
> +		x86_pmu.disable_all = amd_pmu_v2_disable_all;
> +		x86_pmu.enable = amd_pmu_v2_enable_event;
>   	}

Considering the below part of code also run on the PerfMonV2 host

whatever the guest PMU version, how about updating these two use cases as well 
in this patch ?

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 262e39a85031..2f7c62e46314 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1469,8 +1469,8 @@ void amd_pmu_enable_virt(void)
         cpuc->perf_ctr_virt_mask = 0;

         /* Reload all events */
-       amd_pmu_disable_all();
-       x86_pmu_enable_all(0);
+       amd_pmu.disable_all();
+       amd_pmu.enable_all(0);
  }
  EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);

@@ -1487,7 +1487,7 @@ void amd_pmu_disable_virt(void)
         cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;

         /* Reload all events */
-       amd_pmu_disable_all();
-       x86_pmu_enable_all(0);
+       amd_pmu.disable_all();
+       amd_pmu.enable_all(0);
  }
  EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);

