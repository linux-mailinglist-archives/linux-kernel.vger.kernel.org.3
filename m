Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896159FD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiHXOQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiHXOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:16:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E11198D0D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:16:45 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B16540B2B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661350604;
        bh=XAZIO9+48GRjlnarFRC1UPi0uDzTdLs9Ete1xQbj9h8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=n+B5JIdfH1XclXjfuHl1TiTM4QH4CBFAKpfUfrTeDzaSq1bURlwKKnR8y+6tO5MMM
         xFusNMsREtUKC303QZaqph+UaA0Yb8aRNajAX6SPdR4jttMvjpCfsUl0IAkpxm+W9k
         fq0pEZY3MkgiWQjeRIz67qaYGTvcSEn5J1Mnx78LNJZt3jB4wMkIyC9xSYuaCDcU0o
         I3Nbm3CI4/9Vh2b8TxkjOSg/yg4EhdqxHMmlC0C7XOZdAdEyD6aNFNUYnBJ1DC8EsJ
         IO7UaWIi8qqrem1yU9T0sRsCuSAbujnpieOrzmZd7azC6hTDYPJWT8g84CjlT+X6KY
         0M9D0nHUpDhfg==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-11ceb376e16so3320750fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XAZIO9+48GRjlnarFRC1UPi0uDzTdLs9Ete1xQbj9h8=;
        b=D5boesF3kfYnSaftTqxLs4Q1sWr2q08emHvappFWrngg9FK83JKnIwX6lVXc0Eq4xm
         MSRivj21hLIeKQHmGaAg2TVj6kvJ1KLL0yqXGXaxWn7K2xBjW4Us2NfZ0FEGkjEn93eQ
         BiGbcT1wuLre783mVR+Rrc8LMAQO/gXOR9L43i79wDMwkZbOYYIm6F/VdK0gnm8ajcdU
         11NQvwbuVltAcj0kB0+DgdRXLwMmHc3zzebGzH5LKlG4aJVvuKKN8512knO5ZF4eh72T
         x5cRweG3vHwYYRIeKqM+jqVDWkpS9g4ELzKq6riVavG7OpSGmvSSQgOMaMFQ/gACeqlP
         RM1Q==
X-Gm-Message-State: ACgBeo2gYLi4H0IqofPRD7uf9cUxXo94oL3Nb53tgtydSTc1h5IfHPl1
        xmFQVMRW/RYt/N3pAFsYZlo2JYa9JmyOwogqs4AVRkcC4v8vChnPxIk/Qypv1Pa4KGCt85MoRbn
        tax0baoLSA1Mc85ZscnGNN2QFKjwi9qZFjNhD2/ujVMsyAcuGTGtK0ylfuQ==
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id i1-20020a056870890100b0011d416d2ccbmr3609438oao.176.1661350602962;
        Wed, 24 Aug 2022 07:16:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4S/bXPjudD5r+jeg8zjdF8VIIfPTbKsr6UBU4BPdcvaSuYf6QRJqDYyWMLocI8oex7KKC2lxdqQd8jgQ9wzG0=
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id
 i1-20020a056870890100b0011d416d2ccbmr3609414oao.176.1661350602662; Wed, 24
 Aug 2022 07:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220823185134.14464-1-mario.limonciello@amd.com> <20220823185134.14464-2-mario.limonciello@amd.com>
In-Reply-To: <20220823185134.14464-2-mario.limonciello@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 24 Aug 2022 22:16:30 +0800
Message-ID: <CAAd53p6MfBaRTTNJ5mAFU6XfDndLFJihLHKdrbq8Nq-27LArjg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPI: OSI: Remove Linux-Dell-Video _OSI string
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, Dell.Client.Kernel@dell.com, kherbst@redhat.com,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 2:51 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This string was introduced because drivers for NVIDIA hardware
> had bugs supporting RTD3 in the past.  Thoes bugs have been fixed
> by commit 5775b843a619 ("PCI: Restore config space on runtime resume
> despite being unbound"). so vendors shouldn't be using this string
> to modify ASL anymore.

Add some backgrounds on what happened.

Before proprietary NVIDIA driver supports RTD3, Ubuntu has a mechanism
that can switch PRIME on and off, though it requires to logout/login
to make the library switch happen.
When the PRIME is off, the mechanism unload NVIDIA driver and put the
device to D3cold, but GPU never came back to D0 again. So ODM use the
_OSI to expose an old _DSM method to switch the power on/off.

The issue is fixed by the said commit so we can discard the workaround now.

Kai-Heng

>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/osi.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 9f6853809138..c2f6b2f553d9 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>         {"Processor Device", true},
>         {"3.0 _SCP Extensions", true},
>         {"Processor Aggregator Device", true},
> -       /*
> -        * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> -        * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> -        * cards will hang without RTD3 disabled.
> -        *
> -        * Once NVidia drivers officially support RTD3, this _OSI strings can
> -        * be removed if both new and old graphics cards are supported.
> -        */
> -       {"Linux-Dell-Video", true},
>         /*
>          * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
>          * audio device which is turned off for power-saving in Windows OS.
> --
> 2.34.1
>
