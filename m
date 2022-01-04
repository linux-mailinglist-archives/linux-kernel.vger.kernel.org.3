Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070D148476C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiADSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:05:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiADSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:05:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99EE8B817A1;
        Tue,  4 Jan 2022 18:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38CC36AED;
        Tue,  4 Jan 2022 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641319508;
        bh=7RSdFQFpBqdCoxl/65c9xSRVLdInWEhy73odzDwXXy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GICvKzbjdWXAx0LarWK3Fjffui6HX4G7B9+byizgVbWPOr7Q89w9izxhccUJDL+s2
         IXVqnH/8VmqnwUjyYG55INPRixcO1XUSnx3Bzl5iN+7di7vF977SaTDclrvlQihLzN
         HU7s1inhI0T6sT+n4oF+m4FpNuqUjAaeL0f0HQNgV7hMh//XBvBT3RoiuAkhodR69Y
         nUCw1L8r7+xHQYlZcbBPsfhD2K3rVJ9JCOU/GTlRY9Zyn2EfcE49GGLCnnAPm/eoeU
         CJB09U3yaVBEQbmNHoSClnTM6jBVy5iilN2gpRjf9M21ErBMOU5xCoyBcsgrfN9bzU
         TVWpU11sA6fXg==
Date:   Tue, 4 Jan 2022 10:05:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: sysfs: use default_groups in kobj_type
Message-ID: <20220104180507.GE31583@magnolia>
References: <20211228144641.392347-1-gregkh@linuxfoundation.org>
 <20220103191321.GA31583@magnolia>
 <YdPwxhuSiTwkPH8L@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdPwxhuSiTwkPH8L@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 08:01:26AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 03, 2022 at 11:13:21AM -0800, Darrick J. Wong wrote:
> > On Tue, Dec 28, 2021 at 03:46:41PM +0100, Greg Kroah-Hartman wrote:
> > > There are currently 2 ways to create a set of sysfs files for a
> > > kobj_type, through the default_attrs field, and the default_groups
> > > field.  Move the xfs sysfs code to use default_groups field which has
> > > been the preferred way since aa30f47cf666 ("kobject: Add support for
> > > default attribute groups to kobj_type") so that we can soon get rid of
> > > the obsolete default_attrs field.
> > > 
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > Cc: linux-xfs@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Looks good to me.  Shall I take this through the xfs tree?
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Please feel free to.  Or if you do not want to, I can take it through my
> trees, which ever is easier for you, just let me know.

I'll put it in my tree, thanks for freshening the sysfs code! :)

--D

> thanks,
> 
> greg k-h
