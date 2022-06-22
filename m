Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2F554626
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiFVJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFVJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:57:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150F3A183
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:57:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622095729euoutp01533d73ea031d78ed6c0da1ca750fab1e~66N0lDOP51533715337euoutp012
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:57:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622095729euoutp01533d73ea031d78ed6c0da1ca750fab1e~66N0lDOP51533715337euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655891849;
        bh=FePwQ4O/YSznXBsN/aF7A8HVK6oQ8MRUR2C9E7B9jF0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=REqZkvf8HPtfSU5+DJhc92y0fTQuFxqAZ0qWLtjvF21/hcygzdo512Vd8O/U4ks9r
         KNGXogiDoYPegniZzZcyUzcKM4eXypp0FeKcP8EDfa0nZSD2wHpbi4kDJdFj3ziJT4
         74fhe9P2Idk1p5EN+uiQGgX7qSA4y6sOXiEYVpDA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220622095728eucas1p27c8e332c655bf827abd03dedb6dbb6f5~66NzxoGr91480814808eucas1p2p;
        Wed, 22 Jun 2022 09:57:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.F5.09664.887E2B26; Wed, 22
        Jun 2022 10:57:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220622095728eucas1p11a4d7c17808256e599f1888ce9ab4cb3~66NzMRAay0805008050eucas1p1G;
        Wed, 22 Jun 2022 09:57:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220622095727eusmtrp2395019a94bb083f5f58a9ad7b31fa1d7~66NzKazqG1462214622eusmtrp2r;
        Wed, 22 Jun 2022 09:57:27 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-fb-62b2e788686b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.C3.09038.787E2B26; Wed, 22
        Jun 2022 10:57:27 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220622095724eusmtip14e377a1805eb0bfea932599c4b108040~66NwTpPHE1778117781eusmtip1j;
        Wed, 22 Jun 2022 09:57:24 +0000 (GMT)
