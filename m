Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622F948943A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiAJIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiAJItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:49:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550BBC02982B;
        Mon, 10 Jan 2022 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=pvGDZ6Y2iGUmxUZesU0A2mxuYD
        smclxTqAvW1W9ejKljHogHTtQ5Q8J41WHaGs7YyCprTP2Pbz3HvPjRXUmovEg4+/w/dnw75hEIdTI
        Izq6CqeEhDduKZLH66FuaNeI9Q0+fZIW3HFpyoLwuqnxfPaWjz/fstViohSinJJQBV3YIdpAS1wFV
        Rk614Yf1Qt0q14DCvfdyKmKkkYo9AgBHWSgQaOij9mo8jhSA/GezWvd2oLNX3QDD/gfkDKC5OlLZO
        Oar9fMFOkLBIepGBKd1xiVI2+Qv0+x/ZmIXbHSZTCl2VD5x3Jba/8/eE558DBG+7J8mYBmhAy1DxF
        tnaP/b3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qKu-00A1H7-1N; Mon, 10 Jan 2022 08:47:28 +0000
Date:   Mon, 10 Jan 2022 00:47:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 11/16] scsi: mptbase: Use dma_alloc_coherent() in
 'mpt_alloc_fw_memory()'
Message-ID: <Ydvyn3/dvUSy/2EI@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <db3db9db219005b75659561d08117d312d0cfb13.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db3db9db219005b75659561d08117d312d0cfb13.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
