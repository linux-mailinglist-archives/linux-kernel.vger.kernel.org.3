Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C021489449
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242524AbiAJIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiAJItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:49:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8FC028C17;
        Mon, 10 Jan 2022 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ON9/dpDLIS8vkZgw7rvVpOJQBV
        wce7sANHFoUZo82MEAoWQZBR2mxRBzV9RRarEXOuRzDxj/q046x0U/nLKenq4kk2AGBXNojxClB/8
        dvEGHLnLvBd8Z6J6Bd1dzhtoa2qMRLUt+aywPCnXn2U8zdAf07Di69yCljeec6b8fCHLfyOy703i4
        hNXsop7rN+YrQWGGP6NKfXXPsUol+N9DOoB6d9pPvvv+TdFOaM7rXH01pqq9c5H9qkyoyNIAizSFw
        C0sre48dASf69ufOCRSTKGZRpYHo8blk2x0ioq5nXePArmEFrbxCE70wuUY5GrzNm6KXmoa02MvlU
        avw/MR6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qM0-00A1tP-RV; Mon, 10 Jan 2022 08:48:36 +0000
Date:   Mon, 10 Jan 2022 00:48:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 15/16] scsi: mptctl: Use dma_alloc_coherent()
Message-ID: <Ydvy5FU4b8K6Y0kw@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <516375d6d06114484533baf03aae351306100246.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516375d6d06114484533baf03aae351306100246.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
