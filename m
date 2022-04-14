Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE776501D04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbiDNVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbiDNVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:02:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55023D599C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:00:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220414210028euoutp013431041de12c7f2fb0fa4a95864e366a~l3v_hgiqg1109911099euoutp01I
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:00:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220414210028euoutp013431041de12c7f2fb0fa4a95864e366a~l3v_hgiqg1109911099euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649970028;
        bh=1sPEUOenjbwSwEmgb/ae34G8hb7c40f80oqDc56Zjog=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=qV0P2+KA2dSOtefYtMIZJk4GIXIkakqFm8NXcMXXdGi6Rucg0Q5M/bbQigrj/2Jap
         7ypGBw+WpSlejEi5Wjr7G0vl5KykkPVLHQaLoB4oamS793RGWoO6bhhfWqmmM/qeD7
         FNvoqiRFfbBJ2WKeiz1oxmusCLXZ1jw20ufaqNfI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220414210027eucas1p185f27a902ba36c6fc8dc997ccd841c3e~l3v95CXSX2407624076eucas1p1T;
        Thu, 14 Apr 2022 21:00:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.1F.10260.B6B88526; Thu, 14
        Apr 2022 22:00:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220414210025eucas1p1c3faa4c9c3ce5fd273ba0675e7a2c86a~l3v8ltveF2383323833eucas1p1S;
        Thu, 14 Apr 2022 21:00:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220414210025eusmtrp174e6e526f6ccfdc233a5eaaefc1435cc~l3v8k4KZU2087320873eusmtrp1M;
        Thu, 14 Apr 2022 21:00:25 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-70-62588b6b0918
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.E8.09522.96B88526; Thu, 14
        Apr 2022 22:00:25 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220414210025eusmtip19363f4121502594c4e8ce2c783e2eccc~l3v7zLbwE3006330063eusmtip1A;
        Thu, 14 Apr 2022 21:00:25 +0000 (GMT)
