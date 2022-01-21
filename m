Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3360A495F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380379AbiAUMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:31:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:61614 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350448AbiAUMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:31:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220121123121euoutp0154f669487e13b26dc040cde6572b8e64~MSQxYre8r1009410094euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 12:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220121123121euoutp0154f669487e13b26dc040cde6572b8e64~MSQxYre8r1009410094euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642768281;
        bh=RrzB8h/bMnzcV+j+1Jb+7Ew0T99xNnjQpPe8goU3pU0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=r+VH1Tq8fsFunC7dJNx/uB0Iy75wVmmWUEVWCzYZbVJ2bkrCJyP7SxrCw0BzAZKwV
         0GfRHWH1RmU1T79FDIcF/T0zZvtLu6jnAG24LP89yx4BlMD6kRbkp1tfPizmIqHe9v
         8qjtnOBpD1XozSsAL7ZN3BLdAQsMQ3dJD6IfHRjM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220121123120eucas1p294c92264f37be911af0be1cb16846432~MSQw7SOKC2476624766eucas1p2m;
        Fri, 21 Jan 2022 12:31:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.E8.10009.897AAE16; Fri, 21
        Jan 2022 12:31:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220121123120eucas1p1b3dd2371deca8485b9d9371097fdb14f~MSQwXdv4K1413914139eucas1p1W;
        Fri, 21 Jan 2022 12:31:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121123120eusmtrp24fb48e291e91fbc00debcfbe610aa982~MSQwWYdhl0056800568eusmtrp2Y;
        Fri, 21 Jan 2022 12:31:20 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-5d-61eaa7987050
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.18.09522.897AAE16; Fri, 21
        Jan 2022 12:31:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220121123119eusmtip13e3280ba3efd5ab0ad34cf54b204d2a2~MSQvLEE7k0395503955eusmtip1X;
        Fri, 21 Jan 2022 12:31:19 +0000 (GMT)
