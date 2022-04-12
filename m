Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08664FEA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiDLWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDLWtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 18:49:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF551BE12D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:30:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w7so168433pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKc2RsG7u0Dt9SRYrdepMbEzWeuJkK4ThHyJlKzG4oQ=;
        b=KvGviDahz+0YxI4Ikdgo2vKDTpdEKuUdKS0LYj1ul1SopRDHL2WTRg3B7lZb+G5BXQ
         LLz2+aXrSvqvyscboBTUiCg7RIFAhidq6am/3nwGtpp5axMP3ebS5boDlxfZzXH+aRhx
         qaLgBg9AvSkRfR1pX9sJbgmlEhK88ttwpgCX4dIrOdy3O5ZoIHCYxixh+IAfj1OucRJW
         eCeb3DHLKPyIOayoBJcK1HZT7L09K3TYhIR1BtzUdbbCWTTAotB5hSHUcWyS4Mwq/Ezj
         ebREbAEiDq+b/h1CDf8gxUMUHRiPQCbP9d0GYjxEqP3itNGatAptHDF87Wk/PS8suAVw
         +clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKc2RsG7u0Dt9SRYrdepMbEzWeuJkK4ThHyJlKzG4oQ=;
        b=3vRzmvBF+MXgOrl5HT/rjHQUwSaSitJnUcpSmd82IOMGfMwHg5e2Cm3V13AtFC+otZ
         ip0/B7Xa3mXQdWR4R0PEs5SWWk47xwEKDKPdS9LzE6IShTJ57R/G6ohaTukMvVNeqQvH
         umm/Ez6U4V27GQuStyL/OBi7gxmlyoJyq4xidsjmLUbphLWfe/bMZON5VMJHmvmpFe5O
         3McNaRVNhcydJgkBTyuLI2dpKdLpTMouMHX6DLwNB1p7o6NsqF8R9A2yATc+sj10IaUg
         MqRPZnSxxkBQOjQDu8C78KARiDaSM2d3cHuMHnjbMYoDpRWI5tRNues/o/4H74gMf2JW
         xY8Q==
X-Gm-Message-State: AOAM530daZdgvl8oniQFfryRMpEe0UPkgefhIxXzAE77XWOQ0m32eeel
        vSK+EfNxzFp6YQcMlBIxers4Z5zAyC+5u/6ly/5+qA==
X-Google-Smtp-Source: ABdhPJyyil8BZGNUAaxupefL2LwqP4c7rGgTZBi2Ndy2D3Tc3LXcIpd0IqCPcKte9vCXggWHFoPkUNDd64ZCAnDRD9E=
X-Received: by 2002:a65:638d:0:b0:39d:74ad:ce0b with SMTP id
 h13-20020a65638d000000b0039d74adce0bmr7400676pgv.103.1649799016617; Tue, 12
 Apr 2022 14:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220411205321.13109-1-mahak_g@cs.iitr.ac.in> <c5fc1685-b1cc-7cfa-1ddd-e2f93105c2a5@intel.com>
 <027acae3-29ee-ae35-4448-a56e66383849@lwfinger.net>
In-Reply-To: <027acae3-29ee-ae35-4448-a56e66383849@lwfinger.net>
From:   MAHAK GUPTA <mahak_g@cs.iitr.ac.in>
Date:   Wed, 13 Apr 2022 02:59:39 +0530
Message-ID: <CANnaPbBpWmp3PUgp=yRxhykzKjpP1HHh9Fk0aEBJ_+EGNUStvA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: correct multiple misspellings in driver r8188eu
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:48 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 4/11/22 16:28, Dave Jiang wrote:
> > Subject:
> >
> > staging: r8188eu: fix multiple spelling errors in driver source
> >
> > Given that it already annotated that it's the r8188eu driver, no need to add "in
> > driver r8188eu".
> >
> > Maybe the log can be something less terse:
> >
> > Fix multiple spelling errors reported by checkpatch.
> >
> >
> > Probably doesn't hurt to fix other issues on the same line while you are at it.
> > See below...
>
> Wrong on the first and last points. That subject is exactly what should be used
> - it describes what is being modified.
>
> A given patch should fix one, and only one, problem.
>
> Yes, the commit message could be less terse, but that is not a problem.
Ok so considering the last comment, I am sending version 2 of this
patch with an appropriate commit message.
>
> Larry
