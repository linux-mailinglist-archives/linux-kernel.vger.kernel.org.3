Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A32B4650B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbhLAPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbhLAPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:03:50 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496C3C061748;
        Wed,  1 Dec 2021 07:00:28 -0800 (PST)
Received: from [192.168.1.101] (83.6.166.111.neoplus.adsl.tpnet.pl [83.6.166.111])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 91A103F6CF;
        Wed,  1 Dec 2021 16:00:23 +0100 (CET)
Message-ID: <bd109d31-4f87-1155-613b-7df4293b3163@somainline.org>
Date:   Wed, 1 Dec 2021 16:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu
 implementation
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211201073943.3969549-1-vkoul@kernel.org>
 <20211201073943.3969549-3-vkoul@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211201073943.3969549-3-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.2021 08:39, Vinod Koul wrote:
> Add SM8450 qcom iommu implementation to the table of
> qcom_smmu_impl_of_match table which brings in iommu support for
> SM8450 SoC
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

With deep pain, as we've had to deal with this for a few generations now..

Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>



Konrad

