Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554634653AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbhLAROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:14:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35430 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbhLARNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:13:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B80E4CE1FD9;
        Wed,  1 Dec 2021 17:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CECC53FAD;
        Wed,  1 Dec 2021 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638378621;
        bh=bR784jvzgGguSIueCPcbkWB/+GPwwBYa575LKG41YzQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pYqDVCvOqSHUpcSoGEDNRReaOGd7AvFyVW81EM/HSOhIFrHLfT87TLkGTJbqSkOOr
         awIT/Co2E4J0W5p5k07h/sZjfTpMbOZwthTbvmNbBGytjBRa95veTmhLctOIKBuKn1
         XrlZnDTGdjtmGOfamj9ENvfwU2TTxBv00/UQFfKt4rS9/JWJGSCbpPr6Br47Q8LjNj
         zYiyTZV1/CyXHLUkcbBGdQL6zSNHnHKlpmx+VTZn5MAgJ8iXC09icczAppsy/jVtgc
         sl71zW78wzU6B5s3SaekEtJIUDHYptxru+aVjOks/tBWoH5v0FC+8TbvE6ApTo1gWK
         M4qmfDVluNdaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 937065C0FC6; Wed,  1 Dec 2021 09:10:20 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:10:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS:  Add Frederic and Neeraj to their RCU files
Message-ID: <20211201171020.GG641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211201143312.GA3103715@paulmck-ThinkPad-P17-Gen-1>
 <b5a72137f2f412e0794987ff1f03adee93ffc92a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a72137f2f412e0794987ff1f03adee93ffc92a.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 08:42:11AM -0800, Joe Perches wrote:
> On Wed, 2021-12-01 at 06:33 -0800, Paul E. McKenney wrote:
> > Adding Frederic as an RCU maintainer for kernel/rcu/tree_nocb.h given his
> > work with offloading and de-offloading callbacks from CPUs.  Also adding
> > Neeraj for kernel/rcu/tasks.h given his focused work on RCU Tasks Trace.
> > As in I am reasonably certain that each understands the full contents
> > of the corresponding file.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -16084,6 +16084,8 @@ F:	tools/testing/selftests/resctrl/
> >  
> >  READ-COPY UPDATE (RCU)
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > +M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> > +M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
> 
> The words used in parentheses are email address comments and not
> file matches so get_maintainer will still show them on any file
> that matches the F:/X: patterns specified in the maintainers
> section block.
> 
> MAINTAINERS-F:  Documentation/RCU/
> MAINTAINERS-F:  include/linux/rcu*
> MAINTAINERS-F:  kernel/rcu/
> MAINTAINERS-X:  Documentation/RCU/torture.rst
> MAINTAINERS-X:  include/linux/srcu*.h
> MAINTAINERS-X:  kernel/rcu/srcu*.c

Understood, and the files in parentheses are only intended for human
consumption.  I am personally in favor on Frederic and Neeraj seeing
RCU-related patches.  ;-)

							Thanx, Paul
