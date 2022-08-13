Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715A591C38
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiHMSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239951AbiHMSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:11:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3D60D4;
        Sat, 13 Aug 2022 11:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A8E6B8069F;
        Sat, 13 Aug 2022 18:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61C8C433C1;
        Sat, 13 Aug 2022 18:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660414286;
        bh=R+sHRHJ+FydUbrZnKVvnVZRYfXdSBTppYcgv1s7lKPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEs9nsUEQMleVFfqXBIT8fcq36bkmL/lMBp2yp+F2+RQcTzRn/9Nxw8Zsp6ce32Ov
         uJOwkkKSUYzf1yZRJsPyS1Enz7bwUIN2A7UkCRXRcg+fLdHJB9YNM7u2zw1J4LCW+1
         sCyssXpHnGpoYLMeuCNnzXv/7mcOTvfnkxGo2dGreYvOYWVBcdKf3TnupFPOO9xZJb
         geeTMLT1RvmiEWEpwXwTRV8/6rZKQCvWfXzgbgMiOkRuM1viw42YG0CcWfZen+72aW
         ku+kMkfHbck27pBZ+IDBLL+HMVS+R/rEnm0NJiEJW8AA2lkjg9cdbBIWOr3tzbKxZy
         532p8LPq5gyDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C7784035A; Sat, 13 Aug 2022 15:11:23 -0300 (-03)
Date:   Sat, 13 Aug 2022 15:11:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <YvfpS+Lc/cI8BCg2@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <Yvaj2ukXV+SLIBR0@kernel.org>
 <20220813141739.GB687527@leoy-huanghe.lan>
 <YvfpCnZ30tKFBfG+@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvfpCnZ30tKFBfG+@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 13, 2022 at 03:10:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Aug 13, 2022 at 10:17:39PM +0800, Leo Yan escreveu:
> > On Fri, Aug 12, 2022 at 04:02:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > So with fixing the merging conflict:
> > 
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
>   [PATCH v7 14/14] perf test: Add relevant documentation about CoreSight testing
>     + Tested-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
>     + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
> ---
> Total patches: 14
> ---
> NOTE: some trailers ignored due to from/email mismatches:
>     ! Trailer: Link: https://lore.kernel.org/r/20220728145256.2985298-1-carsten.haitzler@foss.arm.com
>      Msg From: Arnaldo Carvalho de Melo <acme@kernel.org>
> NOTE: Rerun with -S to apply them anyway
> ---
> Cover: ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.cover
>  Link: https://lore.kernel.org/r/20220812121641.336465-1-carsten.haitzler@foss.arm.com
>  Base: not specified
>        git am ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.mbx
> ⬢[acme@toolbox perf]$        git am ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.mbx
> Applying: perf test: Refactor shell tests allowing subdirs
> .git/rebase-apply/patch:56: trailing whitespace.
> /*
> warning: 1 line adds whitespace errors.
> tools/perf/tests/builtin-test-list.c:29: trailing whitespace.
> +/*
> ⬢[acme@toolbox perf]$
> 
> 
> Fixing... 

After that:

⬢[acme@toolbox perf]$        git am ./v7_20220812_carsten_haitzler_perf_test_add_trace_data_quality_tests_for_coresight.mbx
Applying: perf test: Refactor shell tests allowing subdirs
Applying: perf test: Add CoreSight shell lib shared code for future tests
Applying: perf test: Add build infra for perf test tools for CoreSight tests
error: patch failed: tools/perf/Makefile.perf:1015
error: tools/perf/Makefile.perf: patch does not apply
.git/rebase-apply/patch:109: new blank line at EOF.
+
Patch failed at 0003 perf test: Add build infra for perf test tools for CoreSight tests
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$

Fixing...
