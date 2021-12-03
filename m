Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF659467A4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381795AbhLCPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381789AbhLCPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D28C061354;
        Fri,  3 Dec 2021 07:29:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8047562BEF;
        Fri,  3 Dec 2021 15:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F62EC53FD5;
        Fri,  3 Dec 2021 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638545384;
        bh=mOay9HVH5ASpXpZOd5zaNCJnGk5cbbWXMga7nvs8gV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsgAfqPsQPSzHofRvzkwYYdEtMu3FISxKt7KLIUwFogtTkdgPINM05Vh1NkTVlJrH
         +vq1cajrwbIeHqHindPGrDylHOMwLjgRcHcffH22HBzFen7ZhV0zRekAc+DYKia4ja
         oiyHK8BIL/5m6gYjqL6wId0HOWz4Gy2qvVgF9ImI=
Date:   Fri, 3 Dec 2021 16:29:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <Yao35lElOkwtBYEb@kroah.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 07:22:57AM -0800, Dave Hansen wrote:
> On 12/3/21 6:31 AM, Mathias Nyman wrote:
> >>> Can you please see if you can repro and fix this?
> >>>
> >>> This all was with current 5.16-rc3 on a tigerlake nuc.
> >>>
> >>> Also, perhaps you can update the guide on what sort of setup/cables
> >>> etc.. you need when either the host or the client is a usb3.1 usb-c only
> >>> device.
> >>>
> >> + Mathias, maybe he still has a USB 3.0 debugging cable.
> >>
> > Should have at the office, I'll pick it up next week and try it out.
> 
> Is someone at Intel responsible for this thing? get_maintainer.pl
> doesn't think so:
> 
> > $ perl scripts/get_maintainer.pl ./drivers/usb/early/xhci-dbc.c
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> > Mike Rapoport <rppt@kernel.org> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:5/5=100%,removed_lines:5/5=100%)
> > Andrew Morton <akpm@linux-foundation.org> (commit_signer:1/1=100%)
> > linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> > linux-kernel@vger.kernel.org (open list)

Intel is the only one that has this hardware :(


