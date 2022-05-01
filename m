Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA8516699
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353069AbiEARYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiEARYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:24:10 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C02DF14
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:20:39 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 9A49229585;
        Sun,  1 May 2022 17:20:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 86C3120015;
        Sun,  1 May 2022 17:20:37 +0000 (UTC)
Message-ID: <7aad0831441e864660b181f9f52f9be759466d4b.camel@perches.com>
Subject: Re: [PATCH] USB / dwc3: remove a possible unnecessary 'out of
 memory' message
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kushagra Verma <kushagra765@outlook.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 01 May 2022 10:20:36 -0700
In-Reply-To: <Ym6+1wPawNOUKKTr@kroah.com>
References: <SI2PR01MB3929F20DA02363BD6A88657DF8FE9@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
         <Ym6pp/O1fpneA5ZW@kroah.com>
         <8cf3b100a4dc0eaac9214e1a9ea2b6dace7c85bb.camel@perches.com>
         <Ym6+1wPawNOUKKTr@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 86C3120015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Stat-Signature: pf67r1t9prdqj6k1zzr9mdzxnncxfkz4
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19o7rmahgF44yQHAISnHs/J3PcRl4q7G50=
X-HE-Tag: 1651425637-850317
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-01 at 19:09 +0200, Greg KH wrote:
> On Sun, May 01, 2022 at 09:50:45AM -0700, Joe Perches wrote:
> > On Sun, 2022-05-01 at 17:39 +0200, Greg KH wrote:
> > > On Sun, May 01, 2022 at 09:01:36PM +0530, Kushagra Verma wrote:
> > > > This patch removes a possible unnecessary out of memory message from
> > > > core.c
> > > > as reported by checkpatch.pl:
> > > >    WARNING: Possible unnecessary 'out of memory' message
> > 
> > 
> > > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > > a patch that has triggered this response.  He used to manually respond
> > > to these common problems, but in order to save his sanity (he kept
> > > writing the same thing over and over, yet to different people), I was
> > > created.  Hopefully you will not take offence and will fix the problem
> > > in your patch and resubmit it so that it can be accepted into the Linux
> > > kernel tree.
> > > 
> > > You are receiving this message because of the following common error(s)
> > > as indicated below:
> > > 
> > > - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
> > >   and can not be applied.  Please read the file,
> > >   Documentation/email-clients.txt in order to fix this.
> > 
> > Seems like a patch-bot false positive patch-bot to me.
> > 
> 
> Try to apply the patch, it is line-wrapped.
> 
> It's a good bot :)

Right, I was just looking at the patch but it's the patch header
that's wrapped.

