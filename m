Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B553730B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiE3AGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiE3AG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BB737B3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9023660FC6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60065C385A9;
        Mon, 30 May 2022 00:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653869186;
        bh=mT1I3Fl37Fkszm5PlYwey/4KQg+RDSh/eN7Z/0JYqjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pd7wVlI61dtMkMOOvN2T1uMh8JGl9L0YXk0X+2KKI+4OJ7IQORCgRx0t6bOTUu8ZX
         Z1tohQoFHWEGHqtNCWp7vrOhlKAxZm1ncMn7sAnFbNOpQgIf6wPZiMPTGS8ZVY3TLD
         CVOzDDcgyW6r6KQKmcEWL1w/H++wcZxi1VJQhrbo=
Date:   Sun, 29 May 2022 17:06:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm: Add PAGE_ALIGN_DOWN macro
Message-Id: <20220529170624.0ceefb52ffd2c4496cbe696d@linux-foundation.org>
In-Reply-To: <20220527185600.1236769-1-davidgow@google.com>
References: <20220527185600.1236769-1-davidgow@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 11:55:59 -0700 David Gow <davidgow@google.com> wrote:

> This is just the same as PAGE_ALIGN(), but rounds the address down, not
> up.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please include this in the UML tree alongside [2/2].
