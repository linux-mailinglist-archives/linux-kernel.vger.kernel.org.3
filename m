Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216D84EE7BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiDAFWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiDAFWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:22:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072A60AB2;
        Thu, 31 Mar 2022 22:20:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44CC068AFE; Fri,  1 Apr 2022 07:20:09 +0200 (CEST)
Date:   Fri, 1 Apr 2022 07:20:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the device-mapper tree with the
 block tree
Message-ID: <20220401052009.GA9398@lst.de>
References: <20220331094425.0a9e0b92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331094425.0a9e0b92@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:44:25AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the device-mapper tree got a conflict in:
> 
>   include/linux/bio.h
> 
> between commit:
> 
>   57c47b42f454 ("block: turn bio_kmalloc into a simple kmalloc wrapper")
> 
> from the block tree and commit:
> 
>   135eaaabd22a ("block: allow using the per-cpu bio cache from bio_alloc_bioset")

Isn't this something Jens already had queued up in the block tree?
