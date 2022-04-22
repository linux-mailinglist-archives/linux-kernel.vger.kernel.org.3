Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5110750BC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349098AbiDVQBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449622AbiDVQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:47 -0400
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AA5DA7A;
        Fri, 22 Apr 2022 08:57:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2959096|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0197065-0.00421785-0.976076;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NVuYnRb_1650643065;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVuYnRb_1650643065)
          by smtp.aliyun-inc.com(33.32.41.12);
          Fri, 22 Apr 2022 23:57:46 +0800
Subject: Re: [PATCH v4 0/3] Add OTG support for Ingenic SoCs.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hminas@synopsys.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, paul@crapouillou.net,
        linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
 <YmJntZ7RYpPVaxhm@kroah.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <8e2472c8-39d1-065f-4cfb-41359af435f2@wanyeetech.com>
Date:   Fri, 22 Apr 2022 23:57:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YmJntZ7RYpPVaxhm@kroah.com>
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

Hi Greg,

On 2022/4/22 下午4:30, Greg KH wrote:
> On Fri, Apr 22, 2022 at 01:15:05AM +0800, 周琰杰 (Zhou Yanjie) wrote:
>> 1.Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000
>>    SoC, the X1600 SoC, the X1830 SoC, and the X2000 SoC.
>> 2.Introduce support for disable Ingenic overcurrent detection,
>>    once selected it enables GOTGCTL register bits VbvalidOvEn
>>    and VbvalidOvVal to disable the VBUS overcurrent detection.
>>
>> v1->v2:
>> 1.Add Rob Herring's Acked-by.
>> 2.Add Minas Harutyunyan's Acked-by.
>> 3.Use "activate_ingenic_overcurrent_detection" instead
>>    "deactivate_ingenic_overcurrent_detection" as Greg's suggestion.
>>
>> v2->v3:
>> Refresh USB nodes in device tree files, remove "snps,dwc2" since
>> it is nolonger needed.
>>
>> v3->v4:
>> Remove the compatible string of X1700 since it could use the X1600
>> string　as the fallback.
> I already applied v3, so can you just provide a fixup patch for the
> difference between v3 and v4?


Sure.


Thanks and best regards!


>
> thanks,
>
> greg k-h
