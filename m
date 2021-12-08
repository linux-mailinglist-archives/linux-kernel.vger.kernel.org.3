Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1746CCAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhLHEsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbhLHEsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:48:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350DFC061574;
        Tue,  7 Dec 2021 20:44:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so4172182edd.3;
        Tue, 07 Dec 2021 20:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mvjWIFDl3Z932+ulOmlLjYQdMm4oZF1plc2CmRUrZ7A=;
        b=P1Nid0yP7jCMnNY7woFaZQ4qxE9QiSWUwm95VCAS+65R4pshASNVHc+kaP8zo/h+cX
         gUdKV2A6GyMfsBayqvY3cVq9VPuxgRKbqzgxuY9bjdc4TYH+AEXGFio4b+ftSOiOBP7b
         PnK1NxtGJOp0vCVxS5f0pV8RiN5t4YIOHv1owb2FcIP1AYzg6Pfxi2ei0PpnrkjeQnF5
         bML/YwRwxoH0fQKBUjJWIZAZ4EEtHcXSlbW42QR+OIF+3m8sm2NHAz2584lZAFxYsvRg
         QGvb+571Tvi7vGC1yhpsqCJoeOQJFudR1IrWbvIN+dJrud58KaTeSq4gcKczI01qFqjM
         1SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mvjWIFDl3Z932+ulOmlLjYQdMm4oZF1plc2CmRUrZ7A=;
        b=Zved9Q2NyKGeg3AKWMhTwyvPsa5CXOSVXTLCqAg1L/kUVNkGSIWQlhrktRTTodr+RG
         +YP5W2UV9k7lXOSnDwBc1oErTZHD4vMlSQycSugM+4l67MiQiU0H05vBuCklC9ernNMd
         0ZaIOsOt3mPTiM22FB4IO++KTn1K2r3eQzR40SNwQWa+kNBbcZA7xx2QLOwog1m8jXz/
         xdOi4h8b747SIYXtq1axMoAVcjzS29BmGvjvKs+4eZpqKDz0fq/BMmT0qVsQ7uYcfVWJ
         ApJsqXv5Mb+7rGfbm/AwGH8GMl4fmAP1mJ+Yb4qruVJqOPTqXFS677qiQISjBeTti9Pz
         GXPg==
X-Gm-Message-State: AOAM5318ygOsMnaAQWS1/d/mnXF2b/022Op2+2Mm1xbovWe/7ygSLntZ
        j5BXqdthnQZPknU3+KuGdDw=
X-Google-Smtp-Source: ABdhPJwAW+j1KiEM8wN0uczT86kc03ngEICuZtXPY/dQO0Mj4zmuvAFJTqmSn7HQQwjwIimRqn/DQw==
X-Received: by 2002:a17:906:1be2:: with SMTP id t2mr4700337ejg.399.1638938683782;
        Tue, 07 Dec 2021 20:44:43 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i5sm725922ejw.121.2021.12.07.20.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 20:44:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH 2/9] dt-bindings: arm: amlogic: add X96-AIR bindings
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <Ya/Qask7Fpb6mTxb@robh.at.kernel.org>
Date:   Wed, 8 Dec 2021 08:44:40 +0400
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Benoit Masson <yahoo@perenite.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1918DC0-F873-4832-AF1A-91AFEF4F7151@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-3-christianshewitt@gmail.com>
 <Ya/Qask7Fpb6mTxb@robh.at.kernel.org>
To:     Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8 Dec 2021, at 1:21 am, Rob Herring <robh@kernel.org> wrote:
>=20
> On Tue, Nov 30, 2021 at 06:05:16AM +0000, Christian Hewitt wrote:
>> Add board bindings for the Amediatech X96-AIR STB which ships with
>> model variants distiguished by Ethernet configuration: models using
>> internal 10/100 PHY have a -100 suffix, while models using external
>> Gigabit PHY have a -1000 suffix.
>=20
> Isn't the phy described in DT? Why do you need to describe this 1=20
> difference at the top level?

Users who purchase Android STBs as a cheap Linux media device (or are
reimiaging an existing device when they give up on Android) generally
have no idea what a PHY is, so reading a device-tree file to pick the
correct one is beyond them. Most people blindly try all dtb files for
a class of device until they find one that works, so top-level naming
is simply to hint the process and reduce guesswork. It=E2=80=99s not =
perfect,
but it does appear to reduce the quantity of =E2=80=9CEthernet doesn=E2=80=
=99t work!=E2=80=9D
posts seen in support forums.

Christian

>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml =
b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> index 36081734f720..e9ab0ffe8be7 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> @@ -170,6 +170,8 @@ properties:
>>       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 =
SoC
>>         items:
>>           - enum:
>> +              - amediatech,x96-air-100
>> +              - amediatech,x96-air-1000
>>               - bananapi,bpi-m5
>>               - hardkernel,odroid-c4
>>               - hardkernel,odroid-hc4
>> --=20
>> 2.17.1
>>=20
>>=20

