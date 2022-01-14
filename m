Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353E848E4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiANHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:15:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34484 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiANHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:15:43 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220114071541epoutp019c2ce0aae43e8f7ca8983c75273fe206~KEcKX_uod1538115381epoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220114071541epoutp019c2ce0aae43e8f7ca8983c75273fe206~KEcKX_uod1538115381epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642144541;
        bh=NVIomeEgODe8tegR8r2U5YGk7C+JtFjkl+aUMxD0IPI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Svb3zGBdMJJWis6XNif3awJC634bmQdgwqs/0Iomgecy8t99FETgAYoJTpcp4Ustk
         qkkPFHpMhFcB1rxoGlqayEAQvEgiZ83jwU8ubAeZxu0Xm7ncB1sUxQqqV5NINjAB0P
         WUvAmxTBmIBQmqGUOK5dyU82L5CywkpYIft+3HB0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220114071540epcas5p1f74592640aa5c2feb56867ece78641bd~KEcJyKq5W0987409874epcas5p1F;
        Fri, 14 Jan 2022 07:15:40 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZsyd2GLzz4x9Qk; Fri, 14 Jan
        2022 07:15:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.1D.05590.91321E16; Fri, 14 Jan 2022 16:15:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220114071536epcas5p454d2a70a38acfbdbce56b7370c0d9306~KEcFm6Rkg2423024230epcas5p4Y;
        Fri, 14 Jan 2022 07:15:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114071536epsmtrp1fd2041e7965000704ae2cb35818cc340~KEcFlDyW_0658106581epsmtrp17;
        Fri, 14 Jan 2022 07:15:36 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-81-61e12319f590
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.24.08738.81321E16; Fri, 14 Jan 2022 16:15:36 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114071532epsmtip1cfbbe1a39227d40a3330e2cdb66e6641~KEcB6wyHO0309503095epsmtip1a;
        Fri, 14 Jan 2022 07:15:32 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Mark Brown'" <broonie@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <olof@lixom.net>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, <linux-spi@vger.kernel.org>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>
In-Reply-To: <YeAiIhfN216pRWhn@sirena.org.uk>
Subject: RE: [PATCH 18/23] spi: s3c64xx: Add spi port configuration for
 Tesla FSD SoC
