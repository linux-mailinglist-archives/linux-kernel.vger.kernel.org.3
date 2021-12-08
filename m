Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29746CC96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244202AbhLHEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbhLHEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:37:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB18CC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:33:34 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 42A08CE1ECA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:33:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6E7760ED4;
        Wed,  8 Dec 2021 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638938011;
        bh=IAFR0vb7BSyeM1EI7uIaqkfVlv6GGrUcDlsssAxVqU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxqaVk0W1tY7Iko69bY4pr2O5uFW4RxPq8yWuS4N4C5UOWHEQOeLPwU5wdUGecHTB
         HTPuLZdIKZ1s/rpnfCdBiWG3OWQ4Kk90+athBl6ASv6Jyao7eVsVpQOIwP4vDqGvxZ
         YNotZ0tWil1JUC7KXI6XQp6gHDoPtaPL+Y5/FjdY=
Date:   Tue, 7 Dec 2021 20:33:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Donnelly <John.p.donnelly@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        kexec@lists.infradead.org, rppt@linux.ibm.com
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-Id: <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
In-Reply-To: <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
References: <20211207030750.30824-1-bhe@redhat.com>
        <20211207031631.GA5604@MiWiFi-R3L-srv>
        <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 22:03:59 -0600 John Donnelly <John.p.donnelly@oracle.com> wrote:

> On 12/6/21 9:16 PM, Baoquan He wrote:
> > Sorry, forgot adding x86 and x86/mm maintainers
> 
> Hi,
> 
>    These commits need applied to Linux-5.15.0 (LTS) too since it has the 
> original regression :
> 
>   1d659236fb43 ("dma-pool: scale the default DMA coherent pool
> size with memory capacity")
> 
> Maybe add "Fixes" to the other commits ?

And cc:stable, please.  "Fixes:" doesn't always mean "should be
backported".
