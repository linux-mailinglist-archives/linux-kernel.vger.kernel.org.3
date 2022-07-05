Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E5566A3E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGELw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiGELwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0D17A87
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:37 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220705115236epoutp02ce2b251ba5a9a57e7c37f9ed36b09643~_7LCipOrL1300313003epoutp02i
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220705115236epoutp02ce2b251ba5a9a57e7c37f9ed36b09643~_7LCipOrL1300313003epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021956;
        bh=DWwnnQcx4d9JzdomPQPFY86iDA6jDBXhkNhPD2lramg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WXgxDxzGSkU/Q1Z3PNRgpMkIJDpt86c+i9Y2lxKeGVj2DXjXAI17eoJUAWr6LGK56
         pdUQ3W4xU08ovy8wbVWMfoTR1CYfJGPZBfu1PT9zLIm2ywZIOEvKX8gok+ANmy9PPo
         J8W9YIjPwBcEYKisM/47nus9TqA99Z67EvoMkEIE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220705115235epcas5p42795c9bb5cc6c12018e9483c12e53c33~_7LBwXedI1026910269epcas5p4U;
        Tue,  5 Jul 2022 11:52:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lcgym4BKvz4x9Q2; Tue,  5 Jul
        2022 11:52:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.00.09566.00624C26; Tue,  5 Jul 2022 20:52:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220705115059epcas5p1be01205050de84e0eb9e1bf0c8ef69ae~_7Joz0fQH1655616556epcas5p1v;
        Tue,  5 Jul 2022 11:50:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705115059epsmtrp1900700da904f5ac258811acb26279dc9~_7Joyh0_32804028040epsmtrp1e;
        Tue,  5 Jul 2022 11:50:59 +0000 (GMT)
X-AuditID: b6c32a4a-b8dff7000000255e-61-62c4260070d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.52.08802.3A524C26; Tue,  5 Jul 2022 20:50:59 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705115056epsmtip1a72d7b894d8c3d6962e51bed14455c0c~_7JlzlQUH1239212392epsmtip1K;
        Tue,  5 Jul 2022 11:50:56 +0000 (GMT)
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
In-Reply-To: <a5b6a8e8-929b-91ef-c07c-69ed31174121@linaro.org>
Subject: RE: [PATCH 18/20] media: s5p-mfc: Correction in register read and
 write for H264
