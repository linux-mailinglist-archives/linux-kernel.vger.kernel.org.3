Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D104A3F57
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiAaJiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:38:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:46135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236445AbiAaJiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621884;
        bh=zlF90V7JL1EiSwH6LuxSsLZKGpgmQrZqPIjkbXxCpOk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=N+2b3vSTU5oJeV0YtbZj2M1vHad1SAtgJCtbklvOKJlKsxaegUN8dbe5/b1XJsYE3
         5zUewppbFsOAUIrlFz6vsK2pwtH5v1sut1U5jJt6+qxkTWa7DhGdfJbyyDTxqf1KCm
         X+ojV0feQmb7TDZ4GEKUjAIcRVFKzRWKBm7mjZUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MKbg4-1my1e33aea-00KxPK; Mon, 31 Jan 2022 10:38:03 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/4] hwmon: (sch56xx) Automatically load on supported hardware
Date:   Mon, 31 Jan 2022 10:37:52 +0100
Message-Id: <20220131093756.8075-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xvfLeptTkrlIgxjmIE3D2PUZfmE5u7xLULRpVJ5y8Epl4gVo+Fj
 0WesrnH/O1zxw58qiW/O7NF09DCg/DBH/bLG9qhAyWXs4Lqzi1vtTn233tiK9WbUicDp0o5
 ftqHt9um2ApAjxSdM0Y+SYXabV9WGOxnoivosnFL7QS6KuE2bnhB3OhLssg2ZUBMVib9hKj
 +hCcxifuqqAFThbbh4B1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AvKpvIB8R2s=:232Zl8j46VBclfby+y36P2
 8ilWoTr1DAED5x2eJYtpRTj1jihSHfas4msJKhgq4CaPVbU/xYo4cotzzb+bNBOJJ77lmDZNc
 MP7yBFQO4ArDQdSdGI4lzwFwV4TR+oPd9n2hE9qWpwBPFLkpzLSA+2BrM2wxvGX9X2lZbJHU5
 seoumGVXBwfIinrJZOfjYDGjZJCfoqKj8aL9SFEEJfxtknsvqT/WQEgoD5Hz8n21pqL/VCDyl
 tf5oggJu8jQI8qmZ+mLVr6OghQa+OBLlNzwen0ymfs/yDcVVwqqIA1Pq8MnlCnUvfaouAMMFP
 kU0Y/VXib6vgm5nHVNogv9BmdhqKNy7wtBQkYu4bxGN8NpY8xqa4V45PAmNx4P74m3q3sh1gZ
 xMZXDYNMgTHLpKHN2swEj0lBM/JIBDqQxbn7fiGKRq6R/AxcV7R4fok1Q9XlByPTVT9MX6To4
 5JB7D9suTZrEV5HBLqoY0trMb1d71BBXxuY/Kv71SxI8zBhjhf9Y1cpuKVFeW2ORJtjvFDL0r
 Rxl93KyH+WUJ8P5xmkA6aXeqX+c4uASwqp9mwYJHTuZWUARDMgL0L9oPCdsvCCYwVhMh1Y+ht
 9OvTfAtJMC6Lzuf0A090lJtlX4kkHBb6MlJv1ahwIgkjqkPVP8o1RHoSVfgY6T0PIBRrjsQn5
 D0YSbYSdBDLwJKBDoyH/tVluDiSWpDY5wD8YdlVeOUNtXIgDrYPwZmNiup+Cd31V0YfPuBWWi
 r4aeQ8ukbNjwEP80qLSut3/9WXmpyuvKluffw2MwTQ3Prd25B3VrxskgNIPzrhMODEbF2deHH
 YsOTtaNogFMkNMMJ4B7YXkNevbVMscBzVX9uxz/EOJmhlYJxY+X0p/ReD8nGLJJAldAOTmDJt
 UMK/VsfUzpPihV52AXWSlZAxb+4s9GpCjMbPZAwI9k/5iXG1085xhVm4qvOXemMz5JsJ3m3iH
 L1qml1OuqfJj00hdoq1zFV7d+HzWMFG1c52EI4dC36vNSMla6z8SmcnT16Y5nFkjWpEaXcCt+
 2sO6DbX8LnGIduYKpnhKDWiyHk80FmEQICMqdvur/YcYNZ1bmU1nb3/GF9R7rRFfCfBSZwynz
 SAivflINhQekmU=
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

Armin Wolf (4):
  hwmon: (sch56xx) Autoload modules on platform device creation
  hwmon: (sch56xx-common) Add automatic module loading on supported
    devices
  hwmon: (sch56xx-common) Replace msleep() with usleep_range()
  hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING

 drivers/hwmon/sch5627.c        |  9 +++++++
 drivers/hwmon/sch5636.c        |  9 +++++++
 drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 4 deletions(-)

=2D-
2.30.2

