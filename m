Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACFF468617
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbhLDQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:08:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:32785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236441AbhLDQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638633864;
        bh=yK+12Dpgzzi4E+EJ1QXF33Gihf1KaHQLY4w1ep0j5cw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IhaKYsa9bL+jUeevpwVpFYRQq7jaAkDjW1jUAASaQKVuf6z6Ynr5dYa+KT/Df1ucM
         4FUiHNQlxGPsGPK0rFuZhexqzQ66fupy5Q34600u2CJ8mh23CvA/y3SpvsYit0VGsW
         B1StCHRztSBC3X3CW82WikmNv6UZiSBBuFwe3wE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.135.7.113] ([87.122.242.86]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1mL23J222H-00aiYT; Sat, 04
 Dec 2021 17:04:24 +0100
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     linux-kernel@vger.kernel.org, bberg@redhat.com, hadess@hadess.net,
        markpearson@lenovo.com, nicolopiazzalunga@gmail.com,
        njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211123232704.25394-1-linux@weissschuh.net>
From:   Thomas Koch <linrunner@gmx.net>
Message-ID: <948711a6-385d-799c-b71f-037d7fa0f478@gmx.net>
Date:   Sat, 4 Dec 2021 17:04:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123232704.25394-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s5J5rG/I6xHpAB+pQGMR6uyH/CFeUZxHcqff0K7x+QnOBDLC7M5
 GmsDKP8kOtgJ5uzNJ7n0QWzt4qhZom25deCT1YrqFTH/d0TLxJEcAjubKlvrxvbWKIs3aM0
 5LYHmUIngXAQAvv4BK2M2wyKtS4eIP5+5PNUP2hLV9ZxXx/QDSh58t1rpZc38OMezuornIj
 ybjoXyPNTidn9Lo1wJDmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mcgJ47u3yi0=:+wjZPPIf1ZwsZkziJG3JzG
 iZMx/2HJZN2/0C0D1Azf/MCBaWH3AkxwQqR91zXCyxXww4d7BKK4CcEK6VThT3R5XE3qvvCwh
 gcfeOfRsZMZqKzUxF7vGCSZqiFsa26y8grMNJSG3Y5821kGT4MIG2TsO2m64HnojDtpuY3qR/
 uqA9l8X1/LHwx5v8K93Ikdj9ereytDXvY54hNI19McubPmxc+ffi8YRofSX4JvhyGR/gBaa5C
 N1Z6Ka+ehaNbefcqW7QVlg0P89L/5XQv4xStB6fEy66GrG7a8XlMBsuVYsvqj4+UsQ47dd9Uj
 SZ5e17yV8aFtHg9FvA2wWWwWuy2PBOWvX5U4f2zcCLqbPBL6xHF8KfynQzv0k2M5XTfU3ZM1o
 HpGFUs59ex7jhASc455/gCX7N9r0PU28m6xRcpvdfqAXen71AOlXzUiS0qUhdHScL1Q8bLP79
 xyj0jZuH+AvSk/VLHts3z9RcLpj9tbG10K8w+fLGOazxhpwOQjNR0rYuRvMOuQqsx1PWREmmG
 V81ZY7JahH6lnCINNsbh6ygDNXkl7P+8J/IyUSTSR/OEkmxpnEiD5ffxDaSuPPTPa5s55WEs8
 1H+rRngj/yvnfBx7FFCsjy55ZHX+VSFJtDLV/xSyK55jriE7N7xmthKyPfIxtgHXwObAn6heC
 80cAFYHxa5j8rPDTA7iy7wXeKpL/6IhMY8oKPZfeSKRghRGI+Cei9pVVA2DJ9EOBVwfnCph1J
 aIrIG9Npe16mnO6odAtiHbqaKTR1HJaE0AVklLFIzNWKVN/vkpSFP96+8JaNuNzUTR3OK7iYY
 eMyrEMcWPXeWMVkobEVUuVz0Po4QLYUasObON5Q2e0qDoHhS6IeUMGUH8TFyfafOTRX3cGjU8
 AcC7B1dZDMLHiLFeH1EqgK60DHGx6W7cDO3WDmwmheKTuCoEymY4QyBvmBEK4/hsYqKYtm0B2
 sF/nXgnGC5JohmJqwfREbv3k/UFOwiCLIby8W4g5e7ykMVLVEmuqcc65jBH0gCRnaN+bQ4FhG
 tlS7rb2LAPOUbEGU8Iw6XxtztiGYdu93geFnxehJMzjWHSsb21eOnAmR5ApPqxB7Y2gVcTFKz
 2fo6N2tvPes+tE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 24.11.21 00:27, Thomas Wei=C3=9Fschuh wrote:
> Hi,
>
> this series adds support for the charge_behaviour property to the power
> subsystem and thinkpad_acpi driver.
>
> As thinkpad_acpi has to use the 'struct power_supply' created by the gen=
eric
> ACPI driver it has to rely on custom sysfs attributes instead of proper
> power_supply properties to implement this property.
>
> Patch 1: Adds the power_supply documentation and basic public API
> Patch 2: Adds helpers to power_supply core to help drivers implement the
>    charge_behaviour attribute
> Patch 3: Adds support for force-discharge to thinkpad_acpi.
> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>
> Patch 3 and 4 are largely taken from other patches and adapted to the ne=
w API.
> (Links are in the patch trailer)
>
> Ognjen Galic:
>
> Your S-o-b is on the original inhibit_charge and force_discharge patches=
.
> I would like to add you as Co-developed-by but to do that it will also r=
equire
> your S-o-b. Could you give your sign-offs for the new patches, so you ca=
n be
> properly attributed?
>
> Sebastian Reichel:
>
> Currently the series does not actually support the property as a proper
> powersupply property handled fully by power_supply_sysfs.c because there=
 would
> be no user for this property.
>
> Previous discussions about the API:
>
> https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linu=
x@weissschuh.net/
> https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fe=
c29983d1@gmail.com/
>
> v1: https://lore.kernel.org/lkml/20211113104225.141333-1-linux@weissschu=
h.net/
> v1 -> v2:
>
> * Use sysfs_emit-APIs instead of plain sprintf
> * More cecks for actual feature availability
> * Validation of the written values
> * Read inhibit-charge via BICG instead of PSSG (peak shift state)
> * Don't mangle error numbers in charge_behaviour_store()
>
> Open points:
>
> Thomas Koch has observed that on a T450s with two batteries
> inhibit-charge on BAT0 will affect both batteries and for BAT1 it is ign=
ored
> entirely, this seems to be a bug in the EC.
> On my T460s with two batteries it works correctly.
>
> Thomas Wei=C3=9Fschuh (4):
>    power: supply: add charge_behaviour attributes
>    power: supply: add helpers for charge_behaviour sysfs
>    platform/x86: thinkpad_acpi: support force-discharge
>    platform/x86: thinkpad_acpi: support inhibit-charge
>
>   Documentation/ABI/testing/sysfs-class-power |  14 ++
>   drivers/platform/x86/thinkpad_acpi.c        | 191 +++++++++++++++++++-
>   drivers/power/supply/power_supply_sysfs.c   |  51 ++++++
>   include/linux/power_supply.h                |  16 ++
>   4 files changed, 268 insertions(+), 4 deletions(-)
>
>
> base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
>

Reviewed-by
: Thomas Koch <linrunner@gmx.net>
Tested-by: Thomas Koch <linrunner@gmx.net>

Works well on ThinkPad X220, T450s, X1C6 with the exception mentioned abov=
e.

The new API is included in TLP already [1].

[1]
https://github.com/linrunner/TLP/commit/f0bf18f847470ae495a68f9f0e30130b96=
348936


=2D-
Freundliche Gr=C3=BC=C3=9Fe / Kind regards,
Thomas Koch

Mail : linrunner@gmx.net
Web  : https://linrunner.de/tlp
