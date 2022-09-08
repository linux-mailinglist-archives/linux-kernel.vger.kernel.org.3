Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE35B2599
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiIHSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIHSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:24:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49EF2945;
        Thu,  8 Sep 2022 11:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1ABFB821DB;
        Thu,  8 Sep 2022 18:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E836C433C1;
        Thu,  8 Sep 2022 18:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662661451;
        bh=i1IlDHKxy8OFtCHlFz7v4XemmtvEnPd4tiCVmhk3mn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vr2GLrF921V8MmUwFrNYq7iQ1vTMddvuKCjl9f36TMxcYKfxBr3ZWDuxkX21YydHw
         yo/zkFKT0aGGINn9VTK7guhq3Aa4KDYLsXAfxWBkWA12Dx7hn6lmRlgRHieORqeYkC
         hteaWd43wm6zAQ1VXwnBXd+Qpc70QXjOIrgf6CnozWq7EHz8P0L7LNW5F+4WiAHe8L
         ZfyroGiDv4q9aY5CxADOT4F6S9dmgF5l2OtemMrcrSP0is1/jeCRYiLXZ/7WDThn7O
         fyIhJzeGpzU5u3w1ExkqpRYhBF1rzF5waa31o0IE08UqZmPF1nbgCvlnYu3F2pSLoM
         nSKSxoph/ASUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4488404A1; Thu,  8 Sep 2022 15:24:08 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:24:08 -0300
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
Subject: Re: [PATCH] perf lock: Remove redundant word 'contention' in help
 message
Message-ID: <YxozSIIVx4UwseYS@kernel.org>
References: <20220908014854.151203-1-yangjihong1@huawei.com>
 <CAM9d7ciPd4vf3v1rdOD43vR-bh0pjj1LCcrMVTLfH6Fcxx_Dsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciPd4vf3v1rdOD43vR-bh0pjj1LCcrMVTLfH6Fcxx_Dsw@mail.gmail.com>
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

Em Wed, Sep 07, 2022 at 11:59:27PM -0700, Namhyung Kim escreveu:
> On Wed, Sep 7, 2022 at 6:52 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> > Fixes: 528b9cab3b81 ("perf lock: Add 'contention' subcommand")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Thanks for the fix!

Thanks, applied.

- Arnaldo

