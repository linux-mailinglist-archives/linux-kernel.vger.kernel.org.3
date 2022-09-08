Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4D5B21E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiIHPUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiIHPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855549B40;
        Thu,  8 Sep 2022 08:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B2D61D52;
        Thu,  8 Sep 2022 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96112C433C1;
        Thu,  8 Sep 2022 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662650421;
        bh=9rwo6DpUJrmMV35qND1EFSDHN+K75sepibyztupsdGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqrDksBflFye4sWMwGBJ6usvEs8IAQA1JOhmLbMvPS8qxUJwCxbkF+352CcJa/m+M
         zRqKLFzLbRHbRcuUMY+RVn1CERG5sig0m1Lh2I7fE7wQdPr26bVfeoNf21WgzI/tIJ
         X94vntR1pT3TrNzP7o5yubq8ph1lRNzy/yX1ykj/VzoeZmD/1Xe46pzETGgnZpCFLV
         MmmNeX2NaauRq7z/VHnZSQse7L9Z9fcMlheHPsNaIUdEiTHOtKO01RVZjY1hnfNBeZ
         Ri7hMyZukRguyNFHnl3f4JwHeUvJDycC6FLX42JwTteaansBi7YIZ61Tbd1VOmU49U
         F/8qoE0u7BczQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D1AB404A1; Thu,  8 Sep 2022 12:20:19 -0300 (-03)
Date:   Thu, 8 Sep 2022 12:20:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events arm64: Move REMOTE_ACCESS to "memory"
 category
Message-ID: <YxoIMxKp7OyrU286@kernel.org>
References: <20220908112519.64614-1-nick.forrington@arm.com>
 <39abfee9-4a9b-ec44-9b02-a6cd34cfe64d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39abfee9-4a9b-ec44-9b02-a6cd34cfe64d@huawei.com>
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

Em Thu, Sep 08, 2022 at 12:47:47PM +0100, John Garry escreveu:
> On 08/09/2022 12:25, Nick Forrington wrote:
> > Move REMOTE_ACCESS event from other.json to memory.json for Neoverse
> > CPUs. This is consistent with other Arm (Cortex) CPUs.
> > 
> > Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, queued up for 6.1.

- Arnaldo
