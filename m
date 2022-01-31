Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274264A5155
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380436AbiAaVT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:19:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:56743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380248AbiAaVTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643663978;
        bh=FOFujHvQnEpMpVsD8VvD4ru3ELqywq3krdj9gT8xkiA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=l6hyOXE8BtJva1j6zBFAyvaUjN4EKghbx3UEmcVxZwDf/t75loGneTzPA8PelJS+R
         ExLfzqMOOadtnfdEC0hv27urTI5RoKSWXFSDEOLbz9jQ50QaCkFHO7mpjR6eGQb++W
         WiTw0KDAXSPBCcV7PtUsN7A5GXmzvQNbK/knGx/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEUz4-1mzou33cRm-00G18a; Mon, 31 Jan 2022 22:19:37 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] hwmon: (sch56xx) Automatically load on supported hardware
Date:   Mon, 31 Jan 2022 22:19:31 +0100
Message-Id: <20220131211935.3656-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HBFB0UQ5EOKYUbThiep7rd/sOBgxxY06DNZWR9dRtk+wxRmMgxJ
 VEmlxGiH7tTBlN3PpUG7C9jSsexalJU9w6h8BRDWyzJ79WS20lw9ThvJSykwXDBaHNNyHC9
 vtty+iq/hLhCyHPeklP3ba4rbbZZ6JC+qJDFAAITrARkTVEwuqZXMbIChlJAZY487r0ZGkr
 mt7gwNP973hv0g1hZL6+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LanMCbDTJLM=:jy++/dveCPJ9YWHf39XZLw
 oiahXLPfZMhsmdGDDytgV3PxGcHYCI/GYk6vVFEIpmVI1oUasFxf0hpN0NfOXDXvF+H961R64
 a50ckn518FZVkYxEJof7QsCEJ1RgSHLQc7M1/Obedd9iVlKF7cC27HJM3cVJZ9VRZfkd/IThl
 ZurOlXSQTMsIV9xaShHHJR3cQyBBPFVhwgo7yfMo7ROlJByi5e/Sm3PaxgJMl3vKSBvDoCWr6
 VJWl2BrcLUUcEVGvHQN5N5CpbVc+MxfY9r2pDszFWbbcUY1UYkqeRURWVLcgtSqxMFEAfPKRT
 +OwPgvCzuyIBQ1Fbq8oyHV52v7+DPnd0ObjNv9tXlF49XPVZaT2P95e232ku8+cE3cFOt66wo
 G/bPPen5LEsxYWdsJ91F1XD7sqGN5mrA+0+m5f2Lh+8T/FyNpnEV8Yvq8cjfU0vDYfQ1WVe4I
 5LU9vVcI5Bxk9vENPWcQxJZ4aE89cHugBGmm56ytmfsqFxbDX+FHc5a7cr9iehP9U1QoKvS8I
 5/MuQb8SndJ16vpgw1UA+IEgZabvNTf0n5LI+zg9K1J+4mSnUbuFbwlDz8s7m2JNCB08ut5oK
 Zwzz+uKl7l90FgF9qaFeZdyIARsYzQPCd0XJCz7kpgxsBP+saJs4BT46nbp0nRV2Se2dLWC7K
 nxivfKJ5z4l9GaF7lX4KRJBAQu+Os+Y7O5fo0fYNPjbSkha7+61sHBnNl5lEAuMTvwUEuH8+T
 a1G2ojArB0m/eXhssjja3c2/egwP3Fhhks4+R7+u0xmjSR7w28qjobLlkDWm3+iW2bAU00jsr
 lKPExFaLZmaFI6EnisO565OUEHMjCL1e/IdDSJ/Sl5pOKQTY4F9mgsIg2QvqwWlLC266dy1e7
 axXs8UciFMO7UTKpm4qR7lkiZyT/3PzIsCkXgXbw5GrNKCRgue5DPSV+CnjP5YQFozHbxjrF7
 Zf/pULWguBBido/Xf/+0ngiLsUHTpXRKKj3KLV3Vg/pGLUYxft9xfVk8ZvBeMAJ4rVwujF4hr
 +6dq9wPjGlgARMzOLU+PpFeE36oqLALGQbDnRSb0TzKS7TI3yzsTqLLhYSX4x12IfxldMecYO
 WvbLA5Wn68crDk=
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
Changes in v3:
- fix usleep_range using the same value as msleep

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

