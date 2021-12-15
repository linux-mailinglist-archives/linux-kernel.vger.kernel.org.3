Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272BB47586F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbhLOMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:09:50 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43631 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbhLOMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:09:47 -0500
Received: by mail-ot1-f54.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so24638910otu.10;
        Wed, 15 Dec 2021 04:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCA5ded+I5x3sDgisFpvfN1DImt0yc2/pVxbT5RruKU=;
        b=kYIJKyF8FwLfWN6K9st4fi5N3v8hhIL6k1nHz9jJANVRBJ7sZNOW5wej3kXrliVFtR
         B57oved4AC0pjzsIMU0KjSn8U0Pn+nuHcS7rGfJry8D+NyD71hDeQVfKJchGiATTR2rD
         YmAO1G1ATwyf7vJyskpTaVjE93C2tVg+ARCnworjyyqLlsw6U8O3SLZ5umPELYCJy8zq
         yYIfJY0FVUCJNtWMwB1UksbyfkbrYFG3aOnJZNUX3afVzcI4NEDdJYJnVOODaZYsbZzm
         dQGxo2WS2vpaospGIUIeFDh0HylU7sInblPTn4Q8Vf7PdP2qKk0mvp4Ye/c9Lr+YxM47
         DygQ==
X-Gm-Message-State: AOAM530M21WLAzB76I88z5jR5jiXko6lKcAGV37+VO84zzPvL2VT0eSP
        iLdoDZZmxhQ07Rajfe/WGwlszjv9qpR6J7ab1nQDw68E3ZE=
X-Google-Smtp-Source: ABdhPJxHDsY/V2rG/GCrrjnWZd4A3MEHYJ5K+NLt8q0y7Qglh5WylkUyadI/6JbmFqh8ufI6ojPSjmC9qlCUwfzxHuk=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr8453925otf.198.1639570187360;
 Wed, 15 Dec 2021 04:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20211129061044.1779456-1-ishii.shuuichir@fujitsu.com> <e721c474-1788-5edb-3ce9-26b1ec03b784@huawei.com>
In-Reply-To: <e721c474-1788-5edb-3ce9-26b1ec03b784@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Dec 2021 13:09:36 +0100
Message-ID: <CAJZ5v0h4vA5qeys7MrCJLGF-Y5SQPvYoZn4AC+mo-6VZo6PZ_g@mail.gmail.com>
Subject: Re: [PATCH v3] acpi/tables: Add AEST in ACPI Table Definition
To:     Hanjun Guo <guohanjun@huawei.com>,
        Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 7:52 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2021/11/29 14:10, Shuuichirou Ishii wrote:
> > When We added AEST using the Upgrading ACPI tables via initrd function,
> > the kernel could not recognize the AEST, so added the AEST table to
> > the list to enable the table upgrade function.
> >
> > Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> > ---
> > v3 : Changed the location of the change log so that it does not
> >       disappear when the patch is applied.
> >
> > v2 : The reason for committing in the commit log was not clear,
> >       so it was pointed out and corrected.
> >
> >   drivers/acpi/tables.c | 2 +-
>
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 5.17 material under a new subject ("ACPI: tables: Add AEST
to the list of known table signatures") and with a cleaner changelog.

Thanks!
