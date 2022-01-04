Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C44841D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiADMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:47:29 -0500
Received: from verein.lst.de ([213.95.11.211]:49786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233046AbiADMr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:47:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43BE268AFE; Tue,  4 Jan 2022 13:47:25 +0100 (CET)
Date:   Tue, 4 Jan 2022 13:47:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block: remove dead queue_dma_alignment branch from
 bio_map_user_iov()
Message-ID: <20220104124724.GA21670@lst.de>
References: <20220104120158.20177-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104120158.20177-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:01:58PM +0100, Lukas Bulwahn wrote:
> If queue_dma_alignment(rq->q), then blk_rq_map_user_iov() will call
> bio_copy_user_iov() and not bio_map_user_iov(). So, bio_map_user_iov() does
> not need to handle the queue_dma_alignment(rq->q) case in any special way.
> 
> Remove this dead branch from bio_map_user_iov().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
