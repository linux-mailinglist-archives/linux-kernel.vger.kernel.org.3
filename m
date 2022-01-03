Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B66482F66
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiACJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiACJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:24:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB912C061761;
        Mon,  3 Jan 2022 01:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=sGoJXN5pj8zftVrL2EqoQsQDuD
        ZWM36uueNDztFUl9/JYHRh0G8iIwvXl4wrNCl/sIgC3CieVyGqWKgW6VDJJD0pAxvu+uDN3nE3Adx
        xqnAalMuWa3K0iqXl0gF5mYtUjDNI+QXqwFT12SM60VVH/5R8pShsfgMRk0cZxZOiTCNyUvxerMFo
        4799X+oHIwUdZH6L5lesEAS3t6c9pBl6i4SrOqjree4t4j2ygE7z8UjWp3JFKpoT/1u1D+aPyBDFA
        324ZVez+rNjGTGafsowA3LMUWue6QPzO4nqO/L131+VfTS/uyfFxcbxVL1hCZZYwOox+aQR0JOZcA
        +dwElQNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4JZK-008g04-OC; Mon, 03 Jan 2022 09:23:54 +0000
Date:   Mon, 3 Jan 2022 01:23:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] floppy: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdLAqi+WQu4ZhAxE@infradead.org>
References: <9e24eedeab44cbb840598bb188561a48811de845.1641119338.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e24eedeab44cbb840598bb188561a48811de845.1641119338.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
