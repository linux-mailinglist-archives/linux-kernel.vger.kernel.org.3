Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327A44857B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiAERw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:52:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59346 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiAERwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:52:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 529F06185A;
        Wed,  5 Jan 2022 17:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E27C36AE0;
        Wed,  5 Jan 2022 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641405170;
        bh=w6D+tWsjSSHuHo93oJpb8lN0kLDVlj0dTMFRl/odXmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDlFR1ANjZuW3UqMzSVze32bGV7Wal5UCphdrHab2Uhf35thLbhnh5c9GIL4stzMh
         gqDOXjRE6BDryRdLV9CHB/Gj4sbRa1UWQjZcVA8m1oxxLlPwok7G+7QMa9+VlP2Ehk
         L8akett14Q9W9d1+iCCuVtAbD1hfMF+0+WdbH2nI=
Date:   Wed, 5 Jan 2022 18:52:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: sq: use default_groups in kobj_type
Message-ID: <YdXa7y+3seYoV85z@kroah.com>
References: <20220104162240.1309639-1-gregkh@linuxfoundation.org>
 <4622e641-1423-e72a-4f6d-5f2cc747a148@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4622e641-1423-e72a-4f6d-5f2cc747a148@landley.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:46:28AM -0600, Rob Landley wrote:
> On 1/4/22 10:22 AM, Greg Kroah-Hartman wrote:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the sh sq sysfs code to use default_groups field which has
> > been the preferred way since aa30f47cf666 ("kobject: Add support for
> > default attribute groups to kobj_type") so that we can soon get rid of
> > the obsolete default_attrs field.
> 
> Let's see, sh4-specific, depends on CONFIG_SH_STORE_QUEUES... it built but I'm
> not finding an "sq" entry under /proc. (Or anything with "mapping" in it...)
> 
> Oh well, probably right? Didn't break anything for me:
> 
> Tested-by: Rob Landley <rob@landley.net>

Thanks!  Seems to pass 0-day testing as well :)

Should I take this in my tree?

greg k-h
