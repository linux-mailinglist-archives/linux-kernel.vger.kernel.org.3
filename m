Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A22503694
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiDPMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiDPMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:24:22 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CBBD7602;
        Sat, 16 Apr 2022 05:21:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07487685|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.233801-0.00141502-0.764784;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.NRqD5fz_1650111394;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NRqD5fz_1650111394)
          by smtp.aliyun-inc.com(33.45.69.145);
          Sat, 16 Apr 2022 20:16:36 +0800
Subject: Re: [PATCH v3 3/3] MIPS: Ingenic: Refresh USB nodes to match driver
 changes.
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
 <1649964337-114337-4-git-send-email-zhouyanjie@wanyeetech.com>
 <WBZDAR.1ZU7BOCJE9S11@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <16eb34cf-508b-b387-b255-4b0a778bf53f@wanyeetech.com>
Date:   Sat, 16 Apr 2022 20:16:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <WBZDAR.1ZU7BOCJE9S11@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022/4/15 下午11:07, Paul Cercueil wrote:
> Hi Zhou,
>
>
> Le ven., avril 15 2022 at 03:25:37 +0800, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Refresh USB nodes in the jz4780.dtsi, x1000.dtsi, and x1830.dtsi files.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>     v3:
>>     New patch.
>>
>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
>>  arch/mips/boot/dts/ingenic/x1000.dtsi  | 2 +-
>>  arch/mips/boot/dts/ingenic/x1830.dtsi  | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi 
>> b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> index b998301..c182a65 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -577,7 +577,7 @@
>>      };
>>
>>      otg: usb@13500000 {
>> -        compatible = "ingenic,jz4780-otg", "snps,dwc2";
>> +        compatible = "ingenic,jz4780-otg";
>
> Could you refresh my memory - why are the "snps,dwc2" fallback strings 
> removed?
>
> To me it seems like they should be here, since the OTG IP in Ingenic 
> SoCs is derived from the DWC2 IP.


The reason is that Nikolaus found that the current jz4780.dtsi will cause
dtbscheck to complain. After discussion, Nikolaus concluded three feasible
solutions, see here:
https://lkml.org/lkml/2022/4/13/1097

And it seems that Krzysztof prefers the c) option.


Thanks and best regards!


>
> Cheers,
> -Paul
>
>>          reg = <0x13500000 0x40000>;
>>
>>          interrupt-parent = <&intc>;
>> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi 
>> b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> index 8bd27ede..343818a2 100644
>> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> @@ -366,7 +366,7 @@
>>      };
>>
>>      otg: usb@13500000 {
>> -        compatible = "ingenic,x1000-otg", "snps,dwc2";
>> +        compatible = "ingenic,x1000-otg";
>>          reg = <0x13500000 0x40000>;
>>
>>          interrupt-parent = <&intc>;
>> diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi 
>> b/arch/mips/boot/dts/ingenic/x1830.dtsi
>> index 2595df8..6aff19f 100644
>> --- a/arch/mips/boot/dts/ingenic/x1830.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
>> @@ -355,7 +355,7 @@
>>      };
>>
>>      otg: usb@13500000 {
>> -        compatible = "ingenic,x1830-otg", "snps,dwc2";
>> +        compatible = "ingenic,x1830-otg";
>>          reg = <0x13500000 0x40000>;
>>
>>          interrupt-parent = <&intc>;
>> -- 
>> 2.7.4
>>
>
