Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4B46FCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhLJI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhLJI0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:26:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECCBC061746;
        Fri, 10 Dec 2021 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCd3ofQIkPoBQszSns7SHd2GIzmG4RnKHOMiYd2VhCg=; b=DpB7kk+by4/CIQgowmU6p6xIYw
        7U1O0x0D/HiPeeKc/ZMnLqEFM5EnZ2Yq5noUXO6vH3/B1FGKegavS0UpunIiUa8nB4J07dwFKhSMo
        VdG6CPdAGAa1EFrWUWkWD7Y1oTccKzJMDYwsauvcsw49u6BJQ5J+qq3n6HH53W1vDVYtqUjOuN2V9
        C6Ww1TrkowmjC7XPRG3FQkagGOCRrsGnlmSOyMxBvgbbo5w4ZpL933eYf+paYZ6Y4wBWBv7FdSsS9
        xKK4arxyxrNmrIkB2XtnJ2qYQgZWlahP8k6WDvbW0yX1MtfqwL7fpPN5gVCr3UpTD0ITIFPh1Swv8
        00rRzUEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvbAI-000X0W-HT; Fri, 10 Dec 2021 08:22:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9C949817E0; Fri, 10 Dec 2021 09:22:02 +0100 (CET)
Date:   Fri, 10 Dec 2021 09:22:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 0/4] perf: Add new macros for mem_hops field
Message-ID: <20211210082202.GQ16608@worktop.programming.kicks-ass.net>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
 <YbJWVYZg1el9PR1I@kernel.org>
 <87o85pm0g2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o85pm0g2.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:35:41PM +1100, Michael Ellerman wrote:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> > Em Mon, Dec 06, 2021 at 02:47:45PM +0530, Kajol Jain escreveu:
> >> Patchset adds new macros for mem_hops field which can be
> >> used to represent remote-node, socket and board level details.
> >> 
> >> Currently the code had macro for HOPS_0, which corresponds
> >> to data coming from another core but same node.
> >> Add new macros for HOPS_1 to HOPS_3 to represent
> >> remote-node, socket and board level data.
> >> 
> >> For ex: Encodings for mem_hops fields with L2 cache:
> >
> > I checked and this hasn't hit mainstream, is it already merged on a tree
> > where this is slated to be submitted in the next window? If so please
> > let me know which one so that I can merge it on perf/core.
> 
> I haven't picked it up. I guess the kernel changes are mainly in
> powerpc, but I'd at least need an ack from eg. Peter for the generic
> perf uapi change.

Done :-)
