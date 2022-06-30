Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1656145D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiF3IIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiF3IID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:08:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76F41983
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:07:57 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31772f8495fso171214717b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuRamS1SI178ACtkzbHW3gIWo/2dAhClIsQUxKXvzRs=;
        b=Edf66koZAAgQCYihpt0wmHQX6cb6a2viEGA/XonD1DFhQ7tW7d6/1pnwl7ehwqvFuh
         7kskIcwxCvy8j6Aci++h9ogYMBNFZbaLyt1PGoxQXT6IYP5snaKoC0RREM7ONVBFFede
         +sPnFexJRpw1ZM/T8F1wtt3meKdmDPgUe6CWIiWVIKZOKXkdpBOHLJshKkhbLiPM2cAI
         E5JTFINt7qWWLrn65iEQzu6Bq0wrlDvLeRXqC8kg2mhcYnwaRhD4fe2vdNYGL5hmIP+X
         k49N+HVLVdj0or5ORocwXlLIODE+aE2bWwao/QP5XVBFJU7sQts2Q3KHn1frFPNp1XbM
         KJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuRamS1SI178ACtkzbHW3gIWo/2dAhClIsQUxKXvzRs=;
        b=GJvuOlV6C0caMmwxIIM9ML2HRIwEj9hpyF+FRDg6CHuVcOUBJg9ljCUFykoiQ/F+65
         18Fr42eYgJHV3zflYpCARENFE/ip1h7Ypjy8cI6zAYOqN3zDSphN08OaY/YtZ4de9ec9
         fxSE4dEJg3ZJktoy34hNUZEImvBY08KcNzyNlteY5ARQJtDe945RLO1hLnWwL52Alwj1
         ivQtFMnA8bao9a9vDNFj32wv/PJ7qYQQoQge/l8bDCHorWY8Ox5A/xxAoD/oY4LB2pgy
         bllRrfwpamC/Bsvt2eYdq+jV5xE0/YWEZsJhlp9VA6wJe9G+YJHj8FdHwZ21jJrGWMlw
         GUBA==
X-Gm-Message-State: AJIora9SSpRLLELfEE6jMJ0w37mbZ2+H/+5WqzDqGJR2651tKponKjNl
        daeQGCRZvemftwVPuN53aQfHGYuO7mALKWAg8bwJtKMSMquAkA==
X-Google-Smtp-Source: AGRyM1sNPRnc973+6t3nks2nAafHckGcGd4C/7mNr4lu6Glls8Mg6oYYXEji3JtUPPaZaILJEUFAHfZvP2Uf5d0JK8M=
X-Received: by 2002:a81:1889:0:b0:317:987b:8e82 with SMTP id
 131-20020a811889000000b00317987b8e82mr8749982ywy.185.1656576476373; Thu, 30
 Jun 2022 01:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com> <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
 <YrxjTD0sJXh8cgVP@google.com> <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
 <Yr1YXHb3GqwZncFK@google.com>
In-Reply-To: <Yr1YXHb3GqwZncFK@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 10:07:18 +0200
Message-ID: <CAHp75Vf1UK9Z2P1D9v_j9rsdKoDXWSvb=wJgmkvACYgwofWrxA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:01 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> > On Wed, Jun 29, 2022 at 4:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 28 Jun 2022, Andy Shevchenko wrote:> > On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> > > > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> > > > > >  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> > > > > >  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> > > > > >  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> > > > > >  4 files changed, 157 insertions(+), 193 deletions(-)
> > > > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> > > > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> > > > >
> > > > > Can you submit this again with the -M flag please.
> > > >
> > > > This is done with this flag. Basically for the last several years I do my
> > > > submissions with that flag.
> > >
> > > Odd.  I thought -M only showed diff for the changes.
> >
> > It's exactly what happens here in this patch. What did I miss?
> >
> > Note here is not renaming, but merging contents of one file (actually
> > two files) into another. What you are talking about is probably -D,
> > but AFAIR Git (at least that time) can't catch up deleted files from
> > the mbox format. That's why I do not use -D for submissions.
>
> Ah yes, that's probably it then.
>
> From a quick look at the diff (I missed the 2 "--" at the end), it
> looked like this was a rename.  In which case -M won't do anything
> useful here.  I'll have to brain grep the differences instead.

Please do, it will be good to have this double checked.

As I pointed out in the commit message the main difference in the code
(after massaging the header inclusion block) is the static const.
Without static we will have warning from the compiler, const is the
new thingy, besides the merge of the Copyright line.

-- 
With Best Regards,
Andy Shevchenko
