Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96C51C68B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382519AbiEERyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiEERyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:54:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052D28E33;
        Thu,  5 May 2022 10:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651773059;
        bh=r9fBrr7FwH7W9LRmDQgfqli9/FO04mumkS5KUN+Fqio=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=gk/gSaTLSzaEoiFc2mPGZ4K1Rcys0i28Eu+WHzlAwTPXZPcF4UZ0vaKG2hp9tVV55
         66ffgtdUSYkY+u17Fs8qY7qKrrQHoDl8FmX7AKi4UoNrZOL2AFWtfHYJGirGT/RDb1
         qr1qDpOBp/meL4FauWeqbtlI0O0nj602bgj15t7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.145.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1nwnV92Sy4-0132QR; Thu, 05
 May 2022 19:50:59 +0200
Date:   Thu, 05 May 2022 19:50:56 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <YnLEwEIOqnLGxFjJ@kroah.com>
References: <20220504174823.156709-1-linux@fw-web.de> <YnLEwEIOqnLGxFjJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v1] opp: add config option for debug
Reply-to: frank-w@public-files.de
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <linux@fw-web.de>
CC:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <E08A9747-2F96-42A7-A427-0E00D4075CF0@public-files.de>
X-Provags-ID: V03:K1:+1AIM9qLsiUaMHn1Nne6xcZJg75ywWG9yhRsl+x8MvbEGOmmlfp
 qZpIE8jgusQpzDhDiY4rw7YkuilHUSmy2ZOHuRr55RyLCxjcAVlNurRUd6zfAxNweovbANH
 i/GlkpQ9M/bYyE0Ni277f0DEpE9LcCv8G/jEq31y7gc4xfMvsxP5Jk0tuLBqkzbdHglQZCV
 f35GRXSnaYNmzVvNlqIkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2kcDMSfUhf8=:AbmWbmcTdR0wPNlPXIiz4g
 oeB1RaYHEq+d2O81QmMN0uGRAE6vHKJh+WhgUqfaP5HucWNFZ2NKvDfE+NRF5NciJgH2UT404
 ptybWn+0c8XHuGQ3lyoFWgxC6eP6vz17WzafeTYv1iZYtM+JeyU6w+BpbJRb84qmTaOxTkhuL
 vGdjwh1pYDRkb1Di0T4HEKKhoGK5ueG+Hx+GZgnhQc6THLbHoR4pivPuH9KwW3GE/fvZ08OZs
 utCsXFhOiDzEY5nqVXUNMQi2bB8RVpuCRitIXX+opA3Y6x4nyqW3XLn2DBAqs/Nm5WiV2PnQi
 XUGBIi1qnafm7v6aUB9OYdQ/twl9zeXk065KukswR5lchPJnk8moO6dEgSgk1GBa7Yz1G39Z2
 /HgmUpECfU9G/sJwdf92/yHoUFUctGX84fZAxkJ+Y6ZzoF/dY/3kJvJPEzQ6jqvmrjIAXslCD
 Vlfit+G+COaO+JIcKYE1kYeTJrAAJf9M/AYqLlicvA37aIKjo3P6QCu0eSJuLmpt86tXgjN8I
 kaAiifZ6IXv70zsViKX1fnQ64Gw+mIO0UeNXg2Av/nqTcYGhtxxDC0prV2dG63rpJSqDq7h5y
 CvxNXw5A+ECzYYKaaqXZg11lniHmRCaJNB6feYDz73lOyx5jPc7/TzE55X6V1gdZuB9KFIBwI
 7wqlaJEa6RytvkstCIhniRGIpE8RKpeG6Z30RC2WuePEM8RlkRUEOWh8zRepT/jueOu2Lp5CY
 8gCk0hKUBDG0UVOCd9PmHtfqFfmS1i3wiTqxOqGfigq1CXstH/MPnDfWhCKAFUjw7mo3LaJCR
 TwQC8s17vuRdEwjGHBv5tAref4irinYqZ2yVRGbAtfvbdarQ3JxpK2oU1XP0TXQoRhoA3iOYv
 sQBHlaNIOwCKKWKoFc5g+kLsT/FIYxTw46Xm4Prauk1JztZfMkVhJ6rAsqbt9SAC4zaMFPeOc
 megI8Bz2IEW0LjiaCC/JJjhQoh7gBARKNEPw2pT1l0w2UJBNa/PNsr7TxsVW8LShovDayH1fY
 v60872N04dtQguPn3OM5c/TPLVNObhfzgoLyh7AkCZyugELIM23neSrZ/bhkTtHqycJpM/0Jr
 ZQHR07KcNiI3ig=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 4=2E Mai 2022 20:24:00 MESZ schrieb Greg Kroah-Hartman <gregkh@linuxfou=
ndation=2Eorg>:
>On Wed, May 04, 2022 at 07:48:23PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Currently OPP debug is enabled by DEBUG_DRIVER option=2E This is
>generic
>> driver debug and opp floods serial console=2E This is annoying if opp
>is
>> not needed so give it an additional config-key=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/base/Kconfig | 1 +
>>  drivers/opp/Kconfig  | 7 +++++++
>>  drivers/opp/Makefile | 2 +-
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index 6f04b831a5c0=2E=2E8ae826c95d5f 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -130,6 +130,7 @@ config DEV_COREDUMP
>>  config DEBUG_DRIVER
>>  	bool "Driver Core verbose debug messages"
>>  	depends on DEBUG_KERNEL
>> +	imply DEBUG_OPP
>
>This should not be needed, otherwise we would have to do that for all
>random driver subsystem in the kernel=2E

Have added this to have same behaviour if anyone sets DEBUG_DRIVER via def=
config=2E Else this is disabled by default=2E

>>  	help
>>  	  Say Y here if you want the Driver core to produce a bunch of
>>  	  debug messages to the system log=2E Select this if you are having a
>> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
>> index e8ce47b32735=2E=2E6a2d2c6c1143 100644
>> --- a/drivers/opp/Kconfig
>> +++ b/drivers/opp/Kconfig
>> @@ -12,3 +12,10 @@ config PM_OPP
>>  	  representing individual voltage domains and provides SOC
>>  	  implementations a ready to use framework to manage OPPs=2E
>>  	  For more information, read <file:Documentation/power/opp=2Erst>
>> +
>> +menu "Operating Performance Points (OPP)"
>> +config DEBUG_OPP
>> +	bool "Debug Operating Performance Points"
>> +	help
>> +	  enable opp debugging
>> +endmenu
>> diff --git a/drivers/opp/Makefile b/drivers/opp/Makefile
>> index f65ed5985bb4=2E=2E2589915eef95 100644
>> --- a/drivers/opp/Makefile
>> +++ b/drivers/opp/Makefile
>> @@ -1,5 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2=2E0-only
>> -ccflags-$(CONFIG_DEBUG_DRIVER)	:=3D -DDEBUG
>> +ccflags-$(CONFIG_DEBUG_OPP)	:=3D -DDEBUG
>
>This feels wrong, you shouldn't need a -DDEBUG for anything if all is
>going correctly=2E  Why is opp so odd this way?  Just use the normal
>dev_dbg() macros and all will be fine, nothing special should be needed
>at all=2E

I have looked more into it,just wanted to get driver debug (probing/bindin=
g) and dev_dbg messages without the opp spam (floods serial console)=2E

>And don't use a config option for it either, no one will turn it on, it
>needs to "just work" for all systems=2E

Config option is to enable if needed and not via driver-debug=2E

>thanks,
>
>greg k-h


regards Frank
