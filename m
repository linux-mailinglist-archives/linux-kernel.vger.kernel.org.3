Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DA497F89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiAXM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiAXM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:28:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99CCC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IbHTPLPHKOYCbcyVROJGgzAPAFeL2yNA4XHtT8dzIss=; b=VgDBa8Mobdswrma4rOB/+beByN
        1hbVBymHCUWWIYIwcEdJVU2Jk2sbb6vZjEw4URDJtioZ0v09lm8oiIq++yjnfywyPv6eC5uSn47cV
        1BGoOcehpVd2+xJxNrauEJ3uGg56aA1ZfoiC2o7/TDPla2nX6fIRcxUMW0oXPQzmLX9HLZ/D01ETx
        mjfBdszvAQLjq9zge91Bsr/swMonOBOa/oO2uMBhY7IWdjQTBLfF6y09M3bqn+I7dhqnf6UFRH2xR
        tEBjlpIJjROfrx8Bk2Ddb9zUy6qCMgtj+GVtMJykI7rvZ2eGM0o7jhRJtF1vy3PiAVX97ED1Pba5s
        RMua2nQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBySr-003HBY-Gw; Mon, 24 Jan 2022 12:28:53 +0000
Date:   Mon, 24 Jan 2022 04:28:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem: Document kunmap_local()
Message-ID: <Ye6bhQG6b6caYurD@infradead.org>
References: <20220124013045.806718-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124013045.806718-1-ira.weiny@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 05:30:44PM -0800, ira.weiny@intel.com wrote:
> + * __addr is often an address returned from kmap_local_page().  However,
> + * this address can be any address within the mapped page.  It does not need to
> + * be the exact address returned from kmap_local_page()
> + */

I'd word this a little different:

> + * __addr is often an address returned from kmap_local_page().  However,
> + * this address can be any address within the mapped page.  It does not need to
> + * be the exact address returned from kmap_local_page()
> + */

 * @__addr can be any address within the mapped page.  Commonly it is the
 * address return from kmap_local_page(), but it can also include offsets.

But documenting this definitively is a good idea!

