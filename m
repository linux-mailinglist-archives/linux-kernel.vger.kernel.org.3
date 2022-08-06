Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1E58B4E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 12:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiHFKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiHFKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 06:01:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F7E0DB;
        Sat,  6 Aug 2022 03:01:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u8so3355010qvv.1;
        Sat, 06 Aug 2022 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tcz+EOVdYcZHlsH9SYESaKQOcLwMzzj4cFiUQj/3xW0=;
        b=FCdFFjbMwMg/s6HFx790Az8w4ZCawOEL2oYxgHvlY9jWlQcfHubH99eC+GJTYsl0LZ
         F05lEQ0OFoM4ii6D0TT1dQIeoaLxS2qNN2BntpYQ5ogfLlatZHWZgevmDmA+hCqod7HB
         URI/PYi/Y2w0LZd/jYCGttSgkv4GyaTFcJyoyOHAY6W0DKjLCWaISBQbU4pUEd4R7HOk
         8HB6dWygBdxYUGkAgmdeb5uH1ObJ4ULsPqC3ShK1CRTkU+MEFJVWe/yVIQv1kibjAaKc
         4Xj8KZ2nur6QTsDH/e+DFATKdcIaCom0515NVDQhm7YUlrRcoe308JZ1uGTi9x7WPIyC
         w2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tcz+EOVdYcZHlsH9SYESaKQOcLwMzzj4cFiUQj/3xW0=;
        b=F0F4himsn4DLpxA+DDgMph1k3u6nvPv6kh3sIwAmYE9Imo7FBn/xlR5d3dEk0a7817
         nbWbA0RrEQbb7HxaiITORynrnW+l1HGVmbGJxF71qtKi33klJ5lbgR1mPKphittxsrR9
         VfXoz2KVzTU6akzRgyBko2c9s/X3RLUuOaMWEliKbcbNnkC0vEVVAJp24abgE5jIS3T7
         Q+t1BqVnnE4z/RjIkb42kPzJAfpxlaVIMIIKBo5Oa83FK0wGb0Thhcryord3MTDVKEBj
         OmzM7Kjy31UzTWAWWo2V3J1lmmONdyFLC0CPyCRGMdvTxM+b/aLiL6HP10OtYPbeWZXS
         Dslw==
X-Gm-Message-State: ACgBeo1Ww3sfkxSqg4t8/pGIoASVoSIUnZD1t9VM5fCpjo23TnPsHT9r
        ODT0kxgVCxoH09KpFgpn9lPPTy8Z35nUXVA0RyVvPNJ14Ak=
X-Google-Smtp-Source: AA6agR5ckULAzwFTpSVX0pVkuHp1yODSlueiPs99bynLj2TckkE8xVP4bBDXAHLyhsn/1oLtaG/Uj0v73o4+n+nV9lA=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr8933644qvq.64.1659780082142; Sat, 06 Aug
 2022 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-5-luke@ljones.dev>
In-Reply-To: <20220805081909.10962-5-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:00:45 +0200
Message-ID: <CAHp75Vdb3bs05iXccrb+Hp=VR-yVAifaY00JruH8i2Sv0QxGAA@mail.gmail.com>
Subject: Re: [PATCH 4/5] asus-wmi: Document many of the undocumented API
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Aug 5, 2022 at 10:21 AM Luke D. Jones <luke@ljones.dev> wrote:
>

Missed commit message.

> Signed-off-by: Luke D. Jones <luke@ljones.dev>

...

> +Date:          Dec 2022

I would be more optimistic here...

> +KernelVersion: 5.17

...and definitely this is the wrong version. I would suggest 6.0.

Both comments are applicable for other similar cases.

In case you are documenting new and old APIs, split this to two
patches with different dates and kernel versions. And commit messages
should be different.
-- 
With Best Regards,
Andy Shevchenko
