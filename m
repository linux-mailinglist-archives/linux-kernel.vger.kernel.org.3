Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7898C489431
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiAJIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiAJIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:48:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0553C029818;
        Mon, 10 Jan 2022 00:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=JThY5n2aZqqSAJY3Gi4ldy3lih
        jPofFJR0LS1z5fCv8YUr1kzrNeA3wqeX8yt+7Bv6em2oEnt9p8qumhe0fcQdxK0qQyHKkAcdNBw+L
        8pJAxJwKd6Fls9uQiJestGOIkGLofNdoGihISpyGHQs3eJ8F8ItbUpd4jLXYMZNsxYfUbM0RP1as5
        D2RSktOH+40ms3mnMCA7keInrO/+h427z5grS7Tc3O6BkSQg4Ud+JJih/lBryENXdw3CljfUu+h6d
        X/tdONRkGuyYVa2Oa9rqK+3y+QeY6jN8Jpeyd9oayAVvUtXyULYTUV5Tv3LrJzuSJv3WR/5+mQiQX
        tFrQ76gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qKZ-00A16q-TU; Mon, 10 Jan 2022 08:47:07 +0000
Date:   Mon, 10 Jan 2022 00:47:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 10/16] scsi: message: fusion: Remove usage of the
 deprecated "pci-dma-compat.h" API
Message-ID: <Ydvyix40L8Q6sObF@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <e38e897fbd3314718315b0e357c824e3f01775d6.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38e897fbd3314718315b0e357c824e3f01775d6.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
