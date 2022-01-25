Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD349AB29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3410075AbiAYEkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:40:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:10292 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1323468AbiAYD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:28:38 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220125032829epoutp0174cc9347ecc46d580062f5e8145468b5~NZb7quWuh2072120721epoutp01x
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:28:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220125032829epoutp0174cc9347ecc46d580062f5e8145468b5~NZb7quWuh2072120721epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643081309;
        bh=V1zBLXm/UJPgvDIjwL8ACY/O218Opqari+8Gh8BGZ7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9WYl9ean5Z+wnolJR3PoCZ5m3VJ+hGqbeF5RJWJoJtiUMEjXQhX5SLgoH/42eC5O
         qEfHeXnAxgTMrhif3CkMXNfZ0LD5vED9vnoLjRpj0loAeXuM4cbT3/OvVPwsDzrFDv
         5b3WltDmt1apwuKARWQ0zBv7PcYQ7FlraX9SviFo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220125032829epcas5p463ed13dc3fdc457f49bce93c99ce0bb8~NZb7NCZXU1924019240epcas5p4m;
        Tue, 25 Jan 2022 03:28:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JjXPL4Dhvz4x9QJ; Tue, 25 Jan
        2022 03:28:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.08.46822.1EC6FE16; Tue, 25 Jan 2022 12:22:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220125032821epcas5p128c99ca3654fce0ec046943c90211849~NZb0dhrF01313413134epcas5p1-;
        Tue, 25 Jan 2022 03:28:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220125032821epsmtrp1ff7fd6850e9ee747b393a5be6ce1a16d~NZb0ctn0_0576205762epsmtrp1R;
        Tue, 25 Jan 2022 03:28:21 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-78-61ef6ce1a54e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.68.29871.55E6FE16; Tue, 25 Jan 2022 12:28:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220125032817epsmtip19e47296f384470582f757a9c255c41b5~NZbwA7U9L0280902809epsmtip17;
        Tue, 25 Jan 2022 03:28:17 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Subject: [PATCH v3 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
Date:   Tue, 25 Jan 2022 08:46:02 +0530
Message-Id: <20220125031604.76009-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125031604.76009-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTQ/dhzvtEgyUz9S0OTHjFavFg3jY2
        i8U/njNZTH34hM1i/pFzrBYb3/5gspjyZzmTxabH11gtHr4Kt7i8aw6bxYzz+5gsGj/eZLdY
        tPULu0Xr3iPsDnwesxp62TyuL/nE7LFpVSebx51re9g8Ni+p9+jbsorR41/TXHaPz5vkAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        bHt8laXgI3vF8bMnWRoYj7F1MXJySAiYSFzofcvYxcjFISSwm1Hiyu6ZrCAJIYFPjBL7HolB
        JL4xSvz7MZsFpmPRnT/MEIm9jBJHpu1jgXBamCT2XroP1s4moC1xd/oWJhBbRMBN4kZjBxNI
        EbPATSaJ3w2vwZYLC3hKfGi8BdbAIqAqsfPSMmYQm1fARmLutx5WiHXyEqs3HACKc3BwCthK
        NE/gAJkjITCRQ+Jb0xZGiBoXiRW33kM9JCzx6vgWdghbSuJlfxs7SK+EQLZEzy5jiHCNxNJ5
        x6C+sZc4cGUOC0gJs4CmxPpd+iBhZgE+id7fT5ggOnklOtqEIKpVJZrfXYXqlJaY2N0NdaSH
        xOmJ3xkhATeBUWLZa7EJjLKzEIYuYGRcxSiZWlCcm55abFpglJdaDo+m5PzcTYzgtKjltYPx
        4YMPeocYmTgYDzFKcDArifD+936fKMSbklhZlVqUH19UmpNafIjRFBhgE5mlRJPzgYk5ryTe
        0MTSwMTMzMzE0tjMUEmc93T6hkQhgfTEktTs1NSC1CKYPiYOTqkGppWM6xO1tj6NU+8wqLUX
        +XPH7vKbgIJH7gtuVU2dcnM5w291XtMvKZOvXHnuu3CFVbJvUCq/4M3o/Nwld0wn9+s3MN4x
        uSPzvXpRKPv20812+1bMsF2sJb6qXZlrW7MLl9zvm9fPSVss3Nupo84V05NyJj9szYat77Vn
        6C4oe5O9z9TLI6blqsyhTf6RZhGm3xKqN6lfcIle4eqx8tb+w8eevdvxWXCdZcyBsCl6vU9E
        XnlH3kkNf/PHiC9zScA++SXuvSnbPbOPfC3Rv8g2lXHbNVm+xn1HL1+pkfK5IWZ1LsXfVW5e
        1g3RbpZkzmLlfbE29sfndVXMfelVrlCr8jlNzvl4TKhziNcGxRX2SizFGYmGWsxFxYkAitGp
        FBQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnG5o3vtEg8aXRhYHJrxitXgwbxub
        xeIfz5kspj58wmYx/8g5VouNb38wWUz5s5zJYtPja6wWD1+FW1zeNYfNYsb5fUwWjR9vslss
        2vqF3aJ17xF2Bz6PWQ29bB7Xl3xi9ti0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH501yARxR
        XDYpqTmZZalF+nYJXBnbHl9lKfjIXnH87EmWBsZjbF2MnBwSAiYSi+78Ye5i5OIQEtjNKPFz
        9mwmiIS0xPWNE9ghbGGJlf+es0MUNTFJPL36D6yITUBb4u70LWC2iICHRNu/e2CTmAWeMklc
        udHGCJIQFvCU+NB4ixXEZhFQldh5aRkziM0rYCMx91sPK8QGeYnVGw4AxTk4OAVsJZoncICY
        QkAl7xdpTGDkW8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIziotTR3MG5f9UHv
        ECMTB+MhRgkOZiUR3v/e7xOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpa
        kFoEk2Xi4JRqYGpYlsLL1yyW1/SrW0X70catMpIHPF6H8TBL7teuWns1I6bky3WBJ7JzuFdM
        myXzZ3Jl5V0+1+D3m09ezs9NOPhT8dGJef8fHL8lYJqfOclqgeL+57L7VhwKffz60ZWia70C
        CxTCvN6v/CkXetWL59mxH9LmEYYzdkYcWO7P9fnB5/X3tv0+dNDCwS/j4I8LfqZsu43nONqb
        Vfif4VtmfbZFc/mzpfujahV/CP0WXd1tfX3d4fwg0Z2RV4xnye3SPFoeWDDru2HphBb+CZ9t
        PjImc52IOOsjPPHJrudbLt6fPSclmu2rX0CyiKjQVa5dLy9lcJhbnvv6tOZKXMydmjXxkq/v
        tfwwaZX7Np/B/+l9JZbijERDLeai4kQAq4Bl5tkCAAA=
X-CMS-MailID: 20220125032821epcas5p128c99ca3654fce0ec046943c90211849
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220125032821epcas5p128c99ca3654fce0ec046943c90211849
References: <20220125031604.76009-1-alim.akhtar@samsung.com>
        <CGME20220125032821epcas5p128c99ca3654fce0ec046943c90211849@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds spi controller dt-binding compatible information for
Tesla Full Self-Driving (FSD) SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Adithya K V <adithya.kv@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Andi Shyti <andi@etezian.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 61c77088e8ee..bf9a76d931d2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -21,6 +21,7 @@ properties:
           - samsung,s3c6410-spi
           - samsung,s5pv210-spi # for S5PV210 and S5PC110
           - samsung,exynos5433-spi
+          - tesla,fsd-spi
       - const: samsung,exynos7-spi
         deprecated: true
 
-- 
2.25.1

