Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53F4B2261
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiBKJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:45:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiBKJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:45:27 -0500
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 01:45:25 PST
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258D91092
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:45:24 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220211093659epoutp010b5619a2f59ea0e233a116c2df4dc1ea~Ssbh6nGfA1809918099epoutp01J
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220211093659epoutp010b5619a2f59ea0e233a116c2df4dc1ea~Ssbh6nGfA1809918099epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644572219;
        bh=fFD6K75pV0FoAeiQKIrWAZBJ447zH2tIfbwBG9t0c0Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tYueUmDAJr56I7Sqr2HdyYvxVAts3nT9VDRWQJUKGLckvgG7X8ABC8vAijcXfUTVF
         Ztb1CPBFjrc0opR0TUG8S7Rt24WR802TAHFNKh4Z7pEp6XafgGoc/RIhX4+3Zy2KqU
         Eawj4W6T/uPAc6ZLbp7jJEat4yPVDT6fy9sZl79A=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220211093658epcas5p2e91920ad986e5a6b1e575f509e5ffa0b~SsbhFV3Ka1874218742epcas5p2M;
        Fri, 11 Feb 2022 09:36:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.AA.05590.A3E26026; Fri, 11 Feb 2022 18:36:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996~SsZzX9feb1760017600epcas5p24;
        Fri, 11 Feb 2022 09:35:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220211093501epsmtrp223638b2014a9b01907bb0573daa04c6f~SsZzXQHna3227732277epsmtrp2Q;
        Fri, 11 Feb 2022 09:35:01 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-e5-62062e3a8c69
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.0D.29871.4CD26026; Fri, 11 Feb 2022 18:35:00 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220211093459epsmtip1c03f8c05ca96a33e12e3731916a032b5~SsZyOR_141656616566epsmtip1K;
        Fri, 11 Feb 2022 09:34:59 +0000 (GMT)
From:   Onkarnath <onkarnath.1@samsung.com>
To:     robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, maninder1.s@samsung.com,
        v.narang@samsung.com, maennich@google.com,
        Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH 1/1] android-recommended.config: change
 BACKLIGHT_LCD_SUPPORT to LCD_CLASS_DEVICE
Date:   Fri, 11 Feb 2022 15:04:44 +0530
Message-Id: <20220211093444.661285-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmhq6VHluSwZ4X6haXd81hs/i29w27
        xeH5bSwWK3o+sFr837OD3eLQybmMDmweCzaVemxa1cnm0bdlFaPH501yASxRXDYpqTmZZalF
        +nYJXBl/Tz5jLDjCUXHv2EXGBsZd7F2MnBwSAiYSL/+eArK5OIQEdjNKHPyxghHC+cQo8aZ3
        GlTmG6PEs2MTmWBaZu0BsUESexklHu9bxAzhfGGU2PT6EwtIFZuApsSf5U/BlogICEsc+dYG
        NpdZoJdRovnIAbCEsECyxM9nPWANLAKqEh82vgCaxMHBK2ArsWcDM8Q2eYmZl76DlfMKCEqc
        nPkErJwZKN68dTZUzT52iX27TSBsF4kfu/qgLhWWeHV8C9SjUhKf3+1lg7CrJaZvvA12tIRA
        C9CfO1dBFdlLPLm4kBXkBmagB9bv0ocIy0pMPbWOCWIvn0Tv7ydQ83kldsyDsVUlfk2ZygJh
        S0vc/z0XapeHxKqTU8BGCgnESnQdYp/AKD8LyTezkHwzC2HxAkbmVYySqQXFuempxaYFxnmp
        5XrFibnFpXnpesn5uZsYwSlEy3sH46MHH/QOMTJxMB5ilOBgVhLhXXGDNUmINyWxsiq1KD++
        qDQntfgQozQHi5I476n0DYlCAumJJanZqakFqUUwWSYOTqkGJq4g+W0fTpl0Ky7f0ZmeyqZ2
        zv/DN50DM87xv7kR3Vln80M5rD9aYNrE4MWx0xYV3Sj7xPyLxUkv+CbfhMYZN2NSlPYvdZho
        fDlM/3l677kNNab7Yll8Vk/g7XNI5ZIK84yfV7VpR5vzuc+ZoadKs6Nfhi7XYnxeYrcs1PJV
        7iNFvp+bzh3kOHv66/4XsRYfVlZKfTAJEuLw2O3Hur1K11JlTcRUuev6rPlJ06pny9Zm7G5N
        aMhLdPmvNMVMyYpV5Uyn9b880fwX8h9lG5K+ugX+vZ/ReJB1xoVzs287FMdx3iqbOzF/w/yE
        1OrDn3dvniI410z+Vt3qk4EPj92fpLB4c0CENR/bhvnuP3a0K7EUZyQaajEXFScCANc6lAmQ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnO4RXbYkg0nHbSwu75rDZvFt7xt2
        i8Pz21gsVvR8YLX4v2cHu8Whk3MZHdg8Fmwq9di0qpPNo2/LKkaPz5vkAliiuGxSUnMyy1KL
        9O0SuDL+nnzGWHCEo+LesYuMDYy72LsYOTkkBEwkZu2ZyNTFyMUhJLCbUWJP03dmiIS0xKfL
        c6CKhCVW/nvODlH0iVHi0vT1YAk2AU2JP8ufgtkiQEVHvrUxghQxC0xklNi0ci1YQlggUeLl
        5l9sIDaLgKrEh40vgDZwcPAK2Ers2QC1TF5i5qXvYOW8AoISJ2c+YQGxmYHizVtnM09g5JuF
        JDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzggNTS3MG4fdUHvUOMTByM
        hxglOJiVRHhX3GBNEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyW
        iYNTqoFpu0ysbEqkxDITya7sqm/u36b+ePCn4smZOybq1S/msfnOvbR/184L5efapqnWrHVz
        /mvy6seRjWs6TkrMnLfkyNQOLZO9PVcvLPKKNFLcp/EzdFPko7Lwi5k1h3j/5oTIb5nu4phg
        E+n9OLZZljth/+/sHVk3cg8v4knZ+8HPNLggx3DhN+G6skNiXfJ5KqFtv6R4Ig0uafCdnHTw
        1hqpwHu8VbddI3Yw3jMJtGj9f/bHw3OtFW+X8q5uOrFa46ZCu+kt2eBmmTZtveBjnys0vDuj
        bkcv4/X6uEtoprzku8M9TxYx6Sncn3jsSJn9WoXvJ0Scdneo3ufSc9KdnBrO/CewK7JR2n3K
        ddPYhVVKLMUZiYZazEXFiQCesIl4twIAAA==
X-CMS-MailID: 20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996
References: <CGME20220211093501epcas5p236bca7c55627ef90c7518a34acf6e996@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with commit '8c5dc8d9f19c ("video: backlight: Remove useless
BACKLIGHT_LCD_SUPPORT kernel symbol")'code of BACKLIGHT_LCD_SUPPORT
is removed from kernel, and control shifted to LCD_CLASS_DEVICE only
thus updating android recommended config also.

Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
 kernel/configs/android-recommended.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index eb0029c9a6a6..0869095ff345 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
@@ -86,6 +85,7 @@ CONFIG_JOYSTICK_XPAD_FF=y
 CONFIG_JOYSTICK_XPAD_LEDS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KSM=y
+CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LOGIG940_FF=y
 CONFIG_LOGIRUMBLEPAD2_FF=y
 CONFIG_LOGITECH_FF=y
-- 
2.17.1

