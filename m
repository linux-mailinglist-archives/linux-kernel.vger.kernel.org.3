Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672C471491
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhLKPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:54:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:52559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhLKPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639238076;
        bh=w09I6mhNq385P5WZh71t6ffdsvjEMKUE3DIIffgnR+s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gYHOW8BtWFiosnsszDI2K3wSZkXjCE6u9/ZYDooV3Xynis5aAJChp5W1zH4d3ArMn
         nlalBOIoc6aaqhbvtX2nVzc6aziQbU8NVHwX6dUQtz/i/L/gHCqAEVJbP1gfK/T7LJ
         Xhf9HH/Yf/dy/jyVlkkCgXjxf2PwvJbcqfqrLkFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeMt-1n1Hdn0Wax-00VhnE; Sat, 11 Dec 2021 16:54:36 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (dell-smm) Improve ioctl handler
Date:   Sat, 11 Dec 2021 16:54:20 +0100
Message-Id: <20211211155422.16830-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tdml37ZHnMLlwMeDIbyjmY8yLecZERa8awpBWbopEzXmAaRwP0I
 ceBXPE64TxsDh9xXGtlH2ppXtEPlInm1ibJ2Db4sDTvX/GuhgD8GiRT1H6UlA1fuWsljnNh
 iB2Rho/X+oh/siGD3MhsJ3XZPmsihTuTzWKoggXzw1/rFT435wEP38tEfM46loQC1RXrP0x
 Wh+3WB8Q5hUYopx6wahww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:udXNhJXsZng=:TRjjkoQwAiwpMTJI/Epdrb
 IcMiCoFfSquVKmEJIjo4dtWOH7I97xOEs9xDvCXjbP0vBAI5avpXu4hG5frcDLHGd+9rayXUg
 PxYKo2WTNfh1Bt4SHrcOdhjQjv7bxYldPMc32B5obB573dXfOeoVklYkdPei5lYtGmmEAH/el
 p7MNn970WqZhpIjPxcwuEjJ6bvLEmGJ8maWq2BfFSIlhSMvgGCTIe5lXkGwLVBMF28OFX4gvO
 fd38rIXzf0KNPkwEHXyCKWOxnGxcytt2cCqkpSQ2JO2RxRqTSf9tF2uAGekrtM3RMM5BfX9OV
 ylgRq+VANb+tQJNp7nuj8iTjh5s9ZNHul6kVA34aZ+PxBw1y/2YbyyRu9uI8tKbUxNtbwnDkz
 5A76J36ANbtNcAo3mjvyBBfcaNBhHZLwZtiv1AXzZKKen0tE/WCPTlPG75g91n54l4csHn+HE
 8yyVPooFeHhI7jWwxIyoj3ZuZAfJ6dUcrdFi9tWGXQyjetE/RaHvd7eZ7uNFBBi8emqaU+kjr
 b9VRie5eOVNVxOw1p46sN7i+VaR5jVi5IKblRSwuvx4wew5MVRxYOqjcxlsrnmJP5sLFYoaMn
 5wZ7SRzKDwr6ijloBaqUx5oc+r5H+HcDLMzMffMfUeNcfFzv0cd8HELZLLl98IuTCvuodKKxW
 zxF7+2C8QXQvH7m6peGDkyXBLPKwtT4aX7kJ3omU942Ggp4y+yeHPPUjRHYX5k8qFzKOFJNVK
 sAfWiF/Kg3tXd+RIw04eRFixRk8NHD9MIuhq18jUgh+eIm6fs9vXxIcoFeQTU8LuaxoSlnpms
 MZKtQAtUyxIStfOVdG7PcUS8uinpWiGCW01JWcxY5QMRVGXc8U/NvFuw0vjNs6HDBpMOk5CcF
 0nTgB/5oj96dU/fanFTkSENCT5qzns5hBp+sI1bPQ8RTfg7viLlEBPqSfQez9NrHDpoUSOlCH
 f8IJoQ/lFu0caU6rdhAIcYP8bRLYg24nswoDrTuubRf/V1+lt6dZPOISq5YaA+JgakNFP7bEx
 DJsgdA4mqT06oCuwgmuMbxIFEOU6jZh5bzqs3yOXiP5uh3uk55Q2Yt86chh9JF3thRKtLTy4S
 visNBobVVDG/T4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the ioctl handler in dell_smm_hwmon.
The first patch is simplifying the ioctl handler by removing
an unnecessary switch case, while the second patch is unifying
both i8k_ioctl() and i8k_ioctl_unlocked(), resulting in better
performance since i8k_mutex is only acquired when needed
(during fan status change) instead of being acquired for
every ioctl call.

Tested on a Dell Inspiron 3505.

changes in v2:
- simplify logic between mutex_lock()/_unlock()
- replace hardcoded values with sizeof statements

Armin Wolf (2):
  hwmon: (dell-smm) Simplify ioctl handler
  hwmon: (dell-smm) Unify i8k_ioctl() and i8k_ioctl_unlocked()

 drivers/hwmon/dell-smm-hwmon.c | 58 +++++++++++-----------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

=2D-
2.30.2

