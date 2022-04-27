Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7084D511335
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359294AbiD0IJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359414AbiD0IJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:09:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2491E3F0;
        Wed, 27 Apr 2022 01:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D9CCB8252E;
        Wed, 27 Apr 2022 08:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC4C385A7;
        Wed, 27 Apr 2022 08:05:48 +0000 (UTC)
Message-ID: <06c5c170-f39c-cd8e-4aa6-5fde56bfa09b@xs4all.nl>
Date:   Wed, 27 Apr 2022 10:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] media: mtk-mdp: make mtk_mdp_comp_init static
Content-Language: en-US
To:     houlong wei <houlong.wei@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "dafna.hirschfeld@collabora.com" <dafna.hirschfeld@collabora.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <Minghsiu.Tsai@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
References: <20210811171512.1.I4a34d99ace27ad2fe55e22c90244d3bba2c29bab@changeid>
 <484e199d23a09d79f121ea37eb9e7d95eabfd886.camel@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <484e199d23a09d79f121ea37eb9e7d95eabfd886.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since the patch series this depends on hasn't been accepted (and using
the components framework is highly controversial in the media subsystem
anyway), I'm marking this (just as the patch series itself) as
'Changes Requested' in the media patchwork. If you want to continue
with this, then this patch should be folded into a v8.

Regards,

	Hans

On 16/08/2021 06:26, houlong wei wrote:
> On Wed, 2021-08-11 at 15:15 +0800, Eizan Miyamoto wrote:
>> This function isn't and doesn't need to be used outside of
>> mtk_mdp_comp.c
>>
>> This patch depends on and is a follow-up to
>>
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=524929
>>
>> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
>> ---
> 
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> 
>>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 2 +-
>>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h | 2 --
>>  2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
>> b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
>> index 9527649de98e..2cf8f1864f8c 100644
>> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
>> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
>> @@ -234,7 +234,7 @@ static const struct component_ops
>> mtk_mdp_component_ops = {
>>  	.unbind = mtk_mdp_comp_unbind,
>>  };
>>  
>> -int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
>> +static int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct
>> device *dev)
>>  {
>>  	struct device_node *larb_node;
>>  	struct platform_device *larb_pdev;
>> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
>> b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
>> index e3d6aef52869..aa6442cc8c1d 100644
>> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
>> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
>> @@ -21,8 +21,6 @@ struct mtk_mdp_comp {
>>  	struct device		*larb_dev;
>>  };
>>  
>> -int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device
>> *dev);
>> -
>>  int mtk_mdp_comp_power_on(struct mtk_mdp_comp *comp);
>>  int mtk_mdp_comp_power_off(struct mtk_mdp_comp *comp);
>>  
>> -- 
>> 2.32.0.605.g8dce9f2422-goog
>>

