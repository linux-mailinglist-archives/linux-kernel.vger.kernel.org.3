Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF42F4E8145
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiCZOBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiCZOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:01:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B7E7287;
        Sat, 26 Mar 2022 07:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2FB1B80092;
        Sat, 26 Mar 2022 14:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDACC340F0;
        Sat, 26 Mar 2022 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648303199;
        bh=OtwUQSJIfqGM9pSzRByk+oWkJW2rmWs3VVB7YTz1NQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUfg2O3KFWxiG7Rmv+kKdymq+2eWH7ZgaIWHVqFV922+rsPsgzBacFGtkZWsY/IfG
         La4L/S8E7+DIYrRaYq1OR3U9zLGE8iVj/fCxvxI93hNQSpAQZKwPz9H1N5jQ/5oUIa
         +M/kMGtYuLYDCAOQYMOYazxCppd4GPQ7bhTpxsDvq0idwb1XlLyZ43pLK4qda0eT7H
         AwAnQKUjh84d6VuQSHfrwje++GB9hGrXZaym2ZziUm/haUQ4ct8IeTfakm0awC0DrC
         +KVVp6ARgLdtr9ZNmfuPRZ0rHxw84WkrL6/QGRcfGADSBKNtVjEIF4SFRZVNSuFGiH
         wBixgZzoFUuEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4206640407; Sat, 26 Mar 2022 10:59:57 -0300 (-03)
Date:   Sat, 26 Mar 2022 10:59:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 1/4] tools: arm64: Import cputype.h
Message-ID: <Yj8cXWaQr1rXnvF8@kernel.org>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-2-alisaidi@amazon.com>
 <Yj4McMHsxtJ3PfKk@kernel.org>
 <Yj4bKHrmKhujZdpj@kernel.org>
 <20220326054956.GB20556@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326054956.GB20556@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 26, 2022 at 01:49:56PM +0800, Leo Yan escreveu:
> Hi Arnaldo, Ali,
> 
> On Fri, Mar 25, 2022 at 04:42:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 25, 2022 at 03:39:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Mar 24, 2022 at 06:33:20PM +0000, Ali Saidi escreveu:
> > > > Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> > > > for arm64 to make use of all the core-type definitions in perf.
> > 
> > > > Replace sysreg.h with the version already imported into tools/.
> >  
> > > You forgot to add it to tools/perf/check-headers.sh so that we get
> > > notificed when the original file in the kernel sources gets updated, so
> > > that we can check if this needs any tooling adjustments.
> >  
> > > I'll add the entry together with the waiver for this specific
> > > difference.
> > 
> > This:
> > 
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index 30ecf3a0f68b6830..6ee44b18c6b57cf1 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -146,6 +146,7 @@ done
> >  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
> >  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
> >  check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
> > +check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
> >  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
> >  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
> >  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
> 
> LGTM.  I did the testing on both my x86 and Arm64 platforms, thanks for
> the fixing up.

Thanks, adding a:

Tested-by: Leo Yan <leo.yan@linaro.org>

- Arnaldo
