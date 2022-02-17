Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798164BAA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiBQUAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:00:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbiBQUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:00:10 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBD29CBA;
        Thu, 17 Feb 2022 11:59:55 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2d07ae0b1c4so44194027b3.11;
        Thu, 17 Feb 2022 11:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibo+ljOZltOHxbfiowmfbU4E0+eJxT2hqrSRwf9WFds=;
        b=8QZY6lI3jXqcmpyxtXp6jocIXp+NaqQEOdv82LkssGAMEw33X5Xb1fBc9U7Ou9MwG5
         L+PO0aAH9NNHqQ8igYgC+8x/sU4mVB3dwiNnptt39uQCSlqOrODomZBc61dMe2+taNa/
         QzHmVoMu9S3EEopnFpBp9TIcNLbRcpVuN/Yoa9eV1vWCxm9fTo0S8AaURnpG6K72SFKF
         YpxQB+s4RRI0Ae0hK8mL8/tbBmP8ZIs+j0g2WeBMJwNg49FkNcoEYr5y38PhvINNWGhH
         qcqBGIpH042TRKsR3HFNGaL22FX3F8a/ry+xwJWFRwg5lcw5/eERA4y4z8M1cG65SbJa
         D/xg==
X-Gm-Message-State: AOAM530Wmm/qm4FgcZzPd6Wv0rRtwjQop4Bzh7zB2nXDqy7teYYZXKKa
        fY98kaWUZYOnU5sf2glz4a3fjK1oJdKJ2zeI98Q=
X-Google-Smtp-Source: ABdhPJwlk5R6MoRUjz/JC7Tw0qXkBl+ocvndg0AZSGM/zqGcn1E5R+qvJ84SwxiZUzksJsAeR9TK1MS/AgCsiy5JmKk=
X-Received: by 2002:a81:1cd8:0:b0:2d6:b74b:5b55 with SMTP id
 c207-20020a811cd8000000b002d6b74b5b55mr1649314ywc.149.1645127994670; Thu, 17
 Feb 2022 11:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20220215035553.102315-1-ilkka@os.amperecomputing.com> <20220215035553.102315-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20220215035553.102315-2-ilkka@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Feb 2022 20:59:43 +0100
Message-ID: <CAJZ5v0h7hCQLQP7-uF+Zh6Yx11AxxYK3rjLS17XHfA17z8fR0Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: tables: Add AGDI to the list of known table signatures
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 4:56 AM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> Add AGDI to the list of known ACPI table signatures to allow the
> kernel to recognize it when upgrading tables via initrd.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This is fine with me and please route the series through arm64.  Thanks!

> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 2d7ed7126faa..ae29b13b8774 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
> +       ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> --
> 2.17.1
>
