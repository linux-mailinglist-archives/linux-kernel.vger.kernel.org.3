Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E8489441
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiAJIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiAJItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:49:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0CC061763;
        Mon, 10 Jan 2022 00:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ItzrFL0LbXYE3K8hHEYz/NPzV1
        e0sf0Ay6eH3EXDtU2tbuKdvpSbrrUefbW2SzFWtbcIRvGOtniu3Gjsv4Vd4Ilq6RHDVyUzzxB2QKa
        NxxErBy/EpKyMGjZO8p3Bjoep+vJe5h4NwJfqQmWPCUet4jvGXY5FSILDeAvGOuFN78PfKUEG2fPO
        jZuP/TKFTuTdN9O0XxrMwu2WT4ckRqRimEs9jHJnotQ7UYqhTuiqVv0FhJWiK4od/3O3YtrOE/o2E
        pAREbHVEmjuatv0RmnX1w9ofuOHO9nJFpX+BwvuQQDSclJhS+ewnqZfUm8lQb8KqvjNvLIl9Wn+AZ
        aomQMCFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qLD-00A1TY-BI; Mon, 10 Jan 2022 08:47:47 +0000
Date:   Mon, 10 Jan 2022 00:47:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 12/16] scsi: mptbase: Use dma_alloc_coherent()
Message-ID: <Ydvys5OJUd8DgesQ@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <3bea2452deb8cc8be65982e87efa4c6861caa01c.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bea2452deb8cc8be65982e87efa4c6861caa01c.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
