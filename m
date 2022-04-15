Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E8502958
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352208AbiDOMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiDOMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:05:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64665BC849;
        Fri, 15 Apr 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXz8h1scW9TaC95RrqC3BatEUPCpcyZHs+jeJJAB5lU=; b=gFOAcBhkj7dshNd/gESsgNytg4
        +wU3qhVLguQMpX1gII8uGaCrIRVUdkQkAfLkT3dwLNwbnwuTisMgHOySrtixLlprqyVfkFiAUsORH
        43AdiJFu1Ai8Sj5bW8xCX2MqmldYa1XgaLVw3ttgKBhJ91Sie2BTohqEt4ILH0OmXiXDsZmkGcv8I
        h/5dVm+qBnH/miBdd9JQc1bWykYjsLqBmf6k7tkNHUJxH3OiT6Ili5cQ6FzcWHIY57PKvn4azoK4M
        u5pqrj1WycrHDjjMq582HbDlTY5KWsTYk/ogus3h/OMZ/PnftoW5z2Nz5X1swJOJu2mm550vvBeyA
        dYRI5J5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKf2-005ND4-Tv; Fri, 15 Apr 2022 12:02:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 306643001AD;
        Fri, 15 Apr 2022 14:02:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21D7330A3B95B; Fri, 15 Apr 2022 14:02:48 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:02:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        artem.bityutskiy@linux.intel.com
Subject: Re: [PATCH] perf/x86/cstate: Add SAPPHIRERAPIDS_X CPU support
Message-ID: <Ylle6DyUaPRnwfvQ@hirez.programming.kicks-ass.net>
References: <20220415104520.2737004-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415104520.2737004-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 06:45:20PM +0800, Zhang Rui wrote:
> From the perspective of Intel cstate residency counters,
> SAPPHIRERAPIDS_X is the same as ICELAKE_X.
> 
> Share the code with it. And update the comments for SAPPHIRERAPIDS_X.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
