Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7E4D604F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbiCKLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiCKLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB41B2AE2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E70D461B4B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D680FC340E9;
        Fri, 11 Mar 2022 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646996465;
        bh=JZ58Y8Mrlbc3C3YvnSSB2HJn2wQXjyBudT9bS4WB1fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQV6X6WZXeHzRJKx/4zoVZnHjOwseH6GKLrA9pWebweoGizo4iG0VJO9Ev5BLcYmK
         l/+FMcO+MlFss7oPJ7n3nDEtdJ0U9DgGxBqObn9YgPWt0jm5E3f1XMsOT27X15qBqD
         iym0/BZyrl2dluH7iZzC9c4BSbWjHumub1zq2wWE=
Date:   Fri, 11 Mar 2022 12:01:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        javier@javigon.com, arnd@arndb.de, will@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
Message-ID: <Yisr7WH+EfEhMbVY@kroah.com>
References: <20220311074413.14644-1-yusisamerican@gmail.com>
 <YisE6jjbzJyytqB8@kroah.com>
 <15e453381279ee9f607936d3b8d77806b58d9678.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e453381279ee9f607936d3b8d77806b58d9678.camel@perches.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:45:01AM -0800, Joe Perches wrote:
> On Fri, 2022-03-11 at 09:14 +0100, Greg KH wrote:
> > On Thu, Mar 10, 2022 at 11:44:13PM -0800, Yusuf Khan wrote:
> > > This patch upstreams the DDCCI driver by Christoph Grenz into
> > > the kernel. The original gitlab page is loacted at https://gitlab
> > > .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> []
> > > diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
> []
> > > @@ -0,0 +1,1887 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *  DDC/CI sub-bus driver
> > > + *
> > > + *  Copyright (c) 2015 Christoph Grenz
> > > + */
> > > +
> > > +/*
> > > + * This program is free software; you can redistribute it and/or modify it
> > > + * under the terms of the GNU General Public License as published by the Free
> > > + * Software Foundation; either version 2 of the License, or (at your option)
> > > + * any later version.
> > 
> > This does not match the SPDX line.  Please fix up first before going any
> > further.
> 
> Which means fix up the SPDX line above to use the actual
> license of the code.
> 
> // SPDX-License-Identifier: GPL-2.0-or-later

If that is the intent, it depends on the original author, I have not
seen the source for where this came from, have you?

thanks,

greg k-h
