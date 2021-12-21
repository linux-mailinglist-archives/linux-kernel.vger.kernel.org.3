Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794F47BBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhLUI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:28:50 -0500
Received: from verein.lst.de ([213.95.11.211]:45816 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbhLUI2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:28:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC66768B05; Tue, 21 Dec 2021 09:28:46 +0100 (CET)
Date:   Tue, 21 Dec 2021 09:28:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Christoph Hellwig <hch@lst.de>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [axboe-block:for-5.17/block 106/108] block/blk-ioc.c:307
 set_task_ioprio() error: we previously assumed 'task->io_context'
 could be null (see line 300)
Message-ID: <20211221082846.GB5889@lst.de>
References: <202112171520.5hNnOM0q-lkp@intel.com> <921dd30d-b9d1-c66c-525f-b678a0b97a47@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921dd30d-b9d1-c66c-525f-b678a0b97a47@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
