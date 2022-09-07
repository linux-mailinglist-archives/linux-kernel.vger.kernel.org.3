Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D825AFE19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIGHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIGHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:50:50 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248552FC5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:50:41 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220907075039epoutp026a2b90a7e0f6700195e6f78ac18106fa~ShKEHz3wG1327413274epoutp027
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:50:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220907075039epoutp026a2b90a7e0f6700195e6f78ac18106fa~ShKEHz3wG1327413274epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662537039;
        bh=V5ibs1eKzgBn/7Xlfi+fFF/W/TtZ/hah8YhVw/JnQgY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NzPWfsEo68aFUcYTmaoOD6CWmrL9LWuI73KWEdD0S/dfrB4HNy5boUJ4ZnB54rjcG
         uxghjt9Bx5cyN2EAjJLN1s5Y1X3G2rnsz4rAS/GNiL/Dmg/3QeQQRwcDDmOQbNpFbb
         JY2rqhy6A9kAT9RPpsCeqY81NkUMycUDgEE7YkbA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220907075038epcas5p300f463ffffeb2d8eb892a2cd1e4e1205~ShKDdxn-o2178621786epcas5p32;
        Wed,  7 Sep 2022 07:50:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MMvZ33kbXz4x9Q3; Wed,  7 Sep
        2022 07:50:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.91.59633.B4D48136; Wed,  7 Sep 2022 16:50:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220907074649epcas5p405f55bff4c61ed6ff3187b9c19e1db22~ShGuPjZHK0834408344epcas5p46;
        Wed,  7 Sep 2022 07:46:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907074649epsmtrp15662bdb776903619916bbf7709503689~ShGuOdKw01628116281epsmtrp1m;
        Wed,  7 Sep 2022 07:46:49 +0000 (GMT)
X-AuditID: b6c32a49-dfdff7000000e8f1-5f-63184d4bc5e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.F7.18644.96C48136; Wed,  7 Sep 2022 16:46:49 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220907074646epsmtip2add35957d3820c0614d6463c224a7816~ShGrMHXFw3136431364epsmtip2O;
        Wed,  7 Sep 2022 07:46:46 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <aakarsh.jain@samsung.com>
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
Subject: RE: [Patch v2 00/15] Add MFC v12 support.
Date:   Wed, 7 Sep 2022 13:16:45 +0530
Message-ID: <04ba01d8c28d$fcda1e80$f68e5b80$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_04BB_01D8C2BC.16945650"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGMTvU9PRo8ZxM/zZZZz4GAPtYcAQIwYET5rlr6twA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH/d3ePhgpuQLCj5ItUHBaJqzdAC8TNucWcnFiMMZsEyO7lssj
        QNu0RTaNGQLFFJHxjNLxhgErj/GG8VgASxhMthUYDLUMEGQgbgtlGS/RltsZ/vuc7/mec8+5
        v9+Pw7AdZfM40RIlJZeQsXzWPrTtZ4HA80wwFAu/27TDFzrymfhMURsLL19fRPBH5UYU729u
        ZeMt41cZeNVgLxMv1t1l4u19cyje+NiU1ecbUHyxuB7gS5ppFt70xwQTn10+i491FrDw9IZW
        Jl6nM7Dxa5N6BK9s2kbwstY1Nq7q0bHxlFQd8q4jUVtUC4gOQwUgJitWGcRNjYFNlHcvIUST
        Vs0ifp/oZhHNFZcJ1cAmSmS0aAGxk1TIJtJ0kyzC2HSAGH5uZIfYfBrjH0WR4ZTchZKIpeHR
        ksgA/pmPw06F+fgKRZ4iP/xtvouEjKMC+Kc/CPEMjI41/QG+y5dkbLxJCiEVCv7h4/5yabyS
        comSKpQBfEoWHivzlnkpyDhFvCTSS0Ipj4mEwiM+JuOFmKjtpS1UtnUVXHxm+IeVCHTZIA1w
        OBDzhqV1B9PAPo4t1gVgds4QQgerAGqf7jDowAhgya0brDRgtVuhXpyxuDoB/PZXI5MOFgF8
        XrbANrtYmBdc1pXvJuwxNYDqqnbUnGBgeSjsm3AysxV2DOpzbzPNg9hhR2BOob1ZRjF3WDO8
        vStzMT94r45plrnYq3Aof97S5RM49eMImx7IBW4sVO7a7U0d+7UK2uIIlwZ0bPMEENuxgmtd
        SRb/aZiYX82g2Q4uD7ZYdB5cupJq4Uj4yJgMaJbBwsQWhOYTsHe8AKV5P8wbrkfoj9nAH7bm
        LR4u7Ch6yXxY9sttS08IH/zdyqSZgOOJRWgmcNXsWU2zZzXNnh1oPgQrS/9iaExrMjABvNF5
        mMZ34E6SE+1whbnfz1rcgbA0IwUpARwtcKJkirhISuEjE0mohP8viFga1wR2H5RHUAcwzDzz
        6gcIB/QDd1P5XEPNfcBDJVIJxbfnhnfYi2254eSlryi5NEweH0sp+oGP6aSyGLzXxFLT65Qo
        w0TefkJvX19fb7+jviK+Izf3EBDbYpGkkoqhKBklf1mHcKx4iUjoG5FDw81nn3AcvLIynLPm
        nJxbngS5PbTvWY/YiHmr6mLDgYeaiJDpb1IP/uTfxx2czexVbU4dvXPSwyH7PDtrdaz4ult5
        24rzny8a3Wy4nz8QXlgXtAq+2B60vRc13HjuFZAxqT+ZopfNqtPvvj7y4ppi2G/ZyXcl66Np
        TapPp3AlcETl9/iEIKT7Ou+8u3hgO/HK3Jv5ycG1NQXke+mOGy6qD1XH5pMTojOtHbXHI0g9
        Nps2WWCX8Nv+oK3RoJmqJOnXl+7khGpvOVSfK5nozs4LqlX/uxaDXraSdN3MXAn9LL0nAhFP
        +YyEplo73Zc/dSXqM7a2262qRyu9xurK3w+25qOKKFLkwZAryP8A9MO0geUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCSvG6mj0SywYtN+hZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4TdoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYwe/5rmsnt0HbnO5vF5k5zHqa+f2QP4orhsUlJzMstSi/TtErgydt9bxVwwu6bi79PNjA2M
        v+K6GDk5JARMJDqfP2DqYuTiEBLYwSix7kgrM0RCQmLl70mMELawxMp/z9khip4ySmyZvBms
        iE1AT+LVkcWsIAkRgV5Gifuf5jKCOMwCK1kk7t7qYoFo6WaU+HT0LQtIC6eAlcTFKSeAWjg4
        hAWMJCbPFQEJswioSKw+9QcszCtgKXF+LStImFdAUOLkzCdgncwCoRI3p59lh7hIQeLn02Vg
        5SJAEw+tKoYoEZd4efQI+wRGoVlIumch6Z6FpAzC1pZ4evMpC4y9bOFr5llAU5kFbCVuNFqg
        CoPYHhIzfnYwL2DkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJEZyKtLR2MO5Z9UHv
        ECMTB+MhRhWg9kcbVl9glGLJy89LVRLhTdkhkizEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDU1j2vsuq9z53du76Jc3fW1mzYI3jKmbdzq1pat/OTHPM
        1tdntvp6Intp/4/dj3KOPOa7nbnxjctr2R3ZUeWpG76cW8cqZhS97fXU3N47Xg47PfeH1Lit
        jnlgUvI/VrNiS8RTyUnHfzof3/HtgZiq/TrR/GwnLUPJ+t2zak28gvaGv80wO9aRaG1ZLlmR
        ftSOxY/RTf2KaYSK3Z52G/ZvW/fdusnC/nz3soIzvv3XvnKEXbitVnFmz2n+vrhPr8LvaIm5
        z/Co5OJvOHbAokfzwixWTc6N7kqLBZz2LOcsFpJbvP21+eqf50KlQpweHSiMauSwOnLqyuPA
        rZVPn3W1Zs7yaTfZtvtXvhtvW0CQEktxRqKhFnNRcSIAQoCVvcADAAA=
