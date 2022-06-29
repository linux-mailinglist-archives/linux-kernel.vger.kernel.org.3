Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B290E5607B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiF2Rt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiF2RtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:49:22 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C4C1401A;
        Wed, 29 Jun 2022 10:49:18 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id v38so18585219ybi.3;
        Wed, 29 Jun 2022 10:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEj0L9yPBFIov6GzHkQf/TLPGDuR00sIvqo6B9sXrY4=;
        b=WDbe/wk4e7WW3jc38h1g52dFJzQSmEoqk3ykoPAubl0VpMrS6Au4m72cFy24Qpp768
         q653XfmOxWwYaRQYi/7dLACG1rzYFxa37BaofT51twyM+V2tHK3RvzP4HllQJfOqBRHh
         7x2jD54NLUFGIOQUlad9TwBZItsBa122iG8IrNOwc3+hpmY5LHu3WR4bw/go6ShifPBS
         vPZJaUBWpgR9i2kcQ8BV/5o2fxgOHwJaAVdeNQqUFPwkCRoTKXIiywFiat0p41mnmhfo
         /BZIAJdW1vn76sgiMRomKTQexwDccgKAau2l3DEYw1r1LbtHkwQ57+4vOzyfz5nGNEY3
         drmg==
X-Gm-Message-State: AJIora9EjYe27eot8YxIzSnvGuEynqbF2tMn6h+GmsVQGZk1BEVLh4AB
        iFLWNvT2wbIsdkVmz8ur2bDxa/ru0AP6ikMRaNqgLVUw
X-Google-Smtp-Source: AGRyM1sNKxeBTcagqq49HlSqe5T5+UtQibdO1i19MQ54e1K4Ou9nH5563QjTGAsIkDAn95DURC4r3YwKjua/0E3y1rk=
X-Received: by 2002:a25:ae26:0:b0:66d:1fdc:263c with SMTP id
 a38-20020a25ae26000000b0066d1fdc263cmr4816331ybj.137.1656524957627; Wed, 29
 Jun 2022 10:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220621150436.3303431-1-sudeep.holla@arm.com> <CAHp75VdFNir18Q-mLVd_87Sxd1Dz0Hg2B4XQfm5XzagO8sZQrg@mail.gmail.com>
In-Reply-To: <CAHp75VdFNir18Q-mLVd_87Sxd1Dz0Hg2B4XQfm5XzagO8sZQrg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 19:49:06 +0200
Message-ID: <CAJZ5v0h5HZQqSV7EEbYBNPTqudkocDjr-KpBD1yDAGUF0qZ+gA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Update links and references to DSD
 related docs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
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

On Wed, Jun 22, 2022 at 1:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The existing references to DSD are stale and outdated. The new process
> > and guidance is maintained @https://github.com/UEFI/DSD-Guide
> >
> > Update the existing documents to reflect the same.
>
> Taking Rafael's comment into account,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks!
>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  .../firmware-guide/acpi/DSD-properties-rules.rst      | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> > index 8b2d8d0864c2..70442bc2521e 100644
> > --- a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> > +++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> > @@ -21,7 +21,9 @@ specific type) associated with it.
> >
> >  In the ACPI _DSD context it is an element of the sub-package following the
> >  generic Device Properties UUID in the _DSD return package as specified in the
> > -Device Properties UUID definition document [1]_.
> > +section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
> > +"Device Properties UUID" in _DSD (Device Specific Data) Implementation Guide
> > +document [1]_.
> >
> >  It also may be regarded as the definition of a key and the associated data type
> >  that can be returned by _DSD in the Device Properties UUID sub-package for a
> > @@ -36,7 +38,9 @@ Property subsets are nested collections of properties.  Each of them is
> >  associated with an additional key (name) allowing the subset to be referred
> >  to as a whole (and to be treated as a separate entity).  The canonical
> >  representation of property subsets is via the mechanism specified in the
> > -Hierarchical Properties Extension UUID definition document [2]_.
> > +section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
> > +"Hierarchical Data Extension UUID" in _DSD (Device Specific Data)
> > +Implementation Guide document [1]_.
> >
> >  Property sets may be hierarchical.  That is, a property set may contain
> >  multiple property subsets that each may contain property subsets of its
> > @@ -96,5 +100,4 @@ contents.
> >  References
> >  ==========
> >
> > -.. [1] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> > -.. [2] https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
> > +.. [1] https://github.com/UEFI/DSD-Guide
> > --

Applied as 5.20 material, thanks!
