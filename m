Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B84899EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiAJN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiAJN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:29:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DBC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bIvQ3iiBdG90qy5CiZJ/j6Ne9iVxuyc7lz8mhd/rS0c=; b=Wi7e7e53xjQVSyoM7SoAi03iCf
        6Zhihcd5Q/URTY8byyLMah09OIcbpqBm7eJJFDDdWHBg4RuS+D6HwG4lXTjY5kMBzbwQEsEaugrUb
        uZ4LedlfNsol3F/G8GMt86ejqnsCj4Sr+hbKkgBRMNKj+mvC9Xok3xIVhZOZdugu2DweFXmwNAjHS
        PEJnb8HCVgRrK6ypTBNpjWiQqvOsQ6AkyPpcghQmnY06hwvUmb4kbcGx5P4foI04KjqPKmtoS2sW1
        AKIWdVORgUW4eD+lJjmu0K/Y4um9XcbS+4aShcZbvP+0vpr3AA9fSMPOctpmW9Z75rBNXmyNuW4VL
        09LuSPQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6uj8-002SEg-0L; Mon, 10 Jan 2022 13:28:46 +0000
Date:   Mon, 10 Jan 2022 13:28:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 05/28] gup: Change the calling convention for
 compound_next()
Message-ID: <Ydw0jYsMYAie9+o8@casper.infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
 <20220110042406.499429-6-willy@infradead.org>
 <Ydvt8TwenyRFClWG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydvt8TwenyRFClWG@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:27:29AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 04:23:43AM +0000, Matthew Wilcox (Oracle) wrote:
> > Return the head page instead of storing it to a passed parameter.
> 
> Looks good, but same comment about maybe passing list and npages first.

Done for both.
