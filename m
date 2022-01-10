Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5C489407
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiAJIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbiAJIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:45:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EEAC06175F;
        Mon, 10 Jan 2022 00:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=r/ACnwKTg6xuOSS/xRtVKQrEgW
        7PRa2HlW11g3CG++vLSKYmzKwbA+N4nJJQCkMHeLqHDgqlFFlgtCZ3jxHucynZpw3YLwQzpYX1zaP
        8r9qxh7X1mcA0xlA1aD3ctm777viLLobG7vjenEJfy2wPaDZfebiWMI8pzK+foX1tSmaoPlRR8lhd
        D3rYdHasmI6cYO4Sxe3SOscC1AwU+3Mz+nCEwU3z9p81YW89fz6UYVXHMn7scS19vNWsrx2sxwar8
        rJY5IU+jDj6q4u1+bVOsocTMsK4hdlrktp4VhKfq5mcINoRt1m1gvKnQqfjVpXX3VYPZGbit9o2Jm
        /wcNuNvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qIm-00A05c-LB; Mon, 10 Jan 2022 08:45:16 +0000
Date:   Mon, 10 Jan 2022 00:45:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 05/16] agp/intel: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvyHE+VtIlVJbga@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <f865712ee4edbbf3cdd831795b7546a768d923a3.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f865712ee4edbbf3cdd831795b7546a768d923a3.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
