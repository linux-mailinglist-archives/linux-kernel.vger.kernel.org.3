Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE746AA8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbhLFVih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351960AbhLFVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:38:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92274C061746;
        Mon,  6 Dec 2021 13:35:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id t5so48580930edd.0;
        Mon, 06 Dec 2021 13:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g/3xej/+7yR5jJ0HvJ4Y8QLnsfRIB2TAouZkdT19Z2g=;
        b=J7JsGjsf/XGWSvpCCG8croHDg8zDuVWD+tHl/bI49pnwZcleqZoMVWfxLLBWqPfzrF
         kumFZb1dl7F+01MzkDELA5qt3iMyS2ail/jGZusyCcLUgwja5bJgiX5zaJhNM25xSS/8
         DdsS1tl59APyj3ACPqfhgcgbI1demlIgtU6Qti85MJ7KX46le2eIMiVv0BHzqhFwsV8n
         X0vqahcDxs4YcAWwLumlhUQZ1IdfHxNjmXUn47z2gAbqxeHhlr0TLF3PeASown5WVn1Q
         Yy3hKGXOOMdDuta1Qi42aYvChfg81FTRkOzp7v+wnEDHvoJ41ell4r5N3n4R02boNKf9
         ccLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g/3xej/+7yR5jJ0HvJ4Y8QLnsfRIB2TAouZkdT19Z2g=;
        b=Y+ocSszV+qKJjJNVYb5kPHto9C31S0kBcQnWcbY5r8Rux78M/sw0GzV1/b0VlKwOu8
         XYAA55dcMmFJ28Gydh4QwevPG874SAMcDd/GRIyHVpWEXeEdSD0Kl2mLHX5cmm76C31x
         x/sF/mtuI9WQdDwgPLR4b9sqjh/8dLHycqmj6tBIwTi5eXGeVYQc5+WOKe3J08DdzI/P
         w72Bv+5s0jeVuig6j+DqiPei+LoF4G0Czt7Sf5Rj8GkflHVKqY1Tumn1iVYYLxW40Zra
         Xew//tEzLRTFvowQnERJvlvUiJdvtndoVehvf9uysU8/Tr84rnYW9G67mHSV+F7hxJGK
         hlRQ==
X-Gm-Message-State: AOAM5339umK/ZlNf4mmjnx1O4JpiNiKuDt2gRLKWosaTTKwiA2VkAGaT
        /7wt4qNp/FEhfsLq2AhE0TTWgPVQsyw1pCJStqs=
X-Google-Smtp-Source: ABdhPJz7vzNiruzGi8mIW3IUnHtTxAzltO2rAWQ0vCs78/iB1Z8kPEXplKx6gdM538xcewsFgbTKHxy/BZxn3gyyy78=
X-Received: by 2002:a05:6402:7d8:: with SMTP id u24mr2500706edy.215.1638826503830;
 Mon, 06 Dec 2021 13:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20211130060523.19161-1-christianshewitt@gmail.com> <20211130060523.19161-4-christianshewitt@gmail.com>
In-Reply-To: <20211130060523.19161-4-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:34:53 +0100
Message-ID: <CAFBinCAK76UY3LPyBRX99oR74JFk8geru-th6FqA9bPgugbCag@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] arm64: dts: meson: add initial device-trees for X96-AIR
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benoit Masson <yahoo@perenite.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:07 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Amediatek X96-AIR is based on Amlogic S905X3 reference board
> designs and ships in multiple configurations:
>
> =E2=80=93 4GB DDR3 + 64GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
> =E2=80=93 4GB DDR3 + 32GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
> =E2=80=93 4GB DDR3 + 32GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
> =E2=80=93 2GB DDR3 + 16GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
> ...
> - HDMI 2.1 video
> - S/PDIF optical output
> - AV output
> - 2x USB 2.0 inc. OTG port
> - 1x USB 3.0 port
> - IR receiver
> - 1x micro SD card slot (internal)
> - 1x Reset/Update button (in AV jack)
> - 7-segment VFD
>
> The device-tree with -100 suffix supports models with 10/100 Ethernet
> and with -1000 suffix supports models with Gigabit Ethernet.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
X96-Air with Gbit/s PHY
