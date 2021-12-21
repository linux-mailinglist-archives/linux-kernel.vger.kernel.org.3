Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1311247BF78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhLUMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLUMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:15:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A0C061574;
        Tue, 21 Dec 2021 04:15:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJFlT4lm0z4xbd;
        Tue, 21 Dec 2021 23:15:17 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     ak@linux.intel.com, Kajol Jain <kjain@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, acme@kernel.org, mpe@ellerman.id.au,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, jolsa@kernel.org, peterz@infradead.org
Cc:     alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, ast@kernel.org, daniel@iogearbox.net,
        rnsastry@linux.ibm.com, songliubraving@fb.com,
        mark.rutland@arm.com, yao.jin@linux.intel.com, paulus@samba.org
In-Reply-To: <20211206091749.87585-1-kjain@linux.ibm.com>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
Subject: Re: [PATCH 0/4] perf: Add new macros for mem_hops field
Message-Id: <164008884985.2078648.16441657679018856536.b4-ty@ellerman.id.au>
Date:   Tue, 21 Dec 2021 23:14:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 14:47:45 +0530, Kajol Jain wrote:
> Patchset adds new macros for mem_hops field which can be
> used to represent remote-node, socket and board level details.
> 
> Currently the code had macro for HOPS_0, which corresponds
> to data coming from another core but same node.
> Add new macros for HOPS_1 to HOPS_3 to represent
> remote-node, socket and board level data.
> 
> [...]

Patches 1, 3 and 4 applied to powerpc/next.

[1/4] perf: Add new macros for mem_hops field
      https://git.kernel.org/powerpc/c/cb1c4aba055f928ffae0c868e8dfe08eeab302e7
[3/4] powerpc/perf: Add encodings to represent data based on newer composite PERF_MEM_LVLNUM* fields
      https://git.kernel.org/powerpc/c/4a20ee106154ac1765dea97932faad29f0ba57fc
[4/4] powerpc/perf: Add data source encodings for power10 platform
      https://git.kernel.org/powerpc/c/6ed05a8efda56e5be11081954929421de19cce88

cheers
