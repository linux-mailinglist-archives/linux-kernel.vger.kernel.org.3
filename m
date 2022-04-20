Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E54508E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbiDTReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381112AbiDTReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:34:04 -0400
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F7BBE;
        Wed, 20 Apr 2022 10:31:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1028301|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0199519-0.00651333-0.973535;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.NUa9eC8_1650475871;
Received: from 192.168.30.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NUa9eC8_1650475871)
          by smtp.aliyun-inc.com(33.40.23.6);
          Thu, 21 Apr 2022 01:31:12 +0800
Subject: Re: [PATCH v5 0/3] Add SMP/SMT support for Ingenic sysost driver.
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
References: <1649962165-111806-1-git-send-email-zhouyanjie@wanyeetech.com>
Message-ID: <3170e9f0-e5f4-eef1-7031-ce9d26c0810e@wanyeetech.com>
Date:   Thu, 21 Apr 2022 01:31:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1649962165-111806-1-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,


Please ignore this series, according to Paul's suggestion, we will use a 
new driver to implement these functions.


Thanks and beset regards!


On 2022/4/15 上午2:49, 周琰杰 (Zhou Yanjie) wrote:
> 1.On the hardware of X2000 SoC, the OST has been split into
>    two parts, two 32bit timers for clockevent and one 64bit
>    timer for clocksource (with different addresses), so it
>    not appropriate to use only one "ingenic,x2000-ost", just
>    remove it, then introduce "ingenic,x2000-ost32" and
>    "ingenic,x2000-ost64".
> 2.The OST in Ingenic XBurst®2 SoCs has a global timer and
>    up to 16 event timers, add support for the event timers.
> 3.Add dt-bindings and compatible strings for the X1600 SoC,
>    the X1700 SoC, the X1830 SoC, the X2000 SoC, the X2500 SoC.
>
> v4->v5:
> Fix warnings reported-by: kernel test robot <lkp@intel.com>.
>
> 周琰杰 (Zhou Yanjie) (3):
>    dt-bindings: timer: Remove unreasonable binding.
>    dt-bindings: timer: Add bindings for new Ingenic SoCs.
>    clocksource: Ingenic: Add SMP/SMT support for sysost driver.
>
>   .../devicetree/bindings/timer/ingenic,sysost.yaml  |   8 +-
>   drivers/clocksource/ingenic-sysost.c               | 405 ++++++++++++++++-----
>   2 files changed, 313 insertions(+), 100 deletions(-)
>
