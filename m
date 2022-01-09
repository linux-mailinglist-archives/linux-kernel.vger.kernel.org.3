Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC44488C99
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiAIVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:43:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:48005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbiAIVnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641764575;
        bh=3x+v7R3ju7oe0DQ35tUAN40lu4j6NIpcZ7Lfqw69hMU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fszMRJzPCn5GfKcBlCZPDm3pPcf+nZ1F/08WXm5olwSNEupSlYVSL2lgZcDTLwZlp
         13J9ctATUWpq8HUtoWhZzz8QQFtsD1DZMmTWk4Zyg5FpyRk2SizYX0nVQ54zcqAp4k
         dJozU4rcYIibPW2ssVDglE/lmTmCrB3BoJqsapYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M26vL-1n4D7X3QmP-002bT1; Sun, 09 Jan 2022 22:42:54 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        rdunlap@infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Documenation: Update documentation regarding dell_smm_hwmon
Date:   Sun,  9 Jan 2022 22:42:45 +0100
Message-Id: <20220109214248.61759-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:me0TX6y7z5mdDv9apuImQ+q5X8S3vyWFOUTYfvjfQclCreksfdp
 CDCWsDXkC5Nl5mRUNYICgFj4g+v0zuzQtgInBgqehVg/Igg3usUf0e8L720lVkxls2ru1nG
 xlACeNAgQPbuKUAgDaxd4LvOOITn5LoCPNuoFqrkEjVWso5CX+pphp4g6i2b9kBPMC0LFb3
 9RCA39/XvqP9as2w6ZM0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aSCVoSPDLaY=:pf/DlERRNX0LvX8p6AE9pM
 JhtJKS7FvqjyVADWS0nkAB0ixx90RWZQZksBzWFTo+HA3PDC4GT3KnSd8Kk5QpDj9DOGQz2K8
 gr5zar0ombl98oPoJxxng2tpWH+m0KBO8839pkk3Ugc2thK1r+OHh4J7EE8/EzcLyZmRxcPfr
 IEi9W6Z7m24P1eo1qfi8OqBtXMJ6YqQ6HWoG1LfCZeA/1w79IuXsSkyfSQuJCSBl/NLNJgii9
 f5unZiOxat4GKflXbpq+bq/k2ALOnVO76f+MNINL/XwSLVKUWyn2Q6lzTZAdzsIxjM3cJrUHi
 0jNoWTTbPM3Qoq1vQfpnwGq640opwVOSOAUwodyt0Ykcfix0fIbU/iRaXsTmN7Ghaj9+WUKGB
 7x8zT+Wg42VkSW4vWKfxxaZ5QHM5j6uuBU4zCbJfPRo3UFdjC6zF/1DttQlkIRBWgGe20kqYy
 hR1/q+dwEhiDuGlq4foevOo7RjjEzz2eIBsTg/NAyznrs6RrqlOyR1iC9PSQh0tlzJgMOFTle
 xB574QFaMqSS+hbt1yyWem+ApSkxqrJGx+USebC0FpBdC8r1iMG33luRGPZckknWo+bKutM0v
 OWztOuMrb3UpvIoqkekFcSVppaa6Tg1zFv4LPjPVRnZIsz44wHxvONvnEyvuwMeXlsz5gH/bg
 xR1OKQRpt3alWfG529oIthMu8YX6txYFVEdbM3+nz8eUL/wPe+Q6cm/OJEKazAH7/6sSzq40F
 ee5bVTjBZEFaw2cbnAwscqOGdV8Ry3VnVc8aO1XLWneObc2mFXJcdavVaaMzbMIloXmOJei9K
 LnwU1RGmojbI+PIqHs7MqVSryeEB4uUK1nT6tNvUQYcT/su4/aPVBDZMWoC5N+Aa1kJE59LF3
 IjL4ipfz90jP/gBKfzTfu8tqrx/UcwJlJAqYiM11+j9O1R+c9mHm3ab7ipmU+Ffwl/ZwXGlqe
 KALYWMStF+OgKMY4qzr+n32BFixcfozHGkNHvHPaRolfDGGu1XiiPUakBldOLi5NN/izWIl5d
 weMjlxtAfhp7Twbwxub8C/AOFhXhpv6rFxqnOQQKq06AywhpwPjsh+1eVWByhQujvSBfl4S2N
 54uhZZjYHvX20U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation regarding dell_smm_hwmon in preparation for
future changes.

=2D--
Changes in v3:
- indent everything with tabs in first patch
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

