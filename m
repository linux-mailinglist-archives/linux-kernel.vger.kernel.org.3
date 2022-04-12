Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE22A4FDD27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiDLK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbiDLKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:53:32 -0400
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E04923178;
        Tue, 12 Apr 2022 02:49:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437479|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.016684-0.000618175-0.982698;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.NP95aWT_1649756947;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NP95aWT_1649756947)
          by smtp.aliyun-inc.com(33.37.72.206);
          Tue, 12 Apr 2022 17:49:08 +0800
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
 <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
 <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
 <3e95f567-03f5-bf9c-1856-9fe602e9b025@linaro.org>
 <81BA49E3-AFDE-4DFD-BB77-2B03488C727B@goldelico.com>
 <b6090a27-12b7-0c01-6d33-ae32b31b4b74@wanyeetech.com>
 <8FA36CE4-CD39-4767-B49E-D112E4313036@goldelico.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <3e088e18-5df9-bf50-0070-b24b8a3c5f41@wanyeetech.com>
Date:   Tue, 12 Apr 2022 17:49:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8FA36CE4-CD39-4767-B49E-D112E4313036@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On 2022/4/11 上午3:13, H. Nikolaus Schaller wrote:
> Hi,
>
>> Am 10.04.2022 um 18:32 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>:
>>
>> Hi folks,
>>
>> On 2022/4/9 下午9:53, H. Nikolaus Schaller wrote:
>>>> Am 09.04.2022 um 15:44 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>>>
>>>> On 09/04/2022 15:32, H. Nikolaus Schaller wrote:
>>>>>> Am 09.04.2022 um 15:15 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>>>>>
>>>>>> On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>>>>>>> This looks wrong, the block usually should have a specific compatible.
>>>>>>>> Please mention why it does not.
>>>>>>> Well, I did not even have that idea that it could need an explanation.
>>>>>>>
>>>>>>> There is no "ingenic,jz4780-otg" and none is needed here to make it work.
>>>>>> Make it work in what terms? We talk about hardware description, right?
>>>>> Yes.
>>>>>
>>>>>>> Therefore the generic "snps,dwc2" is sufficient.
>>>>>> No, you are mixing now driver behavior (is sufficient) with hardware
>>>>>> description.
>>>>> No. "snps,dwc2" is a hardware description for a licensed block.
>>>>> Not a driver behavior.
>>>> snps,dwc2 matches the original block, not necessarily this
>>>> implementation. Unless you are sure?
>>> I assume. Nobody has reported an issue without having any specific jz4780 driver in place.
>>> Well, that is only evidence, not bullet proof.
>>>
>>>>>> Most of licensed blocks require the specific compatible to
>>>>>> differentiate it.
>>>>> If there is a need to differentiate.
>>>> No, regardless whether there is a need currently, most of them have
>>>> specific compatibles, because there are some minor differences. Even if
>>>> difference is not visible from programming model or wiring, it might
>>>> justify it's own specific compatible. For example because maybe once
>>>> that tiny difference will require some changes.
>>>>
>>>> Someone added the ingenic compatible, so why do you assume that one tool
>>>> (bindings) is correct but other piece of code (using specific
>>>> compatible) is not? You use the argument "bindings warning" which is not
>>>> enough. Argument that blocks are 100% same, is good enough, if you are
>>>> sure. Just use it in commit msg. But are you sure that these are the
>>>> same? Same pins, same programming model (entire model, not used by Linux)?
>>> The compatible ingenic,jz4780-otg was introduced in 158c774d3c64859e84dd20e04d5fb18c8d3d318e.
>>> Hence I have added Yanjie for clarification why he added it in the .dts and not in the bindings.
>>
>> It's my fault, last year I made an OTG driver for Ingenic SoCs and sent it
>> to the mailing list, and then I received some revision comments, but for
>> some personal reasons I didn't continue to improve it.
>>
>> I'll finish these modifications as soon as possible and send them out.
>> Then after they merge into the mainline, this problem will be solved.
> No need to apologize.
>
> If you agree I can add "ingenic,jz4780-otg" to the schema file and keep
> the .dts in the v2 of my series.


Sure.

Or you can wait a bit, I plan to send out new patches later today, it 
contains "ingenic,jz4780-otg".


> And I'll add you to the list of reviewers, so you can please comment v2
> if it is correct or if we are still missing something.


Okay, thanks!


>
> Best regards and thanks,
> Nikolaus
