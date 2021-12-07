Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6134946C650
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhLGVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:12:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:60173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241633AbhLGVM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638911329;
        bh=KuuD6eeMVERCTcB38ObnXFq9aI+j62KUONB7+XNWmJ8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jdNIaXUDI61KFrl2Uu0kT7UxcRjjqO8DfRWt4ncRFTfj2rMk5/OK1R5mRekNs9mys
         ETarCqHd5oWGS51PRb1C6o+D+mOfRNnsdDlWGiVLo7CPTuoxqrgLK+brZFyMcCOpXZ
         l7Z51DWkqwYMuFhyzHY+Y34HyoUn5Cuj4a1hI2RM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1nBgah0rA2-00IAob; Tue, 07
 Dec 2021 22:08:49 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 2/8] MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM architecture
Date:   Tue,  7 Dec 2021 22:08:17 +0100
Message-Id: <20211207210823.1975632-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EtnkHO3/DgWnnNDn9NeWYv3hTDh3PjMdqIiWBau9Fa2MKUIVYWZ
 /2Fy9Yc2jXJUIRJJ8bcHEsfFzYKpeRiWr5n6J7yHi42PF4FvPETUwac8BO4qCwodPdbRUHR
 TxWTZEiLhqtALU3mEY7zTrqkrQww2my+8LWAJCfBX+v6lLhwNGbCgP9lS0eLvybCmBi4VIr
 u/2epOCUVYoRviwPqamEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y0aYPSWaj9w=:yLYx2bO7tUZnINS6uBXipG
 V9ChDAAOGIKJ+vfw1AUIE4PWsSO6KTVjHBvaL+tlX1GL3x35v/9qdRZa6qAmw+41Hoa32evCV
 JCoDkLljd7B3LfyWG6/KgscRuhHBV7Ufhx3Ij7XuqYJyDhCHp8arn/Qxib/y9P1QvzQ9yHNbG
 I4HAKOMBr+rbQRLhW3UhJJaOKjZV36uRcrscwZyXwGYCZKmARERByxRDKi1NQCdbaO+bDMdy5
 yMVf4URgR1CHDKgakMxtKOewsqquqblh0D+LeCK1SyscBCFKVwu41sK+aywP985HCumBIcCdE
 lDOQum+pAuLY0W63ashC297z9tsQ5zP4vzB48HqVkgzXOm3I21dx+LvYV7NoSEITLy7xLIryc
 RKP88CGA/EsKOhqupNVy8Vk3zlocTaMxpx32zeO+4awmhE+ja4F34scimakXlwyKnQR0TQofD
 +xVyxdVXcNZVyTYGKDK2Kq2ZutSpuqD1QcA5Kj5XNUetUatPIIu/sjsxUDrjwmsR6OUaSmNAT
 yh6D/EZk38frUmwuy8wPWqUmMOyCa8hb2ZYUrPCuUIOIn7XVEdzhhJGL8MmTklB8fryOhhqLF
 02JhHJehkr/baQLLDKjf2vEJzF0/0Zw1lfw1ap/5IyWJ7UGUbEr8IDQcaUU7nsnRlmdEhhFT+
 INC+k0XxINHGjbzZuCnJZMKVmDKdgQOAs3MNIfNETnOFSt5c6dvkuBGzyLBb5K19NZt9BXq38
 /B/TBFWze5at2ad2CY5moFhkrX+YFJ+psMc2jQ9TYLqVWaCIpjLIJ1I8saDjgwNYlZKpX3k7t
 8vyzFFTbAe1ytlhNBamj8AUc3xs1GHpUgYI9cC/GFQGrOpbE8wGi4ti081VNlE9jyLVBybnup
 iG7pYpqYIPPAXTfi9pNOzbQrFo+HVx1NPKCLMi3Lozwi/4ObbbhtHD51ny2xzIHN9VWaRwWAS
 pzxKRdSU9V2ZZIKe55x1IZuD5AMH5qvWs4sKgUtRROTU+N9ztbWxxnZQkjMk1bD8MA84ZNwzn
 4ygjsDe+N189FXivGvn8NECpK/9YJxFOY8POdetZYqQIM/Afio2ubOsGYRh7haOj5MUOAB9VB
 Ifo6WQdwupJFz0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All files in Documentation/devicetree/bindings/arm/npcm/ belong to the
Nuvoton NPCM architecture, even when their names might not spell it out
explicitly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-3-j.neuschaefer@gmx.=
net/
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d6..eff3edafd8814 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2338,6 +2338,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
=2D-
2.30.2

