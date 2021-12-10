Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B74707E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbhLJR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbhLJR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:59:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BDC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EAF8B8294B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AE2C00446;
        Fri, 10 Dec 2021 17:55:39 +0000 (UTC)
Date:   Fri, 10 Dec 2021 17:55:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 17/34] kasan, x86, arm64, s390: rename functions for
 modules shadow
Message-ID: <YbOUmEBU2TwVAu4t@arm.com>
References: <cover.1638825394.git.andreyknvl@google.com>
 <11f5a6419f8830fdedc84dca5f847543ef7960f4.1638825394.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f5a6419f8830fdedc84dca5f847543ef7960f4.1638825394.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:43:54PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Rename kasan_free_shadow to kasan_free_module_shadow and
> kasan_module_alloc to kasan_alloc_module_shadow.
> 
> These functions are used to allocate/free shadow memory for kernel
> modules when KASAN_VMALLOC is not enabled. The new names better
> reflect their purpose.
> 
> Also reword the comment next to their declaration to improve clarity.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
