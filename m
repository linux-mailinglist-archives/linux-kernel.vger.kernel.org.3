Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96657D60A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiGUVdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGUVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:33:47 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A1289284C;
        Thu, 21 Jul 2022 14:33:42 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D783710E83FF;
        Fri, 22 Jul 2022 07:33:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oEdnd-003hfO-FV; Fri, 22 Jul 2022 07:33:37 +1000
Date:   Fri, 22 Jul 2022 07:33:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [xfs]  345a4666a7:  vm-scalability.throughput -91.7% regression
Message-ID: <20220721213337.GV3861211@dread.disaster.area>
References: <Ytlr9vZbF4SOfA2n@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytlr9vZbF4SOfA2n@xsang-OptiPlex-9020>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62d9c634
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=W6j0_YgMumW3DOhRCFIA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:08:38PM +0800, kernel test robot wrote:
> 
> (just FYI for the possible performance impact of disabling large folios,
> our config, as attached, set default N to XFS_LARGE_FOLIOS)
> 
> 
> Greeting,
> 
> FYI, we noticed a -91.7% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: 345a4666a721a81c343186768cdd95817767195f ("xfs: disable large folios except for developers")

Say what? I've never seen that change go past on a public list...

> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git xfs-5.20-merge

Oh, it's in a developer's working tree, not something that has been
proposed for review let alone been merged.

So why is this report being sent to lkml, linux-xfs, etc as if it
was a change merged into an upstream tree rather than just the
developer who owns the tree the commit is in?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