Message-ID: <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
Date:   Fri, 21 Jan 2022 13:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Jinkyu Yang <jinkyu1.yang@samsung.com>,
        Alex <acnwigwe@google.com>, Carlos Llamas <cmllamas@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Erick Reyes <erickreyes@google.com>,
        "J . Avila" <elavila@google.com>, Jonglin Lee <jonglin@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd27bey81xduC6REWlnViNhNAki0epzG6MWkAs804t4gRL3gH
        VSispdvcQgSlDdTysZkIVESmY7hCEUqDo86PVoQMHFQaWtHCdHYy60qFYjbka16KG/897/O+
        v/fj5JAcUQUeQcrk+YxCTmdLcD63o3t6IKa60Uuvf9QWg3ptCzjquzrORf4fdABNXRskUGWJ
        GkOerrMEmvU6uWiu1M5D9Vc3ofZaJbIYrhNoxl3GQ6WnWgnU5vsHQ6YHTh5yWGpxVD1wBUPz
        ZVaA1Je7CNRQ1IGjsfLn3p9mMeodCRCoSWMAqNj9FjJMLoCtEVKPtQ6TNtc1A6m+sAyX1ptU
        UpOhFJe6nT/j0vbvj0hP3G4E0nKzAUgDpqgP+Hv4mw8w2bLPGUXclv38rKLACTyvN+bLsy6m
        EBRGa0EICak34UlXJa4FfFJEnQdwSDezFEwBaNKXEMEgAOB5tYv3AqldOA6CiUYA7RMNS8gE
        gN90zGNaQJICags0+UNZgEtFw6Jh9SIsoITwlxoPly1ZRaVDXfG7rB1GJcKRpgGM1RxKDO94
        zizqcEoGx61PuGx7DqUhoH+ud7EPTsVDrU+LszqE+hAa5+28IPwKvOir5bAApDR8eL/Yjge3
        ToA+47klHQa9PWYiqF+GC53sNBY4BuD9fiMRDHQAOo5Wg2DVJujuf4aza3OoN+AFS1zQ3gbL
        b01xWBtSofC2TxhcIhR+21G1ZAtgiUYUrF4L9T0t/4212gc5lUCiX/Ys+mX365edo/9/bj3g
        GoCYUSlzMhllvJz5IlZJ5yhV8szYjNwcE3j+Z/vmeyZ/Aqe9E7E2gJHABiDJkYQL8nK9tEhw
        gD78FaPITVOoshmlDUSSXIlYkCFrpUVUJp3PHGKYPEbxIouRIRGFWOouRdjHbdvXRGatH9yQ
        /H7mo/C+tVGH86cfFhx7Tyd2rRpauUIzi1/6vUUkWaHYtbeVf+fBR981KCosuZKn/tHuHXt7
        HBuOYq9pT2/twnYOWYRTjoLV5pPveKOGcdvqyRvnRtH1m2ntD/M4wiL73yoqJfWeP+NXc2B/
        ncOY8FIy71Dq193ptpRPxpK1t5paDlbMNCZ6H8tPFex7u37z8dHdNQ3uy9vvuWqS8pPIFEVV
        emCNDuWvG6DjOp9G1iVcTN7oEbwaabIm7hs+6FQ3v975+O5wAXVltyV7LunTI9v8N4jPqhIu
        jPx1Tebs2vPHyvJnQuOT/ktjgo1p03ejf5vV3xz/UcJVZtHx6zgKJf0vWFLSJSIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xu7ozlr9KNDg7k93i1KH/bBan979j
        sXi/rIfR4suBS+wWEzpamSyeHFnEbvHn1TUWi7+dF1gtFuy3ttg8p9hi16rD7Ba/7/SyWnTO
        3sBusfHtDyaLTY+vsVpc3jWHzWLG+X1MFv96DzJatO49wm6xtHEbm8XzPqDYiy3iFqfufma3
        WN22itGi5Y6pxapP/xkdpDyeHJzH5LFm3hpGj1kNvWweCzaVemxa1cnmcefaHjaPzUvqPSbf
        WM7o0bdlFaPH501yAVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYp
        qTmZZalF+nYJehmNnyezFZzSrVh0PbWBsUG1i5GTQ0LARGLO/25GEFtIYCmjRPfrAoi4jMTJ
        aQ2sELawxJ9rXWxdjFxANe8ZJR6dO8PcxcjBwStgJ7HpPR9IDYuAqkTjzVawel4BQYmTM5+w
        gNiiAkkSDce62UBsYQF3iburzzOB2MwC4hK3nswHs0UEMiUm329hB5nPLNDBLtG4o4cdYtlR
        Jomt1xeCTWITMJToetsFNolTIFBi7b8LrBCTzCS6tnYxQtjyEtvfzmGewCg0C8khs5AsnIWk
        ZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC08q2Yz8372Cc9+qj3iFGJg7GQ4wS
        HMxKIrwF+a8ShXhTEiurUovy44tKc1KLDzGaAkNjIrOUaHI+MLHllcQbmhmYGpqYWRqYWpoZ
        K4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwpSlda9iyXfiugHD1xrLuj2vuiQXIn5+X9cZA
        7+Gilsdd04KPWD9ScH9/smH/2x3pb7eG1K46fnFSW6jgAY4j4X9ENWYvX8947B5bisrq/d03
        fhYdWfl85cQXTwRNGNpcsu8Fqnl9LWrYziEkfGyeQ5Vh0c9/Mz7u3LxslZDakYbozxe2q+iz
        fA3q2aV+Zoa5uXRkjtlVO7OatkrftRa5lceTdju/7DsusCp2qQLDshf+K0qyZG1b6v5lfdzQ
        b/BDkpkjonezcLbc5bu/U05vK9fzaZCM5an4G37SKNcsMWDhFb0HR99urz9wZZbmmU99bnrG
        uvKFDirKfoEytd++Nzt7T/4vNs8+X96xs05PiaU4I9FQi7moOBEAOYxUA7QDAAA=
X-CMS-MailID: 20220121123120eucas1p1b3dd2371deca8485b9d9371097fdb14f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
        <20220120201958.2649-3-semen.protsenko@linaro.org>
        <a111932a-6685-2a9d-abce-87af26b121a4@canonical.com>
        <CGME20220121110911eucas1p28d11e1b04773e8174b9d65f011dc1977@eucas1p2.samsung.com>
        <CAPLW+4kKR+7hM-eZc8-v6Dzeaj+TPBRmCLDSVNEnfx2WmN2TJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 21.01.2022 12:08, Sam Protsenko wrote:
