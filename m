Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D85AC101
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiICTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiICTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:00:38 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF513D5A6;
        Sat,  3 Sep 2022 12:00:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-324ec5a9e97so41755697b3.7;
        Sat, 03 Sep 2022 12:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ibwnT0cqW7ADmxA6K2xllH0o+FjvNmoCUtXkTE8svNo=;
        b=OxfXsHwpqmKATS6m4FFtxYhBTSZbCcl2PLrRPYjN2T6FKJt/qhJ+QUJnvrwuZaZabM
         9GtF/iuNMBO3vf6EDuTb7FFVWS/0p0JCStwkip/pAsWLiUyfuw6pP1aMzuD2tzndG3Ub
         gSXGfDSqf5tjIWZjCgf46nzT1de2mJKB7UyhLTxO/+cQIpR/DrwsPG4w8KwNwBBWR4rJ
         U4suBgfFnfIJzmPioYAwlUx/eJ11iUCADRm2vXTDDBYOp3x9NOt27Av7c8jvZezsJgdt
         8Am9H56sAMdiHwz6sSLjWQaJ2mW/1xr1tJT3Hv3uICetTCRf5En4Gf5B6lutHPMbPHZ2
         cx8g==
X-Gm-Message-State: ACgBeo2eEE1ZVkmPKLV2hzBgDrOr8SPNYWV0GtVv7ANQ6ySIKYklYwQM
        3+D/D8tu/hL7AQBTCFRPifNqECjiYeqoOVpB/+I=
X-Google-Smtp-Source: AA6agR7sHIA8jeuw/V/G2pAEJ3ErQ0yEJVn+RxOKLyZgPT+3Xoci2MvmS4WwW2zidMxkAylE3LY2zAHnY6dGDztMk0M=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr32073228ywa.515.1662231637489; Sat, 03
 Sep 2022 12:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <202209020412.Ts31BZrs-lkp@intel.com> <a6030c5943ccd2965261a92320b1ae1adb909116.1662084833.git.lukas@wunner.de>
 <YxHRSPUWtQdP1w/4@smile.fi.intel.com>
In-Reply-To: <YxHRSPUWtQdP1w/4@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 21:00:26 +0200
Message-ID: <CAJZ5v0g3ybQr7zmgW2FVPQkCgP-ezjgUwz_ro_3q2KgzOpCs9w@mail.gmail.com>
Subject: Re: [PATCH] ACPI / property: Silence missing-declarations warning in apple.c
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Fri, Sep 2, 2022 at 11:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 02, 2022 at 04:15:55AM +0200, Lukas Wunner wrote:
> > Silence an annoying message emitted for W=1 builds:
> >
> > drivers/acpi/x86/apple.c:30:6: warning: no previous declaration for 'acpi_extract_apple_properties' [-Wmissing-declarations]
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/acpi/x86/apple.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
> > index c285c91a5e9c..8812ecd03d55 100644
> > --- a/drivers/acpi/x86/apple.c
> > +++ b/drivers/acpi/x86/apple.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitmap.h>
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/uuid.h>
> > +#include "../internal.h"
> >
> >  /* Apple _DSM device properties GUID */
> >  static const guid_t apple_prp_guid =
> > --

Applied as 6.1 material, thanks!
