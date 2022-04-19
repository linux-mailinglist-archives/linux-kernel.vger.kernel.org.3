Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDE50767A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiDSRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiDSRba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:31:30 -0400
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029AAC37;
        Tue, 19 Apr 2022 10:28:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09927311|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0139186-0.00932436-0.976757;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NTtwIo4_1650389321;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NTtwIo4_1650389321)
          by smtp.aliyun-inc.com(33.45.44.223);
          Wed, 20 Apr 2022 01:28:43 +0800
Subject: Re: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip select
 line.
To:     Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
 <61ZDAR.SD20HFTWMIBH3@crapouillou.net>
 <d7926a1d-c5e3-6519-6a52-1bd3ca3cf773@wanyeetech.com>
 <A5YFAR.5U5RNX82OXJY1@crapouillou.net> <Yl7quUXmEEPHfTfC@sirena.org.uk>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <3164076a-fa2f-30ad-2398-9ceb2b7894a3@wanyeetech.com>
Date:   Wed, 20 Apr 2022 01:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <Yl7quUXmEEPHfTfC@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2022/4/20 上午1:00, Mark Brown wrote:
> On Sat, Apr 16, 2022 at 05:36:46PM +0100, Paul Cercueil wrote:
>> Le sam., avril 16 2022 at 19:55:13 +0800, Zhou Yanjie
>>> On 2022/4/15 下午11:00, Paul Cercueil wrote:
>>>>> -    ctlr->num_chipselect = 2;
>>>>> +    ctlr->use_gpio_descriptors = true;
>>>> I wonder if this should be set conditionally instead. Maybe set it
>>>> to "true" if the "num-cs" property exists?
>>> I'm not too sure, but it seems some other drivers like "spi-sun6i.c",
>>> "spi-stm32.c", "spi-s3c64xx.c", "spi-pic32.c", etc. set it
>>> unconditionally.
>> Ok, maybe Mark can enlighten us here.
> use_gpio_descriptions is just selecting which version of the GPIO APIs
> we should use if we're handling GPIOs rather than if we should handle
> them.  We've got one last driver using the numerical GPIO APIs, once
> that one is converted we should just be able to drop the flag since
> everything will be using descriptors.


Thanks for your answer!


