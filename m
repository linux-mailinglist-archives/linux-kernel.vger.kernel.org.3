Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D358F015
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiHJQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiHJQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:09:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294A7B1C8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t4MwVAfwkCB4EmT15HXtvuXRXMl6148oIcwvT5rWzH0=; b=kPMJXR6bwoyVWhfo3Q7xsHuiDo
        cu8JJgUYOjq7g3kEB5WIsh9x6nbEmYe6xEiLqmEL/GcqqRT1KRBcbdOcD0IQPc5DO2tLg0tFutO+n
        8jox7enRkWZGz1Xnf4MdfmCJVKzOq4mRpK+VYzdXJtVVQ2H5CJunExT5O4E0myfZ+CxWP/zb3jxwf
        fL8YjQ0IgMU+fDDCUbm8haoViYTGXvq78yp/5MjQ83XkXd+yz1/IUPk57t1LVhRD+3Rg2jNOETaC9
        Ua4TR8OXpDgLDsK0RXLQ6P9pLjXNifHs7hjH82RRbDD5IkjPI/38kLQtkqWzOwtuL6KxX+LEQ+h8d
        +RocqkeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLoH3-00Gzln-Lb; Wed, 10 Aug 2022 16:09:37 +0000
Date:   Wed, 10 Aug 2022 17:09:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: i915: crash with 5.19-rc2
Message-ID: <YvPYQeMjfyruTeGe@casper.infradead.org>
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com>
 <f0dd80b2-97e1-c320-8517-7ebdb027f58a@redhat.com>
 <4a204620-7639-c844-455-10e55b372bcf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a204620-7639-c844-455-10e55b372bcf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:55:32AM -0700, Hugh Dickins wrote:
> This is not a bug in zram or i915, but what Matthew fixes in
> https://lore.kernel.org/lkml/20220730042518.1264767-1-willy@infradead.org/

Thanks for tracking that down, Hugh.  Nice to know it's a crash rather
than a data corruption.  The fix is in Andrew's tree, so I think it's
already destined for upstream soon.

Andrew, I have two fixes that I don't see in your tree:

https://lore.kernel.org/linux-mm/20220808193430.3378317-2-willy@infradead.org/T/#u
https://lore.kernel.org/linux-mm/20220808193430.3378317-4-willy@infradead.org/T/#u

The first is of minor importance, the second I believe Hugh has hit in
his testing.

