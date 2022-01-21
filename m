Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7651A4964E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382068AbiAUSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351856AbiAUSRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642789055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GaacSGyAu6TYOpVxBPJ/k9LHhTirl5xGNv6nlz2aQl4=;
        b=VO+0ZtFMxddVMk9HJMZPdcWcY4Ze4XB0NfMIGSQzaH3SL0tI2DtkHwnmZ4TcdCEpT1EsAz
        AM92EdXLwyqa1RgldURTT3dNDlNcdZYSynd2u9bb/9t8H4qNGa8K+kyJnbW0+s+15/mGMm
        4HJQfXiyPwUA4ZbQ4aCwPG2mF73T6J4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-EaAgm0GHMWq1LH-QxG1W7g-1; Fri, 21 Jan 2022 13:17:34 -0500
X-MC-Unique: EaAgm0GHMWq1LH-QxG1W7g-1
Received: by mail-ua1-f69.google.com with SMTP id q19-20020ab04a13000000b002fef2f854a6so6048709uae.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaacSGyAu6TYOpVxBPJ/k9LHhTirl5xGNv6nlz2aQl4=;
        b=j4uo9UT77BtmdXNQ/mjBRCjG+R0Lly7rA3PTBrluQ+Rdj6l9hFoa3fjXU/nlZzEaFD
         U6n3YpLaepThHirFwqHLM+ihkYOngIkF0KuOecz0WeIZVwN2b8PBCrQoNvdfzcFe/foK
         /Y5Vpt8wwPaP33auaKdG65KEPnmuYWcKGIwG6B4/2QLZh8oe9UoiyFvC5sFGmtotoJ8g
         VB/105pby7SvUPD1ucmnKp5wZ+jThv5q1XGNLc4+0Ru9hYs6RJFiXdXbABbjdzUDusj/
         mIT7aMHZF+Y0zffI2FwrYElZzPJClvD+gyFTNyioqqZy4tY0UUflTGV/A3CEzBN1v97g
         o2uw==
X-Gm-Message-State: AOAM533IFbz0j12NYzv3W5XWJkxdi1jMbAJI/BO32XyyOnlTH7GVYSAd
        +jI/VH2y/m7T0BLuWj59RmeS93ejz7yboqa1TCrO+6XTtFGTwlBmbHa17FcckXGCl1MKOy9SLqJ
        X8+t2RcYJWpkxkqU0LkAeakckPW/lHPumbwlxR2x8
X-Received: by 2002:a1f:5702:: with SMTP id l2mr2301196vkb.33.1642789053502;
        Fri, 21 Jan 2022 10:17:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKQVWJ6KXJy3LfcxZ4flOAQ9SGhoyK4JC3P8EQNxA7sLFJZbBXV8PCImDr+/8PzRc9uNEajJchjCAEfDylnfU=
X-Received: by 2002:a1f:5702:: with SMTP id l2mr2301185vkb.33.1642789053268;
 Fri, 21 Jan 2022 10:17:33 -0800 (PST)
MIME-Version: 1.0
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Fri, 21 Jan 2022 13:17:22 -0500
Message-ID: <CAC1cPGypAKcAAia4ipgTWNu33HLW=fb0CSroqR=SK-umrOJb-Q@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: Add missing SPDX license identifiers
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 6:03 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Several files are missing SPDX license identifiers.
>
> Following files are given the following SPDX identifier based on the comments in the top of the file:
>
>         include/asm/ibmebus.h:/* SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD */
 [...]
>         platforms/pseries/ibmebus.c:// SPDX-License-Identifier: GPL-2.0 OR OpenIB BSD

"OpenIB BSD" is not a defined SPDX identifier. There is an SPDX
identifier "Linux-OpenIB"
https://spdx.org/licenses/Linux-OpenIB.html
but I believe that is not a match to what's in these files
(specifically, the wording of the disclaimer), rather I believe what
you want here is BSD-2-Clause, but you may want to check that.

Richard

