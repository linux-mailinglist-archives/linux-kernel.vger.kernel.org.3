Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83E14893F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiAJIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbiAJInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:43:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3503C034000;
        Mon, 10 Jan 2022 00:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=tUjT04nSy9SYd253XcwattFKK6
        LbHcaTX9/6RgvFW+kkmzWE0fJ2rFf4mbeWooRYrF32UOm2tI8sbO+wXxKVy5p5kNTlzDfysqo19tO
        dWLRiNESmpJzm15YW/U5w8/EbDIw97cTWEjEpkoxwwtfRJp/grdCgr6X7TvFW+ll3zcNu8eNZ1UvE
        SJ0yoswdtd28HIZogmU6hjphd7YV/WVNp/klpYluvx6pniI2+LJN5ZleWQOzv3QibeCN550YFFeYz
        SupGmpdKT/kTotBic3Fw/ptm4xp+lKtHCdDNng+Ygu84r+wW4v+t6uXdbJwCoOErDfRtDahyObNtC
        JnUeVabQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qGv-009z63-0I; Mon, 10 Jan 2022 08:43:21 +0000
Date:   Mon, 10 Jan 2022 00:43:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 01/16] alpha: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvxqFMBTpHlvd12@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <30686538ee42aaa4c2dd0788c42edbc6df07f250.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30686538ee42aaa4c2dd0788c42edbc6df07f250.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
