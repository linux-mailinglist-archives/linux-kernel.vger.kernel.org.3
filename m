Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5A552C38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiFUHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347701AbiFUHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:39:47 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75CE911440;
        Tue, 21 Jun 2022 00:39:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EFE6010E7E86;
        Tue, 21 Jun 2022 17:39:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o3YUB-009E86-8e; Tue, 21 Jun 2022 17:39:43 +1000
Date:   Tue, 21 Jun 2022 17:39:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shida Zhang <starzhangzsd@gmail.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, zhangshida@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: add check before calling xfs_mod_fdblocks
Message-ID: <20220621073943.GQ227878@dread.disaster.area>
References: <20220621070224.1231039-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621070224.1231039-1-zhangshida@kylinos.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62b175c1
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=7-415B0cAAAA:8
        a=scJOnP1jaRTltI4sJEwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:02:24PM +0800, Shida Zhang wrote:
> Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
> __xfs_ag_resv_init().

This describes what the patch does, not the problem being solved is. 

i.e. This doesn't tell the reader why the delta can be zero in these
places, nor does it tell them what the impact of it being zero is.
We can't use this information to identify a system that is having
problems due to this issue because they havent' been described.

Hence when I ask for more detail about how something occurs, what I'm
asking for is a description of the how the problem was found, what
the impact of the problem has on systems, how the problem is
reproduced, etc.

Something led you to finding this problem - tell us the story so we
also know what you know and so can understand why the change needs
to be made. A good commit description tells the reader everything
you know about the problem that needs to be fixed, the code change
itself will then describe how the problem was fixed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
