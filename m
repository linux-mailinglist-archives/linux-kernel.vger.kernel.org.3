Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC9483C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiADHBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiADHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:01:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B876C061761;
        Mon,  3 Jan 2022 23:01:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB25B81145;
        Tue,  4 Jan 2022 07:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3182C36AED;
        Tue,  4 Jan 2022 07:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641279689;
        bh=OTRDvjxsF/ajfE2xEZpQNywuWW1KLMY5xzh91PDFsLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpG04RJMsq9lHiAGoXd+oOIOrYs4jSqhzoMIW/uQxSaaNWqhORIVUbcNKY0ghW5nu
         9Wc1Y9It+gU9x5DUXmqzUf1XAvd25uIT7qNwVEn4EDAjLabCypsZgZYUrgsCoAG+0m
         gwOi8rlV0UVNseKXj/zx5Mnq6SdaJyLzuOpcILT4=
Date:   Tue, 4 Jan 2022 08:01:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: sysfs: use default_groups in kobj_type
Message-ID: <YdPwxhuSiTwkPH8L@kroah.com>
References: <20211228144641.392347-1-gregkh@linuxfoundation.org>
 <20220103191321.GA31583@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103191321.GA31583@magnolia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 11:13:21AM -0800, Darrick J. Wong wrote:
> On Tue, Dec 28, 2021 at 03:46:41PM +0100, Greg Kroah-Hartman wrote:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the xfs sysfs code to use default_groups field which has
> > been the preferred way since aa30f47cf666 ("kobject: Add support for
> > default attribute groups to kobj_type") so that we can soon get rid of
> > the obsolete default_attrs field.
> > 
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: linux-xfs@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Looks good to me.  Shall I take this through the xfs tree?
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Please feel free to.  Or if you do not want to, I can take it through my
trees, which ever is easier for you, just let me know.

thanks,

greg k-h
