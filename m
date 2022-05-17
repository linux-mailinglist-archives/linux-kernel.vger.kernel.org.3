Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8452A244
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346926AbiEQM44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbiEQMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:55:56 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692C6317
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:55:50 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125546epoutp02304a73248e120e555121ef6a86abbe51~v5bNoQ86I0964209642epoutp027
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125546epoutp02304a73248e120e555121ef6a86abbe51~v5bNoQ86I0964209642epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792147;
        bh=OVhES/rcDLq4Fi6eEb2iXvfOpdkKuNFGmcfznNbuyxI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HPRqPbLvj3f5KcyajqImXpzHpSy1v+IATj853u5mpE4yEqd2XmdhzmOqfJ2XWv6vE
         cIoJ8Ru1065sOZZkPY6i7D+ahkfr9Ta0o0af9Y1S9KYucR7ZGwl4CHUPNrmN7GEXTg
         AbIqUZZCo938wkZT4e8/vAMoSmMKJhx57OqmzRVA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125546epcas5p3e56563600381bb7f6a62dc06caf66bfa~v5bM6LVwO3186031860epcas5p3x;
        Tue, 17 May 2022 12:55:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bhH59LCz4x9Pw; Tue, 17 May
        2022 12:55:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.DB.09762.F4B93826; Tue, 17 May 2022 21:55:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125511epcas5p4e9a4e3c327771dd1faf0a50057a2c17b~v5asQ9Goq1998519985epcas5p4Q;
        Tue, 17 May 2022 12:55:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125511epsmtrp156957d73069d62bd702d29fa07223d2d~v5asP1maN3276532765epsmtrp1c;
        Tue, 17 May 2022 12:55:11 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-a4-62839b4f7391
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.8A.11276.E2B93826; Tue, 17 May 2022 21:55:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125507epsmtip16dd1109d45e05858658073883203b133~v5apUbHHC2359423594epsmtip1R;
        Tue, 17 May 2022 12:55:07 +0000 (GMT)
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
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH 00/20] Add MFC v12 support.
Date:   Tue, 17 May 2022 18:25:28 +0530
Message-Id: <20220517125548.14746-1-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHue+1rwUte6EwLl107BEXdBRbaOFBQDZk5kVNbFimbtF1D/rW
        Ekrb9IfoEiYIMmEbIMOMUQQnCArKj0IZIM4K3Vh0bkERFqQgPzbpFsFQUQNbtpbW7b/POd9z
        7vlx7+WiQXZMwM3SGBm9hlYTWACrZ2hrpHCfuTBDVPWMIB/U9WBkw/OHCDnd4GKRg11WDtk9
        akbJ5mEbm6y3/8wmv70xyyI7F9zqyNcOFvmwvg2QzpopjLTMjbHJu/21GPl5h5VNXrE7OOSF
        8RGEbLL8hZDnrU845Mlrdg7pGOgBZFGxHXnzZepy3WVA9ToaATXeuIxSfTUODtUw4EQoS0sJ
        Rk2ODWBUV+Nx6uT3qyyqrLsFUKX2cYxyWTZTN1dcHBnv/ewkFUMrGH04o8nUKrI0ymRizzvy
        nXJpnEgsFCeQ8US4hs5hkom0vTLhriy1e3Ai/AitNrldMtpgILbvSNJrTUYmXKU1GJMJRqdQ
        6yS6aAOdYzBplNEaxpgoFolipO7AD7NVfd/cZusuhR1tXHNh+aA+uBRwuRCXwJZTglIQwA3C
        rwJYedHJ9hrLAE4V24DXeArgs9YlpBT4r2fcKmrjeIVrAFY038c8QhBehMALq4c9jOFR8OnS
        rXV/MF4A4NwpoycBxX9HodP2hO0R+PgbsLbiNsfDLHwLHDIvox7m4QnweX0r21vtVdjaYUO9
        PMmF7SU+ToNVYyWYl/nwj+FujpcF0Fle7GMlnHYVAi/r4Nn8bt8EKdA2WsvyzI/iW2F7/3av
        exM8c7NtPQTFA+EXa/O+cB7srXvBBDz/04++4yG898jqa5OCZ+vmON49HIbn5iewCrCp5v8K
        5wBoAWGMzpCjZAxSXayGyf3vnjK1ORaw/py37ekFsw8eRw8ChAsGAeSiRDBPdDQ/I4inoI99
        zOi1cr1JzRgGgdS9stOoICRT6/4PGqNcLEkQSeLi4iQJsXFiIpSH/1OQEYQraSOTzTA6Rv8i
        D+H6C/KRQNVCysoda1TP2PXOtXL+UrrRKTv92i+B9TtataMRga3yt4RFqWVXquMP3CgU+4Vk
        Hrw+8tKvfvxR9aWMO8GfHMrDPtBZku6GCnbbuqRULG/L2A+hlGJmztjME/r3RTnaZvmfCSJm
        VQ39soATf6dPDCcfr47ZOJF3QL73kWVmozL4cerapxNLMa+r8pAjQ9bFnjTXIVPnzim05lhK
        Z3Ovf7e5tt0p3NypkJUfPPNlRZI0vqU5dPLiR9Md74Z8FRlpPiHR7w8sqyzYn5hJ36tbsWpz
        TTP23KSaxKv3q/xc/D+1C01vM/R7USu7KqubjOnsWOyVDWGLq4vmiPzv5n9rT91AsAwqWrwN
        1RvofwHBBCmRVwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnK7+7OYkg7cNzBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLyrjlsFj0btrJarD1yl91i6fWLTBbLNv1hsli09Qu7ReveI+wWd/dsY7RoaTvC5CDm
        sWbeGkaPHXeXMHpcX/KJ2WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7tB79xeLRt2UVo0fX
        ketsHp83yXmc+vqZPYA3issmJTUnsyy1SN8ugStj58KzrAUrJSuW/P7M1sA4X6SLkZNDQsBE
        4nTLOvYuRi4OIYHdjBL3/l1hh0hISKz8PYkRwhaWWPnvOVRRE5PE5mUNzCAJNgEdiW/vT7OB
        JEQEWhklrq/sZAJxmAV+MUssfHUarF1YQFtizoSzYGNZBFQlDs/+BNbNK2Ap8WP+alaIFfIS
        qzccYJ7AyLOAkWEVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwvGhp7mDcvuqD3iFG
        Jg7GQ4wSHMxKIrwGFQ1JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTCt++QTblr3tm+muZP70oOnky9vXbV4zbTFv+U4JjVV7Oja2elwcMrGSJepK2ab
        bJu16sW52VUXTb79DevpTnGUPuRwsaOsQO/xLGulhbf111RvLll8eOtkPhOes+1CfSLbuSfb
        qZxf9mJfcQ3n0WJl27rZJ9Vvnwgr/XzU7N6GtpDVr/5mdj55e/jOLRXziD1J06Ylbnn0w9/Z
        wP4h016b3MzEfM5NJwq7dlx1Vp48KXpdpS7zilDezT7XG2w+bz1jlft/g/Wl+Qce/1wxaXmL
        ZPx9TT3fqN05yW/1uv0a7+TvOye069qzP1+Uw/NU/VWSp/w/m5n/8fvlwO1OC1kWrvyg9335
        2xl1a8Nn14U0KiqxFGckGmoxFxUnAgAv+VkIBgMAAA==
