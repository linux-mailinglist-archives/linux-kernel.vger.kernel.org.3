Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082A4E7C9B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiCYT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiCYT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:26:17 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6EE2A1299;
        Fri, 25 Mar 2022 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648234717; x=1679770717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sP6GOjaZB5ZelmcgJTjP90zeki4v/xwCLzFSvg0IkWM=;
  b=KlcwtdrOQF5Bwpz/DfMc3Xst1yP00HXatNDDRf7GG3J1BbjC1FflpgMf
   Wsz/DmoZVP53WEjUfy1r9j10i675+LFIDaEWr6ddYVF/b0DEIDcId/ZG5
   hsskWUy93/bgQylSGATerh1dA7PIFV+xzOjbqKjnIQjFqUhgovNpBayWt
   0=;
X-IronPort-AV: E=Sophos;i="5.90,211,1643673600"; 
   d="scan'208";a="189252095"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 25 Mar 2022 18:58:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-b48bc93b.us-east-1.amazon.com (Postfix) with ESMTPS id 4D930C09C0;
        Fri, 25 Mar 2022 18:58:35 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 25 Mar 2022 18:58:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 25 Mar 2022 18:58:34 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 25 Mar 2022 18:58:34
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 1352D2569; Fri, 25 Mar 2022 18:58:33 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <acme@kernel.org>
CC:     <Nick.Forrington@arm.com>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <german.gomez@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <leo.yan@linaro.org>,
        <lihuafei1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH v4 1/4] tools: arm64: Import cputype.h
Date:   Fri, 25 Mar 2022 18:58:28 +0000
Message-ID: <20220325185828.25461-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Yj4McMHsxtJ3PfKk@kernel.org>
References: <Yj4McMHsxtJ3PfKk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,

On Fri, 25 Mar 2022 18:39:44 -0000, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 24, 2022 at 06:33:20PM +0000, Ali Saidi escreveu:
> > Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> > for arm64 to make use of all the core-type definitions in perf.
> >
> > Replace sysreg.h with the version already imported into tools/.
> 
> You forgot to add it to tools/perf/check-headers.sh so that we get
> notificed when the original file in the kernel sources gets updated, so
> that we can check if this needs any tooling adjustments.

Sorry.

> ⬢[acme@toolbox perf]$ diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> --- tools/arch/arm64/include/asm/cputype.h	2022-03-25 15:29:41.185173403 -0300
> +++ arch/arm64/include/asm/cputype.h	2022-03-22 17:52:10.881311839 -0300
> @@ -170,7 +170,7 @@
> 
>  #ifndef __ASSEMBLY__
> 
> -#include "sysreg.h"
> +#include <asm/sysreg.h>
> 
>  #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
> 
> ⬢[acme@toolbox perf]$
> 
> 
> I'll add the entry together with the waiver for this specific
> difference.

Thank you! 

It looks like it's been missed several times:
% find  tools/arch/arm64 -type f
tools/arch/arm64/include/uapi/asm/unistd.h
tools/arch/arm64/include/uapi/asm/bpf_perf_event.h
tools/arch/arm64/include/uapi/asm/kvm.h
tools/arch/arm64/include/uapi/asm/mman.h
tools/arch/arm64/include/uapi/asm/perf_regs.h
tools/arch/arm64/include/uapi/asm/bitsperlong.h
tools/arch/arm64/include/asm/barrier.h
tools/arch/arm64/include/asm/cputype.h
tools/arch/arm64/include/asm/sysreg.h

% grep arm64 tools/perf/check-headers.sh
arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/kvm.h
arch/arm64/include/uapi/asm/unistd.h


Thanks,
Ali

