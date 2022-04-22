Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C050BB06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449117AbiDVPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449125AbiDVPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:02:34 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6115C841;
        Fri, 22 Apr 2022 07:59:40 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id m66so4308085ybm.4;
        Fri, 22 Apr 2022 07:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNFOjNCpQgsQswwarHmngoqDT1JA2XELuUTrOwXKkcU=;
        b=DB2B9F0a3bPkigc5b3hMmrPhQkXLFuUdOTcHJqZaCF89QS1hs3DtYWDBC0R2x0aFuE
         VOjNtU0kjzk9iv9MeNOfYE11sPdvsOXytC2RTlnQ/3NlxmUj45w6aZn/ir+iHon7xtmg
         9qv15Ts+gxiXutLmt4uJI/oF+Cj9qx6KEzmhychss6TgVgwt2mVnIeS9rOnnhzcXozNK
         iilvKaGn/kheEIUY5ENvXtGPYe6Mnwa7OH4j20nFqADJt1Pj1gWgamjQ3wSHmF6HryuW
         pHMpgkBcU054byvfnyFbM33ZHribK2NrHVA79E7X0KDggOCy96fCUt3dRDTOjPvrd3hF
         1RxQ==
X-Gm-Message-State: AOAM532dLzvfyMzgilGT9wtQ9dGMvGOXh/+RSBP0gtKAsN8Z2CHf2Ve2
        ED3dlgNW52HZviD7OS78BF7ywekM1NVDZ8VX9jY=
X-Google-Smtp-Source: ABdhPJwa/RZFpiAVJa2lBcWbHNbqpptu66W3sthW5aORvkgMEcb9ZyjnS3A0y8uT32JAnZ/pXhW38CArQi72JRoMuEU=
X-Received: by 2002:a25:688d:0:b0:645:794b:815 with SMTP id
 d135-20020a25688d000000b00645794b0815mr4367951ybc.633.1650639580026; Fri, 22
 Apr 2022 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220421165543.435-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20220421165543.435-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:59:29 +0200
Message-ID: <CAJZ5v0jM_o0n3BzqAr5donRZN6a5y2tYHddV_naA3hbaMTJEEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Correct description of INT3407 / INT3532 attributes
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 6:59 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Remove duplicate comments of PBSS for Battery steady state power and
> correct the typo for PMAX Maximum platform power.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/dptf_power.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
> index dc1f52a5b3f4..1f2e6c29773b 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -12,14 +12,12 @@
>  /*
>   * Presentation of attributes which are defined for INT3407 and INT3532.
>   * They are:
> - * PMAX : Maximum platform powe
> + * PMAX : Maximum platform power
>   * PSRC : Platform power source
>   * ARTG : Adapter rating
>   * CTYP : Charger type
> - * PBSS : Battery steady power
>   * PROP : Rest of worst case platform Power
>   * PBSS : Power Battery Steady State
> - * PBSS : Power Battery Steady State
>   * RBHF : High Frequency Impedance
>   * VBNL : Instantaneous No-Load Voltage
>   * CMPP : Current Discharge Capability
> --

Applied as 5.19 material, thanks!
