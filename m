Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEE476F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhLPKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhLPKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:54:24 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:54:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t6so22942931qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaq4AYvHrkraOXjSh4Dxq1xnyiNdkNmydNNcRNrMS9I=;
        b=lGKx4K34K4qKgeXT42r8Nb+V18P8JGzB3MdQXTLKhdw66EZvcrPDljJZLXJs9ATtXj
         KZMS080jGNTpU3woWA2HWimhhfBDFiXAyMDC+zxVKACLV8pPIqrhpyx0K2NEadjKmcqV
         UEbWzx/78zna4JHaP4uxj+xYdpdpwkn7zBl/41+oV6r748yW40yvZOlsP8RA//9w7OnO
         VmGMKo90ljMFaATgGLh++ap/3b/aONOQPZF7GyWFZ5LgigVwpzjPbCZQXs8D+qCH1g2p
         ieoXWrhz1YPCFyFqc+yTgUf01WgNCdMUvi3QTlskt5d//YzEGkAy9E49XqbbgmwMLXPb
         pWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaq4AYvHrkraOXjSh4Dxq1xnyiNdkNmydNNcRNrMS9I=;
        b=qe5sGSGbaGTn74VXtvPZ7rhugQqOPj/iBxLxH8xyVYXJPrDOsgWMnumC1D9wDgi0qd
         Fbazo0iswlepj8YQgJBIj1oGjSFA1X29j8uWGS/M3U05XKCkoJyaSBnogPFZI7itUCCY
         uD/WYD76dIAY8e0Uq6scFx4YBf15UkQwCmEQ3NxOk9tI3qX8owM3Jfr8h0YPx8b087Tg
         yLnq9JDzq/RGDMPRqx6AGUCF6H1FD3ukGAPdBXEzCENZbsz7wB/QmOWvclKgjKzthuvS
         SBWkGt42c86SQD6giJ2bNdeoxsdLfZ4YD9c0TXjKL9dR+jdcq7Zj3gsqN7apKd3HOtQa
         pUdw==
X-Gm-Message-State: AOAM5313N0SrqnP+QOnB/FQG+PcITBSigYcpneQNFTnA0Hf0nmpKk3rM
        0FrVb57SLvazXODv8FeFuZwafZPYPhC0ugruLPPpkg==
X-Google-Smtp-Source: ABdhPJy17wdiKVVEIPJ+n3Z+Q3CsCQsY10H85F/nbSMhs3J4ZdEuCw6iLuHDkDexT3DqYVledVijbVrmrl+gBnJM8VI=
X-Received: by 2002:a05:620a:28d2:: with SMTP id l18mr6008731qkp.355.1639652063228;
 Thu, 16 Dec 2021 02:54:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639432170.git.andreyknvl@google.com> <678a2184509f5622d4a068f762691eb3ef5897af.1639432170.git.andreyknvl@google.com>
In-Reply-To: <678a2184509f5622d4a068f762691eb3ef5897af.1639432170.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Dec 2021 11:53:47 +0100
Message-ID: <CAG_fn=XFFF16r0irayKp=CnrJsnL_uGR-uz2sa2G12=zrSGO1Q@mail.gmail.com>
Subject: Re: [PATCH mm v3 18/38] kasan, vmalloc: drop outdated VM_KASAN comment
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:53 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> The comment about VM_KASAN in include/linux/vmalloc.c is outdated.
> VM_KASAN is currently only used to mark vm_areas allocated for
> kernel modules when CONFIG_KASAN_VMALLOC is disabled.
>
> Drop the comment.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
