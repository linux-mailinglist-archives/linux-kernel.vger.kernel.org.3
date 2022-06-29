Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1F5606C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiF2Q4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Q4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:56:50 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED602250C;
        Wed, 29 Jun 2022 09:56:49 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3177f4ce3e2so154175987b3.5;
        Wed, 29 Jun 2022 09:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkIej0UJ7PuUWn58IixeF0LRQS/u6RyIKeOWZv4NbdA=;
        b=GVKIIolGRvve74I/JsxWr1PGQWrExf52MGc8FdFocUJlSUjaw//POtC98qtHGUCdkP
         BkHALIAtdDOZnyQpvTpQvjJTPDYmaNvskNwxegc/36shoy5MecAVku0fdLUJqvLOG1DL
         w2QtF6LBAkOGI71M7aVF40qTBSE1ko3i9DBXAq2BpjJ5lXMkr+OrlMK2s2CjUpcjYqOn
         7u3f5VSWw4JMfs1b+57T8LN0I/M4YxTWOiNHkgzlSXehtTFoRd8HrtGMmWnqyOg4q/Dk
         BqOr+NUd903AtwllTSvPCyTp26CEOh3LijwL8M4A8cJVuKTcSnw1CdXUlApfbkDy+mNo
         jlBw==
X-Gm-Message-State: AJIora+epWyJeq18l0nzioaBfWteAZscjLUsCR0/N1SBdDUeT4Eux650
        fY3hU5UbI04VZcc+/pWtXUAqFe7L1GAvam0fF7AmcN44
X-Google-Smtp-Source: AGRyM1s2CbxkModmI/0O7hOvmw6DE7xd5G7FVUCy9hKt/wft6RsAcDx/TDDEpy8faKzufOPehWVJII78xYd5Usg/KAk=
X-Received: by 2002:a0d:d811:0:b0:31b:ddc4:c0ac with SMTP id
 a17-20020a0dd811000000b0031bddc4c0acmr5025839ywe.149.1656521808695; Wed, 29
 Jun 2022 09:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220617025152.1908638-1-luriwen@hotmail.com> <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <87v8szoccp.fsf@stealth>
In-Reply-To: <87v8szoccp.fsf@stealth>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 18:56:37 +0200
Message-ID: <CAJZ5v0gAJSfWmEJjawSHWnYB-rsBxcMyUQjAf4F3jpMhnjx+-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/processor: Remove unused function acpi_processor_get_limit_info()
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Riwen Lu <luriwen@hotmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Riwen Lu <luriwen@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:42 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Riwen Lu <luriwen@hotmail.com> writes:
>
> > From: Riwen Lu <luriwen@kylinos.cn>
> >
> > Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit_info()"),
> > left behind this, remove it.
> >
> > Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> >
> > ---
> > v1 -> v2:
> >  - Make this patch base on ("ACPI: Split out processor thermal register
> >    from ACPI PSS").
>
> For such changes, it is better to send all the related patches as a
> series so it's easy to see the dependencies . In a series the easy /
> obvious fixes should be earlier so it's easier for them to be merged
> while the more significant changes are still being discussed.
>
> Hopefully in this case Rafael too agrees with the dependency patch -
> otherwise, it's just extra churn on the lists.
>
> But don't resend just yet - give some time for others to add their
> feedback.
>
> > ---
> >  include/acpi/processor.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> > index ba1e3ed98d3d..9fa49686957a 100644
> > --- a/include/acpi/processor.h
> > +++ b/include/acpi/processor.h
> > @@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
> >  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
> >
> >  /* in processor_thermal.c */
> > -int acpi_processor_get_limit_info(struct acpi_processor *pr);
> >  int acpi_processor_thermal_init(struct acpi_processor *pr,
> >                               struct acpi_device *device);
> >  void acpi_processor_thermal_exit(struct acpi_processor *pr,
>
> Fwiw,
>
> Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Applied as 5.20 material with some edits in the subject and changelog.

Thanks!
