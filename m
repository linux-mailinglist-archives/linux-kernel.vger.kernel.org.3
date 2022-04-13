Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4F4FFDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbiDMShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiDMSha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:37:30 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D02D1FA;
        Wed, 13 Apr 2022 11:35:08 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2eba37104a2so32868227b3.0;
        Wed, 13 Apr 2022 11:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByeHtfjjHnRe56jMMHw+qy/+mL93tWApiiz58HT1r6A=;
        b=Ac3YyDJDOiWKvQjJ+4FBAouNFsR5x3fFIMLTKHjgXLFX2jlCbdKWLO40r7unRleGhb
         jhiIK4hCk+1t+iZWRmAyRyTxV6+NUSs6NbudeiV4O8Ii3TC+5jn2nwwtccGK5e6MQPuQ
         wrCwQrJxVtLP2DZgx5ZoIqGAcwGA6oC+3NYI+loMkGSUXXpUV1Up8mkMkHRi4mtnvRS7
         iQ+50d0hhHabcEIr0r1TmR9XbUMH4ZkA8mSFDZMfRS0Io8nfz9vNORnU1Zwpayom/o1z
         FrUA/BrjOjwf8JDMRpMaDTxg27O61fg1sSFC9VSwsTRhRbxj4U7BZ0K0ltjwATCidiCB
         wjGw==
X-Gm-Message-State: AOAM532yic5yeNjyzjrx+slDLY5i+TELbB8uTiqJy+Sneg/eMk17lzCd
        k68fyKYhF5qR7i08vg/n4Ia4xSDLbF1L1p5gyiRJUT5N
X-Google-Smtp-Source: ABdhPJz4VL4yyicwKnom4pIDA1THiDF3A+5Cp76OQMH5P8GgDqOX5PMHwLcjVkTQdy1vr0az2PcEGAS9rwmvPhxswvI=
X-Received: by 2002:a81:1096:0:b0:2ec:4a46:7e5a with SMTP id
 144-20020a811096000000b002ec4a467e5amr241528ywq.196.1649874907749; Wed, 13
 Apr 2022 11:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220413115912.41893-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220413115912.41893-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:34:56 +0200
Message-ID: <CAJZ5v0jX7e=cLrqQ9FiJUT3SSOoOS0kz8WONWzdaMf73xEvosA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: docs: enumeration: Unify Package () for
 properties (part 2)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
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

On Wed, Apr 13, 2022 at 1:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Unify Package () representation for properties:
>  - make them one line where it's possible
>  - add spaces between parentheses and curly braces
>  - drop the explicit size of package
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index 47fb4d6d4557..6b62425ef9cd 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -167,8 +167,7 @@ The table below shows an example of its usage::
>          Name (_DSD, Package () {
>              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>              Package () {
> -                Package () {"interrupt-names",
> -                Package (2) {"default", "alert"}},
> +                Package () { "interrupt-names", Package () { "default", "alert" } },
>              }
>          ...
>          })
> --

Applied as 5.19 material, thanks!
