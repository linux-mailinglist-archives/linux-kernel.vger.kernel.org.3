Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48A49AE85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452892AbiAYIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451896AbiAYIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:48:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E73C06E013;
        Mon, 24 Jan 2022 23:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=75fjvxkpcCo4jL8p3FdjfOk5GEVHgIS93fZ4qZc8bNA=; b=b/iOn8Hoyg1wUS7Qh2nzBKg7np
        6I3neoUO8FFrYnLwuI7F5FFB6D/zq/RE9H+RYoI5cJXZ9EoEJSEF5ZeNr2ZGqb46CIrAiOtQQ+sfZ
        zhUdDlgEsHqyrNffazit08rwIRlViWqKuGaZZ2iwEtkCpVWyed/VByG0wf8bVjwrk4RA51O3XmsY3
        dNdUp5UEgwEK2uirQ49eGBy71/067s9j1j5cn1SguthPSwQcSibgj3JLW3zEmVuTdguSjZ2/jK6Zx
        CyU8VxYpajC6sQIEu7evljbtW6LL5Y0FDh6lNbKAWu7fxeKXlHHkFi90ANg13efiK5ZjqQeh5xmDl
        /CfAUpeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCGCq-006iFh-V8; Tue, 25 Jan 2022 07:25:32 +0000
Date:   Mon, 24 Jan 2022 23:25:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/3] block: simplify calling convention of
 elv_unregister_queue()
Message-ID: <Ye+l7K4peViBTOkX@infradead.org>
References: <20220124215938.2769-1-ebiggers@kernel.org>
 <20220124215938.2769-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124215938.2769-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 01:59:36PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make elv_unregister_queue() a no-op if q->elevator is NULL or is not
> registered.
> 
> This simplifies the existing callers, as well as the future caller in
> the error path of blk_register_queue().
> 
> Also don't bother checking whether q is NULL, since it never is.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
