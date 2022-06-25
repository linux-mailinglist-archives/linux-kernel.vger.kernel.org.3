Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75A55A8C7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiFYJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiFYJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:51:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F139B80
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:51:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0158768AA6; Sat, 25 Jun 2022 11:51:16 +0200 (CEST)
Date:   Sat, 25 Jun 2022 11:51:15 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     "hch@lst.de" <hch@lst.de>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [asahilinux:bits/050-nvme 6/9]
 drivers/nvme/host/apple.c:291:19: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <20220625095115.GA23965@lst.de>
References: <202206251551.PTd0wn6d-lkp@intel.com> <20220625075950.GA22592@lst.de> <e874d1f9-912e-487e-bd8c-e227067c00ca@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e874d1f9-912e-487e-bd8c-e227067c00ca@www.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 11:46:55AM +0200, Sven Peter wrote:
> On Sat, Jun 25, 2022, at 09:59, Christoph Hellwig wrote:
> > Sven, can you send a patch to use the proper __le types?  We really
> > prefer the nvme code to no have any sparse warnings.
> 
> Arnd already fixed this with 7ad7ab90368 after the commits hit the soc tree
> (and before I even had a chance to look at it).
> This mail just came from our downstream tree that's still stuck at 5.18.

Perfect, thanks!
