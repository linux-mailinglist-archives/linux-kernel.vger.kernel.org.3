Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D294AA9C5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380290AbiBEPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:54:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:52465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380281AbiBEPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644076428;
        bh=sWxAI+2Ubwgc7CJ2yJopJxt9sR8iLG+48j/jvpxHSS0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PO/VUallywTlRkF/HWK43JwTXuJEkJoGScQk4O5wnF1Jq1LKKSQNm8/fy0Tn9HMpQ
         rHAZa5HbHd0nS7S3qZ3/KN5apmHvXH1nAt6d7haqL9CEMFCwf2Kin9BXnCEndm2m+T
         itjW7CHrAI5lsCFu8Es+VIDouNzhhqfyjycWI9Cs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.182.239]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1mJRRS2obe-00x3Mx; Sat, 05
 Feb 2022 16:53:48 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org
Subject: [PATCH v3 1/2] pinctrl: nuvoton: npcm7xx: Use %zu printk format for ARRAY_SIZE()
Date:   Sat,  5 Feb 2022 16:53:30 +0100
Message-Id: <20220205155332.1308899-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205155332.1308899-1-j.neuschaefer@gmx.net>
References: <20220205155332.1308899-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VUcwN30j3nsTWWxnnWz5VosFkrRCXnEhAAsvLjr9KK+0wQ8gDlF
 UaXiVd2a2fL3IaVNYLBeO4D6YXuWNN4IA21mBSg9ElL1w1IAB6OzGuU72WhQU3mUBLCNLdx
 GZXNd2kYyIvrN3/XPNMtY8/XB11p3WJnVL3vAwdyzZx0ix1dJJUrQwOLRvSdOMHLe7JDtFK
 73n85rUhFukwgpfu+7HbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rsTka80wFto=:5NJhGxcSEZRngtjoCo5IhQ
 FaV/F8XlmRQLxwS79v5N4qPsm71P8P/7dKxnPm7aDr9hXJfNPPqW3YAO8KHJSojW65lf3y5U3
 S+nIiaBOR4vAqM9H7iJnfaGDC7OXVddEurNPWJxMEJ1WJSLopZcww9NLngB7QJEXQnmf4oTnW
 OSwU0eKr8ONxPLTzZ1XeR1aCbyOqSza+6tr5fOND3qWrtQJQvfXYMEmzg429BGS0mV29nIN5y
 Eiuj4KDDXh8DjHeMvNtOqBWKDm1JxX6fV8D+qyHo2B3GMCOiBS8GFxLQ8MOWc3YIHY8ho3XG4
 x+4m00mXm6x49x/fuLzCgn/NS8WV+gQLzYBM7oDXG3d1AGPx8pXy4u3i59lvvmJeWFtXoGAVT
 TyvptdbdD8u1EyLx2yCTtU7NIQgGrKfYdP7ne4aYTdHLTT4noslg+YMq+SOYWs5OKyesLVM0W
 ul2XaHdaasw63sTPWdyVOlKvv8ka5EOvbti6YRkhdJjbD6xWnOQurZ7iIzqv1mRBRZGA2kWW/
 gpGwHY4nH6Gb2ST0ood3x0aLnEfmcmSX9cCRpSyr7exyePjF+hutV88bfZrnSwiyhImdDKBrt
 k8rUy3I5puc2OYb9wWn3TnA6coFsAT5bjW2V3uEknuhpS8ajqqVpETELgM5PqeklYOh5c/S4E
 xnavEM52xbpvXXDHFiamH8zTO+lvm3LXVO+U77nLvaRmwCMAWTVxHmUdJB/dorb/27uKZnmY+
 wPc9vDHp0KntNJF95dcAN1ZT6j8dk9p7jD8kmplxKLbrAezeQqL+e0hdu9lexUcrLgNj+fi5w
 X7RczAsnp0v/nMI6ybS9spIkWH3KpzXA3p8IFdwGT+PRHMoB1nCZkvTx11x7ufroRzDj7cgLU
 oGWk3h8b81yvYR89sYiDUrr/jziuY0qJC2l99TdIrWqzp9jVwvhOaHiy8PcJkSyCerAphlF/y
 wC1mJDHntPw49OC9sUQt5XUb8skd2Wy2OvLqyMzvGJ2bgfXRgNChtf0kCpjMxeMIlL3qZP53S
 U/qzMzi+D9NZrhrPd4b7oj7rc6IV7ysJj1rZr3hhLEgz5hOYaambYOeGRlchbdBzeeKINOxKf
 i+KLFiDM8hV0yg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compile-testing on 64-bit architectures, GCC complains about the
mismatch of types between the %d format specifier and value returned by
ARRAY_LENGTH(). Use %zu, which is correct everywhere.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 3b588e43ee5c7 ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driv=
er")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
=2D--

v3:
- Change from %zd to %zu because we're dealing with an unsigned value

v2:
- Add Fixes and R-b tags
=2D--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/n=
uvoton/pinctrl-npcm7xx.c
index 4d81908d6725d..e05bbc7fb09de 100644
=2D-- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1561,7 +1561,7 @@ static int npcm7xx_get_groups_count(struct pinctrl_d=
ev *pctldev)
 {
 	struct npcm7xx_pinctrl *npcm =3D pinctrl_dev_get_drvdata(pctldev);

-	dev_dbg(npcm->dev, "group size: %d\n", ARRAY_SIZE(npcm7xx_groups));
+	dev_dbg(npcm->dev, "group size: %zu\n", ARRAY_SIZE(npcm7xx_groups));
 	return ARRAY_SIZE(npcm7xx_groups);
 }

=2D-
2.34.1

