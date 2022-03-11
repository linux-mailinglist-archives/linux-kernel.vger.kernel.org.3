Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE74D6002
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiCKKqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiCKKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:46:07 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF914EF65
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:45:04 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 8415A8136C;
        Fri, 11 Mar 2022 10:45:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id B3FE660009;
        Fri, 11 Mar 2022 10:45:01 +0000 (UTC)
Message-ID: <15e453381279ee9f607936d3b8d77806b58d9678.camel@perches.com>
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk
Date:   Fri, 11 Mar 2022 02:45:01 -0800
In-Reply-To: <YisE6jjbzJyytqB8@kroah.com>
References: <20220311074413.14644-1-yusisamerican@gmail.com>
         <YisE6jjbzJyytqB8@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: fi6z97dirmept86g9cxo9kkr7oejf3cz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B3FE660009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18eORL8decV1e1xVclhbFj8O6YZi9Ap/hk=
X-HE-Tag: 1646995501-212910
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 09:14 +0100, Greg KH wrote:
> On Thu, Mar 10, 2022 at 11:44:13PM -0800, Yusuf Khan wrote:
> > This patch upstreams the DDCCI driver by Christoph Grenz into
> > the kernel. The original gitlab page is loacted at https://gitlab
> > .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
[]
> > diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
[]
> > @@ -0,0 +1,1887 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  DDC/CI sub-bus driver
> > + *
> > + *  Copyright (c) 2015 Christoph Grenz
> > + */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or (at your option)
> > + * any later version.
> 
> This does not match the SPDX line.  Please fix up first before going any
> further.

Which means fix up the SPDX line above to use the actual
license of the code.

// SPDX-License-Identifier: GPL-2.0-or-later


