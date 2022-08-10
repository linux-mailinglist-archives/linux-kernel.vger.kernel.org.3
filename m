Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5CC58ECE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiHJNQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiHJNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E81EED6;
        Wed, 10 Aug 2022 06:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E24B81C63;
        Wed, 10 Aug 2022 13:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B94C433C1;
        Wed, 10 Aug 2022 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660137371;
        bh=ezeEA0YXbh1OjCcYRsY0ygDvpE7j/uLUWBAGL1lNUSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaf9LIkj2AD4JYn9vqD1pL/bwYFMLYVyxzH7h0hKAFzGfiP09+sY/eSirVmNrzCeh
         NMXfnE54+GWUjcwoMVV40BhlC0Ch6itb5OhzkG4HTEtxRh0BPBC1BBazQXSFpkxeqc
         ZBcR601jyYDzXziRU1BdXOQY/fWp3JtPTjvAr42eB+mlqpRFqBK9G+9TvQyG88461M
         rNzR87e8pKLbe95/XXVU8/kQJuodtQMRSNa3AIbvRq0MUCtcf010DIHRXfloj7/g5n
         fgyJX2f8ywnXCuaAKrp7Z2DRYO7qnCS5AddgPPCM+lq1YUkfdi8k/vq2Nx/7BgzQgx
         idDM6XMBGFHBg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDD694035A; Wed, 10 Aug 2022 10:16:08 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:16:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] perf kvm/sched: Use strstarts instead of strncmp to
 match subcommands
Message-ID: <YvOvmBTT991n8suX@kernel.org>
References: <20220808092408.107399-1-yangjihong1@huawei.com>
 <CAM9d7cj3HcijAz_C1Y-u87H4XXeR4zW2TFQOxhmSjMuTqHQAzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj3HcijAz_C1Y-u87H4XXeR4zW2TFQOxhmSjMuTqHQAzA@mail.gmail.com>
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

Em Mon, Aug 08, 2022 at 02:22:22PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Mon, Aug 8, 2022 at 2:27 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > Yang Jihong (2):
> >   perf kvm: Fix subcommand matching error
> >   perf sched latency: Fix subcommand matching error
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

