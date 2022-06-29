Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AF5604D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiF2Pmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiF2Pm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:42:27 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447935A8F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:42:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so28691282ybr.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFXDBwOzenoR/IvZm8NoEQWhPAwy/n8DtCUua6hWSQI=;
        b=dL4T+j9wg41AYrbrmU+2vsi4CS08fGzl//oLQcwepOgztP2mC/OeDrD35dw5HnXEm+
         W7NWG6l3Gsa6KOwy4ipocMxwWntMmFMDlDGf5bj5aaA1CbDyMBoKBG3fCkGdm5xLIy+l
         vvx1xDqsPB4naNOADmtJWSaF+x3YJnI+0EAxqSOImkU14pDwC/nTPSOmJ4SkHN0+8z9e
         MVTRNyJUnF98vsSb/AhWmU7wccVYxQZWIuqC/tG5W9T1KG1g/CGGFtoVw7G6p5/1Djnu
         HEW7Qv4HsBeSejvV9MMxxAuqCadMs2tPZXJTWoyc1+R5ZkWKETyd9mh4aS9+S4FepZqs
         xGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFXDBwOzenoR/IvZm8NoEQWhPAwy/n8DtCUua6hWSQI=;
        b=epwuxdi/VbUi6tI1/8gEsOqHyRV/qZxgV7XaSdQqKCQol48CP23Yn6Nu2Ebdmcqwqy
         KdfOs8kb/dJuxzjEB6WKTNPVsK1Vo23Lv3Btu458ItjNGkPf1MuqylRSvsdvA0cyY+ib
         6fIR2wlfLLKUSdZdquwgiqOfhV3awMIiZlDvfvow1RZ7j9Z5p9N7yVddfIEj+gqjjV9f
         VWAPxNdgKVQxZFELSYRYVrKJHfqAz8Xo2ur2wHCy5bmcAqgCb5AwHYucd4gHOiyf44f7
         oiYluY9PBzRhbt0cDPb7bIlGPz+vm1/LiIujgRA6SByNL6MWJzf1zN28hA5b75bANnkp
         XHVg==
X-Gm-Message-State: AJIora9/Y1ofuubgvGFqJXPuS74JTRevNnoH/xAvjpk1yn9HS2NH8YLj
        r/tUjg1sGG2qInJ4e024r/jsAYMJvlYjqvTbgCw=
X-Google-Smtp-Source: AGRyM1t0QblZa9tMy8MYzkhVn8kCamFMKcyTupNGw+ifnip6aZhp/Ymvt4qwZdaPBeOaGXQN8yfOwkvpw3tMa3SVZhA=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr4358516ybg.296.1656517345645; Wed, 29
 Jun 2022 08:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com> <YrrO0CQVv6hj1AB0@smile.fi.intel.com> <YrxjTD0sJXh8cgVP@google.com>
In-Reply-To: <YrxjTD0sJXh8cgVP@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 17:41:48 +0200
Message-ID: <CAHp75VdHpqAxS3jmFi-1Sw6wB1CP3wQVM_+5OP0C_yFFG336LA@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 4:36 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 28 Jun 2022, Andy Shevchenko wrote:> > On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> > > >  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> > > >  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> > > >  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> > > >  4 files changed, 157 insertions(+), 193 deletions(-)
> > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> > > >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> > >
> > > Can you submit this again with the -M flag please.
> >
> > This is done with this flag. Basically for the last several years I do my
> > submissions with that flag.
>
> Odd.  I thought -M only showed diff for the changes.

It's exactly what happens here in this patch. What did I miss?

Note here is not renaming, but merging contents of one file (actually
two files) into another. What you are talking about is probably -D,
but AFAIR Git (at least that time) can't catch up deleted files from
the mbox format. That's why I do not use -D for submissions.

> > Anything else I can do?
> >
> > > Trying to figure out what exactly changed is proving challenging.


-- 
With Best Regards,
Andy Shevchenko
