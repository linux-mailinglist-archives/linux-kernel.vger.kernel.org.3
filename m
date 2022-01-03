Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E8483422
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiACP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiACP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:26:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CCC061761;
        Mon,  3 Jan 2022 07:26:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z9so67310341edm.10;
        Mon, 03 Jan 2022 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/mrTdODckT8qhbL/5PnfjpaZaia9nDRKBsRlTwu+wxc=;
        b=QzjIngw3OXouM0j0FuX8ke2NA6llaMWR0jHIZktbuOcuMJKD4Gv5INANZVZlNnIvTp
         Qi0C3XWe1tMpSWHgTKmzvHd2eZZeW/nN0RDblrrYYL75BV/GJ/pzKnk0ToNiGepyuU9L
         BpNq4GFScrOnr1bXrLD0zSVyltAsjhbhr5tXoZ8vy7FS94IuLqcmfia59ktyPNf3Dd6f
         YzYLyXgjGaaA9rJLxw4+SOlkXXJZ14GxfRQF1v5TDgRcVCl2RMMobinl5MiIjEjh/2A6
         gXKaaIDeyKGHXtT8lfS4U6VbVOOLasqVchzCPiCsRwi3yPAJIU6npenSDPYO9e+8Gdbt
         2cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/mrTdODckT8qhbL/5PnfjpaZaia9nDRKBsRlTwu+wxc=;
        b=UWaJNUaTZwV9CugbyFVg4jnYUGwuEwkiCBk37f+CmqwKGojjqrKILL5H8s3UVwplkB
         NFaVHFBeR1Gjg/6ugLtLiVIZAeBZ/jtM/EA7fkZlZ5qiWje5mOwFlJm7M0Qrb3nvTOZd
         8wYTv3p6h4vncdMPe98iD9L8bIIhAT95hoC7bkUvGcrSa+xnhMZVj1Qk7d365khhfMtO
         ziqTl3l7qDZ45zBT+7ZnK6rnsDJQ3HnT6FZ91OC2BqmpjpIecJc9O4XNztU53tGlrD9j
         ptHMDsNS/gxweKpTuBWKWPfRKy840BbTzWkfSnAod28Gyrs7rzta3M5qJkv7rX0mCaek
         83Cg==
X-Gm-Message-State: AOAM533xKDm8Nr8VCMviI226b4rEPX9tK4/41rgbfIX8yRhZgEonrKkb
        /7Eb2juFVx79qErLPY/28f4=
X-Google-Smtp-Source: ABdhPJxp2hwL2P99jM090XOgIRr00xSYgTseLDej0gMJrdOKgQAWqmpLBvjzW9N436LU8ihAZaA+Eg==
X-Received: by 2002:a17:906:9413:: with SMTP id q19mr36843139ejx.296.1641223613099;
        Mon, 03 Jan 2022 07:26:53 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j21sm10662894ejj.133.2022.01.03.07.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 07:26:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [RFC PATCH 6/9] arm64: dts: meson: add initial device-trees for
 A95XF3-AIR
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <6ff128a6-91cb-5b83-737e-e703cab81743@baylibre.com>
Date:   Mon, 3 Jan 2022 19:26:49 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benoit Masson <yahoo@perenite.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8463510-1955-4826-BE05-20F3B4079ED4@gmail.com>
References: <20211130060523.19161-1-christianshewitt@gmail.com>
 <20211130060523.19161-7-christianshewitt@gmail.com>
 <6ff128a6-91cb-5b83-737e-e703cab81743@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 3 Jan 2022, at 7:21 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
> Hi,
>=20
> On 30/11/2021 07:05, Christian Hewitt wrote:
>> The CYX A95XF3-AIR is based on Amlogic S905X3 reference board
>> designs and ships in multiple configurations:
>>=20
>> =E2=80=93 4GB DDR3 + 64GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
>> =E2=80=93 4GB DDR3 + 32GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
>> =E2=80=93 2GB DDR3 + 16GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
>> ...
>> - HDMI 2.1 video
>> - S/PDIF optical output
>> - AV output
>> - 1x USB 2.0 OTG port
>> - 1x USB 3.0 port
>> - IR receiver
>> - 1x micro SD card slot (internal)
>> - 1x Reset/Update button (in AV jack)
>> - 7-segment VFD
>> - Multicolour case LED 'arc'
>>=20
>> The device-tree with -100 suffix supports models with 10/100 Ethernet
>> and with -1000 suffix supports models with Gigabit Ethernet.
>=20
> I thought about this, and I think we should have:
> - meson-sm1-a95xf3-air.dts for 10/100 version
> - meson-sm1-a95xf3-air-gbit.dts for gigabit 10/100/1000 version
>=20
> With this, I'm ok to apply the serie.
>=20
> Neil

That=E2=80=99s fine with me, thanks for the review. I=E2=80=99ll rework =
the patches and
send a v2 series to the list.

Christian

