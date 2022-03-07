Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAF4CF091
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiCGEGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiCGEGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:06:31 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA23AA77
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 20:05:37 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c4so149562657b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 20:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Va1ivrfy7pqppqn//1ybfbkoZ8zcsGzxAq5Mdwrg6Oo=;
        b=CHEpzzbREopfx95f7FHN1MGscUrK2OsB+/98Z2ZAh7A2LQNPljJ3YRSmOdBloiWW88
         15C9UbCzX63Lt1MJWyGx1K6HiLquJ4C0n7SQFxIYdtDTecDkgueqoOLBFpm8hp3XOJOl
         fs0q54Wn5Kb/On5x1+rOB1f0ohhmfXewgG9SKpuaW2r/qCcy1CCAwOL/v4wlHr0fOJ6x
         ImWHjseZvFEC+HKihvtISdH2g5sAuPxTehxNh4zuSMzVIYRmKv8QrLjaR2Cq4fnk1Z7p
         XCGRjiZuXkkwe1yWiEvsSRVfYN+2WbIB8dzflqDvrNIE/hr8YDc4htKPsHxFvzxBSwdV
         O9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Va1ivrfy7pqppqn//1ybfbkoZ8zcsGzxAq5Mdwrg6Oo=;
        b=bxT+jsce8J5Iuq2H9VKUYaCySp6krz0ZLGqCT5N6MuYpfAcSeu3vhdOXHRxNwVvFZ4
         5wwyH7DVQ34YfPP2yY70PnSjOs6C33ZXhFyc92Z5AbPF/4VevFY9XEA6U7iM7IOOmZNW
         RS9Zuq3PhPkdqdUNCmWkgp+YBr3wvPSjVwQS9edhLWXdHbns49tiZ/WniI4IOmaJPcwS
         4vhKDdtc09EoxNrK9qVtY3V4Tt0m4gzvw1lQltYNTf5FkVQrZVGFCs6k9zMnEzt0Dl8M
         Uj/zi7CAKaL1sQzdC6KUKShPz+jrOrzjvhZ+pytTcD5I7EpbM/WIV/EAfFIxGjDHG7t6
         UrxQ==
X-Gm-Message-State: AOAM531ABn2rHaFdgh8KXbwlO1dTX/vJMPHyg9RbGGvkPy0Z39BR1/qy
        rETxgxH6eXH1eKBoIL7TrVF5sZoYnCehng1mJJbmaQ==
X-Google-Smtp-Source: ABdhPJyiizH6e69CmmtKrMh3+m/by+kjMdBmy1n6E4L2QN9IGHXmoGlhozNEiuGWunZQdPzehWbqrluwp1onENNGxPQ=
X-Received: by 2002:a81:5382:0:b0:2db:81d5:14c3 with SMTP id
 h124-20020a815382000000b002db81d514c3mr6914333ywb.311.1646625936542; Sun, 06
 Mar 2022 20:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20220307034358.286657-1-wjack@google.com>
In-Reply-To: <20220307034358.286657-1-wjack@google.com>
From:   Jack Wu <wjack@google.com>
Date:   Mon, 7 Mar 2022 12:05:25 +0800
Message-ID: <CAHnoD8BTEPeRToRtan7LZJae-K3dv0pvBYQrXkrr3scbjUUcTg@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: add dock type
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ken Yang <yangken@google.com>,
        AleX Pelosi <apelosi@google.com>,
        Vincent Wang <vincentwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Currently, power_supply framework supports only Battery, UPS,
Mains, USB and WIRELESS power_supply_type. Add dock
power_supply_type so that the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

change log
---
v2: updates to Documentation

Thanks!
Jack

Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B43=E6=9C=887=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add dock power_supply_type for the drivers which supports dock can
> register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
>
> Signed-off-by: Jack Wu <wjack@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  include/linux/power_supply.h                | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 859501366777..0b45d9d3a50f 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -34,7 +34,7 @@ Description:
>                 Describes the main type of the supply.
>
>                 Access: Read
> -               Valid values: "Battery", "UPS", "Mains", "USB", "Wireless=
"
> +               Valid values: "Battery", "UPS", "Mains", "USB", "Wireless=
", "Dock"
>
>  **Battery and USB properties**
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c0dfcfa33206..2b1f18b7f98c 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =3D =
{
>         [POWER_SUPPLY_TYPE_USB_PD_DRP]          =3D "USB_PD_DRP",
>         [POWER_SUPPLY_TYPE_APPLE_BRICK_ID]      =3D "BrickID",
>         [POWER_SUPPLY_TYPE_WIRELESS]            =3D "Wireless",
> +       [POWER_SUPPLY_TYPE_DOCK]                =3D "Dock",
>  };
>
>  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index e218041cc000..8f0425f00803 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -189,6 +189,7 @@ enum power_supply_type {
>         POWER_SUPPLY_TYPE_USB_PD_DRP,           /* PD Dual Role Port */
>         POWER_SUPPLY_TYPE_APPLE_BRICK_ID,       /* Apple Charging Method =
*/
>         POWER_SUPPLY_TYPE_WIRELESS,             /* Wireless */
> +       POWER_SUPPLY_TYPE_DOCK,                 /* Dock Charging */
>  };
>
>  enum power_supply_usb_type {
> --
> 2.35.1.616.g0bdcbb4464-goog
>
