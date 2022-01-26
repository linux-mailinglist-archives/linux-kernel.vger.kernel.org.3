Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05F149C41B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiAZHQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiAZHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:16:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B02C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 23:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1YiAgXr+T+5PoTxk9FObhMmaDmPyu89BDQODNplz5ss=; b=tR1PVeVh0kUvMiGgRtLM2fOQ8K
        a2KuIVjewWnSb8v44m2iDOO4jcZ36NweKW2xo/+IVLcoIhsnwEcwtI2eswSVYIGlV9JzePM5fNiQb
        u2ZuFweoqGoljY/MUDiHc7UNTX+VHt+SB2j5U/ZMAd0UK8BYLe9g5l5t1c5Md24DEB//oX0QKnHwH
        +fQcsHq4euN5yXeFa7mHf4DEDk7k4mkQqhyEWaOXf53iKvwYp7He+KSNG+vUBAyRpQekvDhORzD90
        ADb0uW8dydlFFMuwv4GhnU+CjKnprYYDHiFuNEhfsDZNN2MvSVYLn/0Nm2L2m+Hn4IeOcuUDoaWnu
        0Oim0frQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCcXo-00ASlK-KM; Wed, 26 Jan 2022 07:16:40 +0000
Date:   Tue, 25 Jan 2022 23:16:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
Message-ID: <YfD1WFmlFYLkaJ/A@infradead.org>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	[VM_NONE]				= __P000,
> +	[VM_READ]				= __P001,
> +	[VM_WRITE]				= __P010,
> +	[VM_READ|VM_WRITE]			= __P011,
> +	[VM_EXEC]				= __P100,
> +	[VM_EXEC|VM_READ]			= __P101,
> +	[VM_EXEC|VM_WRITE]			= __P110,
> +	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
> +	[VM_SHARED]				= __S000,
> +	[VM_SHARED|VM_READ]			= __S001,
> +	[VM_SHARED|VM_WRITE]			= __S010,
> +	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
> +	[VM_SHARED|VM_EXEC]			= __S100,
> +	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
> +	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
> +	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111

Please add whitespaces around the | operators.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
