Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE05AFCA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiIGGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiIGGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:38:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07829D648
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:38:33 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220907063742epoutp011aeda4aebf0fae37fe83018a5bfa8e73~SgKXqDbiR0537105371epoutp01S
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220907063742epoutp011aeda4aebf0fae37fe83018a5bfa8e73~SgKXqDbiR0537105371epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532662;
        bh=6yt+N8iPUl32rFmi5+XKgUtEt+N0VugFgBaNsDXRf74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pf0D1gs8A0X5SbJOb209ZgVBSsSD6NpNMJ/LjdpVS27InEY1uEeUVzxd8HP2EZBz6
         AAuTiQd+w17XKgZi7qynoo+RZq8OPSo/jYzFvCxWHFDijwhW5f97w3bwgnk0C7vvdp
         j/xl1CZ2pNPe9kyM9xJG1f17Oc17rrVQMszL9aiw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220907063741epcas5p4ce243879838344c3f41682998be86456~SgKW_gts-0714407144epcas5p4f;
        Wed,  7 Sep 2022 06:37:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MMsxt21gRz4x9Q3; Wed,  7 Sep
        2022 06:37:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.21.54060.23C38136; Wed,  7 Sep 2022 15:37:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09~SgHVEePVl1696316963epcas5p3h;
        Wed,  7 Sep 2022 06:34:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220907063413epsmtrp294ad38d744af8ff7c1c0f6c50c4eaf61~SgHVDOqV-1916619166epsmtrp2i;
        Wed,  7 Sep 2022 06:34:13 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-64-63183c32e320
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.EC.14392.56B38136; Wed,  7 Sep 2022 15:34:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063408epsmtip15547283937c1689104357106ff63f807~SgHQiWsxF2482924829epsmtip16;
        Wed,  7 Sep 2022 06:34:08 +0000 (GMT)
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
Subject: [Patch v2 15/15] arm64: dts: fsd: Add MFC related DT enteries
Date:   Wed,  7 Sep 2022 12:17:15 +0530
Message-Id: <20220907064715.55778-16-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGc27b28JSvCsgB7bxcZN9yASptOWgICQYdjc2wjTZ4kxkN+0N
        MEpb2yLqYkABYQgTooKAIqM4GV+D2kJ1sAF2QhxhIWBhjiJfg4HOddYRgY2tpbD995zn/N7z
        nPOec3gswRTux0tTaBm1gpaTuDu7486ON0J2R0Fp2PSCO/rFVMlBUzUdONI9X8DQQ52djfpu
        GrnIMFrNQjf6ezjomnmIgzp7Z9io/VfH7HCllY0WrrUCtFg1iSP9rIWDppc+RCO3r+CouM3I
        QS1mKxddHxvG0Jf6vzBUZ3zGRfndZi6ydnUAlHfWjMVCqrmmGVAmaz2gxuqfsqhbVVYupeta
        xCh942c4NWHpwqmb9dlU/verbOpzQyOg1s9c5VJF5jGcsuv9qXt/2rlJHh+lR6UytIxRBzIK
        qVKWpkiJJhMOJscliyVhwhBhJIogAxV0BhNN7n83KSQ+Te5oAxl4jJZnOqwkWqMhd+2LUisz
        tUxgqlKjjSYZlUyuEqlCNXSGJlOREqpgtHuEYWG7xQ7w4/TU7uoklZ5//LTuLp4Dxt2LgBsP
        EiL4x+R1rAi48wTENwC2D9jYrsFTAB+Pf4c5KQGxDODdptitipn6cY4L6gawbHJhszwXgzOj
        RVwnhRM74fLvP+BO7UWcBnC2UOuEWEQuG1oH1zYgTyIeFs7+CJyaTbwKa01rLKfmE3ugubID
        d8UFwKa2ng3fzeEPXxzYiIZEgRucn5pguaD9sMLSAlzaEy71G7gu7QftT7o3F0qBD+25m4wK
        Xs0xYC4dA3tGrzgOzXPsbgf8+vYul/0KvHSvdQNhER6wZG1uE+dDU82WJmHd4MBmFIT3fzNy
        XJqC3463466ulABoaNRhpcC/6v+IWgAagS+j0mSkMBqxKlzBZP13a1Jlhh5sPPXgBBOYmbKF
        9gGMB/oA5LFIL77M5CUV8GX0iZOMWpmszpQzmj4gdjSwjOXnLVU6/opCmywURYaJJBKJKDJc
        IiR9+BffBFIBkUJrmXSGUTHqrTqM5+aXg52y+St8S+n0ZfnyeepcBUPJCuPPaAe3v5e46vvS
        yfcln4yeGzasf2pst8FDbRcqzdkXUtlzpSsHQ8sC1jsviVfmaxtsIyt5DUHeQ8PZI3xlYF2W
        pOcdefHK0cR/SH53zIP7r32xrVLVM/SzTwhPTD5OlgZPHAuXZk17zhBvl9v31pZAy7o85tS2
        Ry15ZK/nC7omwYtxAb7PLbGeOYdHDvx0a3S/8XDwUpIJ1+Gz+6QRY69r9S97UxZQXXHkGe+s
        2+Xc/A98xBknGkQ7C7YHxUUcb9X9ndj/1uyBCL2wc/WJ3w1d8x3J5SNH5/caij3KD/Wen2td
        XwyCD74q8HhUnmCTkGxNKi0MZqk19L8T2faMcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnG6qtUSywfS3EhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJWxd3ZAwSbeisbF
        x9gaGG9wdTFyckgImEg8WnKDtYuRi0NIYDejxJqNLYwQCQmJlb8nQdnCEiv/PWeHKGpkklh1
        t5sNJMEmoCPx7f1pNpCEiEAro8T1lZ1MIA6zwGwWiR+TDrCCVAkLuEl0PD4PNopFQFViwY7f
        zCA2r4CVxJGZ29ggVshLrN5wACzOCRS/OOUEWK+QgKXE4xnb2Ccw8i1gZFjFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iREceVqaOxi3r/qgd4iRiYPxEKMEB7OSCG/KDpFkId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpgillc92qb25UlnQ+rk
        Kq0ir/2NIpy/OqJf9C/VvXgrpPTOChettUdOndxRM+HsP/PGZVPfbHu7+lL/x6Rw4aNnGlX+
        LIvY8S/l98XQJR0vDT+9ccn8e8x0Wtr51bcuP17lX7Qmzbfc4r7n1zqLY7E3/hlujWD63a7t
        03Pj3IL78bNfrxT3EYuSlwx5Y2xzcUZGbO6x14IHnvIeWHpYseLtZoHLGWe3Rh21aeeybE2p
        Pa+wrZrpzXax7Yk3jQKXnT8zqVz/0Y0/LJ8WJdivqp3UmLn73U1t+dsvFdPKJ1pW34xlLTnF
        o7zCMPdw1J2+uOrgm8Z5q+Md1rZwx67cPOdWo2+F//3n516XTG5nEe5KVGIpzkg01GIuKk4E
        AD/hQlwrAwAA
X-CMS-MailID: 20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063413epcas5p3df6d22933ba2884730c52b6a3af2cb09@epcas5p3.samsung.com>
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

Add MFC DT node and reserve memory node for MFC usage.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts |  4 ++++
 arch/arm64/boot/dts/tesla/fsd.dtsi    | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 1db6ddf03f01..17bb048f9d47 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -30,6 +30,10 @@
 	};
 };
 
+&clock_mfc {
+	status = "okay";
+};
+
 &fin_pll {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..bca0ba030ee7 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -340,6 +340,18 @@
 		#clock-cells = <0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mfc_left: region@84000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0 0x84000000 0 0x8000000>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -832,6 +844,16 @@
 			clock-names = "fin_pll", "mct";
 		};
 
+		mfc: mfc@12880000 {
+			compatible = "samsung,fsd-mfc";
+			reg = <0x0 0x12880000 0x0 0x10000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "mfc";
+			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
+			memory-region = <&mfc_left>;
+			status = "okay";
+		};
+
 		ufs: ufs@15120000 {
 			compatible = "tesla,fsd-ufs";
 			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
-- 
2.17.1

