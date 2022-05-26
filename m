Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF837535185
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbiEZPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiEZPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:36:19 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC5BCEA6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:36:17 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 9D598596;
        Thu, 26 May 2022 15:36:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 2E10E2002A;
        Thu, 26 May 2022 15:36:15 +0000 (UTC)
Message-ID: <b93a8882649e69819e01b44d621f1fc33a7467da.camel@perches.com>
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Date:   Thu, 26 May 2022 08:36:14 -0700
In-Reply-To: <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
         <20220519172421.162394-2-kent.overstreet@gmail.com>
         <Yo+XZ4YtU9fN/sGE@alley> <20220526152127.gw7gb4jnoikop4hl@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2E10E2002A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: re8mr6iqgaqckdmzyoqapfn7d6u8ehdi
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/jTM04rXRmp+mKrB2FBSeZQSp0hn9TN9o=
X-HE-Tag: 1653579375-14664
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-26 at 11:21 -0400, Kent Overstreet wrote:
> On Thu, May 26, 2022 at 05:06:15PM +0200, Petr Mladek wrote:
> > The "pr_" prefix is a nightmare for me because the same prefix
> > is used also for printk() API ;-)
> > 
> > Could we please use "pb_" instead?
> 
> I'm not entirely against that, but I see printbufs as already in this patchset
> tightly coupled to vsprintf.c and thus quite related to printk, as well - and
> there aren't that many different pr_ things. So I think the shared prefix makes
> some sense, I'd like to hear what others think before making that change.

I think the reused prefix is not good.
bufs are not printks.



