Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C700557F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiFWP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiFWP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:59:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905937A9E;
        Thu, 23 Jun 2022 08:59:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so1127375pjv.3;
        Thu, 23 Jun 2022 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qtqWJlpUIAuCO2hAy6cE8sYaGi3ajKGUTZlX2krjZn0=;
        b=bzA7POkssLs54XniN6h0Ct7GjvJebGl5zPNO/uYsvkt1uQ4nof4sVkscs4tFFoYa+S
         1HYDAFBB4JYfEI4R2YCe5jCJ6iyn5RXZNw7iW/lzk+pYyJwMmXMjtcfoOAG6uST3pNHD
         Vf+SFXxhiLiYKNNISKNnj9Gsd8LoG0IhDLYcHA84k1BJQ9wIs0/vseD2iKRZjbUeTs9x
         7Gv3gJmbxckmvlDRUXNG2Ry822nyP96EcRlExSnqueINPihkZxH4KofJ1hO7IRUrwtZT
         3ncfFpOKkGx5GhAe74uZ1ZBdWLA5KaYETyxkD0ktH85xLPLM+Uv96PL5AVYdhQJXxMwG
         6OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qtqWJlpUIAuCO2hAy6cE8sYaGi3ajKGUTZlX2krjZn0=;
        b=RZvLKWZYVF9vBff5z4L3wwiJzM0E4Ar07tZ+Se0FRj/XR6+Ucwk84OjoEpkQIMCClV
         gOXKETZDvcXbf8lqhpG0mEqO8eFxsDUqrRuAYF+OEwT85tbZ11NJ/OLRZlU0xb1Hecf+
         FqENjmiLVF5XQ+nVybQNGaSapXBfeOdmMR/iUiqjwD82vivROycTigofDLo2DcQ/nUf7
         wlMAAV6hgZl5roXQJTuJSqFwchwmK2GeIwwR17jesKyG4rH2TWEkc7Tgpwh8L6idCDxz
         sNjLZvUDWODrQMlwTTeqeebPseOeyaZtnTDxo/s0YNTUM429+z++j8oMAPugI5Ft5UB6
         OXrQ==
X-Gm-Message-State: AJIora9e5zjE6uOeAUJdgtKhkAVhLwEtURnyrgXokJDGMCc3jRRiWafU
        DMkPnks854FG+Gq7iTEaUzo=
X-Google-Smtp-Source: AGRyM1t/SOXyGrqXw3NpfumWtVpHXdzrnbU9df3bZBi8zdSv5TAabHpGR536d7NxaXigFHQry1P9fA==
X-Received: by 2002:a17:90b:194:b0:1ec:96dd:fef2 with SMTP id t20-20020a17090b019400b001ec96ddfef2mr4707471pjs.195.1655999995385;
        Thu, 23 Jun 2022 08:59:55 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:96d9:dda4:3142:7c7a])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b001620db30cd6sm14955617plk.201.2022.06.23.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:59:54 -0700 (PDT)
Date:   Thu, 23 Jun 2022 08:59:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: usbtouchscreen - add driver_info sanity check
Message-ID: <YrSN+DYQun/IOPh7@google.com>
References: <20220623062446.16944-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623062446.16944-1-johan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:24:46AM +0200, Johan Hovold wrote:
> Add a sanity check on the device id-table driver_info field to make sure
> we never access a type structure (and function pointers) outside of the
> device info array (e.g. if someone fails to ifdef a device-id entry).
> 
> Note that this also suppresses a compiler warning with -Warray-bounds
> (gcc-11.3.0) when compile-testing the driver without enabling any of
> the device type Kconfig options:
> 
>     drivers/input/touchscreen/usbtouchscreen.c: In function 'usbtouch_probe':
>     drivers/input/touchscreen/usbtouchscreen.c:1668:16:warning: array subscript <unknown> is outside array bounds of 'struct usbtouch_device_info[0]' [-Warray-bounds]
>      1668 |         type = &usbtouch_dev_info[id->driver_info];
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2
>  - use ARRAY_SIZE() for the sanity check (Dmitry)
>  - drop the dummy entry and combine the two patches as the sanity check
>    itself is enough to suppress the compiler warning (Dmitry)
>  - use -ENODEV instead of -EINVAL even if this means no error will be
>    logged in the unlikely event of a future driver bug

Is this on purpose or because I happened to have used this error code
when I suggested the change? I'm fine with returning -EINVAL there.

Thanks.

-- 
Dmitry
