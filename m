Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2048E83B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiANKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiANKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:19:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:19:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE98B823A5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8B3C36AE5;
        Fri, 14 Jan 2022 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642155545;
        bh=ywTra5QTmRO6NirMTkZ9bdysfIiAFf7WRL5XaV6RSPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKcm4rp0JCZ8uWVJIXYz/wHc5QdMaLxMaPm4iNSciRXxtTwGLY+giTlWAFmGY7Ta1
         BCaXoK5eYaCB00GCJYuk+qgsS2EOQaY2PFXsYJDr8w3m8i0i+enhYt6YLedXrRAGsf
         opnZN3h868dNKBzRiTJFLkIzxYVtNKeMDbJSG0EQ=
Date:   Fri, 14 Jan 2022 11:19:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Stefan Schaeckeler <schaecsn@gmx.net>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] ubifs: use default_groups in kobj_type
Message-ID: <YeFOFJ7W+bCq+A6o@kroah.com>
References: <20220113180857.2158974-1-gregkh@linuxfoundation.org>
 <bafc94269e6fa7632bc6ea458320b238@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafc94269e6fa7632bc6ea458320b238@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:08:03AM +0100, Michael Walle wrote:
> Hi,
> 
> Am 2022-01-13 19:08, schrieb Greg Kroah-Hartman:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the AMD mce sysfs code to use default_groups field which
> 
> copy & paste mistake?

Ugh, yes, sorry, will go fix this up, thanks...

greg k-h
