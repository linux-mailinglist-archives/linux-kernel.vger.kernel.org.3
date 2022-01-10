Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E54892C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbiAJHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiAJHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:47:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8168C061763;
        Sun,  9 Jan 2022 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=kj6fiL329W/gAp0XpvM7fyTCis
        t47te0E/tG9jMJ+w32Gkchb73gXsjWLQ0rrK7Buyg0MOJiLGuhTLN8zQ5lREW8tJ6UDGwFEtxaGWT
        ghnBBQ5fpNry5qp4EeAlGF5NN2aWbxEmvNeVHDUNW/BG9oAGkazLfHLyzTorkVFAsA1hgT2kOoiK8
        4caUHudyQVEC2QAJ9gdwKTI75FA8u6kUzu1Btc7OL6bM88JgrXjksHSAID0cNQrYuGqT3SNQb+Hbg
        KZIhvfZtF4Ojq3dcSuN9c1hD2Of80wm70vXlf78Kiqsp0J0A/gknhlChLLFdXDYHaflpib1r2EPMv
        cZ0809yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6pIf-009gCn-6X; Mon, 10 Jan 2022 07:41:05 +0000
Date:   Sun, 9 Jan 2022 23:41:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH] scsi: efct: Remove useless DMA-32 fallback configuration
Message-ID: <YdvjEU8US+eFR/mi@infradead.org>
References: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
