Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14634D391D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiCISrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiCISq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:46:58 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91D1A39CF;
        Wed,  9 Mar 2022 10:45:59 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id u61so6232275ybi.11;
        Wed, 09 Mar 2022 10:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HC2soOTB9oH/PLOmjkgVDb+QYiG35LyTtX67WW8XF3M=;
        b=3k98+2joTGObwJkFHWzDOZhquiNNE35Yi91Ctr84LAQriHjYqOUS8DmOHo7aisUa5L
         C3DVxBsKHPoCyKsJa/jkjwx/PHRqTABuopoAhhdMLRjM1W7FQ/H9VLwsFV7iO27q4M+k
         vKpvn1EZOKjWzJnCP+v5SUu87e3vxIiJ/0pgsr7PVPetoYA1H2whFHCkdfJZmpCwqH5u
         JA+PGMZ/JjdlbRxay7RIKZrqVMzBVM5NJf+HKFicjSsPzrgywWvgVBsnlhI4lyOqEPvH
         qG03Rs84YmxdUpaI4SBp8GYGPsWJtl3FzRECOD74shgQZ85dPl8uSQBnRD5c6A1f9Y8P
         lswQ==
X-Gm-Message-State: AOAM531+D6k5C/xvxf7mOyOiwcwfw+4562a65MYoVlEpaPkw9bXkZfdJ
        ctESfxifciyztT7lh0wCySZP8zjFKKzap4cpDPw=
X-Google-Smtp-Source: ABdhPJz7TBVFPuyLZT9/sSOp07CsNSoCwn7WwVANVsNDheCFK2/4yUMteLKfeOMwWFTlxunQ4WREsa+oa1bh5AlzyWY=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr923696ybe.365.1646851558391; Wed, 09
 Mar 2022 10:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20220309020750.65399-1-ilkka@os.amperecomputing.com> <20220309020750.65399-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20220309020750.65399-2-ilkka@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 19:45:47 +0100
Message-ID: <CAJZ5v0iY-pV-N7JhuAM4JM99tHVBVnCHj+JyJYpShS4cKA+q_w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: tables: Add AGDI to the list of known table signatures
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        Darren Hart <darren@os.amperecomputing.com>
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

On Wed, Mar 9, 2022 at 3:08 AM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> Add AGDI to the list of known ACPI table signatures to allow the
> kernel to recognize it when upgrading tables via initrd.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 369eb998c3d1..ceee808f7f2a 100644
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

I'm noticing that this depends on the linux-next-only commit
783dedf41b79ac7a3a68b51cf6f88cbfd6dc3292, so it is probably better if
I apply it and the other patch in the series can be routed via ARM64.