Message-ID: <2093efb6-e898-9a2f-4d2a-4ec22ae016bd@samsung.com>
Date:   Thu, 14 Apr 2022 23:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 00/13] iommu: Retire bus_set_iommu()
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, mjrosato@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djPc7rZ3RFJBr/+8FhsnriVzeJ9c5zF
        gv3WFg2rL7BadM7ewG6x6fE1VovLu+awWWxYPJvZ4vnCH8wWBz88YbX4c/s/k8XPXfNYLPr2
        Blm03DG1uD9pM4vF8ge72B0EPJ4cnMfksWbeGkaPnbPusntsWtXJ5nHn2h42jwmLDjB6zDsZ
        6LF5Sb3H5BvLGT1aTu5n8ehtfsfm0T+vn8nj8ya5AN4oLpuU1JzMstQifbsEroz1rU1MBUtk
        K5onfmJsYFwn2sXIySEhYCLxeMJa9i5GLg4hgRWMEgv3nmKFcL4wSpzZdQQq85lR4u7xzWww
        Ld+6HrNAJJYzStx48oIFJCEk8JFR4uGdQBCbV8BO4k3DVyYQm0VAVaK96SwzRFxQ4uTMJ2D1
        ogJJEnP33QOLCwtYSOy82QYWZxYQl7j1ZD5Yr4iAp8TZ3h1gJzEL3GWSeDPxM1gRm4ChRNfb
        LrCLOIGady/+ANUsL7H97RxmkAYJgUucEnunL2PsYuQAclwkHvyPgPhAWOLV8S3sELaMxOnJ
        PSwQJfkSf2cYQ4QrJK69XsMMYVtL3Dn3iw2khFlAU2L9Ln2IsKNE44fJUJ18EjfeCkIcwCcx
        adt0Zogwr0RHmxBEtZrErOPr4HYevHCJeQKj0iykMJmF5PdZSF6ZhbB3ASPLKkbx1NLi3PTU
        YuO81HK94sTc4tK8dL3k/NxNjMDkePrf8a87GFe8+qh3iJGJg/EQowQHs5II783+8CQh3pTE
        yqrUovz4otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTNs+nund3f88ZmrL
        r92yXbu/lZrOMVMXmDtv252ilW9/3jPjmqMYq6jk6aXJuenDj+eV8r+zdy5Tkwg7VP/cTzO1
        qXrhngcZXj8+/zIsK79v8W1Fx9PKZ7GC1yQSBRWYduXxHrLhT/rULtCgdJ591WaukOynhurG
        /w8v8fA09uy3cumM4BHnZD1ZmH1J7tiGG5vWX0oKFWxxdq1dG7/Z5FuArTFHUpTd08vvjJ73
        HVvZb+vY4H4tLUWIs9P52IqPhy8d6kvbd5A3jtNDaVv2nzV9sbfMHrMwlH/g9Tasybu4OFB5
        kuTSp9dP73BM3l1Qliz1VkLshuNaNw+dBx98jvX1L6tLPRHWuuG+e16SEktxRqKhFnNRcSIA
        CnS3Fv0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Xd3M7ogkg1lPjSw2T9zKZvG+Oc5i
        wX5ri4bVF1gtOmdvYLfY9Pgaq8XlXXPYLDYsns1s8XzhD2aLgx+esFr8uf2fyeLnrnksFn17
        gyxa7pha3J+0mcVi+YNd7A4CHk8OzmPyWDNvDaPHzll32T02repk87hzbQ+bx4RFBxg95p0M
        9Ni8pN5j8o3ljB4tJ/ezePQ2v2Pz6J/Xz+TxeZNcAG+Unk1RfmlJqkJGfnGJrVK0oYWRnqGl
        hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb61iamgiWyFc0TPzE2MK4T7WLk5JAQMJH4
        1vWYpYuRi0NIYCmjxKRzfWwQCRmJk9MaWCFsYYk/17rYIIreM0qcWvaVESTBK2An8abhKxOI
        zSKgKtHedJYZIi4ocXLmExYQW1QgSeLFtudg9cICFhI7b7aBxZkFxCVuPZkP1isi4ClxtncH
        K8gCZoG7TBInf79lB0kICXQzSnQstQKx2QQMJbredoFdxwk0aPfiD1CDzCS6tnYxQtjyEtvf
        zmGewCg0C8kds5Dsm4WkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECk8K2Yz83
        72Cc9+qj3iFGJg7GQ4wSHMxKIrw3+8OThHhTEiurUovy44tKc1KLDzGaAgNjIrOUaHI+MC3l
        lcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUw7U8yTDhT9l5PZy1H
        21xHj2cddy57FtyZ/PlpiuY+cX+fCPFL12atOWqS/3GOQOFlQavbR2z/nQlfNenjjwbLRf4S
        XMtu5j7fzLB36eHD+lZy2y6yXVxm3nxmg1i6UOWSPlPbmcaJ/5dE/jszqSV4qkMZm3DgS6n/
        VsXlZ8Kvl3o1qWkURZRGZD7Y1m78LkFwxp+tXDarf6fYO2qocQd9zPa/E7PuSGXvJd5Ff5xt
        n0r9lxTqEUt24Z2o5evEdajs0VZZDa6m9XMmzJETzix9LJBQwvj9vF+2cuGcb7KyXkWz2r08
        2aN8Jy7Z3PtqpeBNq4bazFlX1ubrX2rzEVz666jBfrXpCR1P6/nPG7spsRRnJBpqMRcVJwIA
        OnM/1ZMDAAA=
X-CMS-MailID: 20220414210025eucas1p1c3faa4c9c3ce5fd273ba0675e7a2c86a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220414124252eucas1p1f2d8689ef5d281ea70d619888108d2fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220414124252eucas1p1f2d8689ef5d281ea70d619888108d2fe
References: <CGME20220414124252eucas1p1f2d8689ef5d281ea70d619888108d2fe@eucas1p1.samsung.com>
        <cover.1649935679.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 14.04.2022 14:42, Robin Murphy wrote:
