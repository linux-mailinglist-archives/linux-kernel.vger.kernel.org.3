Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C349C414
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiAZHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiAZHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:12:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDCC06161C;
        Tue, 25 Jan 2022 23:12:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso3557053wmf.1;
        Tue, 25 Jan 2022 23:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+HVMxrypTyMaGZCN3z001LVFWdR0I2CYQt+CsmsXOc=;
        b=mNNb1LZUqPHra8cELYyxO5HimHGitkdix9YzKqSQ5kkzq5Kb8WczBTETAheDVvjP6g
         67csd1jcv0RTsStqqgRD6AoLOVGzFJiB6xtpaVf/nGI5thaW5/5HcobbAO60E6VsZ8Yy
         rcTTXE3zgU0CNH8wCnxgk/xjOcrTi3PA/S/2M3i6BtxP0OPm8duQAVTC0z7W9ewGVcRR
         LgsUAH9LZxvfGKvofGLu/OsHPMGQDWEnT3EUP+/pLWmQrh/VAlq+EE3ZW2TC6sR4DpQE
         6lt6kPst+WJEHTMZuhJxupsSLmgdzo8KAt7vefKfG3ok4xJS6TPDbWM+19iGxTcrUNsP
         opxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i+HVMxrypTyMaGZCN3z001LVFWdR0I2CYQt+CsmsXOc=;
        b=K1J+pw8MrHzBM4ZRfSrQD6BBIw01SYCu0N5ems4nPqQFewahprC6QfTN0txnok64rc
         lLhqw5z/ggcEkN5v3FZ2aSap9DfmoN4bm8zvUf1m3oMB8+wEtIzSWVA3KJyvX8Xfxtjx
         x0ParLv7N06kDZcYDtiKjM+vbnmaYZ7pCLzHQhS2yWHjcY0CXebCSWS9DKue5QPXNLd0
         shT98mlIO+PX1EnYgu8ehrooAHB3QZ1MU/bT0Cx/TvqAt84LFd1qAp/BpDZ0G+TzPZx9
         f1IHmijDv+IQR5kFzgLnuj+MgfFUe6oBXETZ+E+ChQ3kBNV5qCn8/Np4xVFNujFUrC3a
         FAMA==
X-Gm-Message-State: AOAM532ucrgGeIsOKvAcq0B0fEBuA3i4eaRiuGfvoOVsCp1K4l4vejlv
        Wp1pjPbTSDQBSIekyGPnmPFrc2yqU6vebg==
X-Google-Smtp-Source: ABdhPJxfeZUAnN3Ct6WVyIovMDjWsCGrqeTETF2j03Acpcu+o5RVPZ9EUe1wmn1htFvuwv1pjb6l2A==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr6237694wmo.13.1643181166272;
        Tue, 25 Jan 2022 23:12:46 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id z1sm2374825wma.20.2022.01.25.23.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jan 2022 23:12:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/3] arm64: dts: meson-gx: add ATF BL32 reserved-memory
 region
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <a279c365-0615-1c7f-5596-dec9ad1c8229@lexina.in>
Date:   Wed, 26 Jan 2022 11:12:42 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <343C247D-4F10-4E88-B971-5A1F41A2C892@gmail.com>
References: <20220126044954.19069-1-christianshewitt@gmail.com>
 <20220126044954.19069-2-christianshewitt@gmail.com>
 <a279c365-0615-1c7f-5596-dec9ad1c8229@lexina.in>
To:     Vyacheslav <adeep@lexina.in>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 26 Jan 2022, at 9:35 am, Vyacheslav <adeep@lexina.in> wrote:
>=20
> Hi!
>=20
> 26.01.2022 07:49, Christian Hewitt wrote:
>> Add an additional reserved memory region for the BL32 trusted =
firmware
>> present in many devices that boot from Amlogic vendor u-boot.
>> Suggested-by: Mateusz Krzak <kszaquitto@gmail.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index 6b457b2c30a4..aa14ea017a61 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -49,6 +49,12 @@
>>  			no-map;
>>  		};
>>  +		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
>> +		secmon_reserved_bl32: secmon@5300000 {
>> +			reg =3D <0x0 0x05300000 0x0 0x2000000>;
>> +			no-map;
>> +		};
>> +
> How do I check if we need a similar patch for axg boards?

Are they booting using Amlogic (vendor) u-boot sources that
include bl32.img in the FIP signing recipe?

If booting from upstream u-boot, like JetHome boards, it=E2=80=99s
nothing to worry about.

Christian

