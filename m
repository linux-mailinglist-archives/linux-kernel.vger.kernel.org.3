Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CC4964D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382017AbiAUSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351942AbiAUSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642788604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqh1++d+JY4BasdGg/7RHLKqtDDn+ODlJo6mE4WZL2o=;
        b=LR8EZOyA9y8jxPkFVZhOG+5PM0rXZBe/l13AS5dZJUyznliGVtq/oWxLz6mQ6YQCmoQbO8
        p+nDmxA3UsUJVRaRMUGiXS8rnRQM7cDiH4Fpf/d8mzd7Rr42C6TTXtGgcba3juDwGIo7rD
        8o5zJWDLdhT7Q4rl0Go1x7NlWGzMZgE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-qH0QDvcXNJOMGtXt_O0sSQ-1; Fri, 21 Jan 2022 13:10:03 -0500
X-MC-Unique: qH0QDvcXNJOMGtXt_O0sSQ-1
Received: by mail-ua1-f71.google.com with SMTP id v10-20020ab036ca000000b003068cf1e17bso6052446uau.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqh1++d+JY4BasdGg/7RHLKqtDDn+ODlJo6mE4WZL2o=;
        b=e9xuIt6PE0LGmr5UWvqH6TTJG6CkyjoasczVeXoqvA/E8a88BiJVHvSSv06rJvMDEO
         ljSZ1rirInkbYgHpJ5n3jXnFLdVTHpemK2ulfhmZFS8NoQkJZqIBkc6k+cwUpmy+Bqbl
         Z6GCnIfIpVNRbNqiHmCKGzz0T//Gu2BpAE9Oqc5kuI/8DdY6ntCzbEbSSnX6QXBQ4Sfx
         b8rz/5ifdaI1dD3qMPaCS+lOUzw8eD5Qv31ELSD9rB/rYIqC6OCqII9dwxqiRuJ08b8O
         jV1FN7hjIYAjmquO/dpTd/u4eGuk1DFQ4azl70N1/Xt0l3hXzt3Nxvm27EAz5RD47mNk
         TZIQ==
X-Gm-Message-State: AOAM53108nRZKzcZaqjaVmrbXFXrYsUhhfWNWdsiY18sMBC7DZCCoTrN
        WDVs0ClRT0oUTK0tebEErHakqNqYV04e2oW24C8gKJ1RkRqSmGJswWSIS3FJj8ArMTDBBPf5VXS
        jDQwssWvRMWPwnGFcj6n++a5k21Y2Fi9XYT9gff4t
X-Received: by 2002:a67:c911:: with SMTP id w17mr2052006vsk.23.1642788602589;
        Fri, 21 Jan 2022 10:10:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIcdTU8wiDW6QlfD7iXb6wp73IfAqgwR1iqWVlTAgtLeEudcV3iLG/Aae+NYvTZGwrcZ+6r/lnRcWIx3JHH+o=
X-Received: by 2002:a67:c911:: with SMTP id w17mr2051986vsk.23.1642788602329;
 Fri, 21 Jan 2022 10:10:02 -0800 (PST)
MIME-Version: 1.0
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Fri, 21 Jan 2022 13:09:51 -0500
Message-ID: <CAC1cPGwb9eM=0VWiZx+G909Jt7a7=yx1CnVJ=kaFJfn4qxNWPw@mail.gmail.com>
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
>         include/asm/epapr_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */
>         include/asm/fsl_hcalls.h:/* SPDX-License-Identifier: GPL-2.0+ OR BSD */

"BSD" is not a defined SPDX identifier. I believe what you want here
is "BSD-3-Clause" (see: https://spdx.org/licenses/BSD-3-Clause.html)

Richard

