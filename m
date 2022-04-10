Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB554FAEF0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiDJQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiDJQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:29 -0400
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1E192B8;
        Sun, 10 Apr 2022 09:32:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07502633|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.094111-0.000410477-0.905478;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.NNs1TPY_1649608329;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NNs1TPY_1649608329)
          by smtp.aliyun-inc.com(33.37.77.208);
          Mon, 11 Apr 2022 00:32:10 +0800
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <b6090a27-12b7-0c01-6d33-ae32b31b4b74@wanyeetech.com>
Date:   Mon, 11 Apr 2022 00:32:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <81BA49E3-AFDE-4DFD-BB77-2B03488C727B@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On 2022/4/9 下午9:53, H. Nikolaus Schaller wrote:
>
>> Am 09.04.2022 um 15:44 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 09/04/2022 15:32, H. Nikolaus Schaller wrote:
>>>
>>>> Am 09.04.2022 um 15:15 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>>>
>>>> On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>>>>> This looks wrong, the block usually should have a specific compatible.
>>>>>> Please mention why it does not.
>>>>> Well, I did not even have that idea that it could need an explanation.
>>>>>
>>>>> There is no "ingenic,jz4780-otg" and none is needed here to make it work.
>>>> Make it work in what terms? We talk about hardware description, right?
>>> Yes.
>>>
>>>>> Therefore the generic "snps,dwc2" is sufficient.
>>>> No, you are mixing now driver behavior (is sufficient) with hardware
>>>> description.
>>> No. "snps,dwc2" is a hardware description for a licensed block.
>>> Not a driver behavior.
>> snps,dwc2 matches the original block, not necessarily this
>> implementation. Unless you are sure?
> I assume. Nobody has reported an issue without having any specific jz4780 driver in place.
> Well, that is only evidence, not bullet proof.
>
>>>> Most of licensed blocks require the specific compatible to
>>>> differentiate it.
>>> If there is a need to differentiate.
>> No, regardless whether there is a need currently, most of them have
>> specific compatibles, because there are some minor differences. Even if
>> difference is not visible from programming model or wiring, it might
>> justify it's own specific compatible. For example because maybe once
>> that tiny difference will require some changes.
>>
>> Someone added the ingenic compatible, so why do you assume that one tool
>> (bindings) is correct but other piece of code (using specific
>> compatible) is not? You use the argument "bindings warning" which is not
>> enough. Argument that blocks are 100% same, is good enough, if you are
>> sure. Just use it in commit msg. But are you sure that these are the
>> same? Same pins, same programming model (entire model, not used by Linux)?
> The compatible ingenic,jz4780-otg was introduced in 158c774d3c64859e84dd20e04d5fb18c8d3d318e.
> Hence I have added Yanjie for clarification why he added it in the .dts and not in the bindings.


It's my fault, last year I made an OTG driver for Ingenic SoCs and sent it
to the mailing list, and then I received some revision comments, but for
some personal reasons I didn't continue to improve it.

I'll finish these modifications as soon as possible and send them out.
Then after they merge into the mainline, this problem will be solved.


Thanks and best regards!


>
> BR and thanks,
> Nikolaus
>
