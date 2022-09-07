Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF66B5B0D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIGThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIGThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:37:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593CC0BF9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G24caVRKcxlZ53o823B+wiQcoo6cPK7bb5rus+bgZPg=; b=qn5BCajSNgR4ta7ECI8kOB32f/
        chuAzly+9tufQQ2jn9VQfg9MTm/MgPS1WjsqkOY2U4cNiKzqG5cbljVvtQJLNKh6EdWHCeBRbdq1B
        eEoCiiPcJhah1hjvrcVAgHShrJA83LeVmn8kyOjnldP8hTqSAM9vhJKa3lKrp6s34wRFZzvWaCpzv
        SrcD8M/vlHMICGZOJqzkJy/fYsFCOWzYZ+N/26cN7LzM4lzXE+imp2uERa67T+7omiAvb+W6JpHOp
        s+K5nkDhIoAjy7tcfA868HfOJfEkVFy8/MONR3FRCm3tjztgsxTOmlSs8DZlFCpzbTmARG+d1gOtv
        11DWiPDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oW0rl-00BhNQ-Rd; Wed, 07 Sep 2022 19:37:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DD12300070;
        Wed,  7 Sep 2022 21:37:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFD342B656AD0; Wed,  7 Sep 2022 21:37:38 +0200 (CEST)
Date:   Wed, 7 Sep 2022 21:37:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared
 here (not in a function)
Message-ID: <YxjzAnztFtvrtr96@hirez.programming.kicks-ass.net>
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
 <Yxi4os4PUWSARTS/@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxi4os4PUWSARTS/@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:28:34AM -1000, Tejun Heo wrote:
> On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
> > 2. This patchset depends on Tejun's commit e2691f6b44ed ("cgroup: Implement cgroup_file_show()") in linux-next
> > 
> >    Maybe peterz-queue should include that first? I don't know what's the normal way to handle.
> 
> FYI, this patch is in the Greg's driver-core/driver-core-next branch. If
> it'd be better to route these through the cgroup tree, let me know.

I can base sched/psi off of sched/core and driver-core-next and do a
separate late pull for it I suppose.

I'm guessing that is more or less what you'd end up doing too, right?

