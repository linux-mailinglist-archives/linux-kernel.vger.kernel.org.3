Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB535129D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiD1DMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102EE5DA29;
        Wed, 27 Apr 2022 20:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F5A961A11;
        Thu, 28 Apr 2022 03:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EC7C385A7;
        Thu, 28 Apr 2022 03:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651115367;
        bh=+iaD61aHLHqYdABkvvomUIHH7N/Ol9B1RkyIMYc6w74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0uozfCkoR6JHjE5/ENn8eBKX4A98inWr77YfCkehlctasa3O6iqeA2sDnFIVcHwt
         zihdFVr+ThldCum1ZTOgETqiFL0UVYetp73CqkcwAig0rcJAFYo8SbR2/TMc/rkdd8
         vJsmzxzWAzhq6kCUCAKkW+eUyQcp/K5xF2D00w3A=
Date:   Wed, 27 Apr 2022 20:09:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20220427200926.bd22f6b77eb1fa601a56d9ec@linux-foundation.org>
In-Reply-To: <20220428023743.qaxoj7nrrp5buixn@revolver>
References: <20220428084239.06ebf49d@canb.auug.org.au>
        <20220428023743.qaxoj7nrrp5buixn@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 02:37:53 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * Stephen Rothwell <sfr@canb.auug.org.au> [220427 18:42]:
> > Hi all,
> > 
> > In commit
> > 
> >   bc7608890065 ("mm/mlock: use maple state in apply_mlockall_flags()")
> > 
> > Fixes tag
> > 
> >   Fixes: 0d43186b36c1 (mm/mlock: use vma iterator and instead of vma linked list)
> > 
> > has these problem(s):
> > 
> >   - Target SHA1 does not exist
> > 
> > Maybe you meant
> > 
> > Fixes: 1dfcb33e7c19 ("mm/mlock: use vma iterator and instead of vma linked list")
> 
> I did.
> 
> > 
> > This is a semi-automatic notification - I know this is just a fix patch
> > that will probably be rolled into the patch it fixes.
> 
> I'm sorry but there will most likely be more of these since I used a
> side branch for my fixes today.

I dunno about all of this.  My approach to SHA1 shortening is to lean
on the backspace key until it looks about right (circa 1.5" in metric),
then ship it.

How about we simply turn this off?
