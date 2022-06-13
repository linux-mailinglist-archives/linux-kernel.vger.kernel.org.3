Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435B95492B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357569AbiFML5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356521AbiFMLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:50:39 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BF248E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:54:16 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220613105410epoutp04d42ffd05ad022b8cf415e0ffaeae1317~4KLvyG68w3197731977epoutp04b
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220613105410epoutp04d42ffd05ad022b8cf415e0ffaeae1317~4KLvyG68w3197731977epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655117650;
        bh=+nj5AOzfaDd4gy6kMk2RwizYSlfgTYYWEbpWjFZL4W0=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=bqilPCBvl3BDHlNWdBMvit/mBxawDO6UV12bchT21D8kIKAKtfw2dxZGpXlluaeRk
         RJOJVf2vEkEz5eGvKutkX6MIBeWvzu7jMHVc6g+7A7N6fKu/lK3ZHSxXE4fVPtVeWW
         rTR6hOJ2yrjMRBNkDA/My080ZIDL+r0bq8k/qdE4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220613105410epcas2p1108ba36ef4ae24f4cc588ad62010b71e~4KLvOEt3b0041000410epcas2p1C;
        Mon, 13 Jun 2022 10:54:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LM7jY3gyLz4x9Pv; Mon, 13 Jun
        2022 10:54:09 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.8B.10069.15717A26; Mon, 13 Jun 2022 19:54:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220613105409epcas2p3a0a215c6f61e9e74beb2914008f83d9e~4KLuYcEdN1007910079epcas2p3I;
        Mon, 13 Jun 2022 10:54:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220613105409epsmtrp1cc70d118a4aeb1c7ecde88e20e73a52e~4KLuXxBq50101501015epsmtrp1V;
        Mon, 13 Jun 2022 10:54:09 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-79-62a7175113ba
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.8C.11276.15717A26; Mon, 13 Jun 2022 19:54:09 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220613105409epsmtip241a8f2e96587de027afe33d09c86e90d~4KLuNSBDy0082900829epsmtip2Q;
        Mon, 13 Jun 2022 10:54:09 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-scsi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220613101429.114449-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] scsi: ufs: exynos: constify driver data
Date:   Mon, 13 Jun 2022 19:54:09 +0900
Message-ID: <01a201d87f13$e8a1e5a0$b9e5b0e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHfouchLXpE80q66AS+13OTtn+wNgNPyHnQrSRi/KA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhW6g+PIkgwm7ZSwezNvGZrHoxjYm
        i72vt7JbbHp8jdXi8q45bBYzzu9jsui+voPNYvnxf0wOHB53ru1h85iw6ACjx+Yl9R4fn95i
        8ejbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKB7lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGVf+/2cq2MtUcef2RsYGxhamLkZODgkBE4kTkx+xdTFycQgJ7GCUuPG+
        ix3C+cQo0df+hBHC+cYocWzyW7iWy/8OsUIk9jJKvJx6mwXCecEoMf9wNzNIFZuAvsTLjm1g
        VSIC95gk+q/tBktwCrhKvGy+zwJiCwvYSFxvfcEIYrMIqEp8nn+aFcTmFbCUuPm1iwXCFpQ4
        OfMJmM0sIC+x/e0cZogzFCR+Pl0GVi8iYCXxtesNE0SNiMTszjZmkMUSAjM5JF6dOAHV4CKx
        7thEFghbWOLV8S3sELaUxMv+Nii7WGLprE9MEM0NjBKXt/1ig0gYS8x61g50KQfQBk2J9bv0
        QUwJAWWJI7egbuOT6Dj8lx0izCvR0SYE0agucWD7dKitshLdcz6zQtgeEo/WXmGdwKg4C8mX
        s5B8OQvJN7MQ9i5gZFnFKJZaUJybnlpsVGAIj+7k/NxNjODEquW6g3Hy2w96hxiZOBgPMUpw
        MCuJ8E6+uCxJiDclsbIqtSg/vqg0J7X4EKMpMNwnMkuJJucDU3teSbyhiaWBiZmZobmRqYG5
        kjivV8qGRCGB9MSS1OzU1ILUIpg+Jg5OqQam9rRrulnhqw5wFKpwXLBxuMZfLb2GpSREPebD
        H367pmNsRxi9fvUL/1scbnIyaq3g71D2WpP2vqdMSX/l7M+WqF+av6Hh+pYK1y2vY1iFjq67
        xxQmsea4ycv08yWJz5wMvCzr3P5Pvuap43q+wNRB47eV8eZtj5nyPMRPFi9bz3dy9+Lm0894
        9q+2eMqQoa6v/TW8XK0jIlvjjFRqrhCvwe08lkX7XiUECte/XhmhclHo7Vz/fhEh9rZ/eU+4
        vq/586xt829nj3/nHszO3MmxP+9bxXdza+2Pz6Yne94smqvaO8/zkLj369aKmsMfcjQXfenk
        WnLnIWezlcM5h/MpKZm56Yvv89cXCnvcfK3EUpyRaKjFXFScCABeqLmCNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXjdQfHmSwYbtXBYP5m1js1h0YxuT
        xd7XW9ktNj2+xmpxedccNosZ5/cxWXRf38Fmsfz4PyYHDo871/aweUxYdIDRY/OSeo+PT2+x
        ePRtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGlf//mQr2MlXcub2RsYGxhamLkZNDQsBE4vK/
        Q6xdjFwcQgK7GSX+LWpkg0jISjx7t4MdwhaWuN9yBKroGaPE7xPvwYrYBPQlXnZsA0uICDxh
        krh/7yQbRNU0RolPbYvAdnAKuEq8bL7PAmILC9hIXG99wQhiswioSnyef5oVxOYVsJS4+bWL
        BcIWlDg58wmQzcHBLKAn0bYRrJxZQF5i+9s5zBAXKUj8fLoMrFVEwEria9cbJogaEYnZnW3M
        ExiFZiGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4krQ0
        dzBuX/VB7xAjEwfjIUYJDmYlEd7JF5clCfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkgg
        PbEkNTs1tSC1CCbLxMEp1cA07dr3Kd2NXqa/dBVUlDh8Bd7GpBX8Y3dYz80zVf6C0TKjqLnT
        FnRuO8W8c8byZWJ/VPtlFkQrMhXEOZ3wmGj3XVcrVinzgpKN2/L9l8Qiru7ft193Q63Yi8Oe
        69xeGixodnD6reHVsUQoIG270xdN4WtKvxO3miYFq5d/UwwO3/G2QH2Z1r1IVtGfF8SzdB6t
        2Ojv7pv+z+/Rh3hDNu0DRqxXVkf5nl5oyipy+2p/P6fPH7Wnz+YoXu+vyPp6X6ljC9eFBNaf
        Lqa3z1skmSy1Ktjx2+r2sWbenbPs3CMdrjzc/8/vrQLD/VkfXH+/kCs7zz01ZvLObQuXXXvK
        FrVE2ljrzRS+Q+GlvyYa7r+nxFKckWioxVxUnAgA6POuahMDAAA=
X-CMS-MailID: 20220613105409epcas2p3a0a215c6f61e9e74beb2914008f83d9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220613101459epcas2p3ebbea864e0fe67f083127696028b1d75
References: <CGME20220613101459epcas2p3ebbea864e0fe67f083127696028b1d75@epcas2p3.samsung.com>
        <20220613101429.114449-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] scsi: ufs: exynos: constify driver data
> 
> Constify the drv data because it should not be modified (used by multiple
> devices).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

