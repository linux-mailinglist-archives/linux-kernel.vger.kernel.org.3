Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBD535937
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiE0GTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiE0GTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:19:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9E674F0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:19:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a13so3321951plh.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YmwNb7GmrMj+Aj35yVXxyxMSFu/WwxZF0+SnvsJ3ZBc=;
        b=FzUlge1dsiQ6u9tgG56Pfq2xP/PEWoglv6yK0nFxU8GkPm7H/d8o3U5dM9cYHb4B67
         +dfLCEGA2ux9VbPFR4jvktJK7Xk8temg1Ueb2KBaK0/HqHpIFgiMJJfWvoPmoLs3DCJ+
         AXp6969Vphe4sM0QHM4A21a8UUt+O4XcgwkjxGgyDZpSV5cCUHAS7M8599NmAEaVOpjK
         SB/l5mCHtxYBppDKeTjEh6JahyN7NnT3AbE1i+8pY6ZMR5XcjGtGU/XGdJW2+Qe1cYnn
         ReN+KxESb/+a0AuE2xXATd4lYeGRk+HcY9yqpgQefmLAvGQPZpyTtizW9oFy7WQiOsoO
         a0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YmwNb7GmrMj+Aj35yVXxyxMSFu/WwxZF0+SnvsJ3ZBc=;
        b=B547e8ygYZmkjWqRzmimJaMPRiOVNTi8pSkca6IUpJPbtlqNkLGvpC1SJXsBEc8o9i
         FoC8Bb7DtnIEEjhlim5HkRVKKyjpYu7UOPWeUetbsXnzqY8tIjM1ZQdLC0VyS6MP7qnW
         dsjAWDxIRNuefyxr3gjVzy3ZeEhNJj+6/0LNVy6qMKhHFqUFk6BWUB1rB29wm0TIsoEO
         2HLoHz30KZhY9bTmIQHrak//Di/6yps/ke8vXGEMyBrxpDToIZjGXEU5qnIcgQ6gSg4t
         3ZvAOdksKMzna4Q9dIXP4+IJLWr7JNHaV+CvhG/6JI8Vx7RMBGZ5G6DcgvkDDDMv1eF5
         jaqA==
X-Gm-Message-State: AOAM5320qRVjB8/xRAWQo/7uNwVI9K8mlVDgk9718+9T83dxWGHulI+o
        RxgXZ9r+JuBnXoOhAx9OBtE37w==
X-Google-Smtp-Source: ABdhPJwqhqEGd9W8CmvrTs80ShemtIPeUuS1DxDxJentbUWgEs/zUXhACYfIaks1ckbEKdUM/Z1qTA==
X-Received: by 2002:a17:902:7004:b0:161:f216:4f3f with SMTP id y4-20020a170902700400b00161f2164f3fmr34842103plk.98.1653632341007;
        Thu, 26 May 2022 23:19:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id p6-20020a62ab06000000b0051843980605sm2550902pff.181.2022.05.26.23.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 23:19:00 -0700 (PDT)
Date:   Fri, 27 May 2022 14:18:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        german.gomez@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <20220527061854.GA829807@leoy-ThinkPad-X240s>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-5-james.clark@arm.com>
 <Yo+gYbLNnYGOPzGs@kernel.org>
 <Yo/EytFDKnOEiWCa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo/EytFDKnOEiWCa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 03:19:54PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Too old to support?
> 
>   69     7.19 ubuntu:16.04-x-arm64          : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
>     arch/arm64/util/perf_regs.c: In function 'arch__user_reg_mask':
>     arch/arm64/util/perf_regs.c:151:28: error: 'HWCAP_SVE' undeclared (first use in this function)
>       if (getauxval(AT_HWCAP) & HWCAP_SVE)
>                                 ^
>     arch/arm64/util/perf_regs.c:151:28: note: each undeclared identifier is reported only once for each function it appears in
>     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'util' failed
>     make[5]: *** [util] Error 2
>     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arm64' failed
>     make[4]: *** [arm64] Error 2
>     /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
>     make[3]: *** [arch] Error 2
> 
> 
> ⬢[acme@toolbox perf]$ find . -name "*.h" | xargs grep -w HWCAP_SVE
> ./arch/arm64/include/uapi/asm/hwcap.h:#define HWCAP_SVE		(1 << 22)
> ⬢[acme@toolbox perf]$ 

I tested aarch64 GCC-7.4.1 which doesn't support HWCAP_SVE, but
aarch64 GCC-8.3.0 and GCC-9.4.0 support it.

Either we can add below code:

  #ifndef HWCAP_SVE
  #define HWCAP_SVE		(1 << 22)
  #endif

Or directly include header file <.../asm/hwcap.h>.

Not sure which method is preferred.  Maybe the first approach can be
de-couple with Linux kernel code?

Thanks,
Leo