> Hi all,
>
> Here's another chapter in my saga of moving to per-instance IOMMU ops -
> iommu_present() and iommu_capable() cleanups will be ongoing for another
> cycle or two, while this one is at least self-contained within the
> subsystem. The next steps after this are making iommu_domain_alloc()
> instance-aware - which should finish the public API - and pulling the
> fwnode/of_xlate bits into __iommu_probe_device(). And then making sense
> of whatever's left :)
>
> For ease of review here I split out individual driver patches based on
> whether there was any non-trivial change or affect on control flow; the
> straightforward deletions are all lumped together since the whole series
> needs applying together either way, but I'm happy to split the final
> patch up further if anyone would like.
>
> Patch #3 for AMD is based on Mario's SWIOTLB patch here:
>
> https://lore.kernel.org/linux-iommu/20220404204723.9767-1-mario.limonciello@amd.com/
>
> since that wants merging first as fix material. The series is also based
> contextually (but not functionally) on my device_iommu_capable() patches
> here:
>
> https://lore.kernel.org/linux-iommu/cover.1649089693.git.robin.murphy@arm.com/
>
> since those are pretty much good to go now (I'll send a slightly-tweaked
> final version once the iommu/core branch is open).

Works fine on Samsung Exynos based boards (both, ARM 32bit and 64bit).

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com> # for Exynos 
relevant changes


>
> Thanks,
> Robin.
>
>
> Robin Murphy (13):
>    iommu: Always register bus notifiers
>    iommu: Move bus setup to IOMMU device registration
>    iommu/amd: Clean up bus_set_iommu()
>    iommu/arm-smmu: Clean up bus_set_iommu()
>    iommu/arm-smmu-v3: Clean up bus_set_iommu()
>    iommu/dart: Clean up bus_set_iommu()
>    iommu/exynos: Clean up bus_set_iommu()
>    iommu/ipmmu-vmsa: Clean up bus_set_iommu()
>    iommu/mtk: Clean up bus_set_iommu()
>    iommu/omap: Clean up bus_set_iommu()
>    iommu/tegra-smmu: Clean up bus_set_iommu()
>    iommu/virtio: Clean up bus_set_iommu()
>    iommu: Clean up bus_set_iommu()
>
>   drivers/iommu/amd/amd_iommu.h               |   1 -
>   drivers/iommu/amd/init.c                    |   9 +-
>   drivers/iommu/amd/iommu.c                   |  21 ----
>   drivers/iommu/apple-dart.c                  |  30 +-----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +---------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +--------------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
>   drivers/iommu/exynos-iommu.c                |   9 --
>   drivers/iommu/fsl_pamu_domain.c             |   4 -
>   drivers/iommu/intel/iommu.c                 |   1 -
>   drivers/iommu/iommu.c                       | 109 +++++++++-----------
>   drivers/iommu/ipmmu-vmsa.c                  |  35 +------
>   drivers/iommu/msm_iommu.c                   |   2 -
>   drivers/iommu/mtk_iommu.c                   |  13 +--
>   drivers/iommu/mtk_iommu_v1.c                |  13 +--
>   drivers/iommu/omap-iommu.c                  |   6 --
>   drivers/iommu/rockchip-iommu.c              |   2 -
>   drivers/iommu/s390-iommu.c                  |   6 --
>   drivers/iommu/sprd-iommu.c                  |   5 -
>   drivers/iommu/sun50i-iommu.c                |   2 -
>   drivers/iommu/tegra-smmu.c                  |  29 ++----
>   drivers/iommu/virtio-iommu.c                |  24 -----
>   include/linux/iommu.h                       |   1 -
>   23 files changed, 62 insertions(+), 401 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

