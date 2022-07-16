Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B6576C8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGPIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGPIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:17:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25A2B1BC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:17:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220716081738epoutp030cd7525a920b2312399521c7081411ae~CQVfF1K_p1856018560epoutp03t
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220716081738epoutp030cd7525a920b2312399521c7081411ae~CQVfF1K_p1856018560epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657959458;
        bh=YbtmWAQttKWyKsaH/PRmfTFaX/+xfLODvAEqAlXazk0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SSSYvy5uYsZ1/iF4LX9ZkTu3XpMD9wHH4laUznRHErrMp5f7G8pBWdaNbMrMQuHry
         g/jK52EVn9qyEu+a6SAFsUeIYNnCu7dm/c8+YOxfDoGtYZGH183qX4BWk7mXVDnigF
         8nj/4Jm8c7eQ3KrhsTf8MJ8b+VoyMXJOmIvmIcJM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220716081737epcas2p14b9444641e87705850b82ed1f0bde8e2~CQVe1Lu631119211192epcas2p1K;
        Sat, 16 Jul 2022 08:17:37 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LlLgj2xt0z4x9Px; Sat, 16 Jul
        2022 08:17:37 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.D5.09650.12472D26; Sat, 16 Jul 2022 17:17:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf~CQVd2O1O-3136731367epcas2p3q;
        Sat, 16 Jul 2022 08:17:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220716081736epsmtrp15f8c8e54330152542ebe72956590543d~CQVd1bCLd1145911459epsmtrp10;
        Sat, 16 Jul 2022 08:17:36 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-e0-62d274214053
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.71.08905.02472D26; Sat, 16 Jul 2022 17:17:36 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220716081736epsmtip15700a69fbf6e5e8e578bbafb94e9a81a~CQVdklF4R1154611546epsmtip1C;
        Sat, 16 Jul 2022 08:17:36 +0000 (GMT)
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        hosung0.kim@samsung.com, d7271.choe@samsung.com,
        Youngmin Nam <youngmin.nam@samsung.com>
Subject: [PATCH] Makefile.extrawarn: add -Wformat-insufficient-args for
 clang build
Date:   Sat, 16 Jul 2022 17:45:32 +0900
Message-Id: <20220716084532.2324050-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTVFex5FKSwYW/ohbX9k5kt/h6/RG7
        xZ9dO5gsLu+aw2bx8MENVouFZ6ItPkz4z2Sx+MAndgcOjwWbSj02repk87jbZuPRt2UVo8fn
        TXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        hygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjPWPHjAWPCKo2LqmhnsDYyX2LsYOTkkBEwk9n2/yQRiCwnsYJT4djeqi5ELyP7EKLH4
        wwp2COcbo0TL6lWsMB3Tty9ihUjsBeroOwjlfGWUWHemnRmkik1AV2LbiX+MILaIgJfEtTmf
        GUGKmAXmMEpMf/AdLCEsECpx+usHsAYWAVWJBSdugNm8AvYSHzoeAR3FAbROXuLPKwGIsKDE
        yZlPWEBsZqBw89bZzCAzJQQusUvs62+BeshFom/lBiYIW1ji1fEtUHEpiZf9bVB2scSTs0sZ
        IZobGCV2L37NApEwlpj1rJ0RZDGzgKbE+l36EDcoSxy5BbWXT6Lj8F92iDCvREebEESjmsSv
        KRsYIWwZoIErmCFsD4lZZ16xQ4I3VuL6tTPsExjlZyH5ZhaSb2Yh7F3AyLyKUSy1oDg3PbXY
        qMAIHqnJ+bmbGMFpUcttB+OUtx/0DjEycTAeYpTgYFYS4e0+dC5JiDclsbIqtSg/vqg0J7X4
        EKMpMHgnMkuJJucDE3NeSbyhiaWBiZmZobmRqYG5kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5O
        qQamq+qt26/W107wbrx6arfMjcmfzil1lyWbr1qTNelPUEfHli4FX/0tG+sWh+S9mPb64/OP
        wS2vbI8e5u71yc51nSMgqOV6Rmfd2UW/ZzSserniyRf7x3e2ZOSnbJb+MvO9wvlrtWn5l3N7
        zd3t5J37X/1NFjAVE/1wPFrKNvbQv91vH0rlcbZwLjwgacxstsjNo/nSlINrhZ4u4djWd+SO
        sbuZ32cJV4ZNkkmC36tqIkQqzt65XFHtnWn7N5y3Y0v24g/vYkVnvvGQz7vTMfvsopiLc/1W
        toqqiC9If3T8xKbDHRdYA2OWL7q1r958zyaW68py/unrVli6vPSqKWG6a6YpZtW/wZRR1eip
        yRZpJZbijERDLeai4kQAAmA3rhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnK5CyaUkg+s3lCyu7Z3IbvH1+iN2
        iz+7djBZXN41h83i4YMbrBYLz0RbfJjwn8li8YFP7A4cHgs2lXpsWtXJ5nG3zcajb8sqRo/P
        m+QCWKO4bFJSczLLUov07RK4MtY8eMBY8IqjYuqaGewNjJfYuxg5OSQETCSmb1/E2sXIxSEk
        sJtR4tbu9cwQCRmJ2ysvs0LYwhL3W45AFX1mlLgyeSJYEZuArsS2E/8YQWwRAT+J/mfTwYqY
        BRYwSmy8cRosISwQLLHk904WEJtFQFViwYkbYM28AvYSHzoeMXUxcgBtkJf480oAIiwocXLm
        E7ByZqBw89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
        VLU0dzBuX/VB7xAjEwfjIUYJDmYlEd7uQ+eShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZ
        LySQnliSmp2aWpBaBJNl4uCUamASda1kfpxS5V9ecMBIcWtOzum2R868k/2nmj63nXonq4Wt
        o/SZ8wFvU478wgWKKpd6zdL1VyxdfDzywLaN4ivXyk+T/LDxUm1ftZv7uq1mrsJ2izgVDrzb
        uvqW0cyub4ovQ198cnC//r9xJ1Nx6t8rx3MfvZ1z7mDtJ4PbDOuPySQtvOGu8cbSyajldanF
        B/U1hiuOxc26mVKy9iTL7J1xQg9mfy3TNvJ8k19x6WSws2J4ae0u4U/Tp4TuWbX1pYozo21N
        POOvW//v/jTL+LP7xFFuaaebwV943taEHVmZ62vQGrbmc7VgoqbYbsUQsew5mjcrpl3lDcme
        3ljSpnfB+8XHy7uKuzmEpt8S+79KiaU4I9FQi7moOBEAGM/T38QCAAA=
X-CMS-MailID: 20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf
References: <CGME20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -Wformat-insufficient-args for clang is useful to detect the situation
when the total number is unmatched between format specifiers and arguments.

Originally, this option is enabled by default(Link[1]), but it is disabled by
-Wno-format explicitly so that we can't detect this unmatched situation.

We can enable it by adding this option after -Wno-format.

Link[1]: https://releases.llvm.org/13.0.0/tools/clang/docs/DiagnosticsReference.html#wformat-insufficient-args
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index f5f0d6f09053..c23d7c286bad 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -48,6 +48,7 @@ else
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
 KBUILD_CFLAGS += -Wno-format
+KBUILD_CFLAGS += -Wformat-insufficient-args
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-format-zero-length
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
-- 
2.34.0

