Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA05AFC7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIGGfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIGGfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:35:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDAD7F128
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:35:45 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220907063543epoutp04797cd24311f5611ab5a8d03605db4d5e~SgIo2gVBv0952109521epoutp04M
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:35:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220907063543epoutp04797cd24311f5611ab5a8d03605db4d5e~SgIo2gVBv0952109521epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532543;
        bh=xN/NuLAsVmcta2LrfCdXv54Uvu0MpWW1pSTctckBX9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTnhT4VvnauFg+B+A7PKiOD/D1r5k9SpEV+hTzsgtb2VqXWcukLaLeEQFncD1U7UL
         kSMuVD/MQcJibE2g4vdm3ZzACfBG74o2s+K+ZbtRvg4IWp97QmU0BqcR4Sp8J2aXhX
         rrRTcwadmkhtDxxGu2LM+/v1xmVfpaPRKkRqIMRY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220907063542epcas5p2eb5a9ac6acb3931c74b5e12e3ba0864d~SgInxYymF2122721227epcas5p2X;
        Wed,  7 Sep 2022 06:35:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MMsvZ6CjCz4x9QV; Wed,  7 Sep
        2022 06:35:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.13.53458.8BB38136; Wed,  7 Sep 2022 15:35:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911~SgGiMrEv63160631606epcas5p2W;
        Wed,  7 Sep 2022 06:33:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063318epsmtrp2ce4cb24fea9eedb142612cfc93eed9ec~SgGiLfrj-1916519165epsmtrp2y;
        Wed,  7 Sep 2022 06:33:18 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-2c-63183bb8667a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.CC.14392.E2B38136; Wed,  7 Sep 2022 15:33:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063313epsmtip1182bbff493b3e7ce9004e51b69feac9f~SgGdOedXR2482924829epsmtip1y;
        Wed,  7 Sep 2022 06:33:13 +0000 (GMT)
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
Subject: [Patch v2 02/15] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Wed,  7 Sep 2022 12:17:02 +0530
Message-Id: <20220907064715.55778-3-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTVxzOuff2gVp3hyyeEQXS6RLYgBahHBi4JSPzoiawsMjcI91duSuM
        0jZ9qGNzgB2EdYAQAQcTEKhgkGctrDJIuoqBACJEXhPLQ8ZUFgZSVJxOV9qy/ff9ft/3O98v
        3zmHi3vOsb25KXINo5LTMj57C9Fx1T8g0PwWlAgsOhZaMJex0GxlBxvVrt/F0EytnUDWy+0c
        ZBr9CUf1vRYWquoZYqGff71DoLZ7DnakzEagu1XNAN0vn2Yj4/w4C80tJqKbnefYKK+1nYWa
        emwcdGFiBEN1xmcYqmlf46Ds7h4OsnV1APRdTg/2DqQaKxsBZbYZADVhWMWpK+U2DlXbdR+j
        jA3fs6nb411s6rIhg8q+9jdBFZgaAPX8VAWH0vdMsCm70Yfqf2jnxG//KDUqmaGTGJUfI5co
        klLk0mj+oQTxu+IwkUAYKIxA4Xw/OZ3GRPNjDscHvpcic8TA9ztGy7SOVjytVvOD90epFFoN
        45esUGui+YwySaYMVQap6TS1Vi4NkjOaSKFAEBLmEH6Wmrw+NU0oCzgnKnq7WJlggKUHHlxI
        hsLxphFCD7ZwPclfALxZrcddxSqA+aZ64CoeAThcXsLeHLG317JdRDeAC7UFLFehw2DhUCmx
        oWKTb8JHywPOCS8yC8D5XM2GCCd1BLQNPuVsEDvIWNjUacc2MEHuhZ0Xpp19HhkBR7Km3Ha+
        8FKrBd/AHmQkHCnuc7pBUucBq/45DVyiGDi5WIa78A642GviuLA3tP/V7T5ICmfsOrdeCSsy
        TZgLvw0to+ccW3Md2/nDls5gV3s3LOlvdkpwcjvMf/q7W86D5spNzIc1g31uKwjHltrdqVLw
        cfYTZxCeZD6A1StUIfAp/9/hPAAN4FVGqU6TMuowZYicOf7ftUkUaUbgfOsBB81gbnYlyAow
        LrACyMX5Xrwks5fEk5dEf5XOqBRilVbGqK0gzJFfEe79ikTh+CxyjVgYGiEIFYlEoRH7REL+
        Tl7xG0DiSUppDZPKMEpGtTmHcT28MzGtqfV0b0f562sn91wP3ltIrM/Gm6QDlaV1dd2LnR+c
        PXbQMigaSW/8UptwXJR7ZC0kr9rwZw48sNLKSUzb/5BrOj/2ednqtYQYeey9bfr5LPHt3jvG
        6KwXuZpJxa3IncunLjZmx0/delxZVjq5INwmrjlS8g1vogLzK84oUmitiQe+Vp+wDFXs8t3T
        PLv8cdvulZPPrTNx68O7iuiWJV/JpQ/9fc7G9R3aGvRy7vUHOekG7x/tS/6TgjhDXtuL7m/7
        P42qkV0MXjiz9f3c0Rvi8Buxr129si8wMryeaiG9kr84SpfS+vGwet1R+5MH9T/YFBl2nHs4
        q2l4tu3ZH58U/vbSGMMn1Mm0MABXqel/AcRvBaZ0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRf0yMcRzH+z733PM8td15XJmvmnAbYkRj+kajIR5/sZtfGXK6R+W669xz
        CfOrVpljSTNcp6K7Ux2arit1XVPnrHLNOj9qxh0JRTPmSZoIXfPf+7PX+/15//GmBBIDHk6l
        q3WsVi3PkBIheMMDaeTi6FUwZenrqhXofaNBiN6UNRDINDqAodcmHkeuunoS2Z8ZBaiyvVWI
        yt2Phehe21sc1Q7+o16DD0cD5TUAfSzxE8jW3yNEfZ92oKeOawQ6f7deiO64fSSy9HoxdNP2
        C0MV9cMkym9xk8jnbAAor8CNJUDmdtltwDT6zIDpNX8TME0lPpIxOT9ijM16lmBe9TgJps58
        isl/+BNnCu1WwIznlpKM3t1LMLwtknn0nSe3iHeFxCvYjPTDrHbJ6n0haaMv/bimkDxS2u4U
        ngYeoR4EU5BeDvl6E6EHIZSEbgbwXftLYhJAWD1WDCZ1KKweHyAnTTkYHPpgEUwAgl4ER754
        AukwOh/A3uqz2MQhoI04HC1uDXSE0pvgHQePTWicngsdFj85oUV0HPTm/K+bBW/dbQ18DaZX
        Qu+ljkBW8s/Tf7WBLALi6yDICmawGk6VquJiNDFqNjuak6u4LHVqdEqmygYC6y1c0AjuWb9G
        uwBGAReAlEAaJlI0hqVIRAr50WOsNjNZm5XBci4QQeHS6aJufWeyhE6V61gly2pY7X+KUcHh
        pzGcN35PqJjt5BxdUb4b5O8FuRHX8r62zOlU1a7mcw6ENq1vCp+yzseFbxanG/MqUmDy1ppV
        J08adNWRBfaErspfbRuHdybFDg5n3joh5OieQcPYwJk/Onvd1IK0c8XilmMvSsq1WbFlJ47P
        Vho9vjN9aoUs9lPS1P4VQa8Sp1Xyiw/J5lumD3Wc80R1Umtpu3nlxrhs/geWuGZzfKyurWjb
        hoi5RzSmzxdLm5+vkYkFyt1EDeUXvRvP9cbN2/TEoXk7Z88Fq6RPMmwxX74yYk67vzds2aKZ
        s7bHy84rl3+uWjLS4WmNU7aP1T517f8R78H8Cd0GfbZMLFV8K2huOijFuTR5zEKBlpP/BTsH
        R0AsAwAA
X-CMS-MailID: 20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063318epcas5p2a395fc5da7576c3a53b6a55e3cc87911@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DT schema for s5p-mfc with a new compatible
string for mfcv12 variant.

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 7cd26d4acbe4..a806489a9edd 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -23,6 +23,7 @@ properties:
       - samsung,mfc-v8                  # Exynos5800
       - samsung,exynos5433-mfc          # Exynos5433
       - samsung,mfc-v10                 # Exynos7880
+      - samsung,fsd-mfc                 # Tesla FSD
 
   reg:
     maxItems: 1
-- 
2.17.1

