Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F44B71BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiBOPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:07:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiBOPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:07:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B3F7A;
        Tue, 15 Feb 2022 07:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538DBB81ABE;
        Tue, 15 Feb 2022 15:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57FFC340EB;
        Tue, 15 Feb 2022 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644937661;
        bh=C7xNWmNB8I2rrsRZNyUMx4Ydc0DZnMgDAkd7yvuIAVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He9Y/OSYServspfit+tsUU2pbQkfJozuFAfVqhZUxqQqWj6HGkIMyy9krnyIz5884
         rF+sIOsmlJVM1O8KtzCUFoT5RTG61sbcW3VB1u1jF7le6rdiqahb4cACeQpyKJ+r0l
         eU4xirlcN5m8EeTTEjNVMfVdagFpWtYxM4C0hge0aljWeeha6lNV27xgyLjKxOz+ZC
         sZDE1GR2FA2HHiPJrDGYfPFzBQM+s8kbylXv/jQD3S1syD9DgkzeUfyb6i7TVvbioe
         p66l00ZhRDXPLc/qf6K2/JUz1Zn+bsbC1pEk7+UaQNPPo84SLB2dGcdwnKbXwgrbSD
         Wxh+lZQXR5VNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB795400FE; Tue, 15 Feb 2022 12:07:38 -0300 (-03)
Date:   Tue, 15 Feb 2022 12:07:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: cs-etm: No-op refactor of synth opt usage
Message-ID: <YgvBuqxA/FWsNh1d@kernel.org>
References: <20220210200620.1227232-1-james.clark@arm.com>
 <20220211152026.GC475776@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211152026.GC475776@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 11:20:26PM +0800, Leo Yan escreveu:
> On Thu, Feb 10, 2022 at 08:06:19PM +0000, James Clark wrote:
> > sample_branches and sample_instructions are already saved in the
> > synth_opts struct. Other usages like synth_opts.last_branch don't save
> > a value, so make this more consistent by always going through synth_opts
> > and not saving duplicate values.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> The patch looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>


Thanks, applied.

- Arnaldo
