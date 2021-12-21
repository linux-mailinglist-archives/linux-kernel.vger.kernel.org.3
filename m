Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E083D47BFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhLUMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhLUMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:35:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:35:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 196so8075435pfw.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTT5av30welrAQociU+K66RmzZ+DJnHIsmg9e3wmBps=;
        b=TFpvemmyv/CvZRAmXNze6BQV70FOWYvww9WwgfIqJZ7F+2JAzf6epiZvv+XTm82isn
         uuFQ1K9UXqMQaPanANaiBArArrHlDC9nRvm/pL4M1ClRQtT+DielUbvXPPPQUKqIBQTD
         sUFDMTCAIIsH5u2pvtWIZ6O8gemQ9HrAqsQtspwxzdAHh1gMh90trD5xub/dyxsVvsiC
         jnnVIsLXp9+H9/1zhk1yvdRAi5RzTqw9w/kMroLzEifazKRz5E7sjyyAq5otEcv0x3X8
         hbQgYl2Yeo1U2XARtGP1L38N4LEAlgTMA2RZo4B6NdtbAlVFSY7Ugaa6tklYps1zfOlX
         C+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTT5av30welrAQociU+K66RmzZ+DJnHIsmg9e3wmBps=;
        b=Xy7Y0bcCYbGCwOZ7zX/UEyfRCgUxB17Y6RBhbSlEnJJKWxpgh1rC/DdvtGY8IjHkaQ
         inLpuBPfw9dBMWsP/+1cfNr1t3Gh8TmUTScp4wPHIi2aWs5x72VkrwvPbjza2TR3G7/B
         2F1l+50BeCdLBBfXjHukSWERQGi9QTYQjGarjsW3h+4AleOJqcGBbTUp0z4y7ucOTWem
         bc1+LafTmWUbSPCyc8BYv2SMOeTzcN4+dizq8+gDOLs4nTqqdOTt+oFyKHmGVKUUA96g
         oOtu+nq1muSL1FtWdelE0L4C6hviMB/Pomp2/4nDCD5u4X4+s67QRAxLaDCKLuOxI/eA
         LeWQ==
X-Gm-Message-State: AOAM531pf4CPv2DyA9p/VUOHvZro6ZNvofIKHSNfJ+czqROqQrjVz+JU
        n3bOwcpDBzV5yjQg76wnbThjjg==
X-Google-Smtp-Source: ABdhPJz1V+kAEZ4kHZEjM+OeuBUMj/EQb4RhfdnKvU/jqZLgEPpyhanqfeYjPi62LcYapxGYyeI+Lg==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr2717264pgk.393.1640090147302;
        Tue, 21 Dec 2021 04:35:47 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f15sm23320988pfe.171.2021.12.21.04.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:35:46 -0800 (PST)
Date:   Tue, 21 Dec 2021 20:35:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, inux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 03/12] perf test: Use 3 digits for test numbering now we
 can have more tests
Message-ID: <20211221123540.GA41974@leoy-ThinkPad-X240s>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-3-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215160403.69264-3-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 04:03:54PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> This is in preparation for adding more tests that will need the test
> number to be 3 digts so they align nicely in the output.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/tests/builtin-test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 849737ead9fd..8652dcc4912c 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -435,7 +435,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>  			continue;
>  
>  		st.file = ent->d_name;
> -		pr_info("%2d: %-*s:", i, width, test_suite.desc);
> +		pr_info("%3d: %-*s:", i, width, test_suite.desc);
>  
>  		if (intlist__find(skiplist, i)) {
>  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> @@ -485,7 +485,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  				continue;
>  		}
>  
> -		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
> +		pr_info("%3d: %-*s:", i, width, test_description(t, -1));
>  
>  		if (intlist__find(skiplist, i)) {
>  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> @@ -525,7 +525,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
>  							curr, argc, argv))
>  					continue;
>  
> -				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
> +				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
>  					test_description(t, subi));
>  				test_and_print(t, subi);
>  			}
> @@ -560,7 +560,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
>  		if (!perf_test__matches(t.desc, curr, argc, argv))
>  			continue;
>  
> -		pr_info("%2d: %s\n", i, t.desc);
> +		pr_info("%3d: %s\n", i, t.desc);
>  
>  	}
>  
> @@ -582,14 +582,14 @@ static int perf_test__list(int argc, const char **argv)
>  		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
>  			continue;
>  
> -		pr_info("%2d: %s\n", i, test_description(t, -1));
> +		pr_info("%3d: %s\n", i, test_description(t, -1));
>  
>  		if (has_subtests(t)) {
>  			int subn = num_subtests(t);
>  			int subi;
>  
>  			for (subi = 0; subi < subn; subi++)
> -				pr_info("%2d:%1d: %s\n", i, subi + 1,
> +				pr_info("%3d:%1d: %s\n", i, subi + 1,
>  					test_description(t, subi));
>  		}
>  	}
> -- 
> 2.32.0
> 
