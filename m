Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABC516EAF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384707AbiEBLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381044AbiEBLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:18:51 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA528640A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:15:19 -0700 (PDT)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id A8E5D267CE;
        Mon,  2 May 2022 11:15:17 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id A953F20017;
        Mon,  2 May 2022 11:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 032542A2AE;
        Mon,  2 May 2022 11:15:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7omtSMs1A6sZ; Mon,  2 May 2022 11:15:13 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon,  2 May 2022 11:15:13 +0000 (UTC)
Received: from [127.0.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 22815405D8;
        Mon,  2 May 2022 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1651490112; bh=rUT7KoKRnXsktcX5dLdRErqPLZQBY5ISASFS45PYPuA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lVYp40sOuy3Tl/aX6MU6s+mzMFA9W2Tmea013ogW60hxMjcRcxsOgbiQEVZemFUtj
         iVulfzPiiJypRDVvvFEABrViGJodFpr2srOgzhCzKQ7+OWZzpCXY3t4ddxz2uSwv5p
         88PHW6rI7Osufk7244uzAH31BVbtHTdG8DnEKDoY=
Date:   Mon, 02 May 2022 19:15:01 +0800
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime@cerno.tech>, Ruslan Zalata <rz@fabmicro.ru>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_hwmon=3A_=28sun4i-lradc=29_Add_dri?= =?US-ASCII?Q?ver_for_LRADC_found_on_Allwinner_A13/A20_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220502110010.q7vvdkdpaiz5acjl@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru> <20220502110010.q7vvdkdpaiz5acjl@houat>
Message-ID: <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2022=E5=B9=B45=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=887:=
00:10, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>Hi,
>
>On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
>> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
>> low rate (6 bit) ADC that is often used for extra keys=2E There's a dri=
ver
>> for that already implementing standard input device, but it has these
>> limitations: 1) it cannot be used for general ADC data equisition, and
>> 2) it uses only one LRADC channel of two available=2E
>>=20
>> This driver provides basic hwmon interface to both channels of LRADC on
>> such Allwinner SoCs=2E
>>=20
>> Signed-off-by: Ruslan Zalata <rz@fabmicro=2Eru>
>> ---
>>  MAINTAINERS                       |   6 +
>>  drivers/hwmon/Kconfig             |  13 ++
>>  drivers/hwmon/Makefile            |   1 +
>>  drivers/hwmon/sun4i-lradc-hwmon=2Ec | 280 ++++++++++++++++++++++++++++=
++
>>  4 files changed, 300 insertions(+)
>>  create mode 100644 drivers/hwmon/sun4i-lradc-hwmon=2Ec
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5e8c2f61176=2E=2Ed9c71e94133 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18861,6 +18861,12 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-k=
eys=2Eyaml
>>  F:	drivers/input/keyboard/sun4i-lradc-keys=2Ec
>> =20
>> +SUN4I LOW RES ADC HWMON DRIVER
>> +M:	Ruslan Zalata <rz@fabmicro=2Eru>
>> +L:	linux-hwmon@vger=2Ekernel=2Eorg
>> +S:	Maintained
>> +F:	drivers/hwmon/sun4i-lradc-hwmon=2Ec
>> +
>>  SUNDANCE NETWORK DRIVER
>>  M:	Denis Kirjanov <kda@linux-powerpc=2Eorg>
>>  L:	netdev@vger=2Ekernel=2Eorg
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 68a8a27ab3b=2E=2E86776488a81 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>>  	  This driver can also be built as a module=2E If so, the module
>>  	  will be called sis5595=2E
>> =20
>> +config SENSORS_SUN4I_LRADC
>> +	tristate "Allwinner A13/A20 LRADC hwmon"
>> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
>> +	help
>> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs=2E
>> +	  Both channels are supported=2E
>> +
>> +	  This driver can also be built as module=2E If so, the module
>> +	  will be called sun4i-lradc-hwmon=2E
>> +
>> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
>> +	  of these must be used at a time=2E
>
>How do you plan on enforcing that?
>
>I guess a better path forward would be to either register an hwmon
>device in the original driver, or convert that driver to iio and use
>iio-hwmon=2E

I think this driver should be use IIO, and then try to probe an IIO input
if possible=2E

>
>Maxime
