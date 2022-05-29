Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4CB537172
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiE2PCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE2PCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:02:53 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406CA939A7;
        Sun, 29 May 2022 08:02:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1F9E4B7;
        Sun, 29 May 2022 15:02:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1F9E4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1653836570; bh=prfaPouyOR+h3OLn6aM3uj1MK/ywudByeFsbG2uZEBk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jDwL7ar7WO12Ocu9dHfPV7mvCf3la5OQj0lH43MGiZAU5r+c+kGhOr3Vv/paus2RG
         jwdHU2GrkIIaOTUdsV4lg19YqsUa2AWM8nV99048dXHQll20XJ0z6XXYyXHHa7ykXj
         5v/FCGN80wEBco05UGVKz9VP+VkJ+0CE3+lpUOPD9b/taubZcgc4/z+11lkoHx4jln
         rpHCeGzwhRJGoQJMwBENyeUe3azTumzr4DKbAZoC9rXrh64Em0/3e853XBBWZ4iEP9
         XlXdUe8kGBt4Ut9xeuvHUyccFQDTaZDD3pLb8J+u5EqIpcl/pVluGS2oZZbiNInR9p
         d0k3HIEtAoAuA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?Q?Jos=C3=A9?= =?utf-8?Q?_Exp=C3=B3sito?= 
        <jose.exposito89@gmail.com>, llvm@lists.linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: uclogic: remove extraneous asterisk on
 uclogic_params_* static functions comments
In-Reply-To: <20220528091403.160169-2-bagasdotme@gmail.com>
References: <20220528091403.160169-1-bagasdotme@gmail.com>
 <20220528091403.160169-2-bagasdotme@gmail.com>
Date:   Sun, 29 May 2022 09:02:56 -0600
Message-ID: <87tu988jq7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> *uclogic_params_pen_inrange_to_str(), uclogic_params_pen_hid_dbg(), and
> uclogic_params_frame_hid_dbg() are static functions but contain
> double-asterisk (/** */) comment, which confuses kernel-doc as public
> function for generating documentation.
>
> Remove the extraneous asterisk from these comments.

So there is nothing wrong with making kerneldoc comments for static
functions, that is not where the problem lies.

> Link: https://lore.kernel.org/linux-doc/202205272033.XFYlYj8k-lkp@intel.c=
om/
> Fixes: a228809fa6f39c ("HID: uclogic: Move param printing to a function")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nikolai Kondrashov <spbnick@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: "Jos=C3=A9 Exp=C3=B3sito" <jose.exposito89@gmail.com>
> Cc: llvm@lists.linux.dev
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/hid/hid-uclogic-params.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-p=
arams.c
> index db838f16282d64..71501453de12e4 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -20,7 +20,7 @@
>  #include <linux/ctype.h>
>  #include <asm/unaligned.h>
>=20=20
> -/**
> +/*
>   * uclogic_params_pen_inrange_to_str() - Convert a pen in-range reportin=
g type
>   *                                       to a string.
>   *

A more likely problem here is the blank between the function intro and
the parameter description.

> @@ -44,7 +44,7 @@ static const char *uclogic_params_pen_inrange_to_str(
>  	}
>  }
>=20=20
> -/**
> +/*
>   * Dump tablet interface pen parameters with hid_dbg(), indented with on=
e tab.
>   *

Here too

>   * @hdev:	The HID device the pen parameters describe.
> @@ -76,7 +76,7 @@ static void uclogic_params_pen_hid_dbg(const struct hid=
_device *hdev,
>  		(pen->tilt_y_flipped ? "true" : "false"));
>  }
>=20=20
> -/**
> +/*
>   * Dump tablet interface frame parameters with hid_dbg(), indented with =
two
>   * tabs.
>   *

Here, instead, this needs to be formatted as a proper kerneldoc comment
with the function name.

jon
