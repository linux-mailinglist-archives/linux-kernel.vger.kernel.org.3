Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24B46BE85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhLGPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhLGPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:03:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF4FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AVv4NRDLTEOgNBP/O0rn8XHYGKZqjEPb8Ke4zaIQf84=; b=N1zjHSCHdV81XbDdNvZ2ou5tDT
        t1ZP2wFkuyKYsH+LDZmmNcdh1BBbM3QHLBYXFH59mkRSpO6ihetWN560upzRL3DtIkPnw3VtgHl6k
        pkJM4/zn7/2faEqgsN7rUnW7BdOtRowvFLulfafhXKEBf739/QiqQqylSqC0LgxYGoxARgdrwR3Db
        rScrF7OSIiHtBM0pML2/AcAEYttlXoCKygp3ph4HABr3Vu8S6dh92JPno+/MJ9RhtW8fWHO8ZvuIm
        bL2GbSSXThVNWsp2ljfVmTg6D1RReoVUg/Sh6wGB0Z7O4dpHsgOASpG7jofjihpUSuLxt7ihoFXoV
        S2LeiqQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mubwL-007SMH-7o; Tue, 07 Dec 2021 14:59:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9B793000E6;
        Tue,  7 Dec 2021 15:59:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C9A7E201CAF60; Tue,  7 Dec 2021 15:59:32 +0100 (CET)
Date:   Tue, 7 Dec 2021 15:59:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v3] sched/fair: cleanup task_util and capacity type
Message-ID: <Ya921MtQfJbBHRPc@hirez.programming.kicks-ass.net>
References: <20211207095755.859972-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207095755.859972-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:57:55AM +0000, Vincent Donnefort wrote:
> task_util and capacity are comparable unsigned long values. There is no
> need for an intermidiate implicit signed cast.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Thanks!
