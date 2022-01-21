Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58112496415
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381071AbiAURki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27826 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiAURka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:30 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220121174028epoutp01449d9afc4ec5cb2012446458e500ed14~MWerB4psu0781207812epoutp010
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220121174028epoutp01449d9afc4ec5cb2012446458e500ed14~MWerB4psu0781207812epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786828;
        bh=6/sht/J3vL6KHT6G7ayiMbwhGBtFe7fMeK4nY3zeflg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQRPHaG2T08RVyhvz33mfdS+Cw3OxOLaUitKc6iZnDtQaS2rI9BauCZMV7eZpIn+M
         wQgzOYjqxtViU7wq5FpUGSE7plc4jSdTwJSzvbKkCiaij4gNwB6SdLpM12GROu9Bnr
         J2VX6Ta08lk2l9Nb29KxBhHyWx2523RwqRTPGc8M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220121174028epcas5p45abfbb91ce3ce2f5b873138f2bf297e6~MWeqUBHVB1923519235epcas5p4g;
        Fri, 21 Jan 2022 17:40:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JgRVH0Py8z4x9Pv; Fri, 21 Jan
        2022 17:40:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.20.06423.600FAE16; Sat, 22 Jan 2022 02:40:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174021epcas5p2bd857858aa9070f4b91ed937bf81e307~MWekh3nnB0950309503epcas5p23;
        Fri, 21 Jan 2022 17:40:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174021epsmtrp2cf43d635b21fd3614d72c67a4866bc47~MWekg8T451730117301epsmtrp2O;
        Fri, 21 Jan 2022 17:40:21 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-9a-61eaf0065a63
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.A7.08738.500FAE16; Sat, 22 Jan 2022 02:40:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174019epsmtip28cf6b4ca3f3d6ea9351c498aff726487~MWeiNsceh0094500945epsmtip2r;
        Fri, 21 Jan 2022 17:40:19 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 01/16] dt-bindings: add vendor prefix for Tesla
Date:   Fri, 21 Jan 2022 22:58:25 +0530
Message-Id: <20220121172840.12121-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmli7bh1eJBm2LrSwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt/l3byGLx+PofNgdBjzXz1jB6/P41idFjVkMvm8emVZ1sHneu7WHz
        2Lyk3uPKiSZWj74tqxg9/jXNZff4vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6B8lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGjmVz2AvWsldMPHuWtYFxFVsXIyeHhICJxN6X
        Wxi7GLk4hAR2M0ocn9IH5XxilJi76hYLhPOZUeLC7AesMC1Lji+HqtrFKHHv0mYop4VJ4t/E
        c0wgVWwC2hJ3p28Bs0UE3CRuNHYwgRQxC/xnktjYswxoOweHsICTxIZPYSAmi4CqxNbJ8SDl
        vAI2Eh/PL2CEWCYvsXrDAWYQm1PAVuL12XnMIGMkBHZwSKzZv5wJpFdCwEVi/RuoemGJV8e3
        sEPYUhKf3+1lgyjJlujZZQwRrpFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0QcLMAnwSvb+fQA3n
        lehoE4KoVpVofncVqlNaYmJ3NzREPCS+vZ/BCgmECYwSm3+sYZnAKDsLYeoCRsZVjJKpBcW5
        6anFpgWGeanl8GhKzs/dxAhOpFqeOxjvPvigd4iRiYPxEKMEB7OSCG9B/qtEId6UxMqq1KL8
        +KLSnNTiQ4ymwACbyCwlmpwPTOV5JfGGJpYGJmZmZiaWxmaGSuK8p9M3JAoJpCeWpGanphak
        FsH0MXFwSjUwhU71aTr07JZY9pUDt74zdD5Jnry8296qpJNX4650uVxh2s2kdmadmQxGRUuD
        l0Z7GUxIPyMzSXin76K55y3mfVmy8JCkOW9Aw+5N866u3e8T+O1uQ7ePyuv3e1ev5DnOmtIs
        OXc2X0tjQb5v33wm040NzeYhX8pS/P8v12y0KZ2/8XCkqnxq68owjd29zXdYKhfKu9707JnV
        wKwosTUk9t+anXl7fhqyFGw4sJmnPT2me4lBf1f4hI5Vt5LkrHknpIQff7dV3Gzmo69pb0pZ
        H63bvzSsLrjm7YKIE8m/l/iHiTvdN0r9Kfw+x/nik0yLydIvLwbdWbZ45u8HQRcqp3DJJYe3
        HlM8/ERLRoFfiaU4I9FQi7moOBEAf2NEKC0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvC7rh1eJBgdWGls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8aOZXPYC9ayV0w8e5a1
        gXEVWxcjJ4eEgInEkuPLGbsYuTiEBHYwSjQ13GSESEhLXN84gR3CFpZY+e85O0RRE5PEy59z
        wYrYBLQl7k7fwgRiiwh4SLT9u8cMUsQsMJFZYuPesyxdjBwcwgJOEhs+hYGYLAKqElsnx4OU
        8wrYSHw8vwBql7zE6g0HmEFsTgFbiddn54HZQkA1zbO2Mk1g5FvAyLCKUTK1oDg3PbfYsMAo
        L7Vcrzgxt7g0L10vOT93EyM4DrS0djDuWfVB7xAjEwfjIUYJDmYlEd6C/FeJQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAJJZZHT9imznhmwTIls+lt
        W2TvntW/fOZ5krXGCweLJIf8Yy4l2V/23WyxWLC056NP/qU4i283M1n8/lp9uZ5wK2JZhckq
        9i+OB5btmOqfKHyMXyfQ9rrmge/LQ9hW5STulHhnfzspMHm+avMc5jjeRNuYXwaVzce/ckVf
        ZOmsyuaVP3t37vx9/SoJ4ks69Pav/p91q1pgqkbB8Zn1b521flYfXOMRUDV/23PLjSaxm7kd
        dnofXpMS//dF64LNqj1vRaxsnDd9WcE37eJM2Rscv5R+zsxefJPblumS9Nkipnc7UxemnNn1
        wlKTJ20Sl9qHPenexbu3snH4i59YlPdRrfrT0TNRJ1jnyWq8LGBUYinOSDTUYi4qTgQAdG3C
        CvICAAA=
X-CMS-MailID: 20220121174021epcas5p2bd857858aa9070f4b91ed937bf81e307
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174021epcas5p2bd857858aa9070f4b91ed937bf81e307
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174021epcas5p2bd857858aa9070f4b91ed937bf81e307@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for the Tesla (https://www.tesla.com)

Cc: linux-fsd@tesla.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 64c604752052..09fbef521394 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1209,6 +1209,8 @@ patternProperties:
     description: Shenzhen Techstar Electronics Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
+  "^tesla,.*":
+    description: Tesla, Inc.
   "^tfc,.*":
     description: Three Five Corp
   "^thead,.*":
-- 
2.25.1

