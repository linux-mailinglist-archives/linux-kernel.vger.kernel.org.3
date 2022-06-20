Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E62550F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiFTEy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiFTEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7FDEB5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j30w33pgKvnkmiJ8DHGQfIQa6b/GR+VvA+wwmWWYK7E=; b=O2Mz1eTEa1YyqV2pwYjciVC6Ar
        OPnfdVrsHZk+V0zKt7DQys+D5CF+U4oJ3lXxZIokHK6DTDVMCruAg9U4hdqtq6fb2kR7X7C7HhiIC
        qW6gEEie9tDL1Xqk9au/p6lSkP546hglKd8ESKyEN2cgk7qL8mrlUICPzWldciRfQqWxOctuxKNSH
        kndVFTo93k9kRQ1iLyD0s3ZNs9YLjeiJyN0SKGXvKSw6tjTydG6LqM6Z0mUu7S/Y1FZEUne+usQM7
        thjX8lz0NebgrIrbyhE3+uHjR+KiTTTxOvDfKlV16di0qyb7OopMtQ5JVRah8sfxstCNWXNh5HLJG
        PkAQ6DbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o39R2-004sEZ-P9; Mon, 20 Jun 2022 04:54:48 +0000
Date:   Mon, 20 Jun 2022 05:54:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <Yq/9mHZ4opmz+df9@casper.infradead.org>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> I really think that is a bad idea.
> printk() already uses a lot of stack, anything doing a recursive
> call is just making that worse.
> Especially since these calls can often be in error paths
> which are not often tested and can already be on deep stacks.

You made this complaint last time and I challenged you to provide data.
You have not, as yet, provided data.
