Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8724641C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbhK3Wyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:54:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhK3Wyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:54:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638312676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxA+hkYYVjZHxRc6THX5MxPHFVrZJQ8zH99/DHDF0go=;
        b=HKchDQFnVY/VXzCkwfX8yCS8N0bmszIQkeg7ZgUvvyhzFasiElAxGRUsfQ6ql7eIYF7AS+
        YP8C5qfhZySCsgBDxuGTa0sna6f5y1rhAKAP8ep9HgI+iA/prNEQMwuQabCgpO8U1+jz0X
        Bskjgfxb3tJCl6b4+oWWcpZbBY/J0deDXwp0ZaAQgk/O3wwstb3gFEb6+pHiLHOQQtEq2Z
        6RPYT13e7BvW4WPAWXeTrU77GTgSSJu67lJyHQ/Jw8i+st4Rht+4s2D1NccKu2HgwjjPB8
        45uTeGziiqrr95VhyHyFQdDoQy6KogyHFFN3w78n1BAdWfM85CTSo51+P5ad5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638312676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxA+hkYYVjZHxRc6THX5MxPHFVrZJQ8zH99/DHDF0go=;
        b=JsekOn2ubU6M1MKijpmxmWPQYDF/lzeaEBxkPg0nnHsdUdQhkbs5CAfkkYR4dlT2REG/zh
        1eicH1hHDe/a/VAg==
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v12 1/5] x86: perf: Move RDPMC event flag to a common
 definition
In-Reply-To: <20211027201641.2076427-2-robh@kernel.org>
References: <20211027201641.2076427-1-robh@kernel.org>
 <20211027201641.2076427-2-robh@kernel.org>
Date:   Tue, 30 Nov 2021 23:51:15 +0100
Message-ID: <8735ndb6l8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27 2021 at 15:16, Rob Herring wrote:
> In preparation to enable user counter access on arm64 and to move some
> of the user access handling to perf core, create a common event flag for
> user counter access and convert x86 to use it.
>
> Since the architecture specific flags start at the LSB, starting at the
> MSB for common flags.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

        tglx
