Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454CF4D6074
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiCKLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348204AbiCKLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:17:35 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CE1BAF24
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:16:27 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 342D52214E;
        Fri, 11 Mar 2022 11:16:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 75FF820025;
        Fri, 11 Mar 2022 11:16:24 +0000 (UTC)
Message-ID: <9b4e3cda7f5e8b630437cfc101f72810bc3f8d46.camel@perches.com>
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        javier@javigon.com, arnd@arndb.de, will@kernel.org, axboe@kernel.dk
Date:   Fri, 11 Mar 2022 03:16:22 -0800
In-Reply-To: <Yisr7WH+EfEhMbVY@kroah.com>
References: <20220311074413.14644-1-yusisamerican@gmail.com>
         <YisE6jjbzJyytqB8@kroah.com>
         <15e453381279ee9f607936d3b8d77806b58d9678.camel@perches.com>
         <Yisr7WH+EfEhMbVY@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 75FF820025
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 5po8kd3yc1ugunkpkbtwcyziegigaza3
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JF3V02d8DhJtbQQlhIUg4vRfWTPU7y6U=
X-HE-Tag: 1646997384-35921
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 12:01 +0100, Greg KH wrote:
> On Fri, Mar 11, 2022 at 02:45:01AM -0800, Joe Perches wrote:
> > On Fri, 2022-03-11 at 09:14 +0100, Greg KH wrote:
> > > On Thu, Mar 10, 2022 at 11:44:13PM -0800, Yusuf Khan wrote:
> > > > This patch upstreams the DDCCI driver by Christoph Grenz into
> > > > the kernel. The original gitlab page is loacted at https://gitlab
> > > > .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> > []
> > > > diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
> > []
> > > > @@ -0,0 +1,1887 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + *  DDC/CI sub-bus driver
> > > > + *
> > > > + *  Copyright (c) 2015 Christoph Grenz
> > > > + */
> > > > +
> > > > +/*
> > > > + * This program is free software; you can redistribute it and/or modify it
> > > > + * under the terms of the GNU General Public License as published by the Free
> > > > + * Software Foundation; either version 2 of the License, or (at your option)
> > > > + * any later version.
> > > 
> > > This does not match the SPDX line.  Please fix up first before going any
> > > further.
> > 
> > Which means fix up the SPDX line above to use the actual
> > license of the code.
> > 
> > // SPDX-License-Identifier: GPL-2.0-or-later
> 
> If that is the intent, it depends on the original author, I have not
> seen the source for where this came from, have you?

Tes.

Just take 10 seconds to look at the link provided in the text above
before you take 10 seconds to ask me instead.

https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master

And it's a bit odd of you to suggest otherwise when the link is
clearly shown and the actual license text is clear with
"(at your option) any later version".


