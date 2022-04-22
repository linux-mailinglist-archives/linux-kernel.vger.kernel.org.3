Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C852150BF80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiDVSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiDVSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:00:56 -0400
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5342E3CDF;
        Fri, 22 Apr 2022 10:58:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07922698|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0173879-0.00791888-0.974693;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NVx3TFr_1650650244;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVx3TFr_1650650244)
          by smtp.aliyun-inc.com(11.95.168.178);
          Sat, 23 Apr 2022 01:57:25 +0800
Subject: Re: [PATCH v4 1/3] dt-bindings: dwc2: Add bindings for new Ingenic
 SoCs.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650561308-54704-2-git-send-email-zhouyanjie@wanyeetech.com>
 <QERQAR.SQYC38Q7CE0Z2@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <5654205d-8829-6bca-f1be-0ef8e31dd0c0@wanyeetech.com>
Date:   Sat, 23 Apr 2022 01:57:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <QERQAR.SQYC38Q7CE0Z2@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/4/22 下午8:44, Paul Cercueil wrote:
> Hi Zhou,
>
> Le ven., avril 22 2022 at 01:15:06 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000 SoC,
>> the X1600 SoC, the X1830 SoC, and the X2000 SoC from Ingenic.
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
>>     v3->v4:
>>     Remove the compatible string of X1700 since it could use the 
>> X1600 string
>>     as the fallback.
>>
>>  Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml 
>> b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> index 4cebce6..2218df8 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> @@ -17,6 +17,12 @@ properties:
>>      oneOf:
>>        - const: brcm,bcm2835-usb
>>        - const: hisilicon,hi6220-usb
>> +      - const: ingenic,jz4775-otg
>> +      - const: ingenic,jz4780-otg
>> +      - const: ingenic,x1000-otg
>> +      - const: ingenic,x1600-otg
>> +      - const: ingenic,x1830-otg
>> +      - const: ingenic,x2000-otg
>
> You should probably also add:
> - items:
>    - const: ingenic,x1700-otg
>    - const: ingenic,x1600-otg
>
> As discussed in your v3.


Sure.


Thanks and best regards!


>
> Cheers,
> -Paul
>
>>        - items:
>>            - const: rockchip,rk3066-usb
>>            - const: snps,dwc2
>> -- 
>> 2.7.4
>>
>
