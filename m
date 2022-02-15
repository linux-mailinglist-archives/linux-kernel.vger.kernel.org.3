Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC1A4B7322
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiBOQWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:22:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiBOQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:22:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F62717B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:22:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so3403520pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aL1Ai2InGicb7ahZQpdv5e9x/ONiZjtIAS2dF1D0S2o=;
        b=vNb54qajFSiKeRJfRAser6tmq4YROi3TaW6ql4v5+lZ8250zTZTJH1ttBk7phLtJE/
         8X1xJ+aPM3gWHECS563y21SvX9Rb3Whn9VDu4xQqfZimFge8tVLTHWpcjfudVT/+xSBt
         8IJLGbV1EzmvVRGWG1e5Loyjws1+uPfMdm116IGe1i+zsMKsxVCWtIalTFgUB7oct0lF
         MuOPY3rMbsSUfKYcxS+iakLKgNb9dwlSZ87PA4NY2RqCylJGKpnIAotIGx0GuS7VLpnJ
         JQm0c9L6L1JUKc9600lOKO4VcrpWaIkoCrIbss4X4+YQQR/UpMGs55jhnNOVQDUDnF39
         YY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aL1Ai2InGicb7ahZQpdv5e9x/ONiZjtIAS2dF1D0S2o=;
        b=AoxhEf/0ms38mogKeZzpp06Yr228JqSKpk/cBgCIt0Uf2xmzdNGbnuc+ZUdxEceWMN
         nSkNrXrxLCpMgZF1hHE5a0kex2q2Q9NIFDNn1ufss1OOxM4/T3/aXxJ19jCOkbF7Ro6G
         MfloyRn7xZSln+lFdJ5M0yQsRExdbXi9qVnFMckKgz98uO9yWyYFCersHUc+JR7uddMJ
         GcSL+SyXt8qkmv28ZK4Jpd232RUEwerEoWqKSk7xKqwB91/lt80W1qX+UVuzfvmvAM/d
         Do8uLu/uqbFTu3J0zZTdbQjScn9ZndRQmo7hY424X1HQSTBWWuUv3Z49rS3ckEg0JYjm
         a2HQ==
X-Gm-Message-State: AOAM532QevUTaXbd25osnc2K/ldNZXsPdX+7iCFqJeBmlXWmrvUuX+7u
        YuUELs0UDOMiJeb7EmrrBmS2tAsin7f9YZHf49i9Bg==
X-Google-Smtp-Source: ABdhPJycTIiQcI++KSnaRXdKC1+/Za2TF78mUkZ2Pq3jl1G9S9TZeJkyWRyx3RI9dH9/htg5W9HUadriJMCICjLWGTY=
X-Received: by 2002:a17:902:ce12:: with SMTP id k18mr4872669plg.34.1644942129125;
 Tue, 15 Feb 2022 08:22:09 -0800 (PST)
MIME-Version: 1.0
References: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
In-Reply-To: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 08:22:02 -0800
Message-ID: <CAPcyv4jSP4PTehMdkcpZfpDcz1HZ0ekjx+WztOiqpwGFU-1iBg@mail.gmail.com>
Subject: Re: New warning: ACPI: CEDT not present
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Mon, Feb 14, 2022 at 11:52 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> #regzbot introduced: 2d03e46a4bad20191d07b83ec1242d5f002577be
>
> Dear Dan,
>
>
> On the Dell Latitude E7250, Linux 5.17-rc3 logs the warning below
> (`dmesg --level=warn`):
>
>      ACPI: CEDT not present
>
> I think commit 2d03e46a4bad (ACPI: Add a context argument for table
> parsing handlers), part of Linux since 5.17-rc1, is the reason.
>
> If I understand it correctly, CEDT is not to be expected on older
> devices, so the warning is not justified. Can something be done about it?

Rafael,

I'm inclined to just delete the warning altogether, but special casing
is also an option. Any preference?

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0741a4933f62..fb2e4a216154 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -399,7 +399,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
                instance = acpi_apic_instance;

        acpi_get_table(id, instance, &table_header);
-       if (!table_header) {
+       if (!table_header && strcmp(id, ACPI_SIG_CEDT) != 0) {
                pr_warn("%4.4s not present\n", id);
                return -ENODEV;
        }
