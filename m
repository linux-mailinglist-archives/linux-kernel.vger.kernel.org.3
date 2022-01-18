Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0014930CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiARWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:33:20 -0500
Received: from ms.lwn.net ([45.79.88.28]:51140 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237457AbiARWdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:33:19 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4B127608;
        Tue, 18 Jan 2022 22:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B127608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642545198; bh=2z6M/7nnhiDVsJMiSppLJzTLsH7M2OTGB1+SpVQEPgQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pFmru28CcULMP1iHDMOzW2/gUJbeQXA+YMLBFs4aHip5m6pEeQPgi7O4SC4PONPva
         8glJH+wAB3nI038vlMZYX4FJFl5RmeaEjp0LkJSow4fgvTKADMz8i3zIWugDR/FvCj
         sza+AkmTZZGDjVQiU+FR4mOO/CF9vvY5slqMQY3SIFLfWVy9RHbq0uZdkpwQnXCDaU
         hQLW1+rOOemsFMIFirG1wBkMjTvO5JcEfRN+pqXNC1zJdPm1Sv0H6bpfbWgF8t9v1U
         JK82OEmgh6PlG908ddA15TG7KPC0yQrcLm1oTH/+h2IBshYCbzOosBdY+Us1IpPy2R
         uoWE13X/KnKxg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH v3 14/19] docs: add Rust documentation
In-Reply-To: <20220117053349.6804-15-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
 <20220117053349.6804-15-ojeda@kernel.org>
Date:   Tue, 18 Jan 2022 15:33:39 -0700
Message-ID: <87fspk1xoc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:

> Most of the documentation for Rust is written within the source code
> itself, as it is idiomatic for Rust projects. This applies to both
> the shared infrastructure at `rust/` as well as any other Rust module
> (e.g. drivers) written across the kernel.
>
> However, these documents contain general information that does not
> fit particularly well in the source code, like the Quick Start guide.
>
> It also contains a few binary assets used for the `rustdoc` target
> and a few other small changes elsewhere in the documentation folder.

Glad to see documentation!

That said, I have one little request...

>  Documentation/doc-guide/kernel-doc.rst      |   3 +
>  Documentation/index.rst                     |   1 +
>  Documentation/kbuild/kbuild.rst             |   4 +
>  Documentation/process/changes.rst           |  42 ++++
>  Documentation/rust/arch-support.rst         |  35 +++
>  Documentation/rust/assets/favicon-16x16.png | Bin 0 -> 798 bytes
>  Documentation/rust/assets/favicon-32x32.png | Bin 0 -> 2076 bytes
>  Documentation/rust/assets/rust-logo.png     | Bin 0 -> 53976 bytes

We have really tried to keep binary files (like PNG images) out of the
documentation tree.  If we really need these images, can they be
provided in SVG form?

Thanks,

jon
