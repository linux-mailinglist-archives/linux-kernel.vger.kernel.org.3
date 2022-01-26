Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1349C607
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiAZJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:16:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60843 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiAZJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:16:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091559euoutp0209bc852415edf1146ab87ddaa6a04da4~Nx0n_Gp-L2059420594euoutp02b
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:15:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220126091559euoutp0209bc852415edf1146ab87ddaa6a04da4~Nx0n_Gp-L2059420594euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188559;
        bh=qM0mXsmOB4O+Tpm3UVRQJrXR3PRdA/yYzgrio555SKU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=JkkrG0GrmrkFdunEX0F/m6GrnL6xfIdJUJ0ciu9qUJGEGi0njU0i4/tjOQDgfm7qe
         uV511bZpL+3JO9UpDZdGic58aGBlWfHWkrPx/ybCAjztFoWqpNgOC99ZIQi0SJ8HTy
         W7MUJIw+pw0MlPIP1nw1R4FibLFIJw5LQ+44TCd8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220126091559eucas1p2c62968dbbae1e9e3c380b5d8a35849c1~Nx0ns35zb2789827898eucas1p21;
        Wed, 26 Jan 2022 09:15:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.DE.10009.F4111F16; Wed, 26
        Jan 2022 09:15:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091558eucas1p2baa8e70d360b870e0d7ea616ec8aeff8~Nx0nHLfIH2801828018eucas1p2B;
        Wed, 26 Jan 2022 09:15:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126091558eusmtrp1faa119d1a8ac096cfcb25caf96c77628~Nx0nGLcG31443214432eusmtrp1S;
        Wed, 26 Jan 2022 09:15:58 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-a1-61f1114f52f7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.52.09404.E4111F16; Wed, 26
        Jan 2022 09:15:58 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091557eusmtip1515526e62dd6667e88a713fa5452ef16~Nx0l-RnVo2192821928eusmtip1Z;
        Wed, 26 Jan 2022 09:15:57 +0000 (GMT)
Message-ID: <e2893572-66d2-a7e5-e9e3-7feec8738881@samsung.com>
Date:   Wed, 26 Jan 2022 10:15:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 06/16] clk: samsung: fsd: Add cmu_fsys0 clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org, linux-fsd@tesla.com,
        Shradha Todi <shradha.t@samsung.com>,
        Jayati Sahu <jayati.sahu@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-7-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djP87r+gh8TDRbf47A48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLf9c2slj0Hq61eHz9D5uDsMeaeWsYPX7/msToMauhl81j
        06pONo871/aweWxeUu9x5UQTq0ffllWMHv+a5rJ7fN4kF8AVxWWTkpqTWZZapG+XwJUx91xx
        wUWWinMzFzM3MDawdDFyckgImEgs/rKRsYuRi0NIYAWjxPc7O5ggnC+MEq+e97NBOJ8ZJbZv
        uQTXcu1/K1TLckaJs883skM4HxklnnStYAOp4hWwk1j1fDWYzSKgKnG85yEzRFxQ4uTMJ0CT
        ODhEBZIkelqcQcLCAkES+3ZNZwexmQXEJW49mc8EYosI5Ev8/LeTBWQ+s8A2Zomd6+eAXcEm
        YCjRe7SPEcTmFLCVuLl0MwtEs7zE9rdzmEEaJASucUo0bjvLBnG2i8Tur/uhXhCWeHV8CzuE
        LSNxenIPC0RDM6NEz+7b7BDOBEaJ+8cXMEJUWUvcOfeLDeRsZgFNifW79CHCjhKXLzUzgYQl
        BPgkbrwVhDiCT2LStunMEGFeiY42IYhqFYnfq6YzQdhSEt1P/rNMYFSahRQss5D8PwvJO7MQ
        9i5gZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmChP/zv+aQfj3Fcf9Q4xMnEwHmKU
        4GBWEuH97/0+UYg3JbGyKrUoP76oNCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwen
        VAOTTB6znETxoi+qRYXXEjJLDLhL8zxDKmMfvvNd8TIlinXXtrnP939RvxqWZHn8hwXTti/C
        pxbkXk089jVCOXq/3Wo/l1Nc3Du+qE5pS3aRSlgvZHc48tHG9h7DiunVT/IZ2OrcfbU/C1xr
        lJVqP8zyJGW7c/7TAmvDvu+3UrJkTMpmVV3z/PiJK70leZZa3P7vE7Vazqo1uexjP6umXfTA
        dNLVX7HsbYxTv5cZCc1zaNF/PNWvV1VDQZ0jcjXzJaOfBntOqIbqXqsKsS1afd3nh5/uygM2
        HV9e8Cxo7DZKLH5isG7Ot4dO5X0eFtdZDxRcfNOfn2wqGPXnh/Z+98wa2Z+mu6d4t3EyP/s2
        VYmlOCPRUIu5qDgRALSxNz8DBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7p+gh8TDR5Plbc48P4gi8WDedvY
        LP5OOsZu8X5ZD6PF/CPnWC2OnFrCZLHx7Q8miyl/ljNZbHp8jdXiY889VouHr8ItLu+aw2Yx
        4/w+JotT1z+zWSza+oXdonXvEXaLf9c2slj0Hq61eHz9D5uDsMeaeWsYPX7/msToMauhl81j
        06pONo871/aweWxeUu9x5UQTq0ffllWMHv+a5rJ7fN4kF8AVpWdTlF9akqqQkV9cYqsUbWhh
        pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx91xxwUWWinMzFzM3MDawdDFyckgI
        mEhc+9/K2MXIxSEksJRR4vmRx6xdjBxACSmJ+S1KEDXCEn+udbFB1LxnlFjTsYcVJMErYCex
        6vlqNhCbRUBV4njPQ2aIuKDEyZlPwBaICiRJNBzrBqsRFgiS2LdrOjuIzSwgLnHryXwmEFtE
        IF/iT/9HVoj4NmaJ54flIZYdZpRofjCDESTBJmAo0Xu0D8zmFLCVuLl0MwvIocwC6hLr5wlB
        9MpLbH87h3kCo9AsJGfMQrJuFkLHLCQdCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSm
        hG3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeP97v08U4k1JrKxKLcqPLyrNSS0+xGgKDIqJzFKi
        yfnApJRXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cCUYs61iJFV
        uqPL0PTdq1eBmxNVwq/ui0zqdXtazac1uS7qb9VBs3vFbF+jbqds7sq0s9S7tHJ1jkH4UrMe
        zaVJ64NeeDyTfzjXR/L3i+WOq648L7Bm1TreldebYxbO4Fn+sMLZqorlC1+4+bss151H1s2s
        lppRHD9fX9FVWpQzOavqk4VDl7fgm26ukvubc+ROXOdjL/tr8T1z2j3NjK+17m8m3vB0lQ++
        HF3Tdnz6P+m9rIV/nnpaL3yy2O1UY4mQpsOH/QpXVv6Ndd70Kka+foKFR4r6ycM7uma53eRY
        OuXf080Ltvsy2Keovpj3TWOZ0PfZ0f191Quz/04obP70VFqSs6hgSkkfb6WBgRJLcUaioRZz
        UXEiAEW46pqSAwAA
X-CMS-MailID: 20220126091558eucas1p2baa8e70d360b870e0d7ea616ec8aeff8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142919epcas5p3232941c11ef3c5ac8de2ca89b21131e2@epcas5p3.samsung.com>
        <20220124141644.71052-7-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> CMU_FSYS0 block has IPs like UFS, EQOS, PCIe etc, lets add
> the related clock information for the same.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> Signed-off-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

