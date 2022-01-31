Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D555D4A4F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbiAaTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:32:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:53721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244446AbiAaTcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643657510;
        bh=dnjo3ONBa7bJ07VF9fpQLM32MSSfv2ICC2F33LZRrVI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ja8b/PXDhQSRnKlX2LqsJKexd3UPinVJLOJ3f+9gD+JYWhdY+AV/vavh7J4g+7nq6
         0cSKSjw6xVv8OkxTL/W4++bcBsKSQh8ykphn8awk4EindHR9duiSosIW6ecNRP5DRT
         04Fmr4J1PtBFYIhaMhVKX6V5u/ogByk6feVX0CMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1ML9uK-1mxdmW10ss-00IGuN; Mon, 31 Jan 2022 20:31:50 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] hwmon: (sch56xx) Automatically load on supported hardware
Date:   Mon, 31 Jan 2022 20:31:33 +0100
Message-Id: <20220131193137.3684-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QuFBn8yU+wWsrvrzeMXaRN4SoQNpoObll+UEF0iYNTpd9qsTkZk
 Tb/0RLkZorJJtewFXiGXPIOIlmZDjm6qpHIBAMjIHS5QaJ9oweyWjqZG+3qTNiuM8V5PWdM
 5arXc5OkOO6PLclD4PHdczpZ97q4C+uPA0/rrMwX76O+GrspLkZrOhPUqUUnljQZIMSBDtx
 cA6g9JwH9tFtKHn7J2NiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NuA8pD5QMCI=:Rbyr2rgETeVZ9CzCwe5t11
 3OlhCERsKf5iC1FlYsc0BqcB+GnZFEtjVuWWfLcUgvCTutA4Yhh9rBbzbUPfOaWRrGs/TrqhJ
 ObVeYi4pQvt2rrItQJEoHtfVEfdvz0+tBDimlnWQ66P9WEk8sdYt8FNVXVNfqnFZvb588IKgM
 Ga/zCXJ+GFtB0292HsdbhOxh8qGcQiySoeTusYbc745ehw4t1vzwaNHMljbmDDNPkRAp1ihkj
 oNDklHW3r0OgGWnHVy2oRispjRbe/MqgLBnBkipeMgF7FW188TK66Q8BiAZnQIeOIIWa8jm1J
 XDhE4ugEe7am137Q++Lnuqrk2FM9IurcOixy+mpxZvgEEcprl8bhp35eqCMaasn0PcAdO1czI
 LOCWMP/O6FJaEYstrs8f829BkhIRHde1J5FM748BkNpiNTjAhuT1pW/F9OD0cb6vRXb4wDmgD
 AEK6WkZXGwrb8zoWNR2W2aSda8QMoQYXW17ADlataD78nPLq8niiqaU1Jwf91eaIzTuJDZHKa
 826C9uOUq7dDQxj2N4ZMCGy9wFZepO1GSyajFpEk/Gk9UMDbZVeWxptjIk3Xj1qtSTouu3FYM
 EQSOM5WLBsvM+C9qbJFLUPYXV+Y+RePvNcSb4gzCGXaBirty2mC41L3lxHm0bJV9UdfqDazt3
 mapGa5B67UIOvyR+SDHG8gEa04QEB0F6wkKm2cLLiZ4A9ZCmszExbM7k2wrYt1p9KlJjBWMBA
 lE1jeVEe4S0u6eFpGCY0/tHmAiJQSPHfRaPmiQ0kyi4TrIPptIuFwCqPL0icVazfiecdiXWDy
 nSiqKXs2ymSuCSUfHvryM7cze7AX/PMeLqRvd8sG+kvH3g5QkWDbR6Uuuvi4rjIyUfIQFLY5v
 F6obZvU1wHIvI/VKLDR+KDRtqiOFdCSf86e6vUts9TndW/hTPRW7VoVsxpcSAEMVpzVxdBj5y
 1JiVt7fUsvXP29JcqGeoZgdllO6J/S51jCLSIpfCzJ7dab0pdBzxXv+LZMtwAQkZkLrHdytRN
 PQzyN7d+tZ0R01OASAMix/S3uf5+XAwmNAA0x4e7cN2NGAwDqak2Y2UzNBdXZN53PkDbxMlBt
 h5JxgzzysYFNHA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware monitoring solutions supported by the sch5627 and
sch5636 drivers are Fujitsu-specific.
After some online searching, i found out that the solution used
with the SCH5627 is called "Antiope" by Fujitsu, just like the
"Theseus" solution inside the SCH5636.
I also found out that "Antiope" and "Theseus" are listed as
DMI onboard devices on supported Fujitsu devices, so the
sch56xx_common module can be loaded automatically an check
for the DMI devices. However some devices like the Esprimo C700
have both devices, so after verifying that at least one onboard
device is present, sch56xx_common still has to detect which chip
is present.
This is safe however if at least one device is present.

Tested on a Fujitsu Esprimo P720.

=2D--
Changes in v2:
- fix unused variable issue reported by the kernel test robot
by assinging the platform device id list in sch5627/sch5636
to platform_driver->id_table.

Armin Wolf (4):
  hwmon: (sch56xx) Autoload modules on platform device creation
  hwmon: (sch56xx-common) Add automatic module loading on supported
    devices
  hwmon: (sch56xx-common) Replace msleep() with usleep_range()
  hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING

 drivers/hwmon/sch5627.c        | 10 ++++++++
 drivers/hwmon/sch5636.c        | 10 ++++++++
 drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 4 deletions(-)

=2D-
2.30.2

