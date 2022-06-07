Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37502542568
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392146AbiFHBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582268AbiFGXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C1F4A4366
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92247614B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8531C3411C;
        Tue,  7 Jun 2022 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654641345;
        bh=bhM+3DUfK+yVmxrOHV8Ekk/TQbemZ0e85/OguE9jEGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAenFvip0aUWeWYJq/+CSOgQDDNrlLk6y9bMIVTA9jUP8zZ/83JY15xlkatSM4Ddi
         sHuPax1uQ0G/HZ0q4aG38z4+nXhzsR3y3XM+sN8YdOz/LJ8F7KgZMAdp2B+h1rc2d6
         J/xKI81hgnh2+t7l2glLYWSajAcdlcwI/CdJRqRg=
Date:   Tue, 7 Jun 2022 15:35:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 0/5] Reduce a vmalloc internal lock contention
 preparation work
Message-Id: <20220607153544.7727e87f669ea3a7c9f4a6b5@linux-foundation.org>
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jun 2022 11:34:44 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> This small serias is a preparation work to implement per-cpu vmalloc
> allocation in order to reduce a high internal lock contention. This
> series does not introduce any functional changes, it is only about
> preparation.

I can toss it in for some runtime testing, but...

What lock are we talking about here, what is the magnitude of the
performance issues it is causing and what is the status of the patch
which uses all this preparation?

