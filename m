Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA3F4D9C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiCONXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiCONXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:23:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1933F30F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:22:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 796F568AA6; Tue, 15 Mar 2022 14:22:02 +0100 (CET)
Date:   Tue, 15 Mar 2022 14:22:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
        alsa-devel@alsa-project.org, Mark_Hsieh@wistron.com
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Message-ID: <20220315132202.GA12452@lst.de>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 09:20:59PM +0800, Mark Hsieh wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Micron has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev
> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> So also disable Write Zeroes command on Micron.

This still ignores all the questions I've asked.
