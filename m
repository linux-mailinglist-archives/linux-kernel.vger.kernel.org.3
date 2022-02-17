Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF694BA29B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiBQOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:10:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiBQOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:10:07 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07A2B1641
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:09:52 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220217140951euoutp013bb1f6a1bc7b86319ceea966cb5890a2~UmBejf7wF1824818248euoutp01T
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:09:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220217140951euoutp013bb1f6a1bc7b86319ceea966cb5890a2~UmBejf7wF1824818248euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645106991;
        bh=L90JLP9FU+DR9jx26T68H3yy915vfZ9ydJA4vjG6jd0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ZMM9as9366DSlsbza2YRCsCqiYGpxWkoKvoUbwOWqo3a+hKuswAg2f6uPZ1QUos4b
         5TJS60TxSAjsxjP12a6Dn6b/rzim37D9TsYZbLP2L8rL5xF7wrGjWuSzxXBxuPOq5N
         rHUa4GFqGg0Ey4YymQTp25xSlXljF+Hcv0254AnA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220217140950eucas1p22bc8a188c3985a8a98fb6cb9590050dc~UmBeHSvW_1797717977eucas1p2i;
        Thu, 17 Feb 2022 14:09:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 28.EA.10260.E275E026; Thu, 17
        Feb 2022 14:09:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220217140950eucas1p1d6be8434ef341509b66b2f372702805d~UmBdscHP92427524275eucas1p1F;
        Thu, 17 Feb 2022 14:09:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220217140950eusmtrp1de06340e37231ecb4409bc43d387779e~UmBdrVNQH1748017480eusmtrp1E;
        Thu, 17 Feb 2022 14:09:50 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-cd-620e572ee2b8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D0.65.09404.E275E026; Thu, 17
        Feb 2022 14:09:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220217140949eusmtip2e403f9076797fc0962b2458e441458c7~UmBdNZe-G1510715107eusmtip2F;
        Thu, 17 Feb 2022 14:09:49 +0000 (GMT)
Message-ID: <585d09d8-b2ba-97e3-992e-404364fa6bb5@samsung.com>
Date:   Thu, 17 Feb 2022 15:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v3] regmap-irq: Update interrupt clear register for
 proper reset
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220217131733.GH38351@ediswmail.ad.cirrus.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7p64XxJBoseaVlMffiEzeJK6yZG
        i+bF69ksLu+aw2ax5t9iZou5X6YyW7QdO8bqwO6xaVUnm8eda3vYPPbPXcPuMX3Of0aPiXvq
        PD5vkgtgi+KySUnNySxLLdK3S+DK+DB7LUvBMcWKSS9+MjUwXpPoYuTgkBAwkVjwXK+LkYtD
        SGAFo8SqP5NZIJwvjBILDjWydzFyAjmfGSW2L9YEsUEaHj/ezw5RtJxRYtYZkA6Qoo+MElcf
        m4BM5RWwk+ieWQESZhFQlfi+9QsjiM0rIChxcuYTFpASUYEkiUXb3EHCwgJhEm/3nWUGsZkF
        xCVuPZnPBGKLCCRKdEx4xgoRv84osecE2DlsAoYSXW+72EBsTgFbidtP/jJB1MhLNG+dzQxy
        moTACw6JP6t+sUA86SLx9UAAxPnCEq+Ob2GHsGUkTk/uYYGob2aUeHhuLTuE08MocblpBiNE
        lbXEnXO/2EAGMQtoSqzfpQ8RdpRYt+kWE8R8PokbbwUhbuCTmLRtOjNEmFeio00IolpNYtbx
        dXBrD164xDyBUWkWUqDMQvL9LCTfzELYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7u
        JkZgCjr97/jXHYwrXn3UO8TIxMF4iFGCg1lJhPfDQd4kId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUz2S96ZrinxsS9Z2HlSSIapN7PQR3Pqx3dvr/xy
        S7oeOUd76u/kE7O+KB/OfayneuXLGQ6LPA+Z78ecPQ7cdwnb0jHn9uL5s/9d0vC84rbnhXW5
        R9LHoEq7Tpey7ZqZH1f/L76y/qfI733LZZ+dOHB+6epzzqvtJ16p0U3+m7qUMZElpSzv2M6r
        73a5LU72njc7Z21YxrqT3y9MZXjpuGPH5MyZrlqdvRnt+Qf2vjkvPNn0dntBmHVQ1q+H7xL6
        N10I0BI47+fQvv54i9trSSZb1nOeZzlOHlOM3Vtc8OPbyalJHL/OhO9g8Vrp0yQyLfVpaZpJ
        SX6paeu7nik5mzd+PrIs2Kn+l/nk5xNfz3DWVWIpzkg01GIuKk4EAAEwKP+wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7p64XxJBl96+SymPnzCZnGldROj
        RfPi9WwWl3fNYbNY828xs8XcL1OZLdqOHWN1YPfYtKqTzePOtT1sHvvnrmH3mD7nP6PHxD11
        Hp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlfJi9lqXgmGLFpBc/mRoYr0l0MXJySAiYSDx+vJ+9i5GLQ0hgKaPE397rzBAJGYmT0xpY
        IWxhiT/Xutggit4zSmz7dAHI4eDgFbCT6J5ZAVLDIqAq8X3rF0YQm1dAUOLkzCcsILaoQJLE
        uunzwWYKC4RJnNzezA5iMwuIS9x6Mp8JxBYRSJT4fOQj2HxmgeuMEl/2PoK66CijxP6Zm8Em
        sQkYSnS9BbmCk4NTwFbi9pO/TBCTzCS6tnYxQtjyEs1bZzNPYBSaheSQWUgWzkLSMgtJywJG
        llWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8bft2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+H
        g7xJQrwpiZVVqUX58UWlOanFhxhNgaExkVlKNDkfmADySuINzQxMDU3MLA1MLc2MlcR5PQs6
        EoUE0hNLUrNTUwtSi2D6mDg4pRqYshQz2DvTj15RXz/1mnrYP/Xrm9UV+vW+ZTMczppYUqwu
        /CNM9NXsqFnfBNQy3c7fnn3bR/huikNT7bz/9hebZnOF2T78dpvVfV3uK82rXxPuVX47IdX2
        7MkOn292m09kVrenX7wq0ztX/6XlnG6+DSs28sdlHtraXpxcw6i0kcX5xdNtC44ePbc1T/J/
        bUj2r03xih8mLuC7ee/EV3GW6NszvmY0u37Kip96k930fXferKorrqqybzX67JdcsorhKS7e
        6JDH7MSflip1fd/Zx1FXNvZNXillF5seb5/Nk7+S0+x/j952U++LuUa2yXenhDVIPY1u+mnS
        cEm+PjD2ke2f3u3Ge2J6zyx09D+lxFKckWioxVxUnAgAGNJvMkgDAAA=
