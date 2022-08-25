Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701775A18B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiHYSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbiHYSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:20:29 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A20E013;
        Thu, 25 Aug 2022 11:20:28 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-333a4a5d495so562252267b3.10;
        Thu, 25 Aug 2022 11:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uig/6MYAR36rD59j8Vi6nTWfQhMgr5YARco48vJAMTI=;
        b=cbVCdRjUxjvwjmNdVw+cGh6ca64YosBMdE4zgX9E4dtg1rw7aH+O4jINArJ0PQj7SM
         xHyK87VZK5LpvLMm5Mm7PLIL3jl4QBAy0bb8+3Un8n7C6LBfr0rwya8BfWRtfL7+v7Io
         kjfnl0ZuiZq2QaGNDmA/nrMWBJ/yCwBYkHcihmynYPGpLj5563oewHMhZB5XOFRY95RK
         loZ2fUSad/ApvQsFNfltStM4RUBTAgctwamFt31yAyEkssmWOCqHW3t7X/zk6mfZYMUf
         SnXxvhoZEWrHmOLyGrbHGk9PAHGkaCHMFmeYnpkHXngTStLYL18A76HwuYWPoFfzg+HC
         nYAA==
X-Gm-Message-State: ACgBeo3cnhcMpj+1KqG+5OHm7wAkn0R044DbuHaKvuALAyDOkYq5wGJj
        /TZ3DsFvPbqmLaAOfH5yUAGyxyNT8AcssFdZM2I=
X-Google-Smtp-Source: AA6agR7qzCbl13Mm9e8JxxntHyv9wGkANy9di366zSW3SCCGjr0uQd6hZbQWdeTFC4Rf0dy5fw0tVnA6ltCE0hcrePk=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr4105726ybh.622.1661451627618; Thu, 25
 Aug 2022 11:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220823185134.14464-1-mario.limonciello@amd.com>
 <20220823185134.14464-2-mario.limonciello@amd.com> <CAAd53p6MfBaRTTNJ5mAFU6XfDndLFJihLHKdrbq8Nq-27LArjg@mail.gmail.com>
 <MN0PR12MB6101DE7A18DC0343AEBE89C5E2739@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101DE7A18DC0343AEBE89C5E2739@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 20:20:16 +0200
Message-ID: <CAJZ5v0gdn7+EyQ7Br5WxT8pDr4+Y+Fgc274-at5-CZfQ572QKg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ddadap@nvidia.com" <ddadap@nvidia.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "kherbst@redhat.com" <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 8:28 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Wednesday, August 24, 2022 09:17
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: rafael@kernel.org; Len Brown <lenb@kernel.org>;
> > nouveau@lists.freedesktop.org; hdegoede@redhat.com;
> > ddadap@nvidia.com; Dell.Client.Kernel@dell.com; kherbst@redhat.com;
> > Lyude Paul <lyude@redhat.com>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
> >
> > On Wed, Aug 24, 2022 at 2:51 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > This string was introduced because drivers for NVIDIA hardware
> > > had bugs supporting RTD3 in the past.  Thoes bugs have been fixed
> > > by commit 5775b843a619 ("PCI: Restore config space on runtime resume
> > > despite being unbound"). so vendors shouldn't be using this string
> > > to modify ASL anymore.
> >
> > Add some backgrounds on what happened.
> >
> > Before proprietary NVIDIA driver supports RTD3, Ubuntu has a mechanism
> > that can switch PRIME on and off, though it requires to logout/login
> > to make the library switch happen.
> > When the PRIME is off, the mechanism unload NVIDIA driver and put the
> > device to D3cold, but GPU never came back to D0 again. So ODM use the
> > _OSI to expose an old _DSM method to switch the power on/off.
> >
> > The issue is fixed by the said commit so we can discard the workaround now.
> >
>
> Thanks for that.  If this series needs to spin I'll roll that into the commit message.
> Otherwise perhaps Rafael can pick up some of it if he thinks it makes sense to include.

I've applied the series (as 6.1 material) and included the information
above into the changelog of the first patch.  I've also edited the
changelogs of the other patches somewhat.

Thanks!
