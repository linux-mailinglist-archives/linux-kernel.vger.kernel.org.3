Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AFC566A51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGELyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiGELwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:34 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1885175B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:32 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220705115231epoutp015cce27ee91996b07f224f1340369c21c~_7K_B-PY50481904819epoutp01o
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220705115231epoutp015cce27ee91996b07f224f1340369c21c~_7K_B-PY50481904819epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021951;
        bh=9ZkoIdUBGeiW5twsNBrNrXwy3/fi85w4/fvmYMTYrSs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lmA3DXh1nIIoU2mkp/yW3hgT85G73YCdOlZvh+lLuoXtDM58zzrb147ZGrnSLYErn
         4xshmavSC3Yxfe037wQpk6P1Cn2nz5pNXm25iBSmi1ruadvD5MIIL+Log4IQsseJJk
         FdJe15SO58TK9QsNRrnKRjTrBILOMCck32wGxqgw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220705115230epcas5p17b47cfd19bdeb604ed1d9fed97e03216~_7K9U5Jse1357613576epcas5p1b;
        Tue,  5 Jul 2022 11:52:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lcgyg4nQwz4x9Pw; Tue,  5 Jul
        2022 11:52:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.AC.09662.BF524C26; Tue,  5 Jul 2022 20:52:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220705115216epcas5p25047d2627060526f0478dbc156f946ff~_7KwFTk7-1193811938epcas5p2T;
        Tue,  5 Jul 2022 11:52:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705115216epsmtrp15bfb8d977090ff08a59cd8586f186a86~_7KwEOAGB2905129051epsmtrp1k;
        Tue,  5 Jul 2022 11:52:16 +0000 (GMT)
X-AuditID: b6c32a49-86fff700000025be-4d-62c425fb79a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.25.08905.0F524C26; Tue,  5 Jul 2022 20:52:16 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705115213epsmtip236a6fa9a2b8be5ddb88837544a85964c~_7KtFKuY81775417754epsmtip2e;
        Tue,  5 Jul 2022 11:52:13 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
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
        <linux-fsd@tesla.com>
In-Reply-To: <b7dc85c5-acaf-95f4-2409-3c25d9fd8274@linaro.org>
Subject: RE: [PATCH 17/20] media: s5p-mfc: Clear workbit to handle error
 condition
