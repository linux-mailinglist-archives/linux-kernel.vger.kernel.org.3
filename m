Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36B146FEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhLJKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhLJKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:45:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86511C061746;
        Fri, 10 Dec 2021 02:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1C2ia18pafY4IU20rFG09aGHbn8SRx8sSSD9xUMea6Y=; b=b7OCQ1b9q/Lu4bUBBAi9iUnCqE
        3raxEI3VmSSCMfPLi/pl/gtWqi7LJTu3pdzNMMckhRxjLI5INSzYxnR5ecXPS0RVmisLLTJRzYw6S
        1VkClhoXTs5rWiz/gpefNfjrn1Av5EPkzMhOCzOS1fG6UeGr93I4qD+gpNa0I8suXLlVYimZZvtqi
        Zhxwt8uOQOODqcN0/R64soTgxUFiTFKgDNJudEvxfnCLnuK9gsLuV0a/cWTKus4xoyBj4QncrvMdJ
        xkWyrQDReJK9iCHgQNT8YhYzVgYZ5/+eA7HP1P4l+ptm/dGgfrIHqhrcrTSkEdnSkbX1MhYhvgrmD
        o0sR016Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvdLo-000Y4j-7f; Fri, 10 Dec 2021 10:42:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3386984E0B; Fri, 10 Dec 2021 11:42:03 +0100 (CET)
Date:   Fri, 10 Dec 2021 11:42:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     cgel.zte@gmail.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, chi.minghao@zte.com.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] tools/perf: remove unneeded variable make code cleaner
Message-ID: <20211210104203.GT16608@worktop.programming.kicks-ass.net>
References: <20211210022911.424512-1-chi.minghao@zte.com.cn>
 <708b524c-2af5-98a1-f56a-4bb4f268de7a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708b524c-2af5-98a1-f56a-4bb4f268de7a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:41:55PM +0530, kajoljain wrote:
> 
> 
> On 12/10/21 7:59 AM, cgel.zte@gmail.com wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > return value form directly instead of
> > taking this in another redundant variable.
> 
> Can we reword the commit message stating what and
> from where we are removing it. Its not too clear.
> Other than that patch looks good to me.
> 
> Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Never reply or accept email from cgel.zte@gmail.com, there's multiple
people using it to send email, this cannot be right.
