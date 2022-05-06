Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC651DF51
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388780AbiEFSyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351695AbiEFSyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:54:49 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC250E3A;
        Fri,  6 May 2022 11:51:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec42eae76bso90920017b3.10;
        Fri, 06 May 2022 11:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nC1JrFzSsei+a1QRBYikufrL4HRzQCmx66O7akFjxYs=;
        b=1SbeoVP3dqKbSvgVAYQ+vWRKtPglyQIjYUF9y3TkevQFSr6WjU4pmrhULoiPqEdn46
         L6WQah9iwMtcmV9ElhB4a3tX8lpJI1CkRybaeJNxFAJ1piHJNJnT32PJNk5qDcBSMovR
         Rd6yEX4dhBHBeSAaXM4OtY/Li0b4gRqY5fd8/k54ZxcXDJn0ScNwlqAjco2vUVU8Dvj4
         kXxLgu8bcLFvd+jAN/eSJ3yDQup7FuddEANaxNSviaXDTm4sZcxt/TDcFjC2sKYQMPQD
         /7OkBPGeC8BBT19l44GS6oDHFwRiE7R8Bh6nQgtILQDdyhUoZR4iy93U+TgH850Okdxi
         EOqw==
X-Gm-Message-State: AOAM5305iU3yDc2xpWgawR+O4C9o1sMo0fD/15/pViITG6tU1h4HysOP
        x2rSpCI8vDj9Rqtcib2R74+s8NW0WiVAGxh3IkA=
X-Google-Smtp-Source: ABdhPJw4WPBUDP9dbIRq2WMzzCT3V4idBujcIw4ZS01FPCWB4xqYLnls0XyBSIRIrfo47mjjKeLOA9R2sh6lgaECKBg=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr4049157ywv.196.1651863065018; Fri, 06
 May 2022 11:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220502095101.46920-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220502095101.46920-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:50:54 +0200
Message-ID: <CAJZ5v0hNY4wJu2BgOj9tMtOEe2p-VA-NToeq67snZAaJ8xs_PA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Advertise fwnode and device
 property count API calls
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Mon, May 2, 2022 at 11:51 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The documentation of fwnode and device property array API calls isn't
> pointing out to the shortcuts to count the number of elements of size
> in an array. Amend the documentation to advertise fwnode and device
> property count API calls.
>
> Reported-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f289f582209c..836124f54332 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -68,6 +68,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
>   * Function reads an array of u8 properties with @propname from the device
>   * firmware description and stores them to @val if found.
>   *
> + * It's recommended to call device_property_count_u8() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -93,6 +96,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
>   * Function reads an array of u16 properties with @propname from the device
>   * firmware description and stores them to @val if found.
>   *
> + * It's recommended to call device_property_count_u16() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -118,6 +124,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
>   * Function reads an array of u32 properties with @propname from the device
>   * firmware description and stores them to @val if found.
>   *
> + * It's recommended to call device_property_count_u32() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -143,6 +152,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
>   * Function reads an array of u64 properties with @propname from the device
>   * firmware description and stores them to @val if found.
>   *
> + * It's recommended to call device_property_count_u64() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -168,6 +180,9 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>   * Function reads an array of string properties with @propname from the device
>   * firmware description and stores them to @val if found.
>   *
> + * It's recommended to call device_property_string_array_count() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *        number of values available on success if @val is NULL,
>   *        %-EINVAL if given arguments are not valid,
> @@ -256,6 +271,9 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
>   * Read an array of u8 properties with @propname from @fwnode and stores them to
>   * @val if found.
>   *
> + * It's recommended to call fwnode_property_count_u8() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -282,6 +300,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
>   * Read an array of u16 properties with @propname from @fwnode and store them to
>   * @val if found.
>   *
> + * It's recommended to call fwnode_property_count_u16() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -308,6 +329,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
>   * Read an array of u32 properties with @propname from @fwnode store them to
>   * @val if found.
>   *
> + * It's recommended to call fwnode_property_count_u32() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -334,6 +358,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
>   * Read an array of u64 properties with @propname from @fwnode and store them to
>   * @val if found.
>   *
> + * It's recommended to call fwnode_property_count_u64() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -360,6 +387,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
>   * Read an string list property @propname from the given firmware node and store
>   * them to @val if found.
>   *
> + * It's recommended to call fwnode_property_string_array_count() instead of calling
> + * this function with @val equals %NULL and @nval equals 0.
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *        number of values available on success if @val is NULL,
>   *        %-EINVAL if given arguments are not valid,
> --

Applied as 5.19 material, thanks!
