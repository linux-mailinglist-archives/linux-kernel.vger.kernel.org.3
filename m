Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B124747940E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhLQSYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:24:09 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39532 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLQSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:24:08 -0500
Received: by mail-oi1-f181.google.com with SMTP id bf8so4870710oib.6;
        Fri, 17 Dec 2021 10:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqESVUEXiGE9fUPPJtSvg45ZiqTaR8hZjs1IUaZRb/w=;
        b=7FUOwY/X/hY/5Ugi3lvK3tM5q0DOAdiHxO6sk+QJLTiktBD+zhnQnv3ciXQIVd8GJS
         bDr2LaWAfKI1emtieJYcuGzdfQrKQl0BAcQh7PytESAwcx2XpmYaBjlHGMwYVOUQ5o2L
         KO0OVn0Vv971AJTc5ICUjMyCI15lA21DEcwS0/TBBrMeLdik4qRLY6XgG8sgI+wmCelB
         RwTKcUrN2ngUBkNaAjG/R8g1le45A0EaYrmhcAm20u39BdGsa7A0IGbAuMgRje/TwztN
         WWYpyh37/jgIvETKfN+SCmqDFl6sr4NfgJaeaTvtMJp4luCZh6U3sSe9OqrVaScaDdv6
         Qedg==
X-Gm-Message-State: AOAM533s3U3SXgb34blyW3nLY7cUj7RlmcoOJZKXy3NvtLMiSvoAipSM
        a7klZo5MSlofmk6vYcNBbg5C1nKHpUte8M1cpbIYHvdd
X-Google-Smtp-Source: ABdhPJzSHIE9NiA8wrnjx5swIQTDaNO47Eh/jPY6u0cKl22eGvZUG+q9gVUcR2YDpTUkejMwRaoJ5/335VboacRU31E=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr3139061oiv.166.1639765448173;
 Fri, 17 Dec 2021 10:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
 <20211212180527.1641362-3-AjitKumar.Pandey@amd.com> <CAJZ5v0i=LVsz2ZRBB5HzLpw8eR-zLAKtJyc3PFWu_kKCzjzZWw@mail.gmail.com>
 <SA0PR12MB45101C5839BC373C083B19FEE2789@SA0PR12MB4510.namprd12.prod.outlook.com>
In-Reply-To: <SA0PR12MB45101C5839BC373C083B19FEE2789@SA0PR12MB4510.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 19:23:57 +0100
Message-ID: <CAJZ5v0i0csL=w8cmLkpY7NNrKFy2bMymFGO51CrmDD+DAxJ-hw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device
 property "is-rv"
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandey, Ajit Kumar" <AjitKumar.Pandey@amd.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 7:19 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Friday, December 17, 2021 12:07
> > To: Pandey, Ajit Kumar <AjitKumar.Pandey@amd.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>; linux-clk <linux-clk@vger.kernel.org>;
> > Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Hiregoudar, Basavaraj
> > <Basavaraj.Hiregoudar@amd.com>; Dommati, Sunil-kumar <Sunil-
> > kumar.Dommati@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; Len
> > Brown <lenb@kernel.org>; open list:ACPI <linux-acpi@vger.kernel.org>; open
> > list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device
> > property "is-rv"
> >
> > On Sun, Dec 12, 2021 at 7:06 PM Ajit Kumar Pandey
> > <AjitKumar.Pandey@amd.com> wrote:
> > >
> > > Initially "is-rv" device property is added for 48MHz fixed clock
> > > support on Raven or RV architecture. It's unused now as we moved
> > > to pci device_id based selection to extend such support on other
> > > architectures. This change removed unused code from acpi driver.
> > >
> > > Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> > > Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> >
> > Does this or the next patch depend on the rest of the series, or can I
> > simply apply them both?
>
> There are (intentional) dependencies within this series on the order.  It
> would be better for the whole series to come through one tree.

So please route these two along with the rest of the series and I
don't think you need my ACKs for this.

>
> >
> > > ---
> > >  drivers/acpi/acpi_apd.c               | 3 ---
> > >  include/linux/platform_data/clk-fch.h | 1 -
> > >  2 files changed, 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> > > index 6e02448d15d9..6913e9712852 100644
> > > --- a/drivers/acpi/acpi_apd.c
> > > +++ b/drivers/acpi/acpi_apd.c
> > > @@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data
> > *pdata)
> > >         if (ret < 0)
> > >                 return -ENOENT;
> > >
> > > -       if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
> > > -               clk_data->is_rv = obj->integer.value;
> > > -
> > >         list_for_each_entry(rentry, &resource_list, node) {
> > >                 clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
> > >                                               resource_size(rentry->res));
> > > diff --git a/include/linux/platform_data/clk-fch.h
> > b/include/linux/platform_data/clk-fch.h
> > > index b9f682459f08..850ca776156d 100644
> > > --- a/include/linux/platform_data/clk-fch.h
> > > +++ b/include/linux/platform_data/clk-fch.h
> > > @@ -12,7 +12,6 @@
> > >
> > >  struct fch_clk_data {
> > >         void __iomem *base;
> > > -       u32 is_rv;
> > >  };
> > >
> > >  #endif /* __CLK_FCH_H */
> > > --
> > > 2.25.1
> > >
