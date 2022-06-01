Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F653A1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiFAKC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351641AbiFAKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:01:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE063FE;
        Wed,  1 Jun 2022 03:01:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er5so1416337edb.12;
        Wed, 01 Jun 2022 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6bQ8wNEdYW/5SL8f6wJxD6xOkrcMizWwzbAsv5iCvA=;
        b=YLyg9lZx7RpmWmTo5cyuxwreuST/cxTejpPxUTQ0GZK8lNMLhKXVwtpxIoFJ/Fn/pe
         v7gt3idwTDdocYUqobMDS6ukD1d7rbZcT0UPm7jvCALN5AgtwusZW37N1K+O+Sr2hxMY
         YFT+R8i354F7CBA6yx2Li7mltB0MZ73rjEij4bXALPZoX6Ztyhw49VOZbHB+X//d4tTX
         wlALNt75BktCff/LSLb9aemUjjyUtYD73s2Csy1RzjRPMP3Kn0Tjv8bz2QdEIDlhJuum
         81+2A80qcAKk56kT22tswnGY49wnu7mxzePzw2Co83YtV8tCgoTzMh4wD5kO6VcVy7yk
         eugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6bQ8wNEdYW/5SL8f6wJxD6xOkrcMizWwzbAsv5iCvA=;
        b=UXngoaWfGDfkr/S45rRj5t/cSnUzWK+mNsOGDJ5IhzGe0SrRwYgvYUJpVc8A1jxoul
         7idauabBpuJ0Bc1oRMVPRkzpRoEycxaXIIjgVyY2YKQJsyOHAPPUbD/mZLRvqdmgm79M
         zE5K0BpFadm0AyDhDyzXurU6KSZGldB5EStA/VbiuAG3QLd1lWZKJ10h+Id3aBJb7FOR
         4wFpgLdOts1l4pLumBVYYrfT+0CvbSl0NVsDiyrq0KFUsTg/p0fNDEsxNXloR70K7MEy
         8OnfZ7KkG3bge5krUvEA0GtkpKH8/gJdKCKQSWDGs2wfgxBwAXynCWKg0quwwAkDktcJ
         j2wg==
X-Gm-Message-State: AOAM5312aZZykq1C5XQaZ+661xtURsXO/dvDify1cnX4x1pxN1/FNpjV
        byT0V7SJejNqv9jpv8TiNz61x8D6VcD7S2GbYkU=
X-Google-Smtp-Source: ABdhPJy2QZLQKIXspzg65N6kod3tzAV3N/rHqM2AEkBDHA9Ty5p6qEPyxO0l5zVNmzvFCJjG+LHqQFDIJ23PzwmwrEY=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr5401417edq.54.1654077708412; Wed, 01
 Jun 2022 03:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220531181016.76007-1-joetalbott@gmail.com>
In-Reply-To: <20220531181016.76007-1-joetalbott@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jun 2022 12:01:12 +0200
Message-ID: <CAHp75Vdei4SyC0Ph0xB3DFLgkixU2FJ1TS4og8r=b+CkiMQ5hQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 9:40 PM Joe Simmons-Talbott
<joetalbott@gmail.com> wrote:
>
> As reported by checkpatch.pl.  Where possible use DEVICE_ATTR_RO and

DEVICE_ATTR_RO()

> DEVICE_ATTR_RW.  Change function names to be <var>_show() for read and

DEVICE_ATTR_RW()

> <var>_store() for write.

...

>  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> +       0444, length_show, NULL);

>  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> +       0444, watermark_show, NULL);

Why not __ATTR_RO() here?

-- 
With Best Regards,
Andy Shevchenko
