Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4D504764
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiDQJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiDQJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:30:17 -0400
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65A387A1;
        Sun, 17 Apr 2022 02:27:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09126422|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0227706-0.0250717-0.952158;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.NSFwFyR_1650187655;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NSFwFyR_1650187655)
          by smtp.aliyun-inc.com(33.37.71.29);
          Sun, 17 Apr 2022 17:27:36 +0800
Subject: Re: [PATCH v3 1/3] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1649964337-114337-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1649964337-114337-2-git-send-email-zhouyanjie@wanyeetech.com>
 <J1YFAR.2881WOMSYUZM2@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <62d961c6-6c3e-393e-2348-cb874320316e@wanyeetech.com>
Date:   Sun, 17 Apr 2022 17:27:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <J1YFAR.2881WOMSYUZM2@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/4/17 上午12:34, Paul Cercueil wrote:
> Hi Zhou,
>
> Le ven., avril 15 2022 at 03:25:35 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
>> SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
>> from Ingenic.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Notes:
>>     v1->v2:
>>     Add Rob Herring's Acked-by.
>>
>>     v2->v3:
>>     No change.
>>
>>  Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml 
>> b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> index 4cebce6..c6e8c0b 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> @@ -17,6 +17,13 @@ properties:
>>      oneOf:
>>        - const: brcm,bcm2835-usb
>>        - const: hisilicon,hi6220-usb
>> +      - const: ingenic,jz4775-otg
>> +      - const: ingenic,jz4780-otg
>> +      - const: ingenic,x1000-otg
>
> The driver handles the JZ4775, JZ4780 and X1000 the exact same way. 
> Maybe the latter two should use the JZ4775 string as the fallback? Do 
> you know if the IP cores are any different?
>

 From the manual, it seems that JZ4775 and JZ4780 should have the same 
specifications,
but in fact, the behavior of JZ4775 and JZ4780 is different, especially 
if the JZ4780
does not turn off overcurrent detection, there will be a high 
probability of affecting
the use, while the JZ4775 does not have this problem, so I think they 
should actually
be different.

The manual of X1000 shows that it has only 8 endpoints, which is 
different from JZ4775
and JZ4780.

 From the experimental results, it seems that the three of them can use 
the same set of
parameters, but in order to avoid hidden dangers that have not been 
found for the time
being, I think it seems necessary to keep three independent compatible 
strings.


>> +      - const: ingenic,x1600-otg
>> +      - const: ingenic,x1700-otg
>> +      - const: ingenic,x1830-otg
>
> Same here (and btw, first time I hear about the X1600 and X1700 ;))


The OTG of X1600 and X1700 seem to be the same, I will remove the 
compatibility string
of X1700 in the next version, but the device tree of X1830 in Ingenic 
SDK is configured
with different parameters from X1600/X1700, so I believe the X1830 
should be a little
different from the X1600/X1700, so although the experimental results 
show that the three
of them seem to be able to use the same parameters, it seems that it is 
more appropriate
to keep the compatibe string of X1830.

I also heard about the X1600 and X1700 not long ago. From the existing 
information, the
X1600 should be the only SoC with CAN in the known models of Ingenic. 
And the X1700 is
more like an SoC that focuses on display applications.


Thanks and best regards!


>
> Cheers,
> -Paul
>
>> +      - const: ingenic,x2000-otg
>>        - items:
>>            - const: rockchip,rk3066-usb
>>            - const: snps,dwc2
>> -- 
>> 2.7.4
>>
>
