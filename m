Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3C34A3F47
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiAaJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:34:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:53447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbiAaJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621655;
        bh=OjrkrSWBU2ng8J708jeI3QCHtaitPEpoZ70TuD9iCio=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fOE94qgzUb6+14SJE9u5Uq5C3k/Mt18wT2alR9DYLRe108FlLJ0+nfYVQY2n5sOdB
         KKGiDJ1yF9p+KCzl7e4iImii+Q8f+2DgIWgxSCJ9gpkeKD6IaQ3rpS2dsF/zP1d2Ad
         +CsN6ix2O3fglw2n9THoQnYAxBXnhMh6EXXLT5c8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mj8mb-1mZN1W0AQX-00f6r6; Mon, 31 Jan 2022 10:34:15 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hwmon: (sch56xx) Automatically load on supported hardware
Date:   Mon, 31 Jan 2022 10:33:51 +0100
Message-Id: <20220131093355.4151-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7oWG449qOzBQwxJhfKhxcGEJGKpByZP4s7gi7xI1iGlNXH0n4PY
 ud67mOwyjqxCu84VZ3nNl1Madj0+sYXhP9Mv9uD4vUmHMUyG4tONki1i6yBFo/y7gzsG3Vx
 zg3FDg+X411vVrVQHVNNlccLMcaOgd1I/J+dvIQnTBoOTiPsKAHYqRWnS0FzTy1sgKN/K6J
 HGLKnC8Yy1snSS2jJS0ZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ep8DF6JX5k=:nWIyqZOwT9AFFv+MfFloO+
 LH7dnAP8uxbuGn0Hu31oBMtWuFU/u8ycMVvRyszR+5Y/4ESPPlvA4/Vq1lNavzx02oVGst12v
 JPWUj0L8Sfq6urdoiUPWbPQggQRYOh6McJA1GjIg9V/KP6U7MtzoMNprrRdXF+Cd4Ys9w8mrV
 cNHvo2VezGr5og2C2VQfq9JosrRxVTpAvlVNFwnOREKKrFmmiVvsM7G5EsOi0sADmQeBXFjj5
 fwDbjjhIKb0ruw78Rdb3aGZFxBy54RWV2lOlF2js6zcd86y9s5lv4G6Et+AtnPilNL14AC0wR
 AL7W+cxvLfPR9rE/MPMVbjUEm18nLBX5GyGPe3BvjTS9Ofw8wjm8d6TTya3KFaTRqE3/C5oNt
 FvMcs3NDSaHgP7qSUoYlPulL+BWlGJZu2pwPtCAeWnK4USfHDWOakPYjc1vkyWomJy1dLfJah
 qhxBTkOhQCzEX0+mi4fzq/UkKFyqRer2k0F3y0Pd/mIRRuceuZ/ZmWmWg6Rrbn+WfI8UGK5b2
 gETOoivf6Hxl7bO22GyHauKHWD0CIL+pI9Pg/28a1DayMmQMxTLSmaMDAk/BTyvYHC0npfOjl
 JadudlGKG245kvdIfCb3hXUizcjQ12KuCvihZb0GYYzrRI+SLHaQiBZCKbYTfFlLW0++3WTc8
 xj5g6HqXcI5k4N0oSet3mI9GgooDK9VNPH5iQN7ZP65qOGsnAAzS/U7xRkWe3NuAPKj2xFb5C
 qqr1miTM3g+oupPlScEfwhDtoelqJq/2gkPyAgRjv+/SfXaoaa/478Nhtv+7+loF7DIrLlCA6
 wHZwfzIU4jmYea+FmzfTvP4Fpmj/5rzHF5+Hlha3tlTcLfaAsMufGazo6aqwALyfReZm7vpdY
 eeGN/5M11msN4N09NFqQ8xqzCohhVrJfPiDV7GjmbMR4zaSa9ySmrjygRpBri3D9ZwV4fCQjX
 Q2c8Kw3vnHofAKgTkJLqklq5WVzDfKNU6PkT+UsGxvX9XG2mI3ZzbxKOOVN+lr9zrDkUKExbA
 2Rn7yHXCthYMVPg8DiJgMyZqn2IJst+j2ySHZtJgLem7gTSeaXKBaW3Vn1shyMG5EGY6WJqTF
 +HEmBvIz4WkWUU=
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
The last two patches are fixing some minor issues.

Tested on a Fujitsu Esprimo P720.

Armin Wolf (4):
  hwmon: (sch56xx) Autoload modules on platform device creation
  hwmon: sch56xx-common: Add automatic module loading on supported
    devices
  hwmon: sch56xx-common: Replace msleep() with usleep_range()
  hwmon: sch56xx-common: Replace WDOG_ACTIVE with WDOG_HW_RUNNING

 drivers/hwmon/sch5627.c        |  9 +++++++
 drivers/hwmon/sch5636.c        |  9 +++++++
 drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 4 deletions(-)

=2D-
2.30.2

