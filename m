Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB95685A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiGFKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiGFKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:31:49 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04526AC7;
        Wed,  6 Jul 2022 03:31:49 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id i7so26574418ybe.11;
        Wed, 06 Jul 2022 03:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJiCBm5AZZZBSWt/5+TIdRYYpF8q38DKwzi2NL8dpyY=;
        b=bD6j4I87nNVFN8+FSHnbZUBdKb45m3CXgLhxBgRfZXqiz6T4l35SK3sNhCEQp1Ng2V
         BmwE/YGms76PF+KlveyeaHAxpz1F8Oh1k6wmLdmWHU38FrCwuBY9YhVE4EmnaBuAIjUr
         4gPO77sTNl/dKl+65/mrd093OzCl8cAK6FoxYoFnp5gy28HqnkA4LXVDNVYI1bCzWvp6
         GMROpAux2R5FeGwlk0qaVGF1ULrRBHm/yUs201NFAYQgrUUmla7d8SFfacaKSVta2P1I
         d/A4XKHlzzaEi3M69UfME+XFrDWTHXxNtA5Yyai297sLihMYRoRLEBlHySAIMjgK/yel
         FuXA==
X-Gm-Message-State: AJIora9uYwJLnZoAVmYJyqsB9MyN8ZMTx9h3maV8XVh/4jlzaRL+2oz7
        cTdy01P0f54B6s91ctDmo/5mVfL9rBdaaW6zBNnQ1IFx
X-Google-Smtp-Source: AGRyM1u3OKddxGoKgpZvZEGgPRdn1FS60tuhew1VafiCtkBL8lyyWzzilbWBpskIvtAtG8/flvA4FwGBha1gHxIv7tc=
X-Received: by 2002:a25:ab81:0:b0:66e:3dc5:898c with SMTP id
 v1-20020a25ab81000000b0066e3dc5898cmr18651711ybi.81.1657103508554; Wed, 06
 Jul 2022 03:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220706013222.5323-1-zeming@nfschina.com>
In-Reply-To: <20220706013222.5323-1-zeming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 12:31:36 +0200
Message-ID: <CAJZ5v0i4vuH7V-8UUESTOaC5MKuKycLUeC+MsR-Mwq-KE8-d9w@mail.gmail.com>
Subject: Re: [PATCH] acpi/sbshc: Add header file macro definition
To:     Li zeming <zeming@nfschina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@nfschina.com
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

On Wed, Jul 6, 2022 at 3:34 AM Li zeming <zeming@nfschina.com> wrote:
>
> Add header file macro definition.

Please explain why you want to make this change.

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  drivers/acpi/sbshc.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
> index 695c390e2884..22b11a1655d2 100644
> --- a/drivers/acpi/sbshc.h
> +++ b/drivers/acpi/sbshc.h
> @@ -1,4 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SBSHC_H
> +#define _SBSHC_H
> +
>  struct acpi_smb_hc;
>  enum acpi_smb_protocol {
>         SMBUS_WRITE_QUICK = 2,
> @@ -30,3 +33,4 @@ extern int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 slave_addres
>  extern int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
>                 smbus_alarm_callback callback, void *context);
>  extern int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc);
> +#endif
> --
> 2.18.2
>
