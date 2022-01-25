Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DDE49AE89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452942AbiAYIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353952AbiAYIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:48:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C4C06E019;
        Mon, 24 Jan 2022 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=XhPgf/IFRi9FPIRY19B3TcDzQg
        eBv9AXt3df0nCifrwiOrFxq39awFtymOU+OOLhyVvBhN45uYlAZkVkFnoij7T1moIfR1eGNyTyQKM
        eWP62t7EmCG4V8ElKo/VpYzbrTrqvleiE8O8+xdltled/xczpJsYDLiHNDt0MOeIMn9xzc9r/khF/
        zvf7oTZMYw81RlPtBL/Z/lIKGgVsHB3Yw9uBg+tAmw5PtIWGIlVYawIXNHuTZPsRH+SMkiqFNcE7N
        H9aehr6GL7Ny0OBX0ucaAeo5f/j+8da0XjDlLCR/RCdxE7I6Qy5vaI46ZMlBYAFUQ5uZ7Dl/uclf6
        Q0uiRwUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCGDO-006iQj-NC; Tue, 25 Jan 2022 07:26:06 +0000
Date:   Mon, 24 Jan 2022 23:26:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 2/3] block: don't delete queue kobject before its
 children
Message-ID: <Ye+mDhRhatxWAyGA@infradead.org>
References: <20220124215938.2769-1-ebiggers@kernel.org>
 <20220124215938.2769-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124215938.2769-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
