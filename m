Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4F58EDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiHJOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHJOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:08:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18AD6EF27
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:08:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6176D68AA6; Wed, 10 Aug 2022 16:08:12 +0200 (CEST)
Date:   Wed, 10 Aug 2022 16:08:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linjun Bao <meljbao@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: align "fake" nqn with spec 1.3
Message-ID: <20220810140812.GA24773@lst.de>
References: <20220810133953.5411-1-meljbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810133953.5411-1-meljbao@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:39:54PM +0800, Linjun Bao wrote:
> Replace '.' with '-' to align "fake" nqn format with nvme spec 1.3 or newer.

We can't just change the existing NQN construction if we don't want
to break userspace.  Maybe add a comment that it is different from
the canonical version for historic reasons instead.
