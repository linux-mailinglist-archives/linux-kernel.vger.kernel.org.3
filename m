Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60446FAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhLJGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:39:22 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41397 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhLJGjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:39:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J9Lkk74ZCz4xRB;
        Fri, 10 Dec 2021 17:35:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1639118145;
        bh=0BDvfT/lwdOWFPr+nWUoB/LHFtw+9sdQTq7qe6HZorY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HuAweMSI/91u6qoNG9Nr6QgxHHZJNJ3170r1TGwu6xACxU3/yU9dtisbEOX/cxh1k
         IdKUXo/OGZH5WEPAI/fJBXMjdSCkG6ama18Lu+4fxR27mASmwt/rn6hEHT/IUBfAWX
         6wHKeDkzH6H+S0+ucVXnhcO8lpfmcosYxJBydFdKNfBteu2AOBoX0eDZUpUeXU3c8Y
         PTgE+zKkjDCUpFWFNRUrYjQqva+6L4+2tCQ36y4tWNRgTdXvmqf0Ep7C9kAX2zYKVl
         9NPwgCobClTPiZs/6V+4PX9YlX7K71JNO138kn8/S1MG9cwphiI6Kqw8uDwJE/skkz
         IYzzjwujUmYUw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: Re: [PATCH 0/4] perf: Add new macros for mem_hops field
In-Reply-To: <YbJWVYZg1el9PR1I@kernel.org>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
 <YbJWVYZg1el9PR1I@kernel.org>
Date:   Fri, 10 Dec 2021 17:35:41 +1100
Message-ID: <87o85pm0g2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Mon, Dec 06, 2021 at 02:47:45PM +0530, Kajol Jain escreveu:
>> Patchset adds new macros for mem_hops field which can be
>> used to represent remote-node, socket and board level details.
>> 
>> Currently the code had macro for HOPS_0, which corresponds
>> to data coming from another core but same node.
>> Add new macros for HOPS_1 to HOPS_3 to represent
>> remote-node, socket and board level data.
>> 
>> For ex: Encodings for mem_hops fields with L2 cache:
>
> I checked and this hasn't hit mainstream, is it already merged on a tree
> where this is slated to be submitted in the next window? If so please
> let me know which one so that I can merge it on perf/core.

I haven't picked it up. I guess the kernel changes are mainly in
powerpc, but I'd at least need an ack from eg. Peter for the generic
perf uapi change.

Equally the whole series could go via tip.

cheers
