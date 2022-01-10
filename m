Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82104893FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiAJIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiAJIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:45:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB32C033273;
        Mon, 10 Jan 2022 00:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Y+9IFvrL/XG6AMy/K55uoAiGnh
        wCdIWL2CnnynGmAerV/Sr9/PpCtLgQ4yjly3fdXYd8VEX1BPPQS+8WIlwNXxU+D6uqmCp2YPiJNzo
        MpBi1q2u+G7R9Maw7Ln7Q0wHPmm5kj7QOsTuFLYJvCiQRDUanH+tEVSyedUiMGuSwMYLdnYsow9ys
        jDxbAKA4qni3cCdsSOfCfgwuyWjos75ARiK9UW01GKpNsAJjA4yx6hB7R5gWZ4HQc6U+gqUZg7OLM
        HZV7G7xQDjOLGWwvF0kkMTiCas0YwPaoNrJuZ+iSzj/jPNaleleLPYMolSZ12qZfGsMs+OUbK30/R
        gwflqvfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qIU-009zse-4U; Mon, 10 Jan 2022 08:44:58 +0000
Date:   Mon, 10 Jan 2022 00:44:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        awalls@md.metrocast.net, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 04/16] media: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvyCg6AZbbp5emG@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89f4b29b9f7e0c711a3ccc16a009f49f416e1fc.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