> On Fri, 21 Jan 2022 at 10:40, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> On 20/01/2022 21:19, Sam Protsenko wrote:
>>> Introduce new driver for modern Exynos ARMv8 SoCs, e.g. Exynos850. Also
>>> it's used for Google's GS101 SoC.
>>>
>>> This is squashed commit, contains next patches of different authors. See
>>> `iommu-exynos850-dev' branch for details: [1].
>>>
>>> Original authors (Samsung):
>>>
>>>   - Cho KyongHo <pullip.cho@samsung.com>
>>>   - Hyesoo Yu <hyesoo.yu@samsung.com>
>>>   - Janghyuck Kim <janghyuck.kim@samsung.com>
>>>   - Jinkyu Yang <jinkyu1.yang@samsung.com>
>>>
>>> Some improvements were made by Google engineers:
>>>
>>>   - Alex <acnwigwe@google.com>
>>>   - Carlos Llamas <cmllamas@google.com>
>>>   - Daniel Mentz <danielmentz@google.com>
>>>   - Erick Reyes <erickreyes@google.com>
>>>   - J. Avila <elavila@google.com>
>>>   - Jonglin Lee <jonglin@google.com>
>>>   - Mark Salyzyn <salyzyn@google.com>
>>>   - Thierry Strudel <tstrudel@google.com>
>>>   - Will McVicker <willmcvicker@google.com>
>>>
>>> [1] https://protect2.fireeye.com/v1/url?k=19bd3571-46260c3c-19bcbe3e-0cc47aa8f5ba-8a160a7fd38bb35a&q=1&e=eb3f71b3-8df2-46c6-b6d8-0a931ef99024&u=https%3A%2F%2Fgithub.com%2Fjoe-skb7%2Flinux%2Ftree%2Fiommu-exynos850-dev
>>>
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>   drivers/iommu/Kconfig               |   13 +
>>>   drivers/iommu/Makefile              |    3 +
>>>   drivers/iommu/samsung-iommu-fault.c |  617 +++++++++++
>>>   drivers/iommu/samsung-iommu-group.c |   50 +
>>>   drivers/iommu/samsung-iommu.c       | 1521 +++++++++++++++++++++++++++
>>>   drivers/iommu/samsung-iommu.h       |  216 ++++
>>>   6 files changed, 2420 insertions(+)
>>>   create mode 100644 drivers/iommu/samsung-iommu-fault.c
>>>   create mode 100644 drivers/iommu/samsung-iommu-group.c
>>>   create mode 100644 drivers/iommu/samsung-iommu.c
>>>   create mode 100644 drivers/iommu/samsung-iommu.h
>>>
>> Existing driver supports several different Exynos SysMMU IP block
>> versions. Several. Please explain why it cannot support one more version?
>>
>> Similarity of vendor driver with mainline is not an argument.
>>
>>> ...
>> You just copy-pasted vendor stuff, without actually going through it.
>>
>> It is very disappointing because instead of putting your own effort, you
>> expect community to do your job.
>>
>> What the hell is CONFIG_EXYNOS_CONTENT_PATH_PROTECTION?
>>
>> I'll stop reviewing. Please work on extending existing driver. If you
>> submitted something nice and clean, ready for upstream, instead of
>> vendor junk, you could get away with separate driver. But you did not.
>> It looks really bad.
>>
> Krzysztof, that's not what I asked in my patch 0/3. I probably wasn't
> really clear, sorry. Let me please try and describe that better, and
> maybe provide some context.
>
> I'm just starting to work on that driver, it's basically downstream
> version of it. Of course I'm going to rework it before sending the
> actual patch series (that's why this series has RFC tag). I'd never
> asked community to do my job for me and really review the downstream
> driver! I just want to know from the starters some *very* basic and
> high-level info, which could help me to rework the driver in correct
> way. Like naming of files, compatible strings, should it be part of
> existing driver or it's ok to have it as another platform_driver. In
> other words, that kind of "review" shouldn't take more than 2 minutes
> of your time. And it could spare us all unneeded extra review rounds
> in future. Right now I don't need the code review per se (and I'm
> really sorry you had to spend your time on that, knowing how busy
> maintainers can be during the MW). I thought about omitting the code
> at all, only asking the questions, but then I figured it's a good idea
> to attach some code for the reference. Maybe it wasn't a good idea
> after all.
>
> For the record, I'm well aware that we don't send downstream code
> without making it upstreamable first, and I know it must be tested
> well, etc. For example, you already saw me sending clk-exynos850
> driver, which I re-implemented from scratch, and it has ~0.0% of
> downstream code. So why would I change my policy about that all of the
> sudden... Anyway, hope you understand now that there weren't any ill
> intentions on my side, w.r.t. this RFC.


Well, for starting point the existing exynos-iommu driver is really 
enough. I've played a bit with newer Exyos SoCs some time ago. If I 
remember right, if you limit the iommu functionality to the essential 
things like mapping pages to IO-virtual space, the hardware differences 
between SYSMMU v5 (already supported by the exynos-iommu driver) and v7 
are just a matter of changing a one register during the initialization 
and different bits the page fault reason decoding. You must of course 
rely on the DMA-mapping framework and its implementation based on 
mainline DMA-IOMMU helpers. All the code for custom iommu group(s) 
handling or extended fault management are not needed for the initial 
version.

The IOMMU driver on its own doesn't really make much sense, so you need 
the other driver/device pair which will make use of it. You have 
mentioned DPU, so you are trying to bring the display stack. Please 
check the existing Exynos DRM driver(s). They nicely use DMA-mapping 
framework and are really modular, so adding hw-specific sub-drivers for 
Exynos850 shouldn't be that hard. Don't expect that the vendor's drivers 
based on custom frameworks will work there though.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