Date:   Tue, 5 Jul 2022 17:22:12 +0530
Message-ID: <01eb01d89065$ac278f40$0476adc0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwJR0/m2AnCATAgCiOlFA6xa4KWg
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO13N6Yyk7RRY+Wca6E9AgAq0CO2wi23Ry3Mgku5lolBU4a0lL
        27Wlyi4CTplFmWJGBgWLoXhZxSq1XMZEuZQhBFTkphmFghAoBCeXoQxhayls/Hue533e7718
        eVmIVz7Tl5UsU1NKmVCKMzzQysbAjcELAdYEvqPBn7DrKxmE4fkojRgwzKBEw40KJmHpKkSI
        S811dKLYepdOVNUPoUT5mDPaUWBDidFiEyAcun4GUTvhNJsf99CJwfG9RGdNEYM4db2CTly1
        2pjEhd4OGnHR/IJGlFTMMonjtVYmcSzLSnvHhyzTlwGy2lYKyN7SaYT8VWdjkoabDhppNmoZ
        ZF/PTQZ5ozSdPN70N0r+aDECcunoOSaZbe1lkDNmP7L1rxlmnOc+yTYxJUyilDxKlihPSpaJ
        ovAPP4nfER8ewRcECyKJN3GeTJhCReE7Y+OCdyVLnRvAeRqhNNUpxQlVKjx0+zalPFVN8cRy
        lToKpxRJUkWYIkQlTFGlykQhMkr9loDP3xLuNH4hEc833QOK/pcOHyu/DTJApkc2YLMgFgYL
        K18ws4EHywv7DUD9w2GGm0wD2H3ZtELmAGybHUFXU860G4E7UAtg3thj1E1GASyeu4K4XAws
        BI5bDXRXwBtrAtBuGURcBMGeIXDktqsKm8XGtsP8qszld9dhn8LKXO1yNor5w5qlRVo2YLE4
        WCQssu9xyRyMC1sKhpftCPY6rJosQtwt8eD8yEW6W/eBjiYr04W9sV1w8fr55boQe8CGLWPV
        dHfCTnj/dM/KPOvgeLOF6ca+0HE6awWL4MDM98CNFfBchoXmxtGwrqsIdfWGYIHwWk2oW34N
        5rWaaO4ePGHOwvCKnQOr9asYhyVtd1aeh7B7soJ+BuC6NaPp1oymWzOO7v9q5wFqBOsphSpF
        RKnCFQIZdei/L0+Up5jB8ols2l0NbPanIQ2AxgINALIQ3JtjPFuf4MVJEqZ9TSnl8cpUKaVq
        AOHOdecivq8kyp03JlPHC8Ii+WERERFhkVsjBLgP54Nuc4IXJhKqKQlFKSjlah6NxfbNoF3w
        PfiVlX/i6qDkcExBefWB6YdxGX/eEcxy76UHpcZMr/+s+4Bg35OE+3Rx9PxYTYBulnvoG0fK
        G3zR3ey+rlbcpKxP2B307tKW/RX+v7SX2Iw/2bkh30mOvr/32yO5ICs89I/LZxdyTjK4Qy0/
        RGmanzcG7DBsSOD1br1liX15Psg+kJemhxZJ/BHNxB7tQY9TWlSvYT+a42buP/nEW7q1T7mB
        rtFeg43R/zwCgZpeq9iojtzMemArNpTppwZ98UQRfyOSe0VYJ0LbS7Wc/qcTHZ93+n2ZTi9v
        m0rKWDSNx3z0+8+bLw3d+ljhKcl/1vn21HvZs+mmwtjJE9q0nLhX/XBUJRYKNiFKlfBfqmaY
        AasEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJXveD6pEkg64bohYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVns
        fQ1UvOnxNVaLh6/CLS7vmsNm0bNhK6vF2iN32S2WXr/IZLFs0x8mi0Vbv7BbtO49wm7R0naE
        yUHcY828NYweO+4uYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sq
        Ro9/TXPZPbqOXGfz+LxJzuPU18/sAXxRXDYpqTmZZalF+nYJXBk/j55nLLjHXdGycT9jA2Mj
        VxcjJ4eEgInEhLOrGLsYuTiEBHYzSlxZeZQRIiEhsfL3JChbWGLlv+fsEEVPGSXOHJjBApJg
        E9CTeHVkMStIQkTgJKNE/5kWMIdZoJtFovFVKxNEyxtGiVX/brKBtHAK2EnM2N4I1i4sECTx
        bc1PMJtFQEVi17+/QA0cHLwClhJzHviDhHkFBCVOznwCVsIsoC3R+7CVEcKWl9j+dg4zxHkK
        Ej+fLmOFiItLvDx6hB3EFhFwk/i7YQHzBEbhWUhGzUIyahaSUbOQtC9gZFnFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iRGcSLQ0dzBuX/VB7xAjEwfjIUYJDmYlEd5Vkw4mCfGmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDU5NvOk6YXWBTTplIw
        Z83MI9elThWWJ1k9XnVN/bLB7y6Xi8bMG2vnMbeU7Y74uMvb8UXDhQ0ZqrryJ6oOBFfUvLAM
        Dbiz5McBpusv+qxPaT3d/tZw9d/UfYtsjpf9V3I3yDG6f/FdxAaH1pTr/NemTnqSfTuSR3jq
        I5adX6wCWpwcfnlIP9G2u+Xi7XJzTU95+4wkvp4l0g1dXVvLtixIvna1ZqH6lFtZbvHdblJz
        WW7M2He11+alUKv+i2/++RtXHDJYOGOjP4NOT8h7gcl+K2Q5PlqsW7qj8KDOX09OAwlz03PF
        spwVLAekbiht9ozvdll/c41NmdXtsOJerqW/jM8o37umb73cgI+36aASS3FGoqEWc1FxIgAV
        A2aekwMAAA==
X-CMS-MailID: 20220705115216epcas5p25047d2627060526f0478dbc156f946ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125648epcas5p22201053e8a71dcd5ccc8d0566511b635@epcas5p2.samsung.com>
        <20220517125548.14746-18-smitha.t@samsung.com>
        <b7dc85c5-acaf-95f4-2409-3c25d9fd8274@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
> Sent: Tuesday, May 17, 2022 7:34 PM
> To: Smitha T Murthy <smitha.t@samsung.com>; linux-arm-
> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
> pankaj.dubey@samsung.com; linux-fsd@tesla.com
> Subject: Re: [PATCH 17/20] media: s5p-mfc: Clear workbit to handle error
> condition
> 
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > During error on CLOSE_INSTANCE command, ctx_work_bits was not getting
> > cleared. During consequent mfc execution NULL pointer dereferencing of
> > this context led to kernel panic. This patch fixes this issue by
> > making sure to clear ctx_work_bits always.
> >
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> 
> This looks like a bugfix so:
> 1. Send it separately please.
> 2. Add Fixes tag.
> 3. Add Cc stable tag.
> 
> Best regards,
> Krzysztof

Ok I will send this separately

Regards,
Smitha

