Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136995915B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiHLSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiHLSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E92A19F;
        Fri, 12 Aug 2022 11:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9526178A;
        Fri, 12 Aug 2022 18:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6B1C433C1;
        Fri, 12 Aug 2022 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660330518;
        bh=sl0V2l9X7KY7mD8KVg8tW/Vg883/uuNXNxoi8bpdqkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBR3CE6UNMwea/iRAAIMionvI0Qtjeo1cZI6FsLdmMN8JRP8iSFwm4HXPDZSypLBn
         /16sz+d5toOMEYR3aqyoXxZw04uNhUosr99NxXi/BXVJr3F41EpI+IPiUY3NJFnall
         reJP1DQom12/C/GKqflQdi6r8yXoJzaXa8IBh7pYsvQhdTtFzWCsh2vgJqMFXQL6jV
         7w7UQWvAO+UpG8FEY/9z5g0pu1RINpEP5k4nRi7YzJtyKFx9tp16o7lRBpvEkobrTQ
         rb+8QOOt6zqGH7LizwN8WplMp77xyGIGIw5Dcqk9Xq1RzGX1W+frG5jkFJ/IzqBYNt
         jibqFKgeB6KSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B44C74035A; Fri, 12 Aug 2022 15:55:15 -0300 (-03)
Date:   Fri, 12 Aug 2022 15:55:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <YvaiE4w/Fb0XAmmM@kernel.org>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <YvahJcUNAZ0WC8fj@kernel.org>
 <YvahnOSyts95F8xm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvahnOSyts95F8xm@kernel.org>
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

Em Fri, Aug 12, 2022 at 03:53:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Aug 12, 2022 at 03:51:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > > previous older versions of test scripts that are editor backup files
> > > as well as skipping perf.data files that may appear and so on.
> 
> > > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> > On the next series, please add to the cover letter a summary of what
> > changed on each repost.
> 
> I also saw that several of your patches got reviewed and given
> "Reviewed-by" tags, so if some of the patches in the previous versions
> didn't change and received Reviewed-by tags, please collect them on the
> current version.

I tried getting v5 to see if b4 would find v6 and v7 and go on figuring
this out for us, but somehow it can't match v5 to v6 and v7:

⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers 20220728145256.2985298-1-carsten.haitzler@foss.arm.com
Grabbing thread from lore.kernel.org/all/20220728145256.2985298-1-carsten.haitzler%40foss.arm.com/t.mbox.gz
Checking for newer revisions on https://lore.kernel.org/all/
Analyzing 36 messages in the thread
('Reviewed-by', 'Leo Yan <leo.yan@linaro.org>', None)
Checking attestation on all messages, may take a moment...
---
  [PATCH v5 1/14] perf test: Refactor shell tests allowing subdirs
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 2/14] perf test: Add CoreSight shell lib shared code for future tests
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 3/14] perf test: Add build infra for perf test tools for CoreSight tests
  [PATCH v5 4/14] perf test: Add asm pureloop test tool
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 5/14] perf test: Add asm pureloop test shell script
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 6/14] perf test: Add git ignore for perf data generated by the CoreSight tests
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 7/14] perf test: Add memcpy thread test tool
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 8/14] perf test: Add memcpy thread test shell script
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 9/14] perf test: Add thread loop test tool
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 10/14] perf test: Add thread loop test shell scripts
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 11/14] perf test: Add unroll thread test tool
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 12/14] perf test: Add unroll thread test shell script
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 13/14] perf test: Add git ignore for tmp and output files of CoreSight tests
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
  [PATCH v5 14/14] perf test: Add relevant documentation about CoreSight testing
    + Reviewed-by: Mike Leach <mike.leach@linaro.org> (✓ DKIM/linaro.org)
    + Reviewed-by: Leo Yan <leo.yan@linaro.org> (✓ DKIM/linaro.org)
---
Total patches: 14
---
Cover: ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.cover
 Link: https://lore.kernel.org/r/20220728145256.2985298-1-carsten.haitzler@foss.arm.com
 Base: not specified
       git am ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.mbx
⬢[acme@toolbox perf]$

- Arnaldo
