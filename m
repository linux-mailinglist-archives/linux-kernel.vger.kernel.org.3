Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563D4488C14
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiAITob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:44:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:49943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbiAIToa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641757448;
        bh=6hjWSn6vmUVLyAF7IMDX2R0jY+t6+fnYhD+TCZaKHbk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DwB5Q5ofY6ZoefwRRUVhEHkkcUxxk2I3gAzPaHWzycwfnYbgXfLE8QoA4SaUzB6if
         xA3pnc6VA54vIsZDq72CmrlOlUpVJpNue6+/a2zVykBIe92AvUbzLlBJs2YMJ0tM+Q
         oZ70qZHgsSEIfX0NLKqdsLy8/Xzg1a4QvjScHQ2k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjjCL-1mdJZr1OYN-00lFw7; Sun, 09 Jan 2022 20:44:08 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/3] Documenation: Update documentation regarding dell_smm_hwmon
Date:   Sun,  9 Jan 2022 20:43:57 +0100
Message-Id: <20220109194400.58725-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YEeFL7cYrOpaJgtjOsDlsB5O/0QWSPXiLfMIhawUd0NWc4Znhbu
 QN0sZhuNJ/j9m0u3hrR90JfKSTR2rEjzME1TS+tbyJs+qSjRhkcYDSAns5ZF/BhaoyD8txc
 C4hoLK5RQKNlmCZAzK4N/TbM/phm2zM5vYupIFT5LgCRnrjDmmw5zVQSjj4qPt7PdlmQG4q
 boh7YS3m2CycM5oUO4ZNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o/Dxu9PFLE8=:SZiv42uMujpm1pBQmc0hgk
 90wXCfkvjeOhWLSFXGxzCAPZAdBUj6c2iVq3y3Wzk7ztTEGdGLQKz5kVMWqLRiC68aPWmKVoX
 yyXIqBFGKfdprKHa2ayhZoB4olkdrmvg+KQb4VEMw+OVOtxVTlAw0dy2GfYxdJxpkpyaeLRLJ
 pivuSoCYmUAhK+CoUEp0MAzuDplyAuIEBVyzWxtEXZLq2L9xhU4m4GczvrokYYk2GMl8wWTWo
 hrtdhhfiVn7oPvxuVgLEMFEuCQ7KzFWFKkMXOHevTY8oQLeGH+44p2GU6XvNfMbvBdMS8+ypG
 oPb6s7Od8zWlksvmtCsPB6kmjDFa4Tr//6rQj+6Iz+wBYB/GBfzQhshzTFwsE7lHTiYCVR5sw
 aNGlXHJcdcbLhvjeVu0MUHsOuKWWR4THs1+urmbKApbJc4LfXT7lTw31A3gfEd+j5uXV0hff6
 EbbnMfzD2SIsMZqe1KaTx7YSiG6wpwGMZ8V7HRVQmJ6WEUGy/j+zyJg2A4sUVMDtN9Qa6Ku6q
 HZ2x0Gp6acaN4T+tz7ALyLJglzrWrNnPCuQZHaRVOsYnGZtksRD4LpEvLmf8Ico/ff23HPtoy
 4bB7keSw9aUsq3ldAF8aWW0uWl+dgvSL2qyGBRBMmVVcWxvoII0kcrkW+0PQDMNPSSJ8gQ1c1
 Hgz8Cnpj+YoNB8CZjE1afR5nxhVn3u8YsH/U1rS6eOEeBg4diwzDnmTB97taFZLMALs1bMCNO
 EHrIAzavp2VK/GcfxcOmQSfmzHhc/bTSpsUisBEibxx1+0dVp2LjMtbX+70R0vI2Jf3tqrGY9
 y03bPZL1iUxxuagYThZSwR8cW117dg56nOL1ms0ME1s1anpEht+cDj53uk4Nz4hA36qgWhvl2
 EuNVvM4QhjWp9VP/H/gc4EuqsHUAeBebHSHjj2DFbDL4kbBLn2ZvnGosTpYAm9phoDNRasxP5
 HoA/r1WuTuL2q+Nqd/VmaUuqY5gJqlounw95XgRG/hxGFf6LbH+uM9Z7SmdMhheGOYIGRl34c
 IlxyRIYJ2U5J/xZZa0+6zPEnprMZRZGToWJ2iP2ehtLpJN6MLpD7HB37SlMmWgwM8BJlLDs1M
 nE0sdVxeftlnmo=
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

