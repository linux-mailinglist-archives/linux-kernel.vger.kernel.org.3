Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807BC48D7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiAMMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22326 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiAMMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:29 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122428epoutp02c7a86e77263cea71a485ceba3d4860eb~J1Aem1HFU2781727817epoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122428epoutp02c7a86e77263cea71a485ceba3d4860eb~J1Aem1HFU2781727817epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076668;
        bh=MoUlCUEGoVn7b5S0in76C/FAgnEs6P5GOt2vaxytNR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LiOvNt1ak+K1hW4/tPXCKTDiDcojyO1SWevjND79FGTKWVdOcTPdKiwrcC5KtlK/q
         w2pZ45G7ycgaTrtR/IpVfehFcqTzpYbkiZnmynP9QpDPgmhl8uQkoLAlFgTgAKkLfm
         7LrtIeH0MOXN7MXCAwXecPilBLAhPOdjfqDqVnwM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122427epcas5p3c1d3d8c83c2c1b47e84618bebabe67b8~J1AdqKrKe2813028130epcas5p3G;
        Thu, 13 Jan 2022 12:24:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNsM5RBCz4x9Pt; Thu, 13 Jan
        2022 12:24:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.C6.06423.5F910E16; Thu, 13 Jan 2022 21:24:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122421epcas5p1af8422fc992801ced57e0439b48ad08e~J1AYUwUSS2652426524epcas5p1h;
        Thu, 13 Jan 2022 12:24:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122421epsmtrp2d8416854b3c94f9977137b0a9eae6fe3~J1AYT0LNo3204332043epsmtrp2h;
        Thu, 13 Jan 2022 12:24:21 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-f0-61e019f57512
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.A8.29871.5F910E16; Thu, 13 Jan 2022 21:24:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122418epsmtip237d5a08bd1757eacdb1745b38bfe60ea~J1AVpsE2L1246812468epsmtip2C;
        Thu, 13 Jan 2022 12:24:18 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 16/23] arm64: defconfig: Enable Tesla FSD SoC
Date:   Thu, 13 Jan 2022 17:41:36 +0530
Message-Id: <20220113121143.22280-17-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTU/eb5INEg1v3mSwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO2NS40Gmgp8sFc2tG1kbGBezdDFyckgImEh8vDiftYuRi0NIYDejxPknP1kg
        nE+MEtNm3oDKfGOUOD75MHMXIwdYy4mNHhDxvYwSO/c3skM4LUwSu25PYAWZyyagLXF3+hYm
        EFtEwE3iRmMHE0gRs8A9JokfhxuYQRLCArYSZ78/A7NZBFQl1l6/DdbACxJ/8QPqQHmJ1RsO
        gG3mBIrfXZUHMkdCYC6HxNlD71ghalwklix8yAZhC0u8Or6FHcKWkvj8bi8bxNXZEj27jCHC
        NRJL5x2DGm8vceDKHBaQEmYBTYn1u/RBwswCfBK9v58wQXTySnS0CUFUq0o0v7sK1SktMbG7
        G+oAD4nVPbugYTWBUeLLv93sExhlZyFMXcDIuIpRMrWgODc9tdi0wDAvtRweT8n5uZsYwclS
        y3MH490HH/QOMTJxMB5ilOBgVhLh7S+6nyjEm5JYWZValB9fVJqTWnyI0RQYYhOZpUST84Hp
        Oq8k3tDE0sDEzMzMxNLYzFBJnPd0+oZEIYH0xJLU7NTUgtQimD4mDk6pBia1C+62Vh98zos5
        ue8/vF/h97NVZzIkX7trzBaXORicPePx7BeK37q2Fz9e/lxR4ITTApZkprp5Uzp/e+tM+vXe
        8pv7m36LLT0J2bWHGiMjS5mnJR7Qb5x+0/n1zMsur+acv/3Ig9lBq9v+6v01vcc8VLvL1rtw
        TX90+oB1lFX6ir/XW3ce9+LRXrvo8kU+8Yh45mcnrJijg5UfxaR4H0iRfseteMeej2+z1uLS
        Zs5ba8t8QjbpZl/cZt7HXubtua9DfmLv7HKRibscTfjXPTrN282gw7208EX9Fs0Hradm76xW
        U/PeO+HbPc8W9XubYnTWVF/968Us+b2/V/KRi4yJc5cu69yHaTZ75jpdL1ViKc5INNRiLipO
        BAAIPbMQHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvO5XyQeJBs27hSwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGcVlk5Kak1mWWqRvl8CVManxIFPBT5aK5taNrA2Mi1m6GDk4JARMJE5s9Ohi
        5OQQEtjNKDHtlx2ILSEgLXF94wR2CFtYYuW/50A2F1BNE5NEx5JOZpAEm4C2xN3pW5hAbBEB
        D4m2f/eYQYqYBd4wSfy/P4cFJCEsYCtx9vszsAYWAVWJtddvgzXwgsRf/GCB2CAvsXrDAWaQ
        gziB4ndX5UEcZCNx7tV6tgmMfAsYGVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgSH
        uZbmDsbtqz7oHWJk4mA8xCjBwawkwttfdD9RiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBqb1gpuKO9dmttwK07hdpBcm9bbX5qW73Z6TAaLpqbOfP5hT
        VXGyjfHK/+3Jv27ETLvz6NiKmS5ffmucuTF90UKuNZUqivWJTL57BS+uyM3S8877Ffvt43n7
        DQVPtVkvHckXvbbnTeSSff81QsXe3DKqWKn5Yz7jjQqmG9J1Rn4v5EJ2fLohYjrtGIdyq9Xd
        UvH6/l12k7wmcIo+T5uwM7Cocf6BOTlqZf8eln87ueLCFrZmI10NQfPiv/UKH57U69sFhAst
        Z3FkjUkw2+b/7Kb4t/DZiXO3x578cu5pw9Qm/8nXH4mdEj69Mr575fW1ld8F7N7bNWhFXfyQ
        6hKU+kvEvn2n3V/NsPL4wKapDceVWIozEg21mIuKEwEtTqaB4gIAAA==
X-CMS-MailID: 20220113122421epcas5p1af8422fc992801ced57e0439b48ad08e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122421epcas5p1af8422fc992801ced57e0439b48ad08e
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122421epcas5p1af8422fc992801ced57e0439b48ad08e@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the Tesla FSD SoC in arm64 defconfig.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..6e6f26eb54ab 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -54,6 +54,7 @@ CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_INTEL_SOCFPGA=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_TEGRA=y
+CONFIG_ARCH_TESLA_FSD=y
 CONFIG_ARCH_SPRD=y
 CONFIG_ARCH_THUNDER=y
 CONFIG_ARCH_THUNDER2=y
-- 
2.17.1

