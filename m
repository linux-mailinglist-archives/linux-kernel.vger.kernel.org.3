Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886D44B9871
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiBQFvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBQFvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0895413DE7;
        Wed, 16 Feb 2022 21:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3712B80D56;
        Thu, 17 Feb 2022 05:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DDAC340E8;
        Thu, 17 Feb 2022 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645077085;
        bh=DbWFlI8tR+zfxxtBr/EFeEr5eetJy4Sz7A2lzK7mrEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P1Y8CY/LkMU0O+62HvfFKN07FRBgmUnpGbFouLqN7Q3sCYJcHGel+Wk9gcrSrO35N
         RfZlaSbH1I9+XXOjVAKWGyGgby9ORPJdLQ3Ll+vcqdBg/56iSStilTpSPt6Uxu7im2
         kxGBo9HGUqMp6qcgzNtf+oareAsvNxLYAu18n2Hg=
Date:   Wed, 16 Feb 2022 21:51:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-Id: <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org>
In-Reply-To: <20220217163026.5e48ccb1@canb.auug.org.au>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
        <20220216172109.72fd0a38@canb.auug.org.au>
        <Yg1hf0iHdKcjnq6l@casper.infradead.org>
        <20220217163026.5e48ccb1@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 16:30:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Matthew,
> 
> On Wed, 16 Feb 2022 20:41:35 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > So where do we go from here?  I can see ways of resolving this if
> > Andrew switches to git, but he won't, so that's out.  Perhaps I can
> > publish a git tree of Hugh's mlock patches and Christoph's series,
> > and you can pull that before Andrew's tree so git resolves the conflicts
> > early before trying to resolve conflicts against my tree?
> 
> My response for any other subsystem would be that you need to go
> through the maintainer's tree.  In this case that means feeding a patch
> series to Andrew and updating that patch series.
> 
> Alternatively, you need to find someone (with Andrew's agreement) who
> can maintain a git tree that includes all Andrew's MM patches and any
> other topic branches and deals with all the conflicts and can feed it
> all to Linus.  Linux-next would also include that tree/branch.
> 
> Andrew, do you have any comments?

Let's try Matthew's idea - I'll get Hugh's and Christoph's series via
linux-next and shall figure out the rest.

I assume mapletree will throw another spanner in the works?
