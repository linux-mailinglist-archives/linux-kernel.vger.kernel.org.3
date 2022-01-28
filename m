Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56B4A0471
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbiA1XqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:46:02 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47129 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230352AbiA1XqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:46:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id A380D5803A7;
        Fri, 28 Jan 2022 18:46:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Jan 2022 18:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xUwCqbFq5p1l8yHGU
        oeM5CsdqnzYrFZbgfX57fO0sno=; b=EyZDGmMbZXj3HYgnEN8Ymbbo/jc2DIZ3Z
        Qpu7CUUstdRFb/Dr2e1rD/Hr3ULWiTkOMRz83O9iN4j3RXRzQ8HATWtu7lgHKj/f
        tQnVQ+tBhqrGFWKlzROuVq2hN2hC3Nj8anWpNHWJ8OYzUK9h1Yf4Um3CyhZkvtRS
        iFb1sIDVYRwyxqythbFCiZuJrqLiQLK4KTo8Q/m3wKi3vnoiSUbFb7KMcXexnHEp
        GEyskn3Y11I8Rg/HLXtgn95VNjJ+28TWTuElb5vDbYLJz9S8L0lL8KhSBXU5Guoq
        3DPVHqMOga/H3flVKT7zht7E0svjaFKW8cblPLMDaetHuH2Eg6zHA==
X-ME-Sender: <xms:OID0YdM1wA1GxHlUBm1HWAjxWL0c8sd4g5KNh2QpYtKOirvAy92VPQ>
    <xme:OID0Yf-YrGvUUh9Eju41yuBlO0uePrxZAziWhbtv1wbL-hxYElY8s822dpd9tRy1V
    4zz-X1u_rGUYFlLCNE>
X-ME-Received: <xmr:OID0YcSWZg4nmwrn_xpTvFflBMYvX7VrMy8mGq15BXPw_MDIqym202Eg4lPO4EIWuV1VVW-jLsFF7RFe5yx4ndL_xBzsfEds4KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeeigddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekveevtdekfedtfefhvdfgleelfefhtdefieetjeejvefghfdufeejkeehgfeu
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdr
    ohhrgh
X-ME-Proxy: <xmx:OID0YZu1tYar0MhX_v0vfzusxVV_OJPC956fqgPfooHR48_oBITJaA>
    <xmx:OID0YVdZr61Jrf5Vn3OCclg7DJSpaeU1V7BCKqpEHNW5qcCE3RLZqQ>
    <xmx:OID0YV3QB80lXtTxb8E1jvlkoU_4PiBwTORdLy9YvysgT3Whn8O49Q>
    <xmx:OID0YV20Vqd8eJQSk_4w5hbMfRHLH4lYyGH4iG1MDjyz_KJlmN_8KQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Jan 2022 18:45:57 -0500 (EST)
Date:   Sat, 29 Jan 2022 10:45:53 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Tom Rix <trix@redhat.com>
cc:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <0567fce4-256a-e1b1-dc66-221ba97153d5@redhat.com>
Message-ID: <56b761a-6cf9-23ab-c849-eff27e5e831e@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com> <953eb015-4b78-f7b-5dc1-6491c6bf27e@linux-m68k.org> <CAKwvOdnWHVV+3s8SO=Q8FfZ7hVekRVDL5q+7CwAk_z44xaex8w@mail.gmail.com> <fb308f51-f16b-3d9b-80c2-180940236b00@redhat.com> <5554a75f65fddab4de60d61fd503fe73773dafbb.camel@perches.com>
 <c801989d-5f3e-84d2-24a0-7022be70da98@redhat.com> <7bff2de309384b7c9ee71ad90881d1e0bbe0a781.camel@perches.com> <0567fce4-256a-e1b1-dc66-221ba97153d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022, Tom Rix wrote:

> A testsuite for the fixers may help with churn
> 
> Any interest or thought on organization ?
> 

Here's one way:

1. Identify some source files that are exemplary (i.e. good style).
2. Run a new script to introduce style mistakes into those files.
3. Run the Reformatter Under Test on those files.
4. Compare the output with the original files.

But that's not sufficient to prevent more style patches (churn). We still 
need a way to avoid wasting everyone's time writing, submitting, reviewing 
and merging the inevitably incomplete style patches that may contain 
regressions and cause conflicts.

The tooling I would like to see is not a script to introduce style 
mistakes but an editor for binaries, such that C is not the "source" at 
all but only an ephemeral representation to make it easier for humans to 
effect changes to binaries (and debug info, commentary etc.)

Nonetheless, perfecting the clang-format tool is a good step towards a 
better workflow, which I described once before. 
https://lore.kernel.org/r/alpine.LNX.2.23.453.2010281344120.31@nippy.intranet/
