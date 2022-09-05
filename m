Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F705ADA29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiIEU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiIEU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9946206;
        Mon,  5 Sep 2022 13:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA2CF601D7;
        Mon,  5 Sep 2022 20:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251C9C433D6;
        Mon,  5 Sep 2022 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662409587;
        bh=+4C412KxZfYefy4dDcrB2def8uvyyTv79FPUcv2LiQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYvyL1A/cBVw9wTGrnf74qHNPm0waJBMv7BZonZGTPRHvv3UETl6I+nm5SqeyBdzI
         JgbNOmiqSkihjhhEGxClv6hP1OwsfGNqXsI+JDSea3SNAOA0sxt5lXf9fvw1tzsQDM
         L8LX7wjP4wlZQ55buc9efe8mN58hVqD0EdP8NqXpWeYO1rehytCTOYOsOS1jSFjiRk
         b5siEOfjopt35Mg2kF4xcBe3EtTxzy66tY/WPSTGBfgYQ4i7xJ4O/UHarvZ7kHout7
         QlIfV3T7I1Y3hSAeKbYfkwFyM0eWeiVE3s4T8MdKWl9h8EX+XJkg4+AXBDGkgfWIxL
         shAZxLBEDCqrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5132404A1; Mon,  5 Sep 2022 17:26:24 -0300 (-03)
Date:   Mon, 5 Sep 2022 17:26:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf vendor events: Add missing Neoverse V1 events
Message-ID: <YxZbcOv7OcKO8SYs@kernel.org>
References: <20220905114024.7552-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905114024.7552-1-nick.forrington@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 05, 2022 at 12:40:24PM +0100, Nick Forrington escreveu:
> Based on updated data from:
> https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json
> 
> which is based on PMU event descriptions from the Arm Neoverse V1
> Technical Reference Manual.
> 
> This adds the following missing events:
> ASE_INST_SPEC
> SVE_INST_SPEC
> SVE_PRED_SPEC
> SVE_PRED_EMPTY_SPEC
> SVE_PRED_FULL_SPEC
> SVE_PRED_PARTIAL_SPEC
> SVE_LDFF_SPEC
> SVE_LDFF_FAULT_SPEC
> FP_SCALE_OPS_SPEC
> FP_FIXED_OPS_SPEC
> 
> Reviewed-by: John Garry <john.garry@huawei.com> 
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>



Thanks, applied.

- Arnaldo


> ---
> V1 -> V2: Remove REMOTE_ACCESS re-categorisation (to be submitted
> separately)
>  .../arm64/arm/neoverse-v1/instruction.json    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
> index 25825e14c535..e29b88fb7f24 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
> @@ -85,5 +85,35 @@
>      },
>      {
>          "ArchStdEvent": "RC_ST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_INST_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_FULL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDFF_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_SCALE_OPS_SPEC"
> +    },
> +    {
> +        "ArchStdEvent": "FP_FIXED_OPS_SPEC"
>      }
>  ]
> -- 
> 2.25.1

-- 

- Arnaldo
