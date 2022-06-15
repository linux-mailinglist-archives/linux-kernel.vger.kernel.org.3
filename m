Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA48354C686
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347333AbiFOKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiFOKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDD50B25
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:53:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2919A68AA6; Wed, 15 Jun 2022 12:53:17 +0200 (CEST)
Date:   Wed, 15 Jun 2022 12:53:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Message-ID: <20220615105316.GA7911@lst.de>
References: <20220614210902.744318-1-e.velu@criteo.com> <20220614210902.744318-2-e.velu@criteo.com> <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com> <20220615053729.GA21858@lst.de> <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:57:05AM +0200, Erwan Velu wrote:
> > I would much prefer to not print it all.  The Linux boot is way to spammy
> > to start with and this doesn't add any real value.
> >
> 
> I know the boot is a bit spammy but when systems crash because of nvme
> drives, that's very handy to get a trace showing who was the culprit and
> what drive is installed (including the fw version which is usually a major
> source of troubles).

Well, usually they are all the same or a very small set of different
SKUs compared to the total number of drives.
