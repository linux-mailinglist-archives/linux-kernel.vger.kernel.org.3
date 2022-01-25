Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922649AD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442886AbiAYHL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442364AbiAYHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF7C0619CD;
        Mon, 24 Jan 2022 21:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2JMWkRT8bMLZY9sQn3htmqSvZP
        lOVpVLnLFAnunA+AXaPhmuUNgQzEskFJjGE+pT0rWgwddAysc6ld9mIXDmRNfqakXv4twJ1WGThl2
        ZjqLs74FV7HSU/wiSeqQfM3GtaUn/FubrdsfI1GlZg0qoA+WDO/iXVwISjkLftmIlyzvQIE13Xb9u
        xDsKmQwI4r0T+JaXQ2h1XTOWHNKscC72hVLfyXnjvh6AnS9ag7ed/je7KmOxa9cYBQcytt9J//lgc
        uFmgHBccyRDSAz5JyqS60dUY1a6fa8pKgTt0Js+R0sxq2biVrsvRmKJWH+UM5+D5fWj5jxCt1cCzo
        b1o/Ec8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCEnm-006XD8-Ud; Tue, 25 Jan 2022 05:55:34 +0000
Date:   Mon, 24 Jan 2022 21:55:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -next v2] ia64: make IA64_MCA_RECOVERY bool instead of
 tristate
Message-ID: <Ye+Q1nOv3twgwCuq@infradead.org>
References: <20220124213129.29306-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124213129.29306-1-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
