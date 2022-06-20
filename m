Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27646551101
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiFTHJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbiFTHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:09:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0C4DEAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:09:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB12F68AA6; Mon, 20 Jun 2022 09:09:02 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:09:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     onenowy <onenowy@gmail.com>
Cc:     hch@lst.de, Jason@zx2c4.com, abhijeet.rao@intel.com,
        alan.adamson@oracle.com, axboe@fb.com, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        monish.kumar.r@intel.com, pankydev8@gmail.com, sagi@grimberg.me,
        yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was:
 Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests]
Message-ID: <20220620070902.GA11418@lst.de>
References: <20220615113106.GA10697@lst.de> <20220620033627.8728-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620033627.8728-1-onenowy@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 12:36:27PM +0900, onenowy wrote:
> Some samsung SSD for OEM also have the identical PCI-ids and are affected by this quirk.
> But they have different subsystem-ids.

> Addtition of subsystem-ids of X5 to pci_device_id(as below) may solve this problem.

Monish, can you look into that?