X-CMS-MailID: 20220517125511epcas5p4e9a4e3c327771dd1faf0a50057a2c17b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125511epcas5p4e9a4e3c327771dd1faf0a50057a2c17b
References: <CGME20220517125511epcas5p4e9a4e3c327771dd1faf0a50057a2c17b@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds MFC v12 support. MFC v12 is used in
Tesla FSD SoC.

This adds support for following:

* Add support for VP9 encoder
* Add support for YV12 and I420 format (3-plane)
* Add support for Rate Control, UHD and DMABUF for encoder
* Add support for DPB buffers allocation based on MFC requirement
* Fix to handle reference queue at MFCINST_FINISHING state.
* Fix to handle error scenario on CLOSE_INSTANCE command.
* Fix for register read and write for H264 codec encoding.
* Update Documentation for control id definitions

Smitha T Murthy (20):
  MAINTAINERS: Add git repo path for MFC
  dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to new DT schema
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
  media: s5p-mfc: Fix to handle reference queue during finishing
  media: s5p-mfc: Clear workbit to handle error condition
  media: s5p-mfc: Correction in register read and write for H264
  arm64: dts: fsd: Add MFC related DT enteries
  arm64 defconfig: Add MFC in defconfig

 .../devicetree/bindings/media/s5p-mfc.txt     |  77 +--
 .../devicetree/bindings/media/s5p-mfc.yaml    |  99 ++++
 .../media/v4l/ext-ctrls-codec.rst             | 167 +++++++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   8 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  22 +
 arch/arm64/configs/defconfig                  |   4 +-
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  60 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  48 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  13 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  51 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 417 ++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  16 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 446 ++++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   3 +
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  44 ++
 include/uapi/linux/v4l2-controls.h            |  33 ++
 22 files changed, 1362 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h


base-commit: 3ae87d2f25c0e998da2721ce332e2b80d3d53c39
-- 
2.17.1