Date:   Tue, 5 Jul 2022 17:20:54 +0530
Message-ID: <01ea01d89065$7e879120$7b96b360$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwK3wPU0AVXBK+ECh8IepaxgkD1Q
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVRTZRjv3b27G5xGVz4Or3QyzlXsQIGMtnXxOOUQ4T1oHQqRTp0ODrgO
        DmOb+8i0UjBZiqBC5onJRwpBziUxNgQEFRohw4+Ir9PRwYARAlnEzA/SbONC8d/v9zy/53mf
        3/Oeh4v4fsUJ4mbJNbRKLpERmDfa+EPoS+HPrLWmRRp+X0U6KhoxsurhJIscqXKhZEeDhUOa
        +08hZG3XFTZZab3BJi+0j6Fk/R13trfUjpKTlecBOaUfxsi2GbfYND7IJkenU8i+ljKMLPze
        wia/s9o55DdDvSyyxvSYRZ6x3OOQ+W1WDnlQZ2XFBFLGCiOgmuzVgBqqnkOoZr2dQ1W1TrEo
        k+EwRt0ebMWohur9VH7nPEodNRsA9c+Bcg5VYB3CKJdpFWX7y8VJ9Hkve0MmLcmgVcG0PF2R
        kSWXioktSamvpwpFkfxwfjT5GhEsl+TQYiJua2J4fJbMvQEi+EOJTOsOJUrUamLdxg0qhVZD
        B2cq1BoxQSszZEqBMkItyVFr5dIIOa1Zz4+MjBK6hTuyM80HTgOl0fuj41M6NBdMcguAFxfi
        Ami5+QVaALy5vvhFAHWHnwCGzAFobBjhMMQF4JFCB1gqmb5RxmISLQBWF9oxhkwCeL+oCfOo
        MDwCTlur2J6EP94JoMM8ingIgj9A4MRl54LKC98Ijw44UQ/2w9+HeZ9PIB6M4mtgpfH0QpyH
        R8OndU42g1fA7lJGj+Avwgt3yxBmpmD4aKKGzcQD4VSnlePB/ng8HBgeXzABcZsXrHbY3ITr
        JnFwtoViav3gdJeZw+AgOHVMt4ilcMT12aJnJSzPNbMYvAle6S9DPW0QPBTWtaxjwi/AL23n
        WcwIPrDob+einAebKpYwAc9cu7rYHsKBuxb2cUDolznTL3OmX+ZG//9rXwPUAFbSSnWOlFYL
        lVFyevd/X56uyDGBhRMJS2gCo47ZiA7A4oIOALkI4c8zlLSn+fIyJHv20ipFqkoro9UdQOhe
        dzESFJCucN+YXJPKF0RHCkQikSD6VRGfCOQlDJjSfHGpRENn07SSVi3VsbheQbks7XhKnKKk
        TtyTy27r7OJX7Yh4Z96QHR5a7mfXxQu1sYb8mzLFL3MtB2/NDn9cQta+sqJgb9iJzpPRGx72
        hCQ8/9PPjmLst8fE1tZPXdd58j82x0T5bPk1LnPXuTWBM3lPOmayd/WdOnb/qX02pDv29p0e
        5/Z2W/KhbXsu17+bJE5uTEivtEz2hfccgoHd8ft2Yu1BGcWi+rNzR6QVb8c0V35ya58k5Fzh
        fvUmc/IHqm3iQQF7eqWjuUjqymOjf5awYnXlg28itW/t7jU2lSZsd75RLhUWN9QG3NvJr+hP
        OnH25KWrP8aFbR57NuDBo9HVbZdqxq7PhyjWote+fe7llChbd97F9QSqzpTwwxCVWvIv534R
        fasEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1CMURjHnXffWzuWt1o6JWLLB5WUwRzXYaaa1wxh5FKM7NY7Fd3sijRF
        USEpgzTtRrKpsbOk3U0hl9ZmyySapJm1i3WZbHIrNe5pW2b69jvP7//8z/lwaJ5LNuFBxyft
        5qRJ4gQRycev3RNNm62caZAEmgvmopfnrpFI+a0HQy+UAzjSa+sopHui4KFq410ClRvaCVTf
        9ApHte9GbEepBUc95VcAssmfk+jW+5Gw5vVTAll7N6HOG2UkKrhaR6DLBguFLnZ3YKhK8wtD
        F+q+Uij3loFCOXkGbLkbqz6nBmyDpRKw3ZX9PPa63EKxykYbxmpUR0nW/LSRZLWVB9jc5h84
        W6hTAfbPwbMUm2/oJtkBzTT2weAAtXZCJH9JDJcQv4eTzlm2nR+nO1gBUtT8tBO2PDwL9ND5
        wImGzDzY216G5QM+7cI0AHiqWEU4BISXfp4EDnaFl/70UI7Q25FQiZm0C5IJgL0GJWEXQqYV
        wKK2nNEDjzmGw+ze3H+9fQBqH+kw+4oTswwWdr3B7ezKRMAyuWL0PpzxgeXqitG5gFkIh2ve
        EA52hq2ljjyP8YPHrbnAwV6w/kMZz/G+6fD72yrCMXeDtmYDZWchEwq7nr+mTgBX+Zgq+Zgq
        +Zgq+Zj18wBXAXcuRZYYmygLSpmbxO0NkIkTZalJsQHRyYkaMPpLfH0bQKPqc4AeYDTQA0jz
        REKB6mSTxEUQI96XzkmTo6SpCZxMD6bQuMhN8Di/NcqFiRXv5nZyXAon/W8x2skjC6sdXhNX
        M3Sa7kQTZv2WVppW+XNZq+d0WUK8pNqaZxnrcj59sO1teWASmOPqCf/JqUMFZxrTmz3VW8cH
        Tt2zY+K4hAWnzIOPs5+EmiN80kIlbT8qDgd5fzvNWP3phXzhnYzNRb6k0EO8sTi0qmXe2kne
        1lnRi7ROD4/0z9w2PTInuHB93jNJODI6e1VLXtwsuNy9389nV1Pglj5V5PxjR1cMq8NE9w8p
        9EvTZiTH3/euNYZUWNs/DgSrF5tLo29vMun1iz+WRG9wHyqigk1dgwpF3/EQo7tRZ/Ts/IK8
        MrdXh3vGrjQF3nQ70tIm2BiGPxI/jJDoIoM6Vpb47/PIjDHJRLgsThzky5PKxH8B0PO5JZQD
        AAA=
X-CMS-MailID: 20220705115059epcas5p1be01205050de84e0eb9e1bf0c8ef69ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125652epcas5p31abe2138fbff6218c9031da714bfb448
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125652epcas5p31abe2138fbff6218c9031da714bfb448@epcas5p3.samsung.com>
        <20220517125548.14746-19-smitha.t@samsung.com>
        <a5b6a8e8-929b-91ef-c07c-69ed31174121@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
> Subject: Re: [PATCH 18/20] media: s5p-mfc: Correction in register read and
> write for H264
> 
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > Few of the H264 encoder registers written were not getting reflected
> > since the read values was not stored and getting overwritten.
> 
> This looks like a bugfix so:
> 1. Send it separately please.
> 2. Add Fixes tag.
> 3. Add Cc stable tag.
> 
> 
> Best regards,
> Krzysztof

Ok I will send it separately and remove it from this series.

Regards,
Smitha


