Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D969D5528F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiFUB1F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 21:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUB1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:27:03 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D71900A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:27:02 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 1CDB432FB4;
        Tue, 21 Jun 2022 01:27:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 8A60120012;
        Tue, 21 Jun 2022 01:26:59 +0000 (UTC)
Message-ID: <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
From:   Joe Perches <joe@perches.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Date:   Mon, 20 Jun 2022 18:26:58 -0700
In-Reply-To: <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
         <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
         <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
         <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
         <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 6i9xmf7fozugzaj85ucgm93s6c5syqtf
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8A60120012
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6laJhvDVSxjllgACLhEHrhgVyrTNCaWA=
X-HE-Tag: 1655774819-286916
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 20:57 -0400, Kent Overstreet wrote:
> On Mon, Jun 20, 2022 at 05:38:51PM -0700, Joe Perches wrote:
> > On Mon, 2022-06-20 at 11:07 -0400, Kent Overstreet wrote:
> > > On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > > > I really think that is a bad idea.
> > > > printk() already uses a lot of stack, anything doing a recursive
> > > > call is just making that worse.
> > > > Especially since these calls can often be in error paths
> > > > which are not often tested and can already be on deep stacks.
> > > 
> > > We went over this before - this patch series drastically reduces stack usage of
> > > sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...
> > 
> > I generally agree with David.
> > 
> > I think Kent has not provided data that this actually _reduces_
> > stack usage.
> 
> I think the people who are comfortable with reading C can discern that when
> large stack allocated character arrays are deleted, frame size and stack usage
> go down.

I am very comfortable reading C.

You have not provided any data.

