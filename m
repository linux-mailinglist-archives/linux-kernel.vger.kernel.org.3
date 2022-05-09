Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17351FD7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiEINFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiEINFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:05:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8A23276A;
        Mon,  9 May 2022 06:01:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v11so12186586pff.6;
        Mon, 09 May 2022 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y1VOSZIWCzEJ86cq6oZntFD5lbrlVmxkCTqvxbTsuTg=;
        b=jgUIdCH57g47g1kCfaLFMEKd8m5jeXbyVawyaJj232M3GU+h8G3dL1Gk9v7nrMMpO2
         nn7aJa8eFXLCk5tZgGSnluGzwjVN7ZheU0rl8a/Ukt9+s2pknnBXAi4xVYXmkpNQmydg
         TeJjI/uce80Nd582K7gKB8G2av4nig3agDO/v6hJcHvfNCyeeUbxBeSZp5lkgnRwBalE
         q8VzetIqmsiXy+wmKubGCBPEa04ZjxSk9gUYSjqfYaa95+vPAPfu3u9jpS9lnU5lm0v3
         L1bOvrHFJzwCKQovFTQz/liWQ3pugbSfn5WPvY+/A1mgVs66yvqjhDT5tBygAs/Ej+1E
         6t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y1VOSZIWCzEJ86cq6oZntFD5lbrlVmxkCTqvxbTsuTg=;
        b=oxXYZd9P3gqy+Coy0L/kr6LPnNpDT6Qolb23/WTx6d5H0QflgJicZqdyoHRh4gEA5E
         8LhCchq/goQZSqlw6ScvHg5pcppyY9L9twuQf6Ejuf8LgQblqesRixkwAkJ9pDU/LAGm
         HZcSwMgJLfvNHqQOsNoxUdHRGiIlEUrZSVVGfoX+Yr3dwEmgv/H4RnlD+TD2iaaM9m5H
         nUIAHs+dohBqAhP5/UpCjVrJ1uLuB0BKfgDHwajzT9hNZa8A9qnPEDM3u6XitX/WS419
         qanA0xPb7mMOxWlVGV7XKSMlvkPizT0yhv6lPMI6hf4mqI2MSqZeTDa4GlKqTylK0mPz
         39Ig==
X-Gm-Message-State: AOAM533E6TgqmyQSdnhpH8PCfvhb6TVnMefOCT/y0rBNJafzzKELRVWc
        8QmLRUCBajyWBbtUuUH8zOA=
X-Google-Smtp-Source: ABdhPJwu0d4G31B2Ybkf88smk0c0f/5f3pumQ7oaxiA37CVPclKAOlLQKZhUVG8BH35wkrDcOq0vsQ==
X-Received: by 2002:a05:6a00:234f:b0:4f6:f0c0:ec68 with SMTP id j15-20020a056a00234f00b004f6f0c0ec68mr16349283pfj.14.1652101300366;
        Mon, 09 May 2022 06:01:40 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.89])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b003c6ab6ba06csm2891487pge.79.2022.05.09.06.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 06:01:39 -0700 (PDT)
Message-ID: <78e001bd-42bd-5481-5a19-1a0bcca9a63c@gmail.com>
Date:   Mon, 9 May 2022 21:01:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 3/7] perf/x86/amd/core: Detect PerfMonV2 support
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
 <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <8d3e23760726cf6647a98999e1fcd12a37f36a42.1651058600.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/4/2022 7:31 pm, Sandipan Das wrote:

>   	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;

Thus boot_cpu_has(X86_FEATURE_PERFCTR_CORE) is true.

> +
> +	/* Check for Performance Monitoring v2 support */
> +	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
> +		/* Update PMU version for later usage */
> +		x86_pmu.version = 2;

Is it safe to assume that once AMD CPU has the PERFMON_V2 (or further) bit,

it must also have the PERFCTR_CORE bit set ?

