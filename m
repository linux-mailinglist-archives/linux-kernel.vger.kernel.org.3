Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8F48686E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiAFR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:26:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbiAFR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641489990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/tjE9Rl0cFSbYTg7KMQimkZAPm0+MbhtQojTHAS147M=;
        b=OVkk5hkdRvhAo6Sx2cZwvLAbnwC/DQb/phVmxm3nhyyEwxIP1RIA2Cuvr9Lf4p6iibsIN7
        JGs6ot3tFdJNrBkmbqK5q1zk9gGRDt5E1zskOt3iCZuANUVNSS16qSUuqjSP8+Omt1iubP
        nxCDaszW3+fCqq95fGaGGJa4y+NPex8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-bi9hAoHVPyGleDTpkeyzYQ-1; Thu, 06 Jan 2022 12:26:27 -0500
X-MC-Unique: bi9hAoHVPyGleDTpkeyzYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09E981CCB4;
        Thu,  6 Jan 2022 17:26:25 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA2D07FBAD;
        Thu,  6 Jan 2022 17:25:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 153F341885DA; Thu,  6 Jan 2022 10:43:23 -0300 (-03)
Date:   Thu, 6 Jan 2022 10:43:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 0/8] sched/isolation: Split housekeeping cpumask
Message-ID: <20220106134323.GA165892@fuller.cnet>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:49:36PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> To prepare for extending cpusets to control CPU isolation features
> (nohz_full, rcu_nocbs, unbound timers, workqueues, kthreads affinity...),
> we need to split the global housekeeping_mask to one cpumask per isolation
> feature.
> 
> Doing so is quite a chunk already so I'm working on that as a standalone
> patchset. Once that get merged, the next step is to finally provide a
> cpuset interface for one of these isolation features: rcu_nocb could
> be interesting to handle first as nohz_full depends on it.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	isolation/split
> 
> HEAD: 2c07a16ff50d1e722babee28b926d70522e6bd3e
> 
> Thanks,
> 	Frederic

Looks good.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>


