Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE01529FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbiEQKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344690AbiEQKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:50:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097D36317
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:50:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so2098928pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVR6zNLI+c0k/X+csgUVN8nm7PvvodORekMaxXxc1M0=;
        b=P2qf7Qtgz9XAg7exjMtb8+M9Sz0eO/t+AfddkwEFhWXoNRj99c1cdjLjuh/0JEsXQQ
         dEsp4+DhbXW+qtdL1mcwW46guWWKLsujaG/UKrR1X03zrXbgN4RrR2vU+qzqQEJ59fQi
         s5vtF0YquujenckSNVmVwq36pv5QhYE5WUXR7LUOLCf8UpFsjf8nzHdAp/1BCCVygnqH
         IuoHakDVI4ykqxHBI9Fgp927b+FWf9Rfxjlnfz1ktQh+G+mkGGV9acXsQK8qXcDZBb3j
         LY1JeU3X2Ixd2FUjs7iER8Xag1kDOEv6loGhpWZNd2YECqd2RE39jSBpEiCs4GBe0pFB
         DSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVR6zNLI+c0k/X+csgUVN8nm7PvvodORekMaxXxc1M0=;
        b=P+DZnk9sPtscYyMM7drLJidcQ8BGStjxBWwKeMB6OJeVmS3lPKu4p4won6TwXMjcUB
         bJXiaK3Yruhs9H8JC1K/59EVQeX/nv2hv+gffRQ0DenLmNul3niwre9iyBNirIUSLAeS
         wWmQwyHq5U5WEObiw7YGZro5dsaFz8yZ3cNdd9mKICRZwtwbl4Xgfdqbms+3tlF16AZq
         5Np6JGI2eOmhOAwh3Km80eYVFaOccFH9YFQR+m/RcZWFE/DnahNi7eFD6ZUNpkle49Vo
         y00qqUJsHDmTD4xh1X2B/4X9kEZcUKuOTtCqNYniw45ELPMm+AEm6YYvLwwspLsU/nrI
         hfRQ==
X-Gm-Message-State: AOAM533V/hcO5BFU6+QTJg5gO6D0rjFmNfLSZ4X4Hltoi8TU+NZgj6vt
        F4FPL1+Yy9bx9LrWdZLfnJDlZg==
X-Google-Smtp-Source: ABdhPJzJrylNLgqRP10b0FK8mEviLe31EBXM9tkz9+Fpl4VtpNbhDD1nImE+3rO4hV1KxBwVXYjkqw==
X-Received: by 2002:a17:902:c7cd:b0:161:8b6f:73c3 with SMTP id r13-20020a170902c7cd00b001618b6f73c3mr7000127pla.156.1652784653611;
        Tue, 17 May 2022 03:50:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a858600b001df47e47d41sm1336540pjn.36.2022.05.17.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:50:53 -0700 (PDT)
Date:   Tue, 17 May 2022 18:50:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] perf tools: arm64: Copy perf_regs.h from the
 kernel
Message-ID: <20220517105045.GB153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-2-james.clark@arm.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:20:02AM +0100, James Clark wrote:
> Get the updated header for the newly added VG register.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/arch/arm64/include/uapi/asm/perf_regs.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> index d54daafa89e3..fd157f46727e 100644
> --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> @@ -36,6 +36,11 @@ enum perf_event_arm_regs {
>  	PERF_REG_ARM64_LR,
>  	PERF_REG_ARM64_SP,
>  	PERF_REG_ARM64_PC,
> -	PERF_REG_ARM64_MAX,
> +
> +	/* Extended/pseudo registers */
> +	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> +
> +	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> +	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
>  };
>  #endif /* _ASM_ARM64_PERF_REGS_H */
> -- 
> 2.28.0
> 
