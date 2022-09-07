Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644E65AFC78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIGGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:35:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71E4DB5A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:35:22 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220907063518epoutp03be432c65125ac4145d3b2451d4416a90~SgIRMX6JJ2016920169epoutp03D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:35:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220907063518epoutp03be432c65125ac4145d3b2451d4416a90~SgIRMX6JJ2016920169epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532518;
        bh=6tlsYqS4FLhOPvwqcoaVoNfhPy7sDrJGnZbGq7969rk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=M2X4Y/aqyHJ46nKWdNoKNOasejhBmkfd+3SxWtB+USD/xEjx0wS5oPfM33Zy0Fi53
         6Zu4QqClgK6KhF7uE5LbB1ewfyzTmhtCpy99aCp+gHsoMGyWOAzJQdHy8HkOJ2mZgG
         Ew6n2vZPDNuPSmV2ZUm8o/YfrQjuxaHht3R8qp/I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220907063517epcas5p314b95ca7eb6d4257f3b5b8e319bacb58~SgIQgIX0y1809618096epcas5p3n;
        Wed,  7 Sep 2022 06:35:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MMsv571gJz4x9Pw; Wed,  7 Sep
        2022 06:35:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.40.54060.0AB38136; Wed,  7 Sep 2022 15:35:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063309epcas5p1793555c0747fd7a11997e97649924552~SgGZzZgk32639926399epcas5p1G;
        Wed,  7 Sep 2022 06:33:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063309epsmtrp10cd486fdf01e1662194effac553ae508~SgGZx_n800506905069epsmtrp1p;
        Wed,  7 Sep 2022 06:33:09 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-be-63183ba060e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.CC.14392.52B38136; Wed,  7 Sep 2022 15:33:09 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063306epsmtip12af350a2d66ed8d22dd308b9ae2de9e8~SgGWoAfxe2637926379epsmtip1t;
        Wed,  7 Sep 2022 06:33:06 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2 00/15] Add MFC v12 support.
Date:   Wed,  7 Sep 2022 12:17:00 +0530
Message-Id: <20220907064715.55778-1-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTbUxbVRj23Ht7W9DCtWN6JA7ZTYzCgLVQ6ukGIgLbTZiTZGYajWJXroUB
        bW0Loxi0gmwKbjCVH4NRGF/Ojg0sFCuCIKtgkM0hDGZYXRkyPjIY40syiNjSTv897/s8z3ue
        vOccHi74nfTnpSl1rEYpy6BJb6LtclBwaPVeKBc6avagSesZDnIY20hUuzaFoVu1SwTqabFw
        UetwBY6+7uvmoCrbVQ767qfbBPp22skOnrETaKrqEkAz5X+SyDwxwkHjs6+jofazJPq82cJB
        F212LqofHcRQg3kDQzWWZS4q7LRxkb2jDaBPjtuwlyDTaGwEjNVeB5jRukWc+b7czmVqO2Yw
        xmz6jGRujnSQTEvdR0zhzw8I5lSrCTD/5FdymSLbKMksmQOY/pUlbpLPm+lRqawshdUEskq5
        KiVNqYimEw8lxyVHSoSiUJEUvUAHKmWZbDQdfyApdF9ahnMNdGC2LCPL2UqSabX07hejNKos
        HRuYqtLqomlWnZKhFqvDtLJMbZZSEaZkdXtEQmF4pFP4bnpq4fh5rvoPmGNZ7uUYQLFfEfDi
        QUoMT7WcB0XAmyegfgAwv7mS4y4WAVwyVJPuYhXALlOxs+BtWa5cjnC5BVQngBvWfW5NAQZv
        NC2SLoKkQuDqvV+3sB/1MYATn+pcIpwqIKB9YJ3rGrSNCoNFxq0YBPUsnO8wcV2YT0nhYn4L
        5o73DLzQ3I27vJBa4MGelXqOm4iHjvUfgRtvg7N9rVw39oczJcc9WAFvLRV4NGpYaWj1DI2B
        3cNnCVcGnAqCTe273e0dsKz/0pYEp3zgyfW/PHI+tBofYhrWDPziGQ/h9TmLJw4Dhw1Gwr2U
        t+HAdD1RCnaU/39CNQAm8BSr1mYqWG2kOkLJHvvvnuSqTDPYetzBiVZw27EQ1gMwHugBkIfT
        fvwUq59cwE+R6XNZjSpZk5XBantApHNnp3H/7XKV83codckisVQolkgkYmmEREQ/yf9qF5AL
        KIVMx6azrJrVPPRhPC9/A5ZX803paVgVfWdz8oQ+pH8YVESMt0nGsqVjy2Ppew+eIFebDbbh
        D0u8Eiavdz/3RFkFPpiX4Ng+e3FWmnc4L/vY/I3Bud7i2Gn788XFliHR4WXq6buJMaL3R76s
        cszd3fmIj5gfn6Pfv/GBuiK0RHiIDPettXS3D6ptO9/pWshLK+1/tWi+K458MCt5zTe8NGkj
        Fj+q+m2tdCOgc2Uzdk0vqLqWgB3ZZbIblNNXsH79hDhH3HTk7972oXtXFfpgRe6dc75f3DfG
        nAug4paF81GVr1gv3FwoeflRuXdzdHjD0cnR93KCHqsreOvg42WN1xy5JwOCOTmb1SFvRCjv
        TzWYsT6a0KbKRMG4Riv7F4VcCxZlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfUzMcRzH+/7u9+S4+rnO+iZi1zKajmR8rbJs6FdsLDM7Zpz6iemuc1e4
        zCRFzuNiNiTUka5S7lxdVJfrPOVZdLU6KpLzkPS0W0U6zX/v9+f1/uz9x5vmCUd5U+mdimRO
        pZAlikk+Xl4n9g8ODINx800loajTfIFAbbnlJMp3dWHoQ34fjqxGE4XuvL3EQwWPagl0xfaC
        QBX3O3B0+8sYfX3BgaOuK7cAcl58TyLDx0YCtX/dgBru5pDoRJmJQCU2B4Wu219j6IZhBEN5
        pn4KZVbbKOSoKgco44gNi4RscW4xYM0OHWDtul4eW3nRQbH5VU6MNeiPkWxrYxXJGnUH2cwH
        Qzh76o4esH/SL1Os1mYn2T6DP1s/0Eet9dzID4/nEnfu4VTzlm7l78hsv0kpm+E+U/9DIg0c
        F2kBTUNmIXxeF6oFfFrI3AOw3plDaMGEsTuEhcPZYFx7w8I/XdR46BAGLZ2n/wGSmQsHfz4l
        3UDEZAJoLzyGuQ2PuYRDV3Yt4a7wZiRQmytyP+BMIOyu0lNuLWCWwN50IzbeMAMWldXyzoBJ
        V4GHHvhySrU8Qa4OUYYouL0StUyuTlEkSOKS5Abwb6OgOWZQoe+RWAFGAyuANE8sEsSbRXFC
        QbxMk8qpkraoUhI5tRX40bjYR/BK+2SLkEmQJXO7OE7Jqf5TjJ4wNQ2bPTi0J4tZUTO8ftS7
        6OmuFtcg9vjaioObaV/UstjRuOykZVFqVExBdnKE6PbQr4EY3+l1weZr6yzvQCwNl0sHLQ1y
        L35ktU4Jk65zA9RMe15N6ZrIJL1X9YzVD84Rpez5/ft+r3kmrVxQnK452/2l/4e39tPKN6UV
        AZ8zerYJm+/N6rcc9jK2+h1YpTvaTWXMfVgSFAleulZCcaz/iPS79Mhww+fVHjOLij7GZoWF
        a5ZO+9YWLSnePrm+sbPAmjcvqikwZ0qMZ91j6fbos88ZEcw11awiUXlbwG6XT7BxYlCUOmKa
        n8ecTTZnh8bnQ0DqxLa9n5o0lQanQNGeUtYkxtU7ZCFBPJVa9hfszN75EgMAAA==
