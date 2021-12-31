Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD148218B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 03:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbhLaCbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 21:31:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57452 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbhLaCa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 21:30:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB142B81D48
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 02:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2B9C36AEB;
        Fri, 31 Dec 2021 02:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640917855;
        bh=7sj6CF347P5a5/CxHJ7uph1lB75B+xCi7nel49MY9zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XK8n+Jc/An9PwVTFKOfQJEStMegbPxwKDAr0sckaO8mSFQ7/hH8KeS/Ibu9thFvya
         cj0YlnEn0b9mxm27IZi9TZiE65utdVPjAobH+BpM/SMM5L46mLnp7REU9ZIMVo/ubq
         UhZrGzrGuJz5Tv/U3orZz8d9yJmGiMCk2kj9ogwU=
Date:   Thu, 30 Dec 2021 18:30:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Subject: Re: [PATCH mm v5 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
Message-Id: <20211230183054.a06a88b459b393957cb2d823@linux-foundation.org>
In-Reply-To: <CA+fCnZd+sBzecOGBD8zR3CxXS1yjV-X3-epAb6N=ZT8rJdCU6A@mail.gmail.com>
References: <cover.1640891329.git.andreyknvl@google.com>
        <CA+fCnZd+sBzecOGBD8zR3CxXS1yjV-X3-epAb6N=ZT8rJdCU6A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 20:19:01 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> Could you PTAL and consider taking this into mm?

What's PTAL?

We're at -rc7 so I'll process this after -rc1.
