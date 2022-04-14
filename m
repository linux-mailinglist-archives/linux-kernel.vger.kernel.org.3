Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5782D5019D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbiDNRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbiDNRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:16:46 -0400
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF03617D;
        Thu, 14 Apr 2022 10:11:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1074771|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0686534-0.00765563-0.923691;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.NQlfgH1_1649956298;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQlfgH1_1649956298)
          by smtp.aliyun-inc.com(33.38.168.42);
          Fri, 15 Apr 2022 01:11:39 +0800
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hminas@synopsys.com, Rob Herring <robh+dt@kernel.org>,
        linux-usb@vger.kernel.org, linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, dragancecavac@yahoo.com,
        dongsheng.qiu@ingenic.com, qipengzhen <aric.pzqi@ingenic.com>,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
 <6F03670F-9040-4560-AD78-CC7A03EC678F@goldelico.com>
 <c79a8ff7-7a3f-9627-f910-dbbf942e34cb@wanyeetech.com>
 <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
 <76ea346b-0645-97b5-f8fb-5b46b4bcc80b@linaro.org>
 <F6929BAA-D552-4C34-B392-33AEA263F0C9@goldelico.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <40d34f8b-4ab7-5ced-b533-da1f4b501cdc@wanyeetech.com>
Date:   Fri, 15 Apr 2022 01:11:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <F6929BAA-D552-4C34-B392-33AEA263F0C9@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/14 下午6:00, H. Nikolaus Schaller wrote:
>
>> Am 14.04.2022 um 09:32 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 13/04/2022 21:30, H. Nikolaus Schaller wrote:
>>> So we need "snps,dwc2" to get any driver match and I thought the "ingenic,jz4780-otg" is redundant.
>>>
>>> But maintainers convinced me to keep it as a dummy compatible in the .dtsi for potential future
>>> specialization (which does not exist and seems not to be necessary).
>> Isn't exactly the next patch 2/2 using such specialization?
>>
>>> Unless I can convince them
>>> that this is never ever needed. Which is beyond my knowledge and almost everyone.
>>>
>>> So we can't remove the "snps,dwc2" here.
>>>
>>> Well, we can with more work elsewhere.
>>> You have to extend the dwc2_of_match_table to include all ingenic devices.
>>>
>>> Therefore we now know 3 potential solutions:
>>> a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
>>> b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" (your proposal + my suggestion here)
>>> c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match table in drivers//usb/dwc2/params.c (new proposals)
>>>
>>>  From consistency point of view I think variant b) is the right one. a) was rejected and c) only adds redundant code.
>> c) was already proposed by Zhou, so if you think the code is not correct
>> (the params for jz4780) maybe nack it there, so we will know that driver
>> needs fixes.
> Ah, ok. Now I see. I was just focussed on this patch and related dtbscheck
> messages and did not read patch 2/2.
>
> Yes, looking at both, they are variant c). Sorry that I didn't see it earlier.

It looks like we need a [3/3] to remove "snps,dwc2", which not only solves
the dtbscheck complaining problem, but also doesn't affect normal use after
removing "snps,dwc2".


>
> As said: I am open to anything as long as the dtbscheck doesn't complain any more.
>
> BR and sorry for the confusion,
> Nikolaus
