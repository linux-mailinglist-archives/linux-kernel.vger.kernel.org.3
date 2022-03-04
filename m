Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0F4CD20D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiCDKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiCDKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:08:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23245793;
        Fri,  4 Mar 2022 02:07:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3D2CF1F464FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646388469;
        bh=FZsV9ba/xuMDKrYCeoG5kKb+WB3TEznV+q7TAKpo3JE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z/+HfKH6m2gMYR33+DYiAue+iFGOvhah5GOHFpNlKFJqMG4MOd1VbxxrERk9rfAtu
         8/Qd1FnQpl8UrU1lpchE1zxVjdxc8M46oXrPWgg9e07c8pGsGSItv44kp+mT8vkxiC
         GqKMLEbT6u0aMosmlCZK3J02q13Vcqt7xl1S3bzZ9gL6QZxwDFnYoCzJHth9SqmKt/
         zdAo07VBT2F1Sy2xWlemRsHGnyl3/3GjNVh2dW1sF+CDd8leaItHUb94UDOyyT6Uvd
         3vidqdgIrB5sogWh7aqmnt7IJTQxNQiO/aLZ9ww7dxnQLDl/Z50tobHcx3MmMwzheE
         MK7tpc8yctI2Q==
Message-ID: <6b1bd27c-d371-51eb-d166-575312d8506f@collabora.com>
Date:   Fri, 4 Mar 2022 11:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <YhzBSsn/zUlGg5JE@8bytes.org>
 <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
 <5ed9278fa0b72b993512cff2316218ab88cafe50.camel@mediatek.com>
 <YiHZ4lq2QClkdyxS@8bytes.org>
 <123cb154ca0e87504c2b663ebdca2ccad967776f.camel@mediatek.com>
 <YiHkhERbAY8oYRYw@8bytes.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YiHkhERbAY8oYRYw@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 11:05, Joerg Roedel ha scritto:
> On Fri, Mar 04, 2022 at 05:57:19PM +0800, Yong Wu wrote:
>> Thanks for this info. I will re-send this patchset after the next -rc1.
>>
>> Could you help apply Dafna's patchset at this time? This patchset
>> depends on it and it won't conflict with the others.
> 
> Alright, picked up Dafna's patch-set.
> 
> Regards,
> 
> 	Joerg

Thanks for picking Dafna's series right now, this was very appreciated.

Regards,
Angelo
