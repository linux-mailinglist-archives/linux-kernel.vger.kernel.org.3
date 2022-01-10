Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7CD48942D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiAJItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiAJIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:48:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99739C03325A;
        Mon, 10 Jan 2022 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=BEBBMZwf0UmxhTJNInFsXsac4+
        RQQE9GuzWjhEpN9yfYfnppN1BjLY90RLCvFxzv8z8Z6vcAv4JnZQD2Vwuqcg76FYbPSo5djDdB3cf
        ftPI2Z1GbBt8pFbN2Pz8/x2jckdPb4S+d+y2gYt/4DKzbOLutI9Ic1w0Y8Go+VLSRjuAQRg/kj4Rh
        9xVndmfQW3RQClKKYNheEZkmCJ9/vgryp0EL//1ToE/oe3yuhfIo7W4Y4A7H0nGrWKTOhcKXybRbX
        peVGTPo1PhVBnzqCtjmaieHMbK6JAwulYOBr3iMe9GTJwWl/1FznI1A6lQW369eCwBzjw3bL3GFZo
        IbXTYJ8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6qK0-00A0mV-3i; Mon, 10 Jan 2022 08:46:32 +0000
Date:   Mon, 10 Jan 2022 00:46:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 09/16] media: v4l2-pci-skeleton: Remove usage of the
 deprecated "pci-dma-compat.h" API
Message-ID: <YdvyaNKTIP6fKP9O@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <4c35f397720fccb6c9166fa85fa25475b0659a6a.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c35f397720fccb6c9166fa85fa25475b0659a6a.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
