Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01259A8FC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiHSWzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243256AbiHSWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601810DCD7;
        Fri, 19 Aug 2022 15:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D8A6182A;
        Fri, 19 Aug 2022 22:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243BCC433D6;
        Fri, 19 Aug 2022 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660949715;
        bh=6SLzADGIbpXl2meWiw7UY5YWi0+GnZPs6UAdbiVEgsU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yZWqihvtBtrmNvuE1FMUWX7JrhQbmbjiENO5kCHtfWMUDc/P0WeqUGp0NLLRGzCxM
         li28UVgNZaVn5vJe0ii0fIEUPH7VrRnygdw/+H7sxlyM8HnG+Siv7rEs9pd/rAJ+hc
         kc2ZjTLL5Jala6xvN5afwkBrb/Fop0Dq7n+OUT7I=
Date:   Fri, 19 Aug 2022 15:55:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-Id: <20220819155514.be312f8ceeaaf8e314a6badf@linux-foundation.org>
In-Reply-To: <20220819220243.ieq3drqvg3lcmark@revolver>
References: <20220819082714.5313827d@canb.auug.org.au>
        <Yv8vZQB25NE0r/uN@kroah.com>
        <20220819184027.7b3fda3e@canb.auug.org.au>
        <Yv9QArukYhIgg3R7@kroah.com>
        <20220819133458.eqshbr5xp4yr3xws@revolver>
        <20220819133539.f8eb934e29e8f4f72c62752b@linux-foundation.org>
        <20220819220243.ieq3drqvg3lcmark@revolver>
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

On Fri, 19 Aug 2022 22:02:53 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> > I moved "binder_alloc: add missing mmap_lock calls when using the VMA"
> > into mm-hotfixes-stable this week.
> > 
> > It's the v2.  I intend to send this Linuswards today or tomorrow.  Below.
> > 
> > So I think we're all good.
> > 
> > 
> > commit b3bb668f3dc6a97a91c47a4cebb0e3f33554c08c
> 
> ...
> 
> Sounds good, as long as it isn't the above commit which is v1, but
> d6f35446d076 which is v2 :)

Well dang, I somehow messed that up.  I have the v2 now.