Date:   Fri, 14 Jan 2022 12:45:30 +0530
Message-ID: <078d01d80916$86a461c0$93ed2540$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgHhERMeAYIU1PAB0s92N6qMD62A
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmhq6k8sNEgwdTOC0Obd7KbjH14RM2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLxo832S1O
        Xf/MZrFo6xd2i9a9R9gtDr9pZ7V4fP0Pm4Ogx5p5axg9ZjX0snlsWtXJ5nHn2h42j81L6j2u
        nGhi9ejbsorR41/TXHaPz5vkAjijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgF5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgV
        J+YWl+al6+WlllgZGhgYmQIVJmRnvDj/jLngCHvFysPnWRoYT7B1MXJySAiYSKy4d4Cli5GL
        Q0hgN6PEriPzWSGcT4wS33bPYodwPjNKrDj5ngmm5eG2x1CJXYwSjbP2sIMkhAReMkr8uhMC
        YrMJ6ErsWNwGtkNEQF3i6KaNrCA2s8BjZolbB3VAbE6gmj8zm8CGCguES/zbcIMFxGYRUJVY
        +3AeWJxXwFLiyLo1LBC2oMTJmU9YIObIS2x/O4cZ4iAFiZ9Pl7FC7HKTWHT5HBNEjbjEy6NH
        wA6VEPjPIXFpFswHLhKn162EBoCwxKvjW9ghbCmJl/1tQDYHkJ0t0bPLGCJcI7F03jEWCNte
        4sCVOSwgJcwCmhLrd+lDrOKT6P39hAmik1eio00IolpVovndVahOaYmJ3d2sELaHxIRnj1km
        MCrOQvLYLCSPzULywCyEZQsYWVYxSqYWFOempxabFhjnpZbDozs5P3cTIzida3nvYHz04IPe
        IUYmDsZDjBIczEoivP1F9xOFeFMSK6tSi/Lji0pzUosPMZoCQ3sis5Rocj4wo+SVxBuaWBqY
        mJmZmVgamxkqifOeSt+QKCSQnliSmp2aWpBaBNPHxMEp1cAksr77Bf/nBIZ5N7+Y5qWtcyxS
        cszg+J3JYWIQvmNr/a6Dk1q29zHesDwTbdvy6cQL5oRL2ud28dUdXv9uM+dP5+IVajM3TXfS
        KU35yrrs/oot6xlyzsfNmde7i+XX/OJAzvJ3LR/+Piz8t8SqO3barEcBn6rC6hwnOKiavO5X
        1tdy4GGdzVCwdtfOVzweOczMFbnWAQ2xB2Z95X5ucE5+vvuNkMaQp39zbz0yPi5SflCOq0x1
        J8+1M7oKYnMv+tn90ExQ6/QPTFBcz/dw9gGDudsWtf18fTNtNqd3oOqTLTqc1/5EHfva4L5g
        hb3y0qnlUodj33Y3rxJx6T14YvbB83WNUz6cf/2isW7738fNSizFGYmGWsxFxYkAg8QWjnAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnK6E8sNEgx2HhS0Obd7KbjH14RM2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLxo832S1O
        Xf/MZrFo6xd2i9a9R9gtDr9pZ7V4fP0Pm4Ogx5p5axg9ZjX0snlsWtXJ5nHn2h42j81L6j2u
        nGhi9ejbsorR41/TXHaPz5vkAjijuGxSUnMyy1KL9O0SuDJenH/GXHCEvWLl4fMsDYwn2LoY
        OTkkBEwkHm57zN7FyMUhJLCDUWLmrmdQCWmJ6xsnsEPYwhIr/z2HKnrOKLHs51wWkASbgK7E
        jsVtYA0iAuoSRzdtZAUpYhb4yizx7O0KqI6HjBK9m2Yxg1RxAnX8mdnEBGILC4RKfPvVyghi
        swioSqx9OA8szitgKXFk3RoWCFtQ4uTMJ0A2B9BUPYm2jWDlzALyEtvfzmGGuE5B4ufTZawQ
        R7hJLLp8jgmiRlzi5dEj7BMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAKC+1XK84
        Mbe4NC9dLzk/dxMjOK61tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwXdTlKJtzvPflvQ+Z03uPxKWfiOFV
        uTez9eTZR8sVz3530z0RPfXTpAt9s/ZFiIfOXSNx9zbThSMuLvkf9OKmqnhdsm2VzV00gbXh
        wqzvjtJbr6rq7J99c5b733B/3m+rBH3nX+RR8dm76evDtqPMDzirNqnXP10VFJNmJeh9dRN/
        2fIr64V2bEwI5THVLXCI1l06L+B9x7Q9x54v7ruy2dPzWPO7k++bV9u8a0podrui/1sn/d/5
        d9/yzLT2fDp+W/PJodOWaqJ27z333Ofg6Bf4WMkoJ2z2V0y1wZC3JGSW9zERXuXtmpukLpSe
        kDI33Lfwgs+TbdOZ7U9ld7zycWo91j3V7cfsl89THLm8PiuxFGckGmoxFxUnAgAkZeJQWgMA
        AA==
X-CMS-MailID: 20220114071536epcas5p454d2a70a38acfbdbce56b7370c0d9306
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122435epcas5p18e6a2699f193b9e1287588278a570235
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122435epcas5p18e6a2699f193b9e1287588278a570235@epcas5p1.samsung.com>
        <20220113121143.22280-19-alim.akhtar@samsung.com>
        <YeAiIhfN216pRWhn@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@kernel.org]
>Sent: Thursday, January 13, 2022 6:29 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; krzysztof.kozlowski@canonical.com;
>s.nawrocki@samsung.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; linux-fsd@tesla.com; linux-
>spi@vger.kernel.org; Aswani Reddy <aswani.reddy@samsung.com>
>Subject: Re: [PATCH 18/23] spi: s3c64xx: Add spi port configuration for
Tesla
>FSD SoC
>
>On Thu, Jan 13, 2022 at 05:41:38PM +0530, Alim Akhtar wrote:
>
>> +	{ .compatible = "tesla,fsd-spi",
>> +			.data = (void *)&fsd_spi_port_config,
>> +	},
>
>This needs a DT bindings update to match.
Thanks for point it out, will update in v2.

