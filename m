Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA113489425
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiAJIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241626AbiAJIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:47:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E81C034008;
        Mon, 10 Jan 2022 00:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=HItJWR4fYqmEkYeZCZgmyPtApp
        O3iuHi7+L8MdS8ODiOg3bX0jtbSeoVD1DG60mSmCl330BE7PSdD4o0qhDrD+ZPMGXGLo9FGenRs2A
        YAVdvy2iZVpqOJvgWpjK7RqZ+tlU6cwBgdN98qLUpkDodJ/r9nPCjvp0GWlXkuBkEXNTzke5eupRw
        xx3GcMPXOL0X1WKCx2wsMiJnAtC6GcLY3RYMXF/T0u29a8QfaHIZDDN+nhcxDuUVQ/2zrS8cTBCJ2
        ImTZJiNw/Lrxu6BFCjnyfxO4AbhD4GJQHwOLPX88mbzXgLgAXuGjCNuY59asy9xWK7zC6MUTzrG5G
        Gm0zVgCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qJi-00A0d2-EW; Mon, 10 Jan 2022 08:46:14 +0000
Date:   Mon, 10 Jan 2022 00:46:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 08/16] rapidio/tsi721: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvyVvHHUjrA7W1k@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <bdcc562c16d2551d6eb87baf557813330de45127.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdcc562c16d2551d6eb87baf557813330de45127.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
