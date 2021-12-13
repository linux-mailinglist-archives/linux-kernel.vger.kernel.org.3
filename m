Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45309472C74
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhLMMla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:41:30 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:51428 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230198AbhLMMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:41:29 -0500
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id BBBFD8A2;
        Mon, 13 Dec 2021 12:41:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 16FB326;
        Mon, 13 Dec 2021 12:41:20 +0000 (UTC)
Message-ID: <97eb3c3f68042443aa71c10766f3bef364e8f90b.camel@perches.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 13 Dec 2021 04:41:24 -0800
In-Reply-To: <Ybc5XPfd5f66L92i@smile.fi.intel.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
         <Ybc5XPfd5f66L92i@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.37
X-Stat-Signature: chw881zcpsmnn9bgfyxyxexu6wmj7q5r
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 16FB326
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19pJfXpE6U9kEdHLPF9l/n5IuA25lCRCDs=
X-HE-Tag: 1639399280-989290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-13 at 14:15 +0200, Andy Shevchenko wrote:
> On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:

> > +	struct kbd_struct *kb = &kbd_table[console];
> > +	int ret = 0;
> > +	unsigned long flags;
> 
> Slightly better to read:
> 
> 	struct kbd_struct *kb = &kbd_table[console];
> 	unsigned long flags;
> 	int ret = 0;

I don't think so.  Why do you?

