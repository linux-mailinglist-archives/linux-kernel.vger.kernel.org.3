Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFEA4893FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiAJIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiAJIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:45:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31382C06173F;
        Mon, 10 Jan 2022 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=kOfHHTvz6w225r2PbPxHU+IdAs
        mDetB6qT/xHtLGEYrSFADka3D1ElT1Y7zA6AnPsaUsmz7vgG2/B5r2CR8rFVXjZ3PUUujF0N7KS+v
        o9v/ZvrFO23oeICLODPzmhcRZSqIC0KZgsQfVhpTE39gLi6Ab7EvGN7IX9mHWraZmXRfT0Se6cemG
        831KeOFxzRPLD424/HB+3hjeSs832ijovJQ8Czri9xjYGFfDMrz05hE/IM/FxeVHhjii9TRqHvq2v
        N5/xxN4p50XXmXwRF0rkwJlV7LK0QYUXLZCfMt+TM+gmqMiJHQk24qTrqj2ll1L8y10maRkoGGn1s
        XIqArCog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qJ6-00A0G8-Ow; Mon, 10 Jan 2022 08:45:36 +0000
Date:   Mon, 10 Jan 2022 00:45:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 06/16] sparc: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvyMCjdlucLFyGL@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
