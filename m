Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF17591C39
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 20:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiHMSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiHMSOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 14:14:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7760DB;
        Sat, 13 Aug 2022 11:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F844CE000E;
        Sat, 13 Aug 2022 18:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B626EC433C1;
        Sat, 13 Aug 2022 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660414486;
        bh=+yiqdsU0Imf8eqgPn2U6dRNCCevyfDmOyoyNnODKtSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfvYUJa7ti/QD7RdrXS/V1jmPUuhPiVTAA30oDrErlD81iMH3gP9lCRXgsDXn/tnC
         RqSRW0MOFfnCfi/D0Vvg+KFt+/jxD3sUsDtPoNp8VZeZUS0dDcG5ziYr5ucFThjFST
         uFRZaxd4b+Jc7YPiKEDsPip/XbSER822vE9rlYdX1Rqt0zRHljbNgl0093V6fIG7dh
         HRClc0r68wQ1UjY9DVjlccro2JAJaeGM44E5E/mkuUW2hadtRR9RbKnL+n6+o4seD8
         H2V1PWFOW/hTClDaDXg3ptH1IdkIC7vIYGkR9YysKZAiMxqs1zZ9GuvjKBnBqSxdPy
         BK8suhXQNlKXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A82C4035A; Sat, 13 Aug 2022 15:14:44 -0300 (-03)
Date:   Sat, 13 Aug 2022 15:14:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <YvfqFF/l07BCpZRJ@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <Yvaj2ukXV+SLIBR0@kernel.org>
 <20220813141739.GB687527@leoy-huanghe.lan>
 <YvfpCnZ30tKFBfG+@kernel.org>
 <YvfpS+Lc/cI8BCg2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvfpS+Lc/cI8BCg2@kernel.org>
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

Em Sat, Aug 13, 2022 at 03:11:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Patch failed at 0003 perf test: Add build infra for perf test tools for CoreSight tests
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf]$
> 
> Fixing...

So, the first patch is merged, I now have to do the test builds to get
what I have out to Linus, which will probably closed the merge window
tomorrow, we can continue after that.

- Arnaldo
