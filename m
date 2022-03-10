Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D14D425B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiCJIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbiCJIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:20:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A295F45799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:19:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE3BB68BFE; Thu, 10 Mar 2022 09:19:08 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:19:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220310081908.GA26477@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com> <20220309061442.GA31316@lst.de> <20220309153136.000048e1@tom.com> <20220309212852.00007828@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309212852.00007828@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:41:59PM +0800, Mingbao Sun wrote:
> So I tried with 'tcp_set_congestion_control'.
> But then I found this symbol is not exported yet.
> Then I applied ‘EXPORT_SYMBOL_GPL(tcp_set_congestion_control);’
> in my local source, and it works well in the testing.
> 
> Then what should I do with this?

Add the export in a separate, clearly documented, patch, and Cc the
netdev list and maintainers to get their opinion on all list.