X-CMS-MailID: 20220217140950eucas1p1d6be8434ef341509b66b2f372702805d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220217131745eucas1p16489e2c6a7c9e11dccd2a9c5dc322c6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220217131745eucas1p16489e2c6a7c9e11dccd2a9c5dc322c6d
References: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
        <CGME20220217131745eucas1p16489e2c6a7c9e11dccd2a9c5dc322c6d@eucas1p1.samsung.com>
        <20220217131733.GH38351@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.2022 14:17, Charles Keepax wrote:
> On Thu, Feb 17, 2022 at 02:20:07PM +0530, Prasad Kumpatla wrote:
>
> + Marek Szyprowski, as the old version of the patch was causing
> problems on his system.

Both devices affected by the previous version of the patch work fine 
with this version.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>> With the existing logic where clear_ack is true (HW doesn’t support
>> auto clear for ICR), interrupt clear register reset is not handled
>> properly. Due to this only the first interrupts get processed properly
>> and further interrupts are blocked due to not resetting interrupt
>> clear register.
>>
>> Example for issue case where Invert_ack is false and clear_ack is true:
>>
>>      Say Default ISR=0x00 & ICR=0x00 and ISR is triggered with 2
>>      interrupts making ISR = 0x11.
>>
>>      Step 1: Say ISR is set 0x11 (store status_buff = ISR). ISR needs to
>>              be cleared with the help of ICR once the Interrupt is processed.
>>
>>      Step 2: Write ICR = 0x11 (status_buff), this will clear the ISR to 0x00.
>>
>>      Step 3: Issue - In the existing code, ICR is written with ICR =
>>              ~(status_buff) i.e ICR = 0xEE -> This will block all the interrupts
>>              from raising except for interrupts 0 and 4. So expectation here is to
>>              reset ICR, which will unblock all the interrupts.
>>
>>              if (chip->clear_ack) {
>>                   if (chip->ack_invert && !ret)
>>                    ........
>>                   else if (!ret)
>>                       ret = regmap_write(map, reg,
>>                              ~data->status_buf[i]);
>>
>> So writing 0 and 0xff (when ack_invert is true) should have no effect, other
>> than clearing the ACKs just set.
>>
>> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
>> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>> ---
> I think this version looks like it should work to me.
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles
>
>>   drivers/base/regmap/regmap-irq.c | 20 ++++++--------------
>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
>> index d2656581a608..4a446259a184 100644
>> --- a/drivers/base/regmap/regmap-irq.c
>> +++ b/drivers/base/regmap/regmap-irq.c
>> @@ -189,11 +189,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>>   				ret = regmap_write(map, reg, d->mask_buf[i]);
>>   			if (d->chip->clear_ack) {
>>   				if (d->chip->ack_invert && !ret)
>> -					ret = regmap_write(map, reg,
>> -							   d->mask_buf[i]);
>> +					ret = regmap_write(map, reg, UINT_MAX);
>>   				else if (!ret)
>> -					ret = regmap_write(map, reg,
>> -							   ~d->mask_buf[i]);
>> +					ret = regmap_write(map, reg, 0);
>>   			}
>>   			if (ret != 0)
>>   				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
>> @@ -556,11 +554,9 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>>   						data->status_buf[i]);
>>   			if (chip->clear_ack) {
>>   				if (chip->ack_invert && !ret)
>> -					ret = regmap_write(map, reg,
>> -							data->status_buf[i]);
>> +					ret = regmap_write(map, reg, UINT_MAX);
>>   				else if (!ret)
>> -					ret = regmap_write(map, reg,
>> -							~data->status_buf[i]);
>> +					ret = regmap_write(map, reg, 0);
>>   			}
>>   			if (ret != 0)
>>   				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
>> @@ -817,13 +813,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>>   					d->status_buf[i] & d->mask_buf[i]);
>>   			if (chip->clear_ack) {
>>   				if (chip->ack_invert && !ret)
>> -					ret = regmap_write(map, reg,
>> -						(d->status_buf[i] &
>> -						 d->mask_buf[i]));
>> +					ret = regmap_write(map, reg, UINT_MAX);
>>   				else if (!ret)
>> -					ret = regmap_write(map, reg,
>> -						~(d->status_buf[i] &
>> -						  d->mask_buf[i]));
>> +					ret = regmap_write(map, reg, 0);
>>   			}
>>   			if (ret != 0) {
>>   				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
>> -- 
>> 2.17.1
>>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

