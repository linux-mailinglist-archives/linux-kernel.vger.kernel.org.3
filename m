Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4E5A25A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiHZKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbiHZKPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1109D46DBD;
        Fri, 26 Aug 2022 03:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C26061408;
        Fri, 26 Aug 2022 10:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0438C43140;
        Fri, 26 Aug 2022 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661508898;
        bh=NK190jfdx00jTrDCv7zIYGo0wJWl8l2X9W8c9twpJWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nIY/moorJ/m4y8AsNO48CqLsfSNmDBPVeSgxPLfk52PP7Y6aYXueV2aNABvSfDMUi
         PDsp5ZmnBW+jFnyUjB+NFpeEaud2aDjGAhL/0GP4P7NeL/sMVy9bfp90MrRO4zY8m3
         aab6J1R5XG4vEQ86+OsqWJAsQyDOSWHH0r7wlUYV87Z1shvS3i2IxpzQA9EK0vCAfP
         mXRq/ZxVseBpULo8TA1iBO4iSt4FYmZg6Pt3c42fJBWPbpuChX7CTEq8XOz1wQJvH5
         3T+i8q/2bsnuufE2Wetp7tEPW5GiTGzTQNKXS7ymuEskEsAhQC7Ky/ZfbW1GE3yc0I
         f9SCR3FYOGWyQ==
Received: by mail-wr1-f50.google.com with SMTP id e13so330836wrm.1;
        Fri, 26 Aug 2022 03:14:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo33rVA+TcAduSoD2aTtHLvMe5Kzl9+XuoxaUrJPyJBM3/66UD2l
        HqS/rUfslS9akDI1371pDPA43yP5HmBnRGAk0OY=
X-Google-Smtp-Source: AA6agR543ZK5dQZzr1lpLH8yqs+KhBfAVVvO1WOBz7r4lxnkexozgQ2VhsVLtTvZFBFUFU85FdH18Lv17LDbYByPKjY=
X-Received: by 2002:a05:6000:782:b0:225:3e46:3dd5 with SMTP id
 bu2-20020a056000078200b002253e463dd5mr4249270wrb.103.1661508897137; Fri, 26
 Aug 2022 03:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220825111715.3025694-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20220825111715.3025694-1-sakari.ailus@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 Aug 2022 12:14:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVnZzmYN46d0YB8ieri4vEPz49ufw1FvQ19GT+cQ+wLw@mail.gmail.com>
Message-ID: <CAMj1kXFVnZzmYN46d0YB8ieri4vEPz49ufw1FvQ19GT+cQ+wLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: Remove default association from integer maximum values
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sbinding@opensource.cirrus.com, andriy.shevchenko@intel.com,
        patches@opensource.cirrus.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 at 13:17, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Remove the default association from integer maximum value checks. It is
> not necessary and has caused a bug in other associations being unnoticed.
>
> Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/acpi/property.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 91d0e75859d37..d4c168ce428ca 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1046,8 +1046,7 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
>                                                                 u8 *: U8_MAX, \
>                                                                 u16 *: U16_MAX, \
>                                                                 u32 *: U32_MAX, \
> -                                                               u64 *: U64_MAX, \
> -                                                               default: 0U)) { \
> +                                                               u64 *: U64_MAX)) { \
>                                 ret = -EOVERFLOW;                       \
>                                 break;                                  \
>                         }                                               \
> --
> 2.30.2
>
