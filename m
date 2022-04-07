Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285354F772E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiDGHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiDGHR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C51107ED;
        Thu,  7 Apr 2022 00:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D1E61DCE;
        Thu,  7 Apr 2022 07:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FB9C385A0;
        Thu,  7 Apr 2022 07:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649315725;
        bh=9/pSQxZKSCCWBCzwEN5pmuogYawG56/M6P8na1rHLYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIw6a9MKBB0tYMm6O1XK0svoSqZWLx5wNXDG/G4yLfdr4qVuaALQXCj1++qvmEcez
         KGzd9NPQo7eynh+CNiyOIthPUfrI0MLRvcfxE1v4sUQNFU3FUHKIED1ERVPo+LlvQr
         XsMI+ad/xrevLWPXNwMfgFbHo1yf6kr0x03u3sfY=
Date:   Thu, 7 Apr 2022 09:15:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, usama.anjum@collabora.com,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5] platform: x86: Add ChromeOS ACPI device driver
Message-ID: <Yk6Pip7f3iUsIHTr@kroah.com>
References: <Yk6ODSxQTiGOrTj/@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk6ODSxQTiGOrTj/@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:09:01PM +0500, Enric Balletbo i Serra wrote:
> --- /dev/null
> +++ b/drivers/platform/x86/chromeos_acpi.c
> @@ -0,0 +1,515 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2011 Google, Inc.
> + * Copyright 2020 Google LLC

You haven't touched this file in 2 years?

