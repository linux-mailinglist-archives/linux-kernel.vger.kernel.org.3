Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5532348D7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiAMM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:26:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22208 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiAMMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:12 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122411epoutp02396b8e50488e8a647784b77c29c8490b~J1AO4wMoQ2969529695epoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122411epoutp02396b8e50488e8a647784b77c29c8490b~J1AO4wMoQ2969529695epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076651;
        bh=EeAR0+rYj37Bb1eESVetyYRLJrzbLdsy0CHLNkqHpQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceOwbCRBXWCjg3DElaefQk7O7k9MXTDQWqQhdNdanJ48LDWtyGVdfpzZDmBDgDfOG
         UrYvfeXPQiVcaDZ0ItRdtUrZsrqmPSsbhn5uu7oMI5Pg2LEAWNrT3LgoQbOgHy2ghO
         GLU8n4L6Hx7LiL0yxcQS/6tVcL23O8my+aKpg774=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220113122410epcas5p22418da837de3df13d3bf23579c8b9800~J1AN4G0MD0949509495epcas5p27;
        Thu, 13 Jan 2022 12:24:10 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZNs13Whcz4x9Pw; Thu, 13 Jan
        2022 12:24:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.C6.06423.4E910E16; Thu, 13 Jan 2022 21:24:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6~J1AIENwhj3143231432epcas5p46;
        Thu, 13 Jan 2022 12:24:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122404epsmtrp12067e84df56a8022e5df48c606c0232a~J1AIEw8p71911119111epsmtrp1V;
        Thu, 13 Jan 2022 12:24:04 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-cc-61e019e4a2d5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.A8.29871.3E910E16; Thu, 13 Jan 2022 21:24:03 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122401epsmtip254c6116eb94f14a9ffb459ee92f517d3~J1AFXm4yK1245212452epsmtip2r;
        Thu, 13 Jan 2022 12:24:01 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 12/23] dt-bindings: add vendor prefix for Tesla
Date:   Thu, 13 Jan 2022 17:41:32 +0530
Message-Id: <20220113121143.22280-13-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ/ep5INEg50eFg/mbWOzeL+sh9Fi
        /pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4df0zm8WirV/YLVr3
        HmG3OPymndXi8fU/bA78HmvmrWH0mNXQy+axaVUnm8eda3vYPDYvqfe4cqKJ1aNvyypGj39N
        c9k9Pm+SC+CMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
        dcvMAbpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJl
        aGBgZApUmJCd0b7nHHvBBraKrVcvsjYwbmftYuTkkBAwkdizYRpLFyMXh5DAbkaJtz3NTBDO
        J0aJQ033GCGcb4wSHdOXMncxcoC1HFiiAxHfyygxf3o3M4TTwiQx+8ozdpC5bALaEnenb2EC
        sUUE3CRuNHaAjWUWuMck8eNwAzNIQljAXuLMzh3sIFNZBFQlrn/NBAnzCthKTH96gA3iPnmJ
        1RsOgC3mBIrfXZUHMkZCYCGHxKf+XqgfXCQ+nV3JAmELS7w6voUdwpaSeNnfxg5xdLZEzy5j
        iHCNxNJ5x6DK7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6JjjYhiGpVieZ3V6E6pSUm
        dndDHeAhMftcLzskFCYwShz5+phlAqPsLISpCxgZVzFKphYU56anFpsWGOallsOjKTk/dxMj
        OFFqee5gvPvgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xmgIDbCKzlGhy
        PjBV55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwMRvrHuvwWBp
        4GRPLy4rY7OogGWlm7pb9h2Y5b2+iJl7n/K6c0FXNS2m+k/pKS5aEep1+Vtkn3rWyQfiSQsT
        GOQW9J0JX3xa7+Tifz7umXvO3b56MGWG1BdXu4k2U6PWV3JovZmh+bUsv3vH2gsH/+2oe+4R
        MPum+kObpXNrp6nbOho6Z2XpiEbPefObsc/Ux+/6bx3Wso7Ywg0cF45Of+Eq77Lp8f/I5Blv
        e6rS6uS3K/UK91r9XNxemRXZWrhOK2pRZNTUw3y8Z57lezTYXVjmydBy7frl0/uNGwKmbOJd
        y67+69Dtr5yr5OJnTrrh8dHglYOpZd63eSmTPy1xPnPWbsKLc672D/IOxs5Us1JiKc5INNRi
        LipOBABPs5J0HQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvO5jyQeJBh0zzSwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGcVlk5Kak1mWWqRvl8CV0b7nHHvBBraKrVcvsjYwbmftYuTgkBAwkTiwRKeL
        kYtDSGA3o8S+vjnMXYycQHFpiesbJ7BD2MISK/89Z4coamKS2HvkFRNIgk1AW+Lu9C1gtoiA
        h0Tbv3vMIEXMAm+YJP7fn8MCkhAWsJc4s3MHO8g2FgFVietfM0HCvAK2EtOfHmCDWCAvsXrD
        AWaQEk6g+N1VeSBhIQEbiXOv1rNNYORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/
        dxMjOMy1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwuRjGNHyYePKJe3Ujz8xLn7unbDAW51P4tsdG0ZVJ
        8bf8sohoqRq7AgPrh3avz+eJfUySettZy+a4TS6jbnn6vxtOC1b7W7wryj6/L//0v7zEjlX+
        vx703Xy0sCyBW9YmPFzn9mTdeQ4PdgnYHTnS2P1HLJ81vGTTzC+Sbu/8JS6zqoVGvdv0Wjfp
        Qd6xvhnzVLSPFZ2oXr6o4VdGrNi2CONrW5TZL2dv37thi89W3y8vRdcJrfK5l5Tz6yTX1BLz
        NfODlSzWRK81Y9K35LPl3XF8R941kac/OA5OXVu2Vsv+mtPN3DzG7A2C56UlnXIDGqdUqB3J
        mhQ3e67ClNyZu7oPlUUueHfYbb3LSrunSizFGYmGWsxFxYkAG30VH+ICAAA=
X-CMS-MailID: 20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for the Tesla (https://www.tesla.com)

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..af71d00f1092 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1189,6 +1189,8 @@ patternProperties:
     description: Shenzhen Techstar Electronics Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
+  "^tesla,.*":
+    description: Tesla, Inc.
   "^tfc,.*":
     description: Three Five Corp
   "^thine,.*":
-- 
2.17.1

