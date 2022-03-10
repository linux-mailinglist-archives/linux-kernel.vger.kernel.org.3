Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D134D4ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbiCJO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbiCJOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:21:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C1C335D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:20:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AC9868AFE; Thu, 10 Mar 2022 15:20:34 +0100 (CET)
Date:   Thu, 10 Mar 2022 15:20:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310142034.GA1038@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com> <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com> <20220310083811.GA26953@lst.de> <20220310190636.00001695@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310190636.00001695@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:06:36PM +0800, Mingbao Sun wrote:
> I feel it’s not proper to create a sysfs entry for each socket.
> And for those sockets that do not have the exception of
> congestion-control, it’s merely a waste of resources.
> 
> Also, since these sockets generate and die dynamically, the info
> exported via fs may even do not have the opportunity to be seen by
> the user.
> 
> Anyway, if you insist that the checking and warning here is not proper,
> I can remove it. 

Something that can happen during normal operation is per definition no
something that should be warned about.