X-CMS-MailID: 20220907063309epcas5p1793555c0747fd7a11997e97649924552
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063309epcas5p1793555c0747fd7a11997e97649924552
References: <CGME20220907063309epcas5p1793555c0747fd7a11997e97649924552@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: aakarsh jain <aakarsh.jain@samsung.com>

This patch series adds MFC v12 support. MFC v12 is used in
Tesla FSD SoC.

This adds support for following:

* Add support for VP9 encoder
* Add support for YV12 and I420 format (3-plane)
* Add support for Rate Control, UHD and DMABUF for encoder
* Add support for DPB buffers allocation based on MFC requirement
* Update documentation for control id definitions

Changes since v1:
 - Addressed review comments by Andrzej Hajda.
 - Addressed review comments by Rob Herring.
 - Addressed review comments by Krzysztof Kozlowski.
 - Addressed review comments by Hans Verkuil.
 - Addressed review comments by Nicolas Dufresne.
 - Rebased on latest krzk/for-next tree.

v4l2-complaince:
Total for s5p-mfc device /dev/video0: 45, Succeeded: 39, Failed: 6, Warnings: 0
Total for s5p-mfc device /dev/video1: 45, Succeeded: 34, Failed: 11, Warnings: 3

Smitha T Murthy (15):
  dt-bindings: media: s5p-mfc: Add new DT schema for MFC
  dt-bindings: media: s5p-mfc: Add mfcv12 variant
  media: s5p-mfc: Rename IS_MFCV10 macro
  media: s5p-mfc: Add initial support for MFCv12
  Documention: v4l: Documentation for VP9 CIDs.
  media: v4l2: Add v4l2 control IDs for VP9 encoder.
  media: s5p-mfc: Add support for VP9 encoder.
  media: s5p-mfc: Add YV12 and I420 multiplanar format support
  media: s5p-mfc: Add support for rate controls in MFCv12
  media: s5p-mfc: Add support for UHD encoding.
  media: s5p-mfc: Add support for DMABUF for encoder
  media: s5p-mfc: Set context for valid case before calling try_run
  media: s5p-mfc: Load firmware for each run in MFCv12.
  media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
  arm64: dts: fsd: Add MFC related DT enteries

 .../devicetree/bindings/media/s5p-mfc.txt     |  77 +---
 .../bindings/media/samsung,s5p-mfc.yaml       | 110 +++++
 .../media/v4l/ext-ctrls-codec.rst             | 167 +++++++
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   4 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  22 +
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  60 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  54 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |   9 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  51 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 410 +++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  16 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 433 ++++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  44 ++
 include/uapi/linux/v4l2-controls.h            |  33 ++
 20 files changed, 1349 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

-- 
2.17.1