Message-ID: <ec775e98-1164-1016-13c7-9247e751782a@samsung.com>
Date:   Wed, 22 Jun 2022 11:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
In-Reply-To: <47a0abcc-b3d6-a9a3-8d3a-5689bbf8767a@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzved/t3RgOXwYdzwHZtdI7sqCdejwF7dS6WlQXHZnFdcXANyDH
        oM3Z8Ew3fgnLIWoQDQSsTG8uXBtyyaS1MUGhY8DG4Lqh3jnCm7cStm4FArm9Wvz3eT4/nu/n
        +9zDxnnHiWR2qXQfJZOKJXyCw+gd/Gf02fo5U+FzK2o+GravEmjE+gcD/fn9UYBCv0ywUFN9
        LYZ8jm9Y6J7fw0DLDWNM1GXNQuZ2OerTD7DQklfLRA1tRhb6MfA3hky3PEzk6msnUKvzZwyt
        aG0A1fY7WMh218dEZ9S9BJprvC/c7klCwzNBFjpfpweoxrsN6RdWwfYUkc/WgYkMHQYg0qm0
        hKjLpBCZ9A2EyOu5TIjM3x0WnZw+C0SNPXogCpo25HLyOdl7KEnpfkqWISzglCwPWvGKY3zl
        704PoQKzKRoQw4bkVnjV3UVoAIfNI88BeHWuGacPIQCPm0+CiItHBgE0X698mKgOLTFo/iyA
        t2ry6MA8gNNnWqIClxRC540hTAPYbAa5EaotT9J0PLz2tS9qeZQshJ29tcwITiBfhTPnnVgE
        42QS/M3XGcWJ5C6o628Ckftx0sqC+ptqPCIQpABqAhoigmPILHhhfOBB+HFYfbEtugEkGznQ
        O6XC6NYvw/C5QYLGCdA/1MOicSpcvdQZLQrJcrjcuoWmldBzx4DTOAt6RxeJiAUn0+CFvgya
        3gEbx0M4nYyD04F4ukEcPNH71QOaC+vreLR7E9QNdf830zY2gTcBvm7No+jWLK9bs4vu/7ld
        gKEHSZRCXlZMyQVS6rN0ubhMrpAWpxeVl5nA/V87sjK08BM45Z9PtwOMDewAsnF+Ijc71ljI
        4+4RVx6gZOUfyRQSSm4HKWwGP4lbVGoU88hi8T5qL0VVULKHKsaOSVZhCRbhoaDzEcNTW9+a
        LUgZOWRZvxRYf+fUbUQ8sTm44XRooW6+KRnLY7V/2LFO4LdMtVQ43uFXrcsN74rNvZu9//Vn
        3ANk3WM5VmF//V+tmdrt3ePiXwvM+YbX+j52+Y+8/V4Fa/jepivyLw++IvzihxOX9bufr+p5
        0b1RkGHc8fm39uSJzlntsPcSJ+90Vkhy7GB43rVT9lLL1HVjbJs+fy6+6v3m7rTdkxcdeZ8Q
        ypK4BGXzijucPeY4cE36gS8xblRWXfnm4huTRfGF3S9Mqm3hT1VeV6pJZ9lcZHEV4DbvFaZR
        cnMbf/HGziOZe2sOu81pR92ZAUXOuzEzkpzU0S3KWT5DXiIWPI3L5OJ/AZbtBbEkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7rtzzclGSxoMLc4deg/m8Xp/e9Y
        LN4v62G0+HLgErvFhI5WJosnRxaxW/x5dY3F4m/nBVaLBfutLTbPKbbYteowu8XvO72sFp2z
        N7BbbHz7g8li0+NrrBaXd81hs5hxfh+Txb/eg4wWrXuPsFsc/PCE1WJp4zY2i+d9QIkXW8Qt
        Tt39zG6xum0Vo0XLHVOLVZ/+MzpIezw5OI/JY828NYwesxp62TwWbCr12LSqk83jzrU9bB6b
        l9R7TL6xnNGjb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxM
        lfTtbFJSczLLUov07RL0Mv4e289c0K9U8ez8NbYGxqfSXYycHBICJhLNX36zdDFycQgJLGWU
        uP34GBtEQkbi5LQGVghbWOLPtS42iKL3jBI/mqexgCR4Bewkzt8/ztTFyMHBIqAq0bhbGSIs
        KHFy5hOwElGBJIl5e1czgtjCAu4Sd1efZwKxmQXEJW49mQ9miwiESrx/eYURZD6zwGF2iSkd
        M6GWfWKWmD1jNjtIFZuAoUTX2y6w6zgFrCXWXzwMNclMomtrFyOELS/RvHU28wRGoVlIDpmF
        ZOEsJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEZhkth37uWUH48pXH/UOMTJx
        MB5ilOBgVhLhteHekCTEm5JYWZValB9fVJqTWnyI0RQYGBOZpUST84FpLq8k3tDMwNTQxMzS
        wNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgcmLr6M6tbb/an87z5ctwSs5S9fKL/RT
        PH537+L/j95b/U+M+5L2dMrpv7vU153U3pQpcvqjJFtZz/WgifWOcUGP3wVcl5nhPrWQr+KZ
        N0eeVVx2r0msaeiayCeTFK8rLao9kPpprvlxi9u/duy7qXN5/W6TU4UT9k62dDUX7jhtlNZ7
        +/PRM/k8IYLbd/rm+a7MXs4zi+np/u2cy3w36DLUnvsu5i0423r+zZr7eukzHO6pHfXi4F/T
        pslo33B0h4e7RHHKviSNJ73BGw59ePjM7vbn4NT42HsN14xSHn9+dv51fbVpHPPBo0cv5qxb
        VSzxY+2O3l3dT4Ku9/A+VI3WurhpjfA2twTRUKUNucVKLMUZiYZazEXFiQCG6INquwMAAA==
X-CMS-MailID: 20220622095728eucas1p11a4d7c17808256e599f1888ce9ab4cb3
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
        <54b76143-dff3-8a19-7ab9-57fb80d59743@samsung.com>
        <CAPLW+4nxSDeGL-1hFzdDr3vYx+9ct8_YrXfVNgzwm1Gq2=Vh7A@mail.gmail.com>
        <47a0abcc-b3d6-a9a3-8d3a-5689bbf8767a@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.06.2022 11:14, Robin Murphy wrote:
