Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD44E491E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiCVW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCVW04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:26:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245155FDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eovEULQEtS4IdiH2X4rLza7n8ELjkv/QjM+V7uK+7fE=; b=bnzkSlKmoegZQal9eq4WRnfrF7
        ErKu7+9xgc0b6+vxkkrSQtEv8hg6b4//HkBa4pUFTUyVM0qYYjprX4a/WUNnYdapLfTIdqyUOJTdF
        NbXWmYCZ5mB64t/qkPw00QKjod2qtFMlEMaam+/6/Q1GxBo8XNRMDhKggxXUMYb3xw0JTzMCXpuhA
        QqeIR6iB1E34oDkeZqDQ/0XcdUHJlfuyUmyuQgUl85/MgC8+/HF5YYa4//BzdDiI7l1qPWj+0GvU7
        /KwPpGU4rd9usZ3WcyxJ75uOnZlU5jm6C1EI0xiye+wAIx9AKvNj8L5q1r0aS6HL6p/cqPr8N/kqp
        jV8/jPtw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWmwC-003a9a-DV; Tue, 22 Mar 2022 22:25:12 +0000
Message-ID: <32f48850-c72d-a551-8383-b2ad344c38d3@infradead.org>
Date:   Tue, 22 Mar 2022 15:25:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf: RISC-V: Remove non-kernel-doc ** comments
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, Atish Patra <atishp@rivosinc.com>
Cc:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220322220147.11407-1-palmer@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220322220147.11407-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 15:01, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This will presumably trip up some tools that try to parse the comments
> as kernel doc when they're not.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> 
> --
> 
> These recently landed in for-next, but I'm trying to avoid rewriting
> history as there's a lot in flight right now.
> ---
>  drivers/perf/riscv_pmu_sbi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a1317a483512..dca3537a8dcc 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -35,7 +35,7 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> -/**
> +/*
>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
>   */
> @@ -477,7 +477,7 @@ static int pmu_sbi_get_ctrinfo(int nctr)
>  
>  static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>  {
> -	/**
> +	/*
>  	 * No need to check the error because we are disabling all the counters
>  	 * which may include counters that are not enabled yet.
>  	 */
> @@ -494,7 +494,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
>  }
>  
> -/**
> +/*
>   * This function starts all the used counters in two step approach.
>   * Any counter that did not overflow can be start in a single step
>   * while the overflowed counters need to be started with updated initialization
> @@ -563,7 +563,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	/* Overflow status register should only be read after counter are stopped */
>  	overflow = csr_read(CSR_SSCOUNTOVF);
>  
> -	/**
> +	/*
>  	 * Overflow interrupt pending bit should only be cleared after stopping
>  	 * all the counters to avoid any race condition.
>  	 */

-- 
~Randy
