Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95853465316
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351573AbhLAQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:46:53 -0500
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:54484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243629AbhLAQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:45:40 -0500
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DF0A1182CED5B;
        Wed,  1 Dec 2021 16:42:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id D6FC919;
        Wed,  1 Dec 2021 16:42:11 +0000 (UTC)
Message-ID: <b5a72137f2f412e0794987ff1f03adee93ffc92a.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS:  Add Frederic and Neeraj to their RCU files
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, quic_neeraju@quicinc.com, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Date:   Wed, 01 Dec 2021 08:42:11 -0800
In-Reply-To: <20211201143312.GA3103715@paulmck-ThinkPad-P17-Gen-1>
References: <20211201143312.GA3103715@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.67
X-Stat-Signature: dp4jmj6fhpouzj5t19c5y7ues6opho8g
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D6FC919
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+3VTWOCwI1kgc+COb0JzfbH9l5rQhiHjI=
X-HE-Tag: 1638376931-224778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-01 at 06:33 -0800, Paul E. McKenney wrote:
> Adding Frederic as an RCU maintainer for kernel/rcu/tree_nocb.h given his
> work with offloading and de-offloading callbacks from CPUs.  Also adding
> Neeraj for kernel/rcu/tasks.h given his focused work on RCU Tasks Trace.
> As in I am reasonably certain that each understands the full contents
> of the corresponding file.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -16084,6 +16084,8 @@ F:	tools/testing/selftests/resctrl/
>  
>  READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
> +M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> +M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)

The words used in parentheses are email address comments and not
file matches so get_maintainer will still show them on any file
that matches the F:/X: patterns specified in the maintainers
section block.

MAINTAINERS-F:  Documentation/RCU/
MAINTAINERS-F:  include/linux/rcu*
MAINTAINERS-F:  kernel/rcu/
MAINTAINERS-X:  Documentation/RCU/torture.rst
MAINTAINERS-X:  include/linux/srcu*.h
MAINTAINERS-X:  kernel/rcu/srcu*.c



