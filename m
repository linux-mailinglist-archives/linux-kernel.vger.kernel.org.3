Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7E46313D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhK3Knm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhK3Knl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:43:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:40:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso12452503wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KuuIZB6GSfIhq8d/S1rOlrCT876l8ZYGmC+dyBOaWSM=;
        b=gG8bbXR1gjo/GWKLcJD/G1WmgLEN7P8cvntZS8OXh1AIOwY2VvPPaNVcK07RUAZ7Nx
         jbTouJBphatTHAJQKICUG2INC1UoX3aunpbdPiw5JxJ27H8qHDpAh3yY1jAPfr2F7AGf
         J90MWh2DzsWlIykshXJS2Hlw8c6j42ENadg/2ztszoOkkljiyMV69EhQwtSnPMSyDKqd
         5Ez4FXccp0ydSgDRDQp8/tccgsYoOXOGOJanT5O+LklE9n4MWktQXzGAhv4p06cQNh6e
         v3Nb6CEW8jH9iXHbKr2Hds99BUPyByZL0HzVBr651E93pMT1ePXpEbnshBpH/thEr4fA
         ESvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KuuIZB6GSfIhq8d/S1rOlrCT876l8ZYGmC+dyBOaWSM=;
        b=1N5siqTz0yr95ykuUeBkmufIVn/34kyx6xpzG2XwvWPErnllWuFE8Id7q73sz+pAiE
         voMXG9GAV1msIL3/lEO5ypYzPCbveXOivXMpVVXasBFplkwypVQTgPTe51RFc2nSx4cu
         fbFDqj3ZSuaz1RC8GzyzAOJf6yeKHOn7qprZrs+5kpaeKjbd1wpPSgp4d25NLNtwPtpB
         loSzvRd5EfjGSYGhgs31qPVSmS8S6ZK5y3dINgMHvudTDtMlsHtMDWApiRuQ4VCROHr4
         gPqcMPJEo1gEHK6MsezGAIFlIyYPXpM20zDEvKN8Dky4L94dr+jKzSv+/S5m0FfeEnbM
         iSvA==
X-Gm-Message-State: AOAM5304mQzJLEHfsWaTmS/KPfsHa4N5qHZ1GAiEEliB67uFgyBpWSee
        gkJEZ/jqkI/wkk4Qgeonn17kUsPlxhjjQk5n
X-Google-Smtp-Source: ABdhPJzESvA8YknWbL6MSpRi5ucQJGO7g/kGd+X6Z3Q9PVMe+l/veR2GB86m8EV5sxWuy54Jd5hvPA==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr4009020wmq.68.1638268820980;
        Tue, 30 Nov 2021 02:40:20 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a? ([2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a])
        by smtp.gmail.com with ESMTPSA id y7sm15868082wrw.55.2021.11.30.02.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 02:40:20 -0800 (PST)
Subject: Re: [RFC PATCH 0/9] arm64: dts: meson: add support for aac2xx devices
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benoit Masson <yahoo@perenite.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <51fb0be9-9186-3d79-38fa-b8a5151ccba9@baylibre.com>
Date:   Tue, 30 Nov 2021 11:40:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130060523.19161-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/11/2021 07:05, Christian Hewitt wrote:
> This series adds support for several popular Amlogic S905X3 (SM1) Android
> Set-Top Box devices. Like most Android box devices, they ship in variants
> with multiple RAM, eMMC, WiFi and BT configurations. RAM and eMMC are not
> something we need to consider to get a working boot, but we do need to get
> the correct connectivity spec. Broadly speaking we see boxes with Higher
> and Lower spec connectivity; High spec is Gigabit Ethernet and Faster dual
> antennna WiFi, and Lower spec is Megabit Ethernet and a single antenna. In
> some low-end boxes BT is ommitted.
> 
> The main reason for the RFC tag is to solicit feedback on the choice of
> the -100 and -1000 suffixes which are used to distinguish between devices
> with 10/100 Mbit (Internal PHY) or 10/100/1000 Gbit (External PHY) NIC
> configurations; which is important to get correct else the box will have
> no connectivity. I'm not a big fan of the suffixes, but earlier versions
> where I used -int/-ext and -mbit/-gbit resulted in users having no idea
> what the difference was. I'd like to informally establish a convention for
> this naming before doing similar things with some S905X2 devices.

I have no opinion for -100/-1000, -int/-ext, -mbit/-gbit or <nothing>/-gigabit or whatever.

I'll wait for further comments from other reviewers here !

Neil

> 
> NB: At the current time the Realtek 8822CS and MT7668 WiFi/BT chips we
> have seen on 'AIR' devices are not supported in the kernel so these are
> deliberately ommitted. The H96-Max uses a conventional Broadcom module
> so has more complete support. I'm also still exploring / learning about
> alsa userspace configuration so for now the boxes have simple HDMI audio
> support; wiring up the Headphone socket will be done at a later date.
> 
> Christian Hewitt (9):
>   arm64: dts: meson: add common SM1 ac2xx dtsi
>   dt-bindings: arm: amlogic: add X96-AIR bindings
>   arm64: dts: meson: add initial device-trees for X96-AIR
>   dt-bindings: vendor-prefixes: add cyx prefix
>   dt-bindings: arm: amlogic: add A95XF3-AIR bindings
>   arm64: dts: meson: add initial device-trees for A95XF3-AIR
>   dt-bindings: vendor-prefixes: add haochuangyi prefix
>   dt-bindings: arm: amlogic: add H96-Max bindings
>   arm64: dts: meson: add initial device-tree for H96-Max
> 
>  .../devicetree/bindings/arm/amlogic.yaml      |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   5 +
>  .../dts/amlogic/meson-sm1-a95xf3-air-100.dts  | 108 +++++++
>  .../dts/amlogic/meson-sm1-a95xf3-air-1000.dts | 129 ++++++++
>  .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 300 ++++++++++++++++++
>  .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 145 +++++++++
>  .../dts/amlogic/meson-sm1-x96-air-100.dts     | 112 +++++++
>  .../dts/amlogic/meson-sm1-x96-air-1000.dts    | 133 ++++++++
>  9 files changed, 941 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-100.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-1000.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-100.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-1000.dts
> 

