Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4865A4BAFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiBRDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:07:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiBRDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:07:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402E689327;
        Thu, 17 Feb 2022 19:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TFcv3hJgDtWWR6ruZhsTad8bORy5a0SPA8ynqp/hYi4=; b=ZL1HI7Njdnbv3bzWwefaPuBMTX
        Al3ARIBsE5q1dzxJfjtUoIVNlmj0cY3a1BNWyYjLu5n7rwkfEw9GsejYhf3Mj47ReUZEtvfvMZQgT
        GwsXrAjZDNIi5JYTnJeUvJWbokfu3Mb/2AmIHlsQp9uv/2KSrKZOMk4eWHQOgGNrc+d/BlzbbC1Ea
        raJOZx1MqpP2w/2Oq+psN+aNH/niP5TG4VQLln7c3AsRPvgZUxMC7zrGbEBpmwFcguCE0wZnFnTQ+
        XzCdxo2/DVGOoIV10ZHbdHMh/JWaZB979pqVVYzH66WEKAWClCHGg4RzwXkxG1QjdlxWT/uI61bW6
        A0xlWRYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKtbu-00GECC-4e; Fri, 18 Feb 2022 03:07:06 +0000
Date:   Fri, 18 Feb 2022 03:07:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
Message-ID: <Yg8NWrvooEDbKg49@casper.infradead.org>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
 <8735ki2x62.fsf@meer.lwn.net>
 <20220217163247.03e37c9b@fuji.fritz.box>
 <87bkz51l2g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkz51l2g.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:04:23AM -0700, Jonathan Corbet wrote:
> *I* prefer Python, and the Sphinx side of things is necessarily in
> Python, so I'd be happy to see kernel-doc move over.  That said, others
> certainly disagree.
> 
> Markus's work was here:
> 
>   https://lore.kernel.org/lkml/1485287564-24205-1-git-send-email-markus.heiser@darmarit.de/
> 
> At the time, we were just trying to get the RST transition done, and
> swapping out the kernel-doc script seemed like a major distraction that
> we didn't need, so this never got looked at as seriously as I would have
> liked.

Personally, I'd like to see us switch over to
https://github.com/jnikula/hawkmoth

but I don't have time to work on the rough edges.  I really hate the
kernel-doc style; I think it makes us write very stilted documentation,
full of parameter descriptions like:

 function() - Do the thing to a page.
 @page: The page.

which really serves nobody.  Being able to write:

 function() - Do the thing to @page

is easier to both write and read.
