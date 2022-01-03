Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14900483158
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 14:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiACNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 08:24:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiACNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 08:24:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 761A4B80EA7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F153C36AEB;
        Mon,  3 Jan 2022 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641216238;
        bh=+bcTLaUgWHsLoBnTZrJn4nlfN54T2db4ye/+cH2BnYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJqSqztgB4NUpACIeclViOu5mBcOGClje6AFnOUzqnz2mP9DLitz5/VTVzFLgFkpd
         trhnMgtEk7H6aKMJZlXt9RAupO6JKPKJkT5OOGsEpGRddH3URThUBlDK4bYaWCzO1K
         uV9eGUDkkvlfyNYsxRdBkg1TFcRmZjy+jew64cDA=
Date:   Mon, 3 Jan 2022 14:23:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] mux: Add support for reading mux state from consumer
 DT node
Message-ID: <YdL46pTsM5dloS3n@kroah.com>
References: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
 <b9bb0b36-cf58-b436-6b72-c4211022981c@axentia.se>
 <YdLvX8TWBavEq8PH@kroah.com>
 <f5351a32-18d1-9426-1060-42d658435247@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5351a32-18d1-9426-1060-42d658435247@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 06:35:52PM +0530, Aswath Govindraju wrote:
> Hi Greg,
> 
> On 03/01/22 6:13 pm, Greg Kroah-Hartman wrote:
> > On Sun, Jan 02, 2022 at 11:38:29PM +0100, Peter Rosin wrote:
> >> From: Aswath Govindraju <a-govindraju@ti.com>
> >>
> >> In some cases, we might need to provide the state of the mux to be set for
> >> the operation of a given peripheral. Therefore, pass this information using
> >> mux-states property.
> > 
> > Where is the user of this new function?
> > 
> 
> This function will be used by the following patch series,
> 
> https://lore.kernel.org/lkml/20211216041012.16892-1-a-govindraju@ti.com/t/
> 
> Since the above has a dependency on this patch series, it is planned to
> be merged after this series.

Please provide the users of new functions as part of the same series,
otherwise it is impossible to determine how the functions are used, or
if they are even used at all.

We try to not add functions with no in-tree users.

thanks,

greg k-h