X-CMS-MailID: 20220907074649epcas5p405f55bff4c61ed6ff3187b9c19e1db22
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063309epcas5p1793555c0747fd7a11997e97649924552
References: <CGME20220907063309epcas5p1793555c0747fd7a11997e97649924552@epcas5p1.samsung.com>
        <20220907064715.55778-1-smitha.t@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_04BB_01D8C2BC.16945650
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi All,

I have attached the v4l2-complaince complete log (mfc encoder and decoder) =
along with this mail for reference.

Regards,
Smitha

> -----Original Message-----
> From: Smitha T Murthy =5Bmailto:smitha.t=40samsung.com=5D
> Sent: Wednesday, September 7, 2022 12:17 PM
> To: linux-arm-kernel=40lists.infradead.org; linux-media=40vger.kernel.org=
;
> linux-kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
> smitha.t=40samsung.com; aakarsh.jain=40samsung.com
> Subject: =5BPatch v2 00/15=5D Add MFC v12 support.
>=20
> From: aakarsh jain <aakarsh.jain=40samsung.com>
>=20
> This patch series adds MFC v12 support. MFC v12 is used in Tesla FSD SoC.
>=20
> This adds support for following:
>=20
> * Add support for VP9 encoder
> * Add support for YV12 and I420 format (3-plane)
> * Add support for Rate Control, UHD and DMABUF for encoder
> * Add support for DPB buffers allocation based on MFC requirement
> * Update documentation for control id definitions
>=20
> Changes since v1:
>  - Addressed review comments by Andrzej Hajda.
>  - Addressed review comments by Rob Herring.
>  - Addressed review comments by Krzysztof Kozlowski.
>  - Addressed review comments by Hans Verkuil.
>  - Addressed review comments by Nicolas Dufresne.
>  - Rebased on latest krzk/for-next tree.
>=20
> v4l2-complaince:
> Total for s5p-mfc device /dev/video0: 45, Succeeded: 39, Failed: 6, Warni=
ngs:
> 0 Total for s5p-mfc device /dev/video1: 45, Succeeded: 34, Failed: 11,
> Warnings: 3
>=20
> Smitha T Murthy (15):
>   dt-bindings: media: s5p-mfc: Add new DT schema for MFC
>   dt-bindings: media: s5p-mfc: Add mfcv12 variant
>   media: s5p-mfc: Rename IS_MFCV10 macro
>   media: s5p-mfc: Add initial support for MFCv12
>   Documention: v4l: Documentation for VP9 CIDs.
>   media: v4l2: Add v4l2 control IDs for VP9 encoder.
>   media: s5p-mfc: Add support for VP9 encoder.
>   media: s5p-mfc: Add YV12 and I420 multiplanar format support
>   media: s5p-mfc: Add support for rate controls in MFCv12
>   media: s5p-mfc: Add support for UHD encoding.
>   media: s5p-mfc: Add support for DMABUF for encoder
>   media: s5p-mfc: Set context for valid case before calling try_run
>   media: s5p-mfc: Load firmware for each run in MFCv12.
>   media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
>   arm64: dts: fsd: Add MFC related DT enteries
>=20
>  .../devicetree/bindings/media/s5p-mfc.txt     =7C  77 +---
>  .../bindings/media/samsung,s5p-mfc.yaml       =7C 110 +++++
>  .../media/v4l/ext-ctrls-codec.rst             =7C 167 +++++++
>  arch/arm64/boot/dts/tesla/fsd-evb.dts         =7C   4 +
>  arch/arm64/boot/dts/tesla/fsd.dtsi            =7C  22 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v12.h   =7C  60 +++
>  .../platform/samsung/s5p-mfc/regs-mfc-v7.h    =7C   1 +
>  .../platform/samsung/s5p-mfc/regs-mfc-v8.h    =7C   3 +
>  .../media/platform/samsung/s5p-mfc/s5p_mfc.c  =7C  36 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c =7C   3 +
>  .../platform/samsung/s5p-mfc/s5p_mfc_common.h =7C  54 ++-
>  .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   =7C   9 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    =7C  51 ++-
>  .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    =7C 410 +++++++++++++++--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    =7C  16 +-
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c =7C  12 +-
> .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c =7C 433
> ++++++++++++++++--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h =7C   7 +-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     =7C  44 ++
>  include/uapi/linux/v4l2-controls.h            =7C  33 ++
>  20 files changed, 1349 insertions(+), 203 deletions(-)  create mode 1006=
44
> Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>  create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-
> v12.h
>=20
> --
> 2.17.1


