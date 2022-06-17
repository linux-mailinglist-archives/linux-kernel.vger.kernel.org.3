Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7919A54EF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379743AbiFQCXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379309AbiFQCXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F064D1D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166FC61B1C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10930C34114;
        Fri, 17 Jun 2022 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655432616;
        bh=7uX2eRg/VxVeS8nduYNANFsLa58NiOLig2gZtrtVtMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oI9MClnGXCkVgoRzhM+L975h2BdeU1+j3l1izJD36Gwv7cM/bf6HQreS4Bx3d2F0S
         IkIk1TZ9hLpuN1V8rKnRto0ykShIiLRrL2viUDUpVou2gu4+JTzKL0PzMO1LiOXhR2
         saYBekZeQRU8pz6daxb4wM1eUZ/pbN6zjBAKWYNw=
Date:   Thu, 16 Jun 2022 19:23:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 1/3] mm: rename kernel_init_free_pages to
 kernel_init_pages
Message-Id: <20220616192335.0f1448680d905a6e22ff700d@linux-foundation.org>
In-Reply-To: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
References: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jun 2022 20:18:45 +0200 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Rename kernel_init_free_pages() to kernel_init_pages(). This function is
> not only used for free pages but also for pages that were just allocated.
> 

Not a lot of review on these three patches.  I'll plan to take silence
as assent and shall move these into the mm-stable branch a few days
hence.

