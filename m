Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9890447EC36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbhLXGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:44:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42974 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbhLXGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:44:43 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211224064440epoutp03f7636f55f6523aca37fd0f8cf3d98f39~DneFxODsk2267522675epoutp03o
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 06:44:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211224064440epoutp03f7636f55f6523aca37fd0f8cf3d98f39~DneFxODsk2267522675epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640328280;
        bh=Q65SdoUxVF82yqKEiz3o/mcQDWD7Y0oAKClGnD10t4s=;
        h=To:Cc:From:Subject:Date:References:From;
        b=TBPPJ9Zf6jepxEoTaoYwrQQ6lGbAhJRA4C295q1s66cwcRuBBLWzOXV7B4Mv+VGD7
         GPxrrR7mVbsPro7fz8ex+swJBNZnOrHtu/+E/oCrqjUvVzw8qHNOHpo0HE06LN4yIo
         0T7rLXXux20fFw+WRPcv2fgx3N0TfpWJksZ+zCJM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211224064440epcas1p20b65f9be32d7b814fb28b74d24cde42d~DneFcDOk_0369603696epcas1p23;
        Fri, 24 Dec 2021 06:44:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JKyGV2b7xz4x9Q7; Fri, 24 Dec
        2021 06:44:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.24.28648.D4C65C16; Fri, 24 Dec 2021 15:44:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211224064428epcas1p40282064859748cd6735279bb7274a753~Dnd6p8RvA2512325123epcas1p4N;
        Fri, 24 Dec 2021 06:44:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211224064428epsmtrp24173e6cfc5022e9a55cc9d49ed883914~Dnd6pI2mS2975829758epsmtrp2-;
        Fri, 24 Dec 2021 06:44:28 +0000 (GMT)
X-AuditID: b6c32a39-813e6a8000006fe8-d9-61c56c4d7af9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.56.29871.C4C65C16; Fri, 24 Dec 2021 15:44:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211224064428epsmtip1e41359287ede42cba7bbda827b722868~Dnd6bCW0X1524715247epsmtip1d;
        Fri, 24 Dec 2021 06:44:28 +0000 (GMT)
To:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] devfreq next for v5.17
Organization: Samsung Electronics
Message-ID: <09ff8415-0ebb-c8f2-026b-65af27f58f44@samsung.com>
Date:   Fri, 24 Dec 2021 16:07:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvq5vztFEg0PfBC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8eLy
        ddaCa3wVM6ZfYm5g/MfdxcjBISFgInFkckwXIxeHkMAORokjH2YyQTifGCWu/vzGDOF8Y5R4
        tbWDsYuRE6xj49ezjBCJvYwSV67tgKp6zygxff1CNpC5IgL2Eh0fMkHizAIXmCSOPtjIBtLN
        JqAlsf/FDTBbGMhetmQOmM0voChx9cdjsA28AnYS9x5NZAaxWQRUJfp/N4LZogJhEie3tUDV
        CEqcnPmEBcRmFhCXuPVkPhOELS+x/e0cZohLf7JLrDjsB2G7SNz5d54JwhaWeHV8CzuELSXx
        +d1eNpBDJQSWMUr8mtzJBOGsZ5R4OasTapKxxP6lk5lAPmMW0JRYv0sfIqwosfP3XEaIxXwS
        7772sEIClVeio00IokRZ4vKDu1B7JSUWt3eyQdgeElvavzFNYFScheSdWUjemYXknVkIixcw
        sqxiFEstKM5NTy02LDCFx3Zyfu4mRnDq1LLcwTj97Qe9Q4xMHIyHGCU4mJVEeD1XHUkU4k1J
        rKxKLcqPLyrNSS0+xGgKDOCJzFKiyfnA5J1XEm9oYmlgYmZkbGJhaGaoJM773H96opBAemJJ
        anZqakFqEUwfEwenVAPTqlcOL1VineWepB/iPvf5k/fPbcIl7qsfrJnlfWllwoMcrlBG/337
        px9d/jFmi910lwxOXQsv9ncnXPqZL/5qlkuc8L5c7vxCH8PYH5NVHSu/vFYoWy4nWcv1612j
        v9mE/2Gn3B73xlzkZLWqvml/s/6R+t4ClTZHU87nbv7iux8s59T7MPem/pz6a6+3/WCavUCL
        o53xy8Gcz/waO1mubbUJM5uzc3vmd2mmhhlHXiR+Zz/O2VQoJbBu/v67H/zXiJ2bxNZzcc5Z
        NZvaD7VyD9Y2uvh6Ge74Uvx8KY+MnOHbGzLrgm7m9GzyW3AhwUdeuIPv1NqFuzdvzvh82DI9
        dqGawHquogXCfte3TspersRSnJFoqMVcVJwIAF2WdPUmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK5PztFEgwfvzS0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFmdOX2J1YPfYtKqTzWPL1XYWj74tqxg9Pm+SC2CJ4rJJ
        Sc3JLEst0rdL4Mp4cfk6a8E1vooZ0y8xNzD+4+5i5OSQEDCR2Pj1LGMXIxeHkMBuRokLjw+y
        QSQkJaZdPMrcxcgBZAtLHD5cDFHzllHi+OUvYHERAXuJjg+ZIOXMApeYJN6fZQWx2QS0JPa/
        uAE2RhjIXrZkDpjNL6AocfXHY0YQm1fATuLeo4nMIDaLgKpE/+9GMFtUIExi55LHTBA1ghIn
        Zz5hgZivLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs5C0jILScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhgmJdarlecmFtcmpeul5yfu4kRHBFamjsYt6/6oHeIkYmD8RCjBAezkgiv56ojiUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwret7sav3xert
        sX7F0+48bl58WvX9O+EI/TeO0y7dYrYSqfr8UXsC33ZzNp85vV0zf7lNOfm08uCmpmeF0z37
        JS+JGzVsszyQuj6O9bT1pT9LRF52p6ydcW5x5etFcSu5j0wXPB/nyHng6vRPN5QWHU4XWsbw
        Zcf6CMUVq+svHc0sKsrrFfWveWR8l7tU5HIhY7OL4uEDKx6/U5bZdqzwvcPjy1srV9zuVjqc
        Ksy+yVF29YmVmz+X7P/mfjbDjM0+sFhKJUfc8d+tlETLzKpb7o8slRfVnT+W47ZH7sAsL7X0
        3InO9zrry1hXvY/y27zVQFpC86/klXlX3HbfTIt+9qjiLWPijtBdlvN4pLW3WSqxFGckGmox
        FxUnAgBxlh4Z9wIAAA==
X-CMS-MailID: 20211224064428epcas1p40282064859748cd6735279bb7274a753
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211224064428epcas1p40282064859748cd6735279bb7274a753
References: <CGME20211224064428epcas1p40282064859748cd6735279bb7274a753@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v5.17-rc1. I add detailed description of
this pull request on the following tag. Please pull devfreq with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.17

for you to fetch changes up to 4667431419e93b63b4edfe7abdfc96cefcbcc051:

  PM / devfreq: Reduce log severity for informative message (2021-12-16 11:29:54 +0900)

----------------------------------------------------------------
Update devfreq next for v5.17

Detailed description for this pull request:
1. Add new DRAM controller driver for sunXi SoCs
- Add DRAM frequency controller devfreq driver for Allwinner sunXi SoCs
in order to support dynamic frequency scaling of DRAM frequency. It
calculates the supported frequency list from source clock in the range
of full speed to quarter speed instead of devicetree.

- Add COMMON_CLK dependency to fix build error

2. Reduce log severity for informative message about frequency transition fail
----------------------------------------------------------------

Arnd Bergmann (1):
      PM / devfreq: sun8i: addd COMMON_CLK dependency

Samuel Holland (1):
      PM / devfreq: Add a driver for the sun8i/sun50i MBUS

Tzung-Bi Shih (1):
      PM / devfreq: Reduce log severity for informative message

 drivers/devfreq/Kconfig          |   9 +
 drivers/devfreq/Makefile         |   1 +
 drivers/devfreq/devfreq.c        |   4 +-
 drivers/devfreq/sun8i-a33-mbus.c | 511 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 523 insertions(+), 2 deletions(-)
 create mode 100644 drivers/devfreq/sun8i-a33-mbus.c
