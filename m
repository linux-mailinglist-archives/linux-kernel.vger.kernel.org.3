Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE749293F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbiARPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52109 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbiARPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:04 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220118150102epoutp030965d1432338419c70711bfb4e4223d4~LZXm-SNOH2377123771epoutp03J
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220118150102epoutp030965d1432338419c70711bfb4e4223d4~LZXm-SNOH2377123771epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518062;
        bh=7ptuZXSncTS5JlOdOFGOyqKkIagWb4FUEe+OvqICh8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrr8QscpBYCiov7nD8g0ieddHu4VcHqWQcBu++4hQdqQhsQysFc5yAepVKaQw4v0/
         Gzqjoz4SXZEghWiRtRGGFqh2bOvIkbhOJPYOa/zBPqcr57ST9QbtDOOOGF4NfPI9np
         7rkJHNdBDeRNbmFRIUSlADTN2NsytL5GEEmLShoU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220118150101epcas5p167cc4d844018e883e68a46db6a362446~LZXmHM-bo2191721917epcas5p1x;
        Tue, 18 Jan 2022 15:01:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JdX5h5vGXz4x9Pp; Tue, 18 Jan
        2022 15:00:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.19.06423.826D6E16; Wed, 19 Jan 2022 00:00:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118150056epcas5p4825077a17b8c37b0e7cea60c4dced3c8~LZXhAW5LC1990519905epcas5p4b;
        Tue, 18 Jan 2022 15:00:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150056epsmtrp10b09742f7adc4648ca41548f11b4171b~LZXg-ZFgc2079320793epsmtrp12;
        Tue, 18 Jan 2022 15:00:56 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-4b-61e6d62812b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.B1.29871.826D6E16; Wed, 19 Jan 2022 00:00:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150053epsmtip127cd11be7362dd0803102a3dfeda651a~LZXe0qTfc1211512115epsmtip1t;
        Tue, 18 Jan 2022 15:00:53 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 11/16] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Tue, 18 Jan 2022 20:18:46 +0530
Message-Id: <20220118144851.69537-12-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmuq7GtWeJBucv61k8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CKyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCdMXn6IqaC+ZwVU7ZdYG5g/MvexcjJISFgIrF/6TemLkYu
        DiGB3YwShzduYINwPjFK/PwPk/kG5Fy9Ddey6t9jqKq9jBKvrq2GclqYJO5/vs4GUsUmoC1x
        d/oWJhBbRMBN4kZjB9goZoG3TBLT930HKxIWiJa4/2sZ2FgWAVWJ9gNtrCA2r4CtxKbOc2wQ
        6+QlVm84wAxicwLFpzZMBdsmIbCSQ2LFjLksEEUuEg+/zGWFsIUlXh3fAnWrlMTL/jYgmwPI
        zpbo2WUMEa6RWDrvGFSrvcSBK3NYQEqYBTQl1u/SBwkzC/BJ9P5+wgTRySvR0SYEUa0q0fzu
        KlSntMTE7m6opR4Sz7ZfYIWEwwRGieapPxknMMrOQpi6gJFxFaNkakFxbnpqsWmBYV5qOTym
        kvNzNzGCk6iW5w7Guw8+6B1iZOJgPMQowcGsJMIrVf8sUYg3JbGyKrUoP76oNCe1+BCjKTDI
        JjJLiSbnA9N4Xkm8oYmlgYmZmZmJpbGZoZI47+n0DYlCAumJJanZqakFqUUwfUwcnFINTPYP
        K6IcesWOvFhScvwGs6Phyn6FRu4t6/amqAR6nmmWZ/vfrDvhWCV/ymVHdtv7XnNCJ916mjw9
        bc5ioVSfq5/3Lvhcf2BZywll1Tvb+f4c6raWmKfAsuD961yeoA0mjOyc65NZvkw6wFvbwi3k
        vy/1yZw8BTnW+P+/0vl6VG/Nrvly4/SOiY2JmRedFROuMRd+fMLbu7xc6DdLlc77PT78Qt18
        5fNeK342Lpo9Zc/ahNbdT5WFAlZWtce+K25yZbC2291a03HZTunzhIWCagGev1Wnipx+9vjB
        Sy3GZ0LzHojbPPJrk5genDn58O93vDHlBW0b9BeonMy+V7b0gYpIdx3vpNvsd8Of7lEWVGIp
        zkg01GIuKk4EAKGfwa8rBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnK7GtWeJBt/vcFs8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CK4rJJSc3JLEst0rdL4MqYPH0RU8F8zoop2y4wNzD+Ze9i
        5OSQEDCRWPXvMVsXIxeHkMBuRokPV16yQSSkJa5vnABVJCyx8t9zdoiiJiaJnX1vwYrYBLQl
        7k7fwgRiiwh4SLT9u8cMUsQs8JdJ4uvrh4wgCWGBSIn3O58wg9gsAqoS7QfaWEFsXgFbiU2d
        56C2yUus3nAArIYTKD61YSpYXEjARuLiymnMExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECI4ALc0djNtXfdA7xMjEwXiIUYKDWUmEV6r+WaIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTJ4twrxZv09a3D9sen/PLzHhqxc99LwE
        jzfHrU9wnJzux3voxgsXlvWSd0107kYLxGhctXG4N0tV+f4a6eLG/yZvjn4ovq/u+shujuCp
        CVM+fXy/bcmMCZt3dDqK3dsi+Muk9H2ofEFi16FXcpc1XU/d4KhqfhGsFu8duUrz3MFn1ka/
        eu7w799cvtw53Gr+J0+jOwUXfSV+HQ6p6Yvkq7hqEynMHsqRPlXlbOvShMQM/QvvNF/f+CIx
        9cC5QtaIAlWZ0HXtSy49ynV65Zb5+5hC5PGDqsce+S75+3eB2LR1F235NrJFLulIFL7bsDHP
        8rLB/KrNhbGC2U8y2nf478nrWfjx4k1pwy6l+ZkpSkosxRmJhlrMRcWJAO7b68HvAgAA
X-CMS-MailID: 20220118150056epcas5p4825077a17b8c37b0e7cea60c4dced3c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150056epcas5p4825077a17b8c37b0e7cea60c4dced3c8
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150056epcas5p4825077a17b8c37b0e7cea60c4dced3c8@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Tesla Full Self-Driving SoC. The
pinctrl hardware IP is similar to what found on most of the
exynos series of SoC, so this new compatible is added in
samsung pinctrl binding.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 9e70edceb21b..81747b88b718 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -25,6 +25,7 @@ Required Properties:
   - "samsung,exynos7885-pinctrl": for Exynos7885 compatible pin-controller.
   - "samsung,exynos850-pinctrl": for Exynos850 compatible pin-controller.
   - "samsung,exynosautov9-pinctrl": for ExynosAutov9 compatible pin-controller.
+  - "tesla,fsd-pinctrl": for Tesla FSD SoC compatible pin-controller.
 
 - reg: Base address of the pin controller hardware module and length of
   the address space it occupies.
-- 
2.25.1

