Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DD4B778A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiBOR3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiBOR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:28:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D0DB4BF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:28:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso2724213pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In6ibvsbevR+oUF1CNB4sd3J1jo3GRL6oP9ohnz3F4Q=;
        b=PavXSWFp42Rb3JhXSuid9+itRv8kFh6GIZuLY2gAhYwo3oc4KsMKMdg91czh/h6Qyo
         /mGMYVMcivtoahXjbQnw5TZAhfVIIDp+E5QCsL/X6VJ9piDGbmQRdfAyWdPYB33yDrlf
         LW/RAqpaseffxKwbcfXWLO+TCFNgnMalHJro+bQdWT0swIlsnrE3e5MjEFWQC06NQ7DQ
         UUuqdlzoG3NdkdmVki7b/1MJ87uOQKhZjDr9QNn9+tY7SKRYmUx08fkXzPJloY59m41M
         d20QVcx3qigbwwURbtc1rOkvtU4+BgKlYYT6moF9Kp2QSqmKqVXRQMAb6FoLvxQkqs+o
         abFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In6ibvsbevR+oUF1CNB4sd3J1jo3GRL6oP9ohnz3F4Q=;
        b=FTnFjuwG6skU5IzflEM4FFpdWVe5WQfvUmg2dZSIkvcmSJUAI55d9T6f2RXAVs5b69
         whqtv3ecN6iLezbDZR/EFEAmxxLF/KQCOBGraLzl9wpjs0hLxKCGCxT/6fGVXAS9m2wz
         WiVob4xgrqQeWeGcuGFJITZCHw8uzeLeEDZRdwF/bwaS+JWdMSrSq0eEeq0Ktugb1Jss
         zBttIsWNpCCE2feZOQ1f0vSK/t6Y9YaeyiUi/z+zgrdntig6W2tTTleI1mbJCB3Cf/S3
         64g0PO5wwQFUXA4Ngqgt11NUJXQmluiDNq/n1f2IYVksQRx0sfIkD2D51rDVKUtRLZU2
         03MQ==
X-Gm-Message-State: AOAM531unNS7BhIUFCtd10nuz8Kq1X0QizZE3VOWy8f7qk2WMLk4+E7q
        /LhnjKEl8JhsgJfq6nySqVRBQXLSVwSBxgafTrt/tw==
X-Google-Smtp-Source: ABdhPJwZnJDH0ZZkUy+8spEtdicBcwJ01t47bO4NgUDlXJmAx54plZE8XmZ+xaHrg9DlDbWQu4mo0doKyyMpgKDxO6E=
X-Received: by 2002:a17:902:ce12:: with SMTP id k18mr75487plg.34.1644946129176;
 Tue, 15 Feb 2022 09:28:49 -0800 (PST)
MIME-Version: 1.0
References: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
 <CAPcyv4jSP4PTehMdkcpZfpDcz1HZ0ekjx+WztOiqpwGFU-1iBg@mail.gmail.com> <CAJZ5v0hv2P9_g0QAsY_guvYA_vSE-q4jz2902Df7r9KS=iRfMg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hv2P9_g0QAsY_guvYA_vSE-q4jz2902Df7r9KS=iRfMg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 09:28:42 -0800
Message-ID: <CAPcyv4jTe48rqGvLBXOH4tLtYM5q6JX1dF7EBApnD291+NaUgg@mail.gmail.com>
Subject: Re: New warning: ACPI: CEDT not present
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 9:14 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 5:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 11:52 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > >
> > > #regzbot introduced: 2d03e46a4bad20191d07b83ec1242d5f002577be
> > >
> > > Dear Dan,
> > >
> > >
> > > On the Dell Latitude E7250, Linux 5.17-rc3 logs the warning below
> > > (`dmesg --level=warn`):
> > >
> > >      ACPI: CEDT not present
> > >
> > > I think commit 2d03e46a4bad (ACPI: Add a context argument for table
> > > parsing handlers), part of Linux since 5.17-rc1, is the reason.
> > >
> > > If I understand it correctly, CEDT is not to be expected on older
> > > devices, so the warning is not justified. Can something be done about it?
> >
> > Rafael,
> >
> > I'm inclined to just delete the warning altogether, but special casing
> > is also an option. Any preference?
>
> Change it into pr_debug()?

Sounds good, patch inbound.