> On 2022-06-21 20:57, Sam Protsenko wrote:
>> Hi Marek,
>>
>> On Fri, 21 Jan 2022 at 14:31, Marek Szyprowski 
>> <m.szyprowski@samsung.com> wrote:
>>
>> [snip]
>>
>>>
>>> Well, for starting point the existing exynos-iommu driver is really
>>> enough. I've played a bit with newer Exyos SoCs some time ago. If I
>>> remember right, if you limit the iommu functionality to the essential
>>> things like mapping pages to IO-virtual space, the hardware differences
>>> between SYSMMU v5 (already supported by the exynos-iommu driver) and v7
>>> are just a matter of changing a one register during the initialization
>>> and different bits the page fault reason decoding. You must of course
>>> rely on the DMA-mapping framework and its implementation based on
>>> mainline DMA-IOMMU helpers. All the code for custom iommu group(s)
>>> handling or extended fault management are not needed for the initial
>>> version.
>>>
>>
>> Thanks for the advice! Just implemented some testing driver, which
>> uses "Emulated Translation" registers available on SysMMU v7. That's
>> one way to verify the IOMMU driver with no actual users of it. It
>> works fine with vendor SysMMU driver I ported to mainline earlier, and
>> now I'm trying to use it with exynos-sysmmu driver (existing
>> upstream). If you're curious -- I can share the testing driver
>> somewhere on GitHub.
>>
>> I believe the register you mentioned is PT_BASE one, so I used
>> REG_V7_FLPT_BASE_VM = 0x800C instead of REG_V5_PT_BASE_PFN. But I
>> didn't manage to get that far, unfortunately, as
>> exynos_iommu_domain_alloc() function fails in my case, with BUG_ON()
>> at this line:
>>
>>      /* For mapping page table entries we rely on dma == phys */
>>      BUG_ON(handle != virt_to_phys(domain->pgtable));
>>
>> One possible explanation for this BUG is that "dma-ranges" property is
>> not provided in DTS (which seems to be the case right now for all
>> users of "samsung,exynos-sysmmu" driver). Because of that the SWIOTLB
>> is used for dma_map_single() call (in exynos_iommu_domain_alloc()
>> function), which in turn leads to that BUG. At least that's what
>> happens in my case. The call chain looks like this:
>>
>>      exynos_iommu_domain_alloc()
>>          v
>>      dma_map_single()
>>          v
>>      dma_map_single_attrs()
>>          v
>>      dma_map_page_attrs()
>>          v
>>      dma_direct_map_page()  // dma_capable() == false
>>          v
>>      swiotlb_map()
>>          v
>>      swiotlb_tbl_map_single()
>>
>> And the last call of course always returns the address different than
>> the address for allocated pgtable. E.g. in my case I see this:
>>
>>      handle = 0x00000000fbfff000
>>      virt_to_phys(domain->pgtable) = 0x0000000880d0c000
>>
>> Do you know what might be the reason for that? I just wonder how the
>> SysMMU driver work for all existing Exynos platforms right now. I feel
>> I might be missing something, like some DMA option should be enabled
>> so that SWIOTLB is not used, or something like that. Please let me
>> know if you have any idea on possible cause. The vendor's SysMMU
>> driver is kinda different in that regard, as it doesn't use
>> dma_map_single(), so I don't see such issue there.
>
> If this SysMMU version is capable of addressing more than 32 bits, 
> then exynos_iommu_probe_device() should set its DMA masks appropriately.

Well, Sam's question was about the Exynos SYSMMU own platform device, 
not the device for which Exynos SYSMMU manages the IO virtual address 
space.

Simply add something like

dma_set_mask(dev, DMA_BIT_MASK(36));

to the beginning of the exynos_sysmmu_probe(). This will disable SWIOTLB 
and switch to DMA-direct for the Exynos SYSMMU platform device.


> (as a side note since I looked, the use of PAGE_SIZE/PAGE_SHIFT in the 
> driver looks wrong, since I can't imagine that the hardware knows 
> whether Linux is using 4KB, 16KB or 64KB and adjusts itself 
> accordingly...)

Right, this has to be cleaned up. This driver was never used on systems 
with kernel configuration for non-4KB pages.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

