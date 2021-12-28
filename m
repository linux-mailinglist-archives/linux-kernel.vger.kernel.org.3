Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92181480B32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhL1QUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:20:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:56751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbhL1QUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640708381;
        bh=6hjWSn6vmUVLyAF7IMDX2R0jY+t6+fnYhD+TCZaKHbk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZVBATds8uunbjosZgb9ysGi+GuKDSVwQ0sLzlr1jkiagn5XVIPSmDcsUSbb7M9zB8
         1pt4P1EkLwDxIE9oH9rh3TZZHY+fc0Y71m3mrepDr8YOdtfDHM7P1Ua4lIXniYUEWT
         /mdQrjXyT6vx56/1YubHGJR5XO7oj0k2ZPIaL02s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mj8qd-1mYOYS01hd-00fDSi; Tue, 28 Dec 2021 17:19:41 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Documenation: Update documentation regarding dell_smm_hwmon
Date:   Tue, 28 Dec 2021 17:19:21 +0100
Message-Id: <20211228161924.26167-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROb/ovoQloAi0TXQG2BYP3GJxmDss8dqlThJmy7f2IgfOwzFL3R
 Q42yQBbFvlrHeAxK2hR1SwZbM02wpaaNcPCXT/GS12Wt1fqqBt8dkTiX5oHJ/uMjy08pbCH
 tP+v/AZuNmGJMvX2nvjgjGNQgR3h6zENBqH4myk/3iq3A4b2uxirqJZQcLocoDjD34SlopR
 fhz7pgtyGZs5koEiI+mKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gUExtMF6L2Q=:3v9Bkjek6vsxqLfAjHJurR
 IjocaWA9Uix10H3sruS+3wRcxmpxcvH4wpjaYgMnGMhXsa2xyTKCY0bSEQHW1+GjHxEaxThwA
 kNXN/HlIcl3E4U/o/MBTeT9JLqA5KQh/8yiSvaf4ul2F0g5bPESvRy/H6WyhzNS14MWCME532
 P1XYE8Nxcg983voaxrTUdbAlZhklH/o9nnJorH8KebuAInGokjyGAJSsjr/2M1IFAp74CiPhc
 yMmPced7WpRYPsxiEXXpX9sVo7GLKZq4WIpSFZNqO5EZQ0W/9IiFIMsAoeORFoQeXNhtZq3CL
 FtRHYGsb3yeQcpW5aDZHpBH461xZEFADWsV0E5xN/oQZ1hxX396UYDgIHfyA1ih91CJAleZEO
 hnhPoA4XCJPjiCROyc9CFV+CQGHiDL9tHEhr16DkWTMTpvQrrOxTdZsmSBy3ZhA7A7to6YWrP
 h3Aox+GjtUy8hpF39grNXJHrKKyzgD6fC2OKjFh6gWmbUVKe3/0aXZctVXLHGKkaufAyxeG1z
 6OW8A1wC97GAwErvGzqZWyWmcG2QqlIVspX4BHqui7gl6pgM9cDptBQRGclA9chRltE8BAUf4
 +DVQnnhiUxXagHgZxznch4bv8wer2E/dFJOLeDM+UX4eCopSLXlQvRZUbzAOIZFbggO24WDt3
 T9DEh8aeewU9XhI44nFIqiiZobvDwlkY+oJWS7PwTZa8z/f6SPDARDbWyQF9g67QmievY4/Re
 tfpPFoBGaWa+Zb1yYFvMungZ9lxHxqf1HCTeauxLFT5TzZRbJlIKm98Q6Ic1A+cgPzaflNc2d
 6vdTwyc7FVhSTIzouo3yPIyC9t0ushRgGtCmZOrR/fKfXmbd96gMuByguMV0V9+VuurKdxwPt
 kGKKeM70sNguyAblgapJbvnM5JSyNRgdxV+mnjv80W5IClBlX5ThxIyahVv8gdSExMtJkL9+/
 FkxCBTfQMZ0dP6WMs1B/SvWKNK/DMs87iB+pfU7ryl3X9S8VqpXKTXyAbax11Z426HJEl1w5O
 FI8utvlPo59guCuH/56VzYtDEHmJsArz2cYMyFj8nmPT8cnsyPnSCQ7lFFA6IKHo8+DlWIyFK
 w44DHf3TwZ+QK4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation regarding dell_smm_hwmon in preparation for
future changes.

=2D--
Changes in v2:
- omit unneccessary patch

Armin Wolf (3):
  Documentation: admin-guide: Update i8k driver name
  Documentation: admin-guide: Add Documentation for undocumented
    dell_smm_hwmon parameters
  Documentation: ABI: Add ABI file for legacy /proc/i8k interface

 Documentation/ABI/obsolete/procfs-i8k         | 10 ++++++
 .../admin-guide/kernel-parameters.txt         | 35 +++++++++++++------
 MAINTAINERS                                   |  1 +
 3 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/procfs-i8k

=2D-
2.30.2

