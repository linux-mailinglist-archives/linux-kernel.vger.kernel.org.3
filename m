Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926A4493397
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiASDZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiASDZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:25:53 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5ECC061574;
        Tue, 18 Jan 2022 19:25:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y22so1197263iof.7;
        Tue, 18 Jan 2022 19:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeiComjozb3H7WSxPqG06uMRQklbE67gyAu/I34ENgQ=;
        b=jgNvzz76xJCkVXydAIVX7OWcya80MX4FkUlnfTt69NAHcd5sfhGJOmk+1IbuG4iqYh
         ciNg9xp3ceJ2p/CUqhnKqtlPjrOLjyaTB2a+v3KqeQzqpDigXDt/rIMDdcTOvEMhzEi0
         SVGoCOnIsHUDoi2xqwQptsLhk8eHrLJxkdyJ+zNjZ/IiLt3DgBZggKESqkzrOVnI2E1i
         YmQRsxnS4EGJOtIhSF69c5qj0g4Tm0lR1dYfeTgmDyWJ2owfiulJAZ0FIXNTEcWwAcvc
         5LJhqJ1UVtdKel5z3FHlBwNz5rEwTrmDw5I4DnncmnVI2aTpsTmz3iMGrBOy11KgeiVF
         Ucvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeiComjozb3H7WSxPqG06uMRQklbE67gyAu/I34ENgQ=;
        b=L83cki/rk2Qf9SAue25vnw2VR7oD+/giOt6b1XzxPvkuJGSE2bS7DPnEyPK4uefb5W
         RejIwBrfWYwEJ/sShNzgvheAL/tRRJGYcKLP2jm9HoQlA97vSEJKeeRtet2OKv+l4nqP
         2Ufjp/VqJiuCksJJIQWkNALeLLyAvALcVjJun0icqFfQ5p4znCAtgQCxdsKHKq/wJIS3
         lDswb837x5U315K4aze2jIA0ghgVkiEWKNAfssZ8MFamrr26VX4M4G0/GfdIFwEmjYdp
         j6muLiuY2+Xf4YvriD+Hhu6pv1C0Yrfm8j33p8bImiE39dJyDtOnh6F68lidGBWc9xU1
         ySeg==
X-Gm-Message-State: AOAM532pzyqRoNAXGxAMnWkK305s37rEAQMk6IEKJFJDIDt3Pl/xca5e
        lQntNVlfimZkhJDVkMHWfqfcKShBTaTaNrJfzJWfomi4ptM=
X-Google-Smtp-Source: ABdhPJxIDFjP40161aTqo0wOL9CTmpWqkkVSLuQI2Z/DvEaqQm3/uGIbWUtljLEYQi/3zOP6jvIQ+H/p06UZO/IzynY=
X-Received: by 2002:a02:2205:: with SMTP id o5mr5908069jao.241.1642562752380;
 Tue, 18 Jan 2022 19:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20220118165316.412735-1-eugene.shalygin@gmail.com> <20220118165316.412735-2-eugene.shalygin@gmail.com>
In-Reply-To: <20220118165316.412735-2-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 19 Jan 2022 04:25:41 +0100
Message-ID: <CAB95QATvQPZ-s4dCWeqKcSZ9Rfx9uK1AyoM9Kk3biPfvXh5r5g@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v7 1/3] hwmon: (asus-ec-sensors) add driver for
 ASUS EC
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did not read carefully what I committed and now two small
corrections are required (see inline). Should I resend again?

On Tue, 18 Jan 2022 at 17:53, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
> +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-F GAMING",
> +               SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CHIPSET
Redundant line break.
> +       ),
> +       DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE, "ROG STRIX X570-I GAMING",
> +               SENSOR_TEMP_T_SENSOR | SENSOR_FAN_VRM_HS |
> +               SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU),


> +struct ec_sensors_data {
> +       unsigned long board_sensors;
> +       struct ec_sensor *sensors;
> +       /** EC registers to read from */
> +       u16 *registers;
> +       u8 *read_buffer;
> +       /** sorted list of unique register banks */
> +       u8 banks[ASUS_EC_MAX_BANK + 1];
> +       /** in jiffies */
> +       unsigned long last_updated;
> +       acpi_handle aml_mutex;
> +       /** number of board EC sensors */
> +       u8 nr_sensors;
> +       /** number of EC registers to read (sensor might span more than 1 register) */
> +       u8 nr_registers;
> +       /** number of unique register banks */
> +       u8 nr_banks;
> +};

Forgot to remove doc-comments.

Thanks,
Eugene
