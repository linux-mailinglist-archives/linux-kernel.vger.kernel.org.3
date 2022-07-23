Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C147657EBB4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiGWDiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWDix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:38:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA010FFD;
        Fri, 22 Jul 2022 20:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658547515;
        bh=ieQTvQtVnZ7mPM09J0g6Wzs4pdOsOVS51LcLDarFaec=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SoGdlj9nO9knroNvYNNFtaf9C/5AZ0hmXGOpGaya+9P4dtMqGPXQ/yUOVylAlfq++
         O4Yme6xG2cy0QeLepy8M8yvMhHClLzUlaHQn+eO61cBBZHYOp0boZSN0GYEcrjo2TF
         ruce2Vh1jIdP3qOu5Qgzu6BmY9AAFtmHTmui98k0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGhuK-1oIviD0rUQ-00DpHU; Sat, 23 Jul 2022 05:38:35 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: Add new pwmX_fan_channel attribute
Date:   Sat, 23 Jul 2022 05:38:18 +0200
Message-Id: <20220723033820.22612-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:giKxwIsn3HIZTNYLES6JzHd4dk1//7X5fnFLMwwGtMTyvSpcAx7
 Ubum6MGnCavKfKjbdhYlggxFV65lPqWKwgDQmPS6ms+vUgpFfGCcWbg9ryrKYOBy6ICAbpr
 hhPXmd0kA8cCd3sRKYhbTo1vaLVBdhhiw/sT32y0GzRxTTTzZBR88qm22qhsVrn0B63Qacw
 0tRLKolDZnRR1Et/mH3jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/y1Vg6VsGPg=:756bx/CbxIaN5R4yvO748H
 Eg7OcuzpWi8bJOnygOYcs8TlYf5DlNCu6opAWAjgGBHa36rwTpdWcbC66M198u8HjRWiNFmS6
 ZjUAcG+QnFlXi1XYUbLMY6e3LL/RI5SrtTxc8BTScLxZRLRAEpAQfeVwhTlgTFVPz/p01H8Up
 1lM9dwycmf5q8lMg3QorDHGAc6yWH2GmlqEjcM4nj440rXFADj3poWHz7pTOW0nCmYHXzjAc4
 RNAKRlJJm/vmGJ1jKx3otbM9O00PdSZ2hQorxZQf27nkFseXTb/cK3g469xZONsUM79YPiWTi
 M4QlvB0FGyFI+bEF9p9IokY+vGKmP8sRyKPXQ1UzyvTJX/pURY8D48ar1Tab51EwI9bPYbExv
 qbiEsmS93/aHsAzxZioJ5FaPIO7ZBa8qmYW0K+jsi192Sp0i4eDC7yw4QGJBFUCLdWIDnkVRO
 woCFYyU5oyvyMi+F80Bx+t2UJfjQQl+iAr5j4+w8FSKblfSm99Rd+PvSegXcGOI3bSyM2+1mW
 68Iy5bbNfaUMxvL1T6y7iaYAT7E4tQGS9/fy9WmH0Rxb7D3baPxlCv9VaJ15FVDR/aGzNRES0
 +ubNdh1FH8UwEIUO/UI81hKKhWtOM9tnZv1VdYK5sLBQocsk7viiRb6UNOxJ6s7vrNhaQZexF
 cyhXshQ+JQhiAdjUULnlTv9FgCNn1g0WY3tyZ3OW7VPPem4DQ4mhFa65GSyIBCSZHB1L2uh7j
 R3BF5SzmFtpLim2cev2PzT98yiLi/kKfOPz4Y2KuondKwG/G3+uKJDhJb4ABRDqpF7D0sPkKV
 DGTkIYTV//l4f50FG6OGgNN04fzUzjrTTFKVy0p9DCg1o18jHAK5pDyH1AZtyeK5YcU4fkZJv
 2LnPoZOns6Mx/IKx4cmMqrgbDC1kvKOnnZJRG2RGVwQcJd5QAfQYFKGMw20VEP9CvFPg/R763
 5dEnRt5X2mJAYJ3QgIJWlt4aay1mXcw+IlRoSIGPQMQciQd75Ih89JMDQMN1/11W1rKnQsyne
 bwzUU9YwBxISukN7UBLiLvqydcrUVlwGRq86IGqHxC4x5uUZqajh2jq/utDQ7Pb2c7EyH6J51
 2txcqUor03GUiUYtYte2X1wXOznYRyI92pvtIKQOwOZ8UCPgW9ojHKkRw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace software which needs to know which PWM channel is
associated with which fan channel (like fancontrol/pwmconfig)
currently has to probe each PWM channel and watch for fan speed
changes.

This process has multiple issues:
1. Hardware might overhead during probing of PWM channels.
2. Not all fans react the same to PWM changes, making
detection unreliable.

However some hwmon chips, especially firmware-based ones, already
know which PWM channels are associated to which fan channel,
making probing of them unnecessary.

Add a new sysfs attribute to allow such chips to export
this knowlege to userspace in a standardized manner.

The first patch adds support for the new attribute to the hwmon core,
while the second patch adds support for this new attribute to the
dell-smm-hwmon driver.

All changes have been tested on a Dell Inspiron 3505.

Armin Wolf (2):
  hwmon: Add pwmX_fan_channel attribute
  hwmon: (dell-smm) Add support for pwmX_fan_channel attribute

 Documentation/ABI/testing/sysfs-class-hwmon |  8 ++++++++
 Documentation/hwmon/dell-smm-hwmon.rst      |  1 +
 Documentation/hwmon/sysfs-interface.rst     |  3 +++
 drivers/hwmon/dell-smm-hwmon.c              | 15 ++++++++++++---
 drivers/hwmon/hwmon.c                       |  1 +
 include/linux/hwmon.h                       |  2 ++
 6 files changed, 27 insertions(+), 3 deletions(-)

=2D-
2.30.2

