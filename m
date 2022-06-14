Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBE54A9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbiFNGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352254AbiFNGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:43:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920638D87;
        Mon, 13 Jun 2022 23:43:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE14568AA6; Tue, 14 Jun 2022 08:43:03 +0200 (CEST)
Date:   Tue, 14 Jun 2022 08:43:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, chenxiang66@hisilicon.com
Subject: Re: [PATCH RFC v2 01/18] blk-mq: Add a flag for reserved requests
Message-ID: <20220614064303.GA31683@lst.de>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com> <1654770559-101375-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654770559-101375-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 06:29:02PM +0800, John Garry wrote:
> Add a flag for reserved requests so that drivers may know this for any
> special handling.
> 
> The 'reserved' argument in blk_mq_ops.timeout callback could now be
> replaced by using this flag.

And we should probably do that ASAP, independent of the rest of this
series.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
