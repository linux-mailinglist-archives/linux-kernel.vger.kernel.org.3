Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E4546A3C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbhLFSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhLFSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:09:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEAFC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:06:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so24137898wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9Eu38/3+9tGaMWfLccEWOU7ckpzNuZ1dJmEA2K5P3hE=;
        b=ksxUHhx7E++eESp3gUhlMdMaGTidNIZ352BtBhdadLYt7T5/NJK57OHZyxUZjAyGaP
         mCIstqO91Jc0+TZf7n2sSnOR1/qLlpXGg7MQcCOdJgU8mWeieClu/MgYD8XB33Jjx86M
         Xmsl0gsbKeFA7bwQ9zQXt34+COopKchDvJsJXl/3LnWCTyntVAUZkrT/N2mV6yLMER3S
         4grd6yjDMd69uTF/3Pg8v+aokAPb4MZexwleNiJkZT6LZpC6ygAtPb4lRv9D1T3ayecX
         51/inhYFnSq08l0J4cvpcyMUaRD0AlBdkGKiePhv1JNgMC8/W4yOIar/8o4pTCyhCZJ9
         WJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9Eu38/3+9tGaMWfLccEWOU7ckpzNuZ1dJmEA2K5P3hE=;
        b=jEA+Kfad6YHSEv1wGOdV6+awsn26aB1ZQCgyszIPIQBkqQx/11mfM4uIYuZbml/KID
         7jXDEVwqbKgWdmggX8ilpucNbut1y7ELFWwKjUsXTxxmZ5jRz2ZuIqpnczlkr6+bmQop
         WgVwlKhvQGBkmtS2IL1Xkt4hiiH+wSvcFXFYGD9YcPBZgewPIzJUcbeJZQegbPEx+OLM
         PNuIbijrWbfjifKpWLh5ijc1BI9N32n6w/wphAQhXOTEpuHJ2ot2SdmElWmv46Kd020E
         OSA+VKF4j3mfL9xeYX7WBm6ekkkLKsE+GqXQwlVC1gOd/uH7tiU7N+Eb+YAgMdUVMDpx
         h1Jg==
X-Gm-Message-State: AOAM531Xr2cc8DKJjDTIk6Swu59kv++hc99xxhJ21YCYB9v2NXrNTKgP
        zMQ2WkX2Of2k0IZf8xcP4jtmIA==
X-Google-Smtp-Source: ABdhPJyeP9mmGnfPC2VzFGb6kW3kaXKtwf/c9ade3X5hh72uFYdGSbs1CnzHMgnUQ5bQquvSyJDstg==
X-Received: by 2002:adf:f001:: with SMTP id j1mr44911077wro.351.1638813963287;
        Mon, 06 Dec 2021 10:06:03 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 9sm15728052wry.0.2021.12.06.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:06:02 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Benoit Masson <yahoo@perenite.com>
Subject: Re: [RFC PATCH 0/9] arm64: dts: meson: add support for aac2xx devices
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
Date:   Mon, 06 Dec 2021 19:06:02 +0100
Message-ID: <7hilw14nhx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> This series adds support for several popular Amlogic S905X3 (SM1) Android
> Set-Top Box devices. Like most Android box devices, they ship in variants
> with multiple RAM, eMMC, WiFi and BT configurations. RAM and eMMC are not
> something we need to consider to get a working boot, but we do need to get
> the correct connectivity spec.

The reason we don't need to care about RAM differences is because u-boot
takes care of that, and updates the DT nodes accordingly.

In general, I'm not a fan of leaving these decisions up to u-boot,
but...  as an option...

I'm pondering if we should do the same for the connectivity settings?  A
properly configured u-boot already knows if it's an internal/external
PHY, Mbit vs Gbit etc. so in a similar way could enable/disable the
right nodes.

We could have a single DTS for each of these board families which
has some reasonable defaults, then u-boot would enable/disable nodes
accordingly.

Kevin


