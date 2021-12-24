Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA347EC25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhLXGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLXGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:31:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BBC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 22:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sY7WKZCXEV7eqPI5ll6Y5LMshz
        OBi23Rb6OuA+dB6ANeF33WZTaGtTlH5ydLlppW+o2eXHK7UB/U3iqhANs1p4VdAmiaVdUi8R2Lkk0
        8XOledWQlSYaYq96Z8fx0w5VPmrrdBr4TWeQUqb55RWsiD5zl8cctVlURppnjvVZMXE1559H6QN8n
        sm522+dQEEnFO0QhfaizKUQey6GkiWEvt3F9m/QSZ9UDvtXuVC8uMNU0HIh7+MzVUWjgmTupnhvlE
        DZ5q3r/HBYl0UhrJO7vmX0G/25hTXlVBFJFNdEBo77sNWmKqqLpAuC8/NDGn1E1+cN8ZQr2/2FZ/D
        xKPPGT6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0e6h-00DniD-CR; Fri, 24 Dec 2021 06:31:11 +0000
Date:   Thu, 23 Dec 2021 22:31:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobe: Remove kprobe_instance and its related functions
Message-ID: <YcVpL8ZnERSyGcCo@infradead.org>
References: <20211222100345.412013-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222100345.412013-1-jolsa@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
