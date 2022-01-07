Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188A64870CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiAGCzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbiAGCzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:55:08 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8BDC061245;
        Thu,  6 Jan 2022 18:55:08 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B04C46EB4; Thu,  6 Jan 2022 21:55:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B04C46EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641524106;
        bh=mV/CusCbYN+ImDIAt+xzz3GQo7TXQaG57+I89Ej6n/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PidLj1BKKe2RHUPM8IfJuH/zCpPTWeh07ovOHSPDgerCJKrkdUemDAfCLBYkaB1nu
         IE6220rYJNKUryzB6XE6+Kfm01rlnu/d8CjQIme8gDbNXk2hVR78rR8cUNz5sFkknH
         CwdVk4OTvP1pCOtIgL7UWObJIbqCt0uDwGZxwmcQ=
Date:   Thu, 6 Jan 2022 21:55:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: state of the nfsd tree
Message-ID: <20220107025506.GA16601@fieldses.org>
References: <20220107134621.7814487b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107134621.7814487b@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 01:46:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> I noticed commit
> 
>   a71baee992c6 ("MAINTAINERS: remove bfields")
> 
> in the cel tree and was sondering if I shuld remove the nfsd tree
> (git://git.linux-nfs.org/~bfields/linux.git#nfsd-next) from linux-next.

Sounds like a good idea to me.

> Maybe I sould rename the cel tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux#for-next)
> to be the nfsd treeas well?

Probably so.

--b.
