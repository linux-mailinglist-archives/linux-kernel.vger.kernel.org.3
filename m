Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B564D949C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbiCOGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiCOGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:31:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6054924E;
        Mon, 14 Mar 2022 23:30:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C49968AFE; Tue, 15 Mar 2022 07:30:16 +0100 (CET)
Date:   Tue, 15 Mar 2022 07:30:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] sr: simplify the local variable initialization in
 sr_block_open()
Message-ID: <20220315063015.GC1086@lst.de>
References: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314150321.17720-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:03:21PM +0100, Lukas Bulwahn wrote:
> Commit 01d0c698536f ("sr: implement ->free_disk to simplify refcounting")
> refactored sr_block_open(), initialized one variable with a duplicate
> assignment (probably an unintended copy & paste duplication) and turned one
> error case into an early return, which makes the initialization of the
> return variable needless.
> 
> So, simplify the local variable initialization in sr_block_open() to make
> the code a bit more clear.
> 
> No functional change. No change in resulting object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Christoph, please ack.
> 
> Jens, please pick this minor clean-up on your -next branch on top of the
> commit above.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