------=_NextPart_000_04BB_01D8C2BC.16945650
Content-Type: text/plain; name="v4l2-compliance-mfcv12.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="v4l2-compliance-mfcv12.txt"

IyB2NGwyLWNvbXBsaWFuY2UgLWQgL2Rldi92aWRlbzENCnY0bDItY29tcGxpYW5jZSAxLjIyLjEs
IDY0IGJpdHMsIDY0LWJpdCB0aW1lX3QNCg0KQ29tcGxpYW5jZSB0ZXN0IGZvciBzNXAtbWZjIGRl
dmljZSAvZGV2L3ZpZGVvMToNCg0KRHJbICAgOTUuMDE0Nzk3XSB2aWRpb2NfZ19wYXJtOjI1NzY6
IFNldHRpbmcgRlBTIGlzIG9ubHkgcG9zc2libGUgZm9yIHRoZSBvdXRwdXQgcXVldWUNClsgICA5
NS4wMjI2NzBdIHM1cC1tZmMgMTI4ODAwMDAubWZjOiBFbmNvZGluZyBub3QgaW5pdGlhbGlzZWQN
ClsgICA5NS4wMjI3MjhdIHM1cC1tZmMgMTI4ODAwMDAubWZjOiBFbmNvZGluZyBub3QgaW5pdGlh
bGlzZWQNClsgICA5NS4wMjI4MTJdIHZpZGlvY19nX3Bhcm06MjU3NjogU2V0dGluZyBGUFMgaXMg
b25seSBwb3NzaWJsZSBmb3IgdGhlIG91dHB1dCBxdWV1ZQ0KWyAgIDk1LjAyMjg3MV0gdmlkaW9j
X3RyeV9mbXQ6MTYwNzogZmFpbGVkIHRvIHRyeSBvdXRwdXQgZm9ybWF0DQpbICAgOTUuMDQ3MTY5
XSBzNXBfbWZjX3F1ZXVlX3NldHVwOjI2OTA6IGludmFsaWQgc3RhdGU6IDANClsgICA5NS4wNDcx
ODFdIHZpZGlvY19yZXFidWZzOjE3MjU6IGVycm9yIGluIHZiMl9yZXFidWZzKCkgZm9yIEUoRCkN
Cml2ZXIgSW5mbzoNCiAgICAgICAgRHJpdmVyIG5hbWUgICAgICA6IHM1cC1tZmMNCiAgICAgICAg
Q2FyZCB0eXBlICAgICAgICA6IHM1cC1tZmMtZW5jDQogICAgICAgIEJ1cyBpbmZvICAgICAgICAg
OiBwbGF0Zm9ybToxMjg4MDAwMC5tZmMNCiAgICAgICAgRHJpdmVyIHZlcnNpb24gICA6IDUuMTku
MA0KICAgICAgICBDYXBhYmlsaXRpZXMgICAgIDogMHg4NDIwNDAwMA0KICAgICAgICAgICAgICAg
IFZpZGVvIE1lbW9yeS10by1NZW1vcnkgTXVsdGlwbGFuYXINCiAgICAgICAgICAgICAgICBTdHJl
YW1pbmcNCiAgICAgICAgICAgICAgICBFeHRlbmRlZCBQaXggRm9ybWF0DQogICAgICAgICAgICAg
ICAgRGV2aWNlIENhcGFiaWxpdGllcw0KICAgICAgICBEZXZpY2UgQ2FwcyAgICAgIDogMHgwNDIw
NDAwMA0KICAgICAgICAgICAgICAgIFZpZGVvIE1lbW9yeS10by1NZW1vcnkgTXVsdGlwbGFuYXIN
CiAgICAgICAgICAgICAgICBTdHJlYW1pbmcNCiAgICAgICAgICAgICAgICBFeHRlbmRlZCBQaXgg
Rm9ybWF0DQogICAgICAgIERldGVjdGVkIFN0YXRlZnVsIEVuY29kZXINCg0KUmVxdWlyZWQgaW9j
dGxzOg0KICAgICAgICB0ZXN0IFZJRElPQ19RVUVSWUNBUDogT0sNCiAgICAgICAgdGVzdCBpbnZh
bGlkIGlvY3RsczogT0sNCg0KQWxsb3cgZm9yIG11bHRpcGxlIG9wZW5zOg0KICAgICAgICB0ZXN0
IHNlY29uZCAvZGV2L3ZpZGVvMSBvcGVuOiBPSw0KICAgICAgICB0ZXN0IFZJRElPQ19RVUVSWUNB
UDogT0sNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX1BSSU9SSVRZOiBPSw0KICAgICAgICAgICAg
ICAgIGZhaWw6IHY0bDItY29tcGxpYW5jZS5jcHAoNzM2KTogIW9rDQogICAgICAgIHRlc3QgZm9y
IHVubGltaXRlZCBvcGVuczogRkFJTA0KDQpEZWJ1ZyBpb2N0bHM6DQogICAgICAgIHRlc3QgVklE
SU9DX0RCR19HL1NfUkVHSVNURVI6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJ
RElPQ19MT0dfU1RBVFVTOiBPSyAoTm90IFN1cHBvcnRlZCkNCg0KSW5wdXQgaW9jdGxzOg0KICAg
ICAgICB0ZXN0IFZJRElPQ19HL1NfVFVORVIvRU5VTV9GUkVRX0JBTkRTOiBPSyAoTm90IFN1cHBv
cnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0ZSRVFVRU5DWTogT0sgKE5vdCBTdXBwb3J0
ZWQpDQogICAgICAgIHRlc3QgVklESU9DX1NfSFdfRlJFUV9TRUVLOiBPSyAoTm90IFN1cHBvcnRl
ZCkNCiAgICAgICAgdGVzdCBWSURJT0NfRU5VTUFVRElPOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAg
ICAgICAgdGVzdCBWSURJT0NfRy9TL0VOVU1JTlBVVDogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAg
ICAgIHRlc3QgVklESU9DX0cvU19BVURJTzogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIElu
cHV0czogMCBBdWRpbyBJbnB1dHM6IDAgVHVuZXJzOiAwDQoNCk91dHB1dCBpb2N0bHM6DQogICAg
ICAgIHRlc3QgVklESU9DX0cvU19NT0RVTEFUT1I6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAg
ICB0ZXN0IFZJRElPQ19HL1NfRlJFUVVFTkNZOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAg
dGVzdCBWSURJT0NfRU5VTUFVRE9VVDogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIHRlc3Qg
VklESU9DX0cvUy9FTlVNT1VUUFVUOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBW
SURJT0NfRy9TX0FVRE9VVDogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIE91dHB1dHM6IDAg
QXVkaW8gT3V0cHV0czogMCBNb2R1bGF0b3JzOiAwDQoNCklucHV0L091dHB1dCBjb25maWd1cmF0
aW9uIGlvY3RsczoNCiAgICAgICAgdGVzdCBWSURJT0NfRU5VTS9HL1MvUVVFUllfU1REOiBPSyAo
Tm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfRU5VTS9HL1MvUVVFUllfRFZfVElN
SU5HUzogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIHRlc3QgVklESU9DX0RWX1RJTUlOR1Nf
Q0FQOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0VESUQ6IE9L
IChOb3QgU3VwcG9ydGVkKQ0KDQpDb250cm9sIGlvY3RsczoNCiAgICAgICAgdGVzdCBWSURJT0Nf
UVVFUllfRVhUX0NUUkwvUVVFUllNRU5VOiBPSw0KICAgICAgICB0ZXN0IFZJRElPQ19RVUVSWUNU
Ukw6IE9LDQogICAgICAgICAgICAgICAgZmFpbDogdjRsMi10ZXN0LWNvbnRyb2xzLmNwcCg0NzMp
OiBnX2N0cmwgcmV0dXJuZWQgYW4gZXJyb3IgKDIyKQ0KICAgICAgICB0ZXN0IFZJRElPQ19HL1Nf
Q1RSTDogRkFJTA0KICAgICAgICAgICAgICAgIGZhaWw6IHY0bDItdGVzdC1jb250cm9scy5jcHAo
NzA0KTogZ19leHRfY3RybHMgcmV0dXJuZWQgYW4gZXJyb3IgKDIyKQ0KICAgICAgICB0ZXN0IFZJ
RElPQ19HL1MvVFJZX0VYVF9DVFJMUzogRkFJTA0KICAgICAgICAgICAgICAgIGZhaWw6IHY0bDIt
dGVzdC1jb250cm9scy5jcHAoODcyKTogc3Vic2NyaWJlIGV2ZW50IGZvciBjb250cm9sICdVc2Vy
IENvbnRyb2xzJyBmYWlsZWQNCiAgICAgICAgdGVzdCBWSURJT0NfKFVOKVNVQlNDUklCRV9FVkVO
VC9EUUVWRU5UOiBGQUlMDQogICAgICAgIHRlc3QgVklESU9DX0cvU19KUEVHQ09NUDogT0sgKE5v
dCBTdXBwb3J0ZWQpDQogICAgICAgIFN0YW5kYXJkIENvbnRyb2xzOiAxMjggUHJpdmF0ZSBDb250
cm9sczogMTENCg0KRm9ybWF0IGlvY3RsczoNCiAgICAgICAgICAgICAgICBmYWlsOiB2NGwyLXRl
c3QtZm9ybWF0cy5jcHAoMjgyKTogbm9kZS0+Y29kZWNfbWFzayAmIFNUQVRFRlVMX0VOQ09ERVIN
CiAgICAgICAgdGVzdCBWSURJT0NfRU5VTV9GTVQvRlJBTUVTSVpFUy9GUkFNRUlOVEVSVkFMUzog
RkFJTA0KICAgICAgICAgICAgICAgIGZhaWw6IHY0bDItdGVzdC1mb3JtYXRzLmNwcCgxMzEwKTog
aXNfc3RhdGVmdWxfZW5jICYmICFvdXQtPmNhcGFiaWxpdHkNCiAgICAgICAgdGVzdCBWSURJT0Nf
Ry9TX1BBUk06IEZBSUwNCiAgICAgICAgdGVzdCBWSURJT0NfR19GQlVGOiBPSyAoTm90IFN1cHBv
cnRlZCkNCiAgICAgICAgICAgICAgICBmYWlsOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAoNDc0KTog
IXBpeF9tcC53aWR0aCB8fCAhcGl4X21wLmhlaWdodA0KICAgICAgICB0ZXN0IFZJRElPQ19HX0ZN
VDogRkFJTA0KICAgICAgICAgICAgICAgIGZhaWw6IHY0bDItdGVzdC1mb3JtYXRzLmNwcCg0NzQp
OiAhcGl4X21wLndpZHRoIHx8ICFwaXhfbXAuaGVpZ2h0DQogICAgICAgIHRlc3QgVklESU9DX1RS
WV9GTVQ6IEZBSUwNCiAgICAgICAgICAgICAgICB3YXJuOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAo
MTE0Nyk6IFNfRk1UIGNhbm5vdCBoYW5kbGUgYW4gaW52YWxpZCBwaXhlbGZvcm1hdC4NCiAgICAg
ICAgICAgICAgICB3YXJuOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAoMTE0OCk6IFRoaXMgbWF5IG9y
IG1heSBub3QgYmUgYSBwcm9ibGVtLiBGb3IgbW9yZSBpbmZvcm1hdGlvbiBzZWU6DQogICAgICAg
ICAgICAgICAgd2FybjogdjRsMi10ZXN0LWZvcm1hdHMuY3BwKDExNDkpOiBodHRwOi8vd3d3Lm1h
aWwtYXJjaGl2ZS5jb20vbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnL21zZzU2NTUwLmh0bWwN
CiAgICAgICAgICAgICAgICBmYWlsOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAoNDc4KTogcGl4ZWxm
b3JtYXQgMzQzNjMyNDggKEgyNjQpIGZvciBidWZ0eXBlIDkgbm90IHJlcG9ydGVkIGJ5IEVOVU1f
Rk1UDQogICAgICAgIHRlc3QgVklESU9DX1NfRk1UOiBGQUlMDQogICAgICAgIHRlc3QgVklESU9D
X0dfU0xJQ0VEX1ZCSV9DQVA6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IENyb3Bw
aW5nOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBDb21wb3Npbmc6IE9LIChOb3Qg
U3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFNjYWxpbmc6IE9LIChOb3QgU3VwcG9ydGVkKQ0KDQpD
b2RlYyBpb2N0bHM6DQogICAgICAgICAgICAgICAgZmFpbDogdjRsMi10ZXN0LWNvZGVjcy5jcHAo
MzUpOiBub2RlLT5mdW5jdGlvbiAhPSBNRURJQV9FTlRfRl9QUk9DX1ZJREVPX0VOQ09ERVINCiAg
ICAgICAgdGVzdCBWSURJT0NfKFRSWV8pRU5DT0RFUl9DTUQ6IEZBSUwNCiAgICAgICAgdGVzdCBW
SURJT0NfR19FTkNfSU5ERVg6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJRElP
Q18oVFJZXylERUNPREVSX0NNRDogT0sgKE5vdCBTdXBwb3JbICAgOTUuNDAzNjU1XSB2aWRpb2Nf
Z19wYXJtOjI1NzY6IFNldHRpbmcgRlBTIGlzIG9ubHkgcG9zc2libGUgZm9yIHRoZSBvdXRwdXQg
cXVldWUNCnRlZCkNCg0KQnVmZmVyIGlvY3RsczoNCiAgICAgICAgICAgICAgICBmYWlsOiB2NGwy
LXRlc3QtYnVmZmVycy5jcHAoNjA3KTogcS5yZXFidWZzKG5vZGUsIDEpDQogICAgICAgIHRlc3Qg
VklESU9DX1JFUUJVRlMvQ1JFQVRFX0JVRlMvUVVFUllCVUY6IEZBSUwNCiAgICAgICAgICAgICAg
ICBmYWlsOiB2NGwyLXRlc3QtYnVmZmVycy5jcHAoNzgzKTogVklESU9DX0VYUEJVRiBpcyBzdXBw
b3J0ZWQsIGJ1dCB0aGUgVjRMMl9NRU1PUllfTU1BUCBzdXBwb3J0IGlzIG1pc3Npbmcgb3IgbWFs
ZnVuY3Rpb25pbmcuDQogICAgICAgICAgICAgICAgZmFpbDogdjRsMi10ZXN0LWJ1ZmZlcnMuY3Bw
KDc4NCk6IFZJRElPQ19FWFBCVUYgaXMgc3VwcG9ydGVkLCBidXQgdGhlIFY0TDJfTUVNT1JZX01N
QVAgc3VwcG9ydCBpcyBtaXNzaW5nLCBwcm9iYWJseSBkdWUgdG8gZWFybGllciBmYWlsaW5nIGZv
cm1hdCB0ZXN0cy4NCiAgICAgICAgdGVzdCBWSURJT0NfRVhQQlVGOiBPSyAoTm90IFN1cHBvcnRl
ZCkNCiAgICAgICAgdGVzdCBSZXF1ZXN0czogT0sgKE5vdCBTdXBwb3J0ZWQpDQoNClRvdGFsIGZv
ciBzNXAtbWZjIGRldmljZSAvZGV2L3ZpZGVvMTogNDUsIFN1Y2NlZWRlZDogMzQsIEZhaWxlZDog
MTEsIFdhcm5pbmdzOiAzDQojDQoNCg0KIyB2NGwyLWNvbXBsaWFuY2UgLWQgL2Rldi92aWRlbzAN
CnY0bDItY29tcGxpYW5jZSAxLjIyLjEsIDY0IGJpdHMsIDY0LWJpdCB0aW1lX3QNCg0KQ29tcGxp
YW5jZSB0ZXN0IGZvciBzNXAtbWZjIGRldmljZSAvZGV2L3ZpZGVvMDoNCg0KRHJpdmVbICAxOTgu
NzY3NjExXSB2aWRpb2NfZ19zZWxlY3Rpb246ODE2OiBDYW4gbm90IGdldCBjb21wb3NlIGluZm9y
bWF0aW9uDQpbICAxOTguNzY4MDg3XSB2aWRpb2NfZ19zZWxlY3Rpb246ODE2OiBDYW4gbm90IGdl
dCBjb21wb3NlIGluZm9ybWF0aW9uDQpbICAxOTguNzY4MTc1XSB2aWRpb2NfZ19mbXQ6Mzk3OiBG
b3JtYXQgY291bGQgbm90IGJlIHJlYWQNClsgIDE5OC43NjgxNzldIHZpZGlvY19nX3NlbGVjdGlv
bjo4MTY6IENhbiBub3QgZ2V0IGNvbXBvc2UgaW5mb3JtYXRpb24NClsgIDE5OC43NjgxODJdIHZp
ZGlvY19nX3NlbGVjdGlvbjo4MTY6IENhbiBub3QgZ2V0IGNvbXBvc2UgaW5mb3JtYXRpb24NClsg
IDE5OC43Njg0NDhdIHM1cC1tZmMgMTI4ODAwMDAubWZjOiBEZWNvZGluZyBub3QgaW5pdGlhbGlz
ZWQNClsgIDE5OC43Njg0NjldIHM1cC1tZmMgMTI4ODAwMDAubWZjOiBEZWNvZGluZyBub3QgaW5p
dGlhbGlzZWQNClsgIDE5OC43Njg2MTBdIHZpZGlvY19nX2ZtdDozOTc6IEZvcm1hdCBjb3VsZCBu
b3QgYmUgcmVhZA0KWyAgMTk4Ljc2ODY0MF0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5v
dCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODY0M10gdmlkaW9jX2dfc2VsZWN0
aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODY0Nl0g
dmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0K
WyAgMTk4Ljc2ODY0OF0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9z
ZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODY1MF0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2Fu
IG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODY1OF0gdmlkaW9jX2dfc2Vs
ZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODcz
MV0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlv
bg0KWyAgMTk4Ljc2ODc2MF0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29t
cG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODgzN10gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjog
Q2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODg2MV0gdmlkaW9jX2df
c2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2
ODg2Nl0gdmlkaW9jX3RyeV9mbXQ6NDI5OiBVbnN1cHBvcnRlZCBmb3JtYXQgZm9yIGRlc3RpbmF0
aW9uLg0KWyAgMTk4Ljc2ODg5NF0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQg
Y29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODkxNV0gdmlkaW9jX2dfc2VsZWN0aW9uOjgx
NjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZvcm1hdGlvbg0KWyAgMTk4Ljc2ODkxN10gdmlkaW9j
X3RyeV9mbXQ6NDI5OiBVbnN1cHBvcnRlZCBmb3JtYXQgZm9yIGRlc3RpbmF0aW9uLg0KWyAgMTk4
Ljc2ODkzOV0gdmlkaW9jX2dfc2VsZWN0aW9uOjgxNjogQ2FuIG5vdCBnZXQgY29tcG9zZSBpbmZv
cm1hdGlvbg0KciBJbmZvOg0KICAgICAgICBEcml2ZXIgbmFtZSAgICAgIDogczVwLW1mYw0KICAg
ICAgICBDYXJkIHR5cGUgICAgICAgIDogczVwLW1mYy1kZWMNCiAgICAgICAgQnVzIGluZm8gICAg
ICAgICA6IHBsYXRmb3JtOjEyODgwMDAwLm1mYw0KICAgICAgICBEcml2ZXIgdmVyc2lvbiAgIDog
NS4xOS4wDQogICAgICAgIENhcGFiaWxpdGllcyAgICAgOiAweDg0MjA0MDAwDQogICAgICAgICAg
ICAgICAgVmlkZW8gTWVtb3J5LXRvLU1lbW9yeSBNdWx0aXBsYW5hcg0KICAgICAgICAgICAgICAg
IFN0cmVhbWluZw0KICAgICAgICAgICAgICAgIEV4dGVuZGVkIFBpeCBGb3JtYXQNCiAgICAgICAg
ICAgICAgICBEZXZpY2UgQ2FwYWJpbGl0aWVzDQogICAgICAgIERldmljZSBDYXBzICAgICAgOiAw
eDA0MjA0MDAwDQogICAgICAgICAgICAgICAgVmlkZW8gTWVtb3J5LXRvLU1lbW9yeSBNdWx0aXBs
YW5hcg0KICAgICAgICAgICAgICAgIFN0cmVhbWluZw0KICAgICAgICAgICAgICAgIEV4dGVuZGVk
IFBpeCBGb3JtYXQNCiAgICAgICAgRGV0ZWN0ZWQgU3RhdGVmdWwgRGVjb2Rlcg0KDQpSZXF1aXJl
ZCBpb2N0bHM6DQogICAgICAgIHRlc3QgVklESU9DX1FVRVJZQ0FQOiBPSw0KICAgICAgICB0ZXN0
IGludmFsaWQgaW9jdGxzOiBPSw0KDQpBbGxvdyBmb3IgbXVsdGlwbGUgb3BlbnM6DQogICAgICAg
IHRlc3Qgc2Vjb25kIC9kZXYvdmlkZW8wIG9wZW46IE9LDQogICAgICAgIHRlc3QgVklESU9DX1FV
RVJZQ0FQOiBPSw0KICAgICAgICB0ZXN0IFZJRElPQ19HL1NfUFJJT1JJVFk6IE9LDQogICAgICAg
ICAgICAgICAgZmFpbDogdjRsMi1jb21wbGlhbmNlLmNwcCg3MzYpOiAhb2sNCiAgICAgICAgdGVz
dCBmb3IgdW5saW1pdGVkIG9wZW5zOiBGQUlMDQoNCkRlYnVnIGlvY3RsczoNCiAgICAgICAgdGVz
dCBWSURJT0NfREJHX0cvU19SRUdJU1RFUjogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIHRl
c3QgVklESU9DX0xPR19TVEFUVVM6IE9LIChOb3QgU3VwcG9ydGVkKQ0KDQpJbnB1dCBpb2N0bHM6
DQogICAgICAgIHRlc3QgVklESU9DX0cvU19UVU5FUi9FTlVNX0ZSRVFfQkFORFM6IE9LIChOb3Qg
U3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJRElPQ19HL1NfRlJFUVVFTkNZOiBPSyAoTm90IFN1
cHBvcnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfU19IV19GUkVRX1NFRUs6IE9LIChOb3QgU3Vw
cG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJRElPQ19FTlVNQVVESU86IE9LIChOb3QgU3VwcG9ydGVk
KQ0KICAgICAgICB0ZXN0IFZJRElPQ19HL1MvRU5VTUlOUFVUOiBPSyAoTm90IFN1cHBvcnRlZCkN
CiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0FVRElPOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAg
ICAgSW5wdXRzOiAwIEF1ZGlvIElucHV0czogMCBUdW5lcnM6IDANCg0KT3V0cHV0IGlvY3RsczoN
CiAgICAgICAgdGVzdCBWSURJT0NfRy9TX01PRFVMQVRPUjogT0sgKE5vdCBTdXBwb3J0ZWQpDQog
ICAgICAgIHRlc3QgVklESU9DX0cvU19GUkVRVUVOQ1k6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAg
ICAgICB0ZXN0IFZJRElPQ19FTlVNQVVET1VUOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAg
dGVzdCBWSURJT0NfRy9TL0VOVU1PVVRQVVQ6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0
ZXN0IFZJRElPQ19HL1NfQVVET1VUOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgT3V0cHV0
czogMCBBdWRpbyBPdXRwdXRzOiAwIE1vZHVsYXRvcnM6IDANCg0KSW5wdXQvT3V0cHV0IGNvbmZp
Z3VyYXRpb24gaW9jdGxzOg0KICAgICAgICB0ZXN0IFZJRElPQ19FTlVNL0cvUy9RVUVSWV9TVEQ6
IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJRElPQ19FTlVNL0cvUy9RVUVSWV9E
Vl9USU1JTkdTOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfRFZfVElN
SU5HU19DQVA6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFZJRElPQ19HL1NfRURJ
RDogT0sgKE5vdCBTdXBwb3J0ZWQpDQoNCkNvbnRyb2wgaW9jdGxzOg0KICAgICAgICB0ZXN0IFZJ
RElPQ19RVUVSWV9FWFRfQ1RSTC9RVUVSWU1FTlU6IE9LDQogICAgICAgIHRlc3QgVklESU9DX1FV
RVJZQ1RSTDogT0sNCiAgICAgICAgICAgICAgICBmYWlsOiB2NGwyLXRlc3QtY29udHJvbHMuY3Bw
KDQ3Myk6IGdfY3RybCByZXR1cm5lZCBhbiBlcnJvciAoMjIpDQogICAgICAgIHRlc3QgVklESU9D
X0cvU19DVFJMOiBGQUlMDQogICAgICAgICAgICAgICAgZmFpbDogdjRsMi10ZXN0LWNvbnRyb2xz
LmNwcCg3MDQpOiBnX2V4dF9jdHJscyByZXR1cm5lZCBhbiBlcnJvciAoMjIpDQogICAgICAgIHRl
c3QgVklESU9DX0cvUy9UUllfRVhUX0NUUkxTOiBGQUlMDQogICAgICAgICAgICAgICAgZmFpbDog
djRsMi10ZXN0LWNvbnRyb2xzLmNwcCg4NzIpOiBzdWJzY3JpYmUgZXZlbnQgZm9yIGNvbnRyb2wg
J1VzZXIgQ29udHJvbHMnIGZhaWxlZA0KICAgICAgICB0ZXN0IFZJRElPQ18oVU4pU1VCU0NSSUJF
X0VWRU5UL0RRRVZFTlQ6IEZBSUwNCiAgICAgICAgdGVzdCBWSURJT0NfRy9TX0pQRUdDT01QOiBP
SyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgU3RhbmRhcmQgQ29udHJvbHM6IDcgUHJpdmF0ZSBD
b250cm9sczogMg0KDQpGb3JtYXQgaW9jdGxzOg0KICAgICAgICB0ZXN0IFZJRElPQ19FTlVNX0ZN
VC9GUkFNRVNJWkVTL0ZSQU1FSU5URVJWQUxTOiBPSw0KICAgICAgICB0ZXN0IFZJRElPQ19HL1Nf
UEFSTTogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAgICAgIHRlc3QgVklESU9DX0dfRkJVRjogT0sg
KE5vdCBTdXBwb3J0ZWQpDQogICAgICAgICAgICAgICAgZmFpbDogdjRsMi10ZXN0LWZvcm1hdHMu
Y3BwKDYyMCk6IFZpZGVvIENhcHR1cmUgTXVsdGlwbGFuYXIgY2FwIHNldCwgYnV0IG5vIFZpZGVv
IENhcHR1cmUgTXVsdGlwbGFuYXIgZm9ybWF0cyBkZWZpbmVkDQogICAgICAgIHRlc3QgVklESU9D
X0dfRk1UOiBGQUlMDQogICAgICAgIHRlc3QgVklESU9DX1RSWV9GTVQ6IE9LIChOb3QgU3VwcG9y
dGVkKQ0KICAgICAgICB0ZXN0IFZJRElPQ19TX0ZNVDogT0sgKE5vdCBTdXBwb3J0ZWQpDQogICAg
ICAgIHRlc3QgVklESU9DX0dfU0xJQ0VEX1ZCSV9DQVA6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAg
ICAgICB0ZXN0IENyb3BwaW5nOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBDb21w
b3Npbmc6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICB0ZXN0IFNjYWxpbmc6IE9LIChOb3Qg
U3VwcG9ydGVkKQ0KDQpDb2RlYyBpb2N0bHM6DQogICAgICAgIHRlc3QgVklESU9DXyhUUllfKUVO
Q09ERVJfQ01EOiBPSyAoTm90IFN1cHBvcnRlZCkNCiAgICAgICAgdGVzdCBWSURJT0NfR19FTkNf
SU5ERVg6IE9LIChOb3QgU3VwcG9ydGVkKQ0KICAgICAgICAgICAgICAgIGZhaWw6IHY0bDItdGVz
dC1jb2RlY3MuY3BwKDEwNCk6IG5vZGUtPmZ1bmN0aW9uICE9IE1FRElBX0VOVF9GX1BST0NfVklE
RU9fREVDT0RFUg0KICAgICAgICB0ZXN0IFZJRElPQ18oVFJZXylERUNPREVSX0NNRDogRkFJTA0K
DQpCdWZmZXIgaW9jdGxzOg0KICAgICAgICB0ZXN0IFZJRElPQ19SRVFCVUZTL0NSRUFURV9CVUZT
L1FVRVJZQlVGOiBPSw0KICAgICAgICB0ZXN0IFZJRElPQ19FWFBCVUY6IE9LIChOb3QgU3VwcG9y
dGVkKQ0KICAgICAgICB0ZXN0IFJlcXVlc3RzOiBPSyAoTm90IFN1cHBvcnRlZCkNCg0KVG90YWwg
Zm9yIHM1cC1tZmMgZGV2aWNlIC9kZXYvdmlkZW8wOiA0NSwgU3VjY2VlZGVkOiAzOSwgRmFpbGVk
OiA2LCBXYXJuaW5nczogMA0KIw0K

------=_NextPart_000_04BB_01D8C2BC.16945650--

