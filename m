Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A94FFF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiDMTpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbiDMTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:45:00 -0400
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E7979389;
        Wed, 13 Apr 2022 12:42:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07527822|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0857127-0.00646813-0.907819;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NQ7bWa9_1649878951;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQ7bWa9_1649878951)
          by smtp.aliyun-inc.com(33.37.2.29);
          Thu, 14 Apr 2022 03:42:33 +0800
Subject: Re: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <56cf73fc-1a7d-831d-b8a4-ff077d260c1c@wanyeetech.com>
Date:   Thu, 14 Apr 2022 03:42:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0AE74BF9-46F1-44EC-8E5F-40EA12851AD0@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On 2022/4/14 上午3:30, H. Nikolaus Schaller wrote:
> Hi,
>
>
>> Am 13.04.2022 um 20:55 schrieb Zhou Yanjie <zhouyanjie@wanyeetech.com>:
>>
>> Hi Nikolaus,
>>
>> On 2022/4/13 下午3:22, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>>
>>>> Am 12.04.2022 um 20:30 schrieb 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>>> :
>>>>
>>>> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
>>>> SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
>>>> from Ingenic.
>>>>
>>>> Signed-off-by: 周琰杰 (Zhou Yanjie)
>>>> <zhouyanjie@wanyeetech.com>
>>>>
>>>> Acked-by: Rob Herring
>>>> <robh@kernel.org>
>>>>
>>>> ---
>>>>
>>>> Notes:
>>>>     v1->v2:
>>>>     Add Rob Herring's Acked-by.
>>>>
>>>> Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
>>>> 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>>> index 4cebce6..c6e8c0b 100644
>>>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>>>> @@ -17,6 +17,13 @@ properties:
>>>>      oneOf:
>>>>        - const: brcm,bcm2835-usb
>>>>        - const: hisilicon,hi6220-usb
>>>> +      - const: ingenic,jz4775-otg
>>>> +      - const: ingenic,jz4780-otg
>>>> +      - const: ingenic,x1000-otg
>>>> +      - const: ingenic,x1600-otg
>>>> +      - const: ingenic,x1700-otg
>>>> +      - const: ingenic,x1830-otg
>>>> +      - const: ingenic,x2000-otg
>>>>
>>> I have merged it with my recently proposed removal of
>>> ingenic,jz4780-otg in jz4780.dtsi but there was no dtbscheck
>>> complaint about missing snps,dwc2.
>>>
>>> So I think should it be:
>>>
>>>        - items:
>>>            - enum:
>>>                - const: ingenic,jz4775-otg
>>>                - const: ingenic,jz4780-otg
>>>                - const: ingenic,x1000-otg
>>>                - const: ingenic,x1600-otg
>>>                - const: ingenic,x1700-otg
>>>                - const: ingenic,x1830-otg
>>>                - const: ingenic,x2000-otg
>>>
> PS: the const: above should be removed (I hadn't run it through the compiler).
>
>>>            - const: snps,dwc2
> here it is needed.
>
>>> similar to the entry for amlogic?
>>>
>>
>> Or we can just remove the "snps,dwc2" from jz4780.dtsi?
> Well, my recent proposal to fix dtbscheck was the other way round:
> remove "ingenic,jz4780-otg" from jz4780.dtsi and leave it out here.
>
>> I'm not too sure, but since we already have a dedicated "ingenic, jz4780-otg", it seems "snps,dwc2" is redundant.
> As far as I see there is no driver specialization compatible to
> "ingenic,jz4780-otg". `grep ingenic,jz4780-otg *` only shows the .dtsi (and the new .yaml).
>
> So we need "snps,dwc2" to get any driver match and I thought the "ingenic,jz4780-otg" is redundant.
>
> But maintainers convinced me to keep it as a dummy compatible in the .dtsi for potential future
> specialization (which does not exist and seems not to be necessary). Unless I can convince them
> that this is never ever needed. Which is beyond my knowledge and almost everyone.
>
> So we can't remove the "snps,dwc2" here.
>
> Well, we can with more work elsewhere.
> You have to extend the dwc2_of_match_table to include all ingenic devices.
>
> Therefore we now know 3 potential solutions:
> a) remove "ingenic,jz4780-otg" from jz4780.dtsi (my proposal)
> b) add "ingenic,jz4780-otg" to dwc2.yaml together with "snps,dwc2" (your proposal + my suggestion here)
> c) add only "ingenic,jz4780-otg" to dwc2.yaml and extend the match table in drivers//usb/dwc2/params.c (new proposals)
>
>  From consistency point of view I think variant b) is the right one. a) was rejected and c) only adds redundant code.


You are probably right, I forgot that the OTG driver only exists in my local
repository and is not merged into the mainline. If we remove "snps,dwc2",
the OTG of the JZ4780 in the current version will not work properly.

I will send v3 tomorrow.


Thanks and best regards!


> I am open to anything as long as the dtbscheck doesn't complain any more.
>
> BR an thanks,
> Nikolaus
