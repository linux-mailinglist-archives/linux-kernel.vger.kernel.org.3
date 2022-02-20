Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A034BCE04
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiBTKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:39:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBTKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:39:05 -0500
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9B4C40F;
        Sun, 20 Feb 2022 02:38:43 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1311721|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0279972-0.00820433-0.963799;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MslCD3M_1645353518;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MslCD3M_1645353518)
          by smtp.aliyun-inc.com(33.37.72.206);
          Sun, 20 Feb 2022 18:38:39 +0800
Subject: Re: [PATCH v3 0/3] Add SMP/SMT support for Ingenic sysost driver.
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1643957682-39450-1-git-send-email-zhouyanjie@wanyeetech.com>
Message-ID: <247a098a-67df-a451-86c9-800c39af80d2@wanyeetech.com>
Date:   Sun, 20 Feb 2022 18:38:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1643957682-39450-1-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A gentle ping :)


On 2022/2/4 下午2:54, 周琰杰 (Zhou Yanjie) wrote:
> 1.On the hardware of X2000 SoC, the OST has been split into
>    two parts, two 32bit timers for clockevent and one 64bit
>    timer for clocksource (with different addresses), so it
>    not appropriate to use only one "ingenic,x2000-ost", just
>    remove it, then introduce "ingenic,x2000-ost32" and
>    "ingenic,x2000-ost64".
> 2.The OST in Ingenic XBurst®2 SoCs has a global timer and
>    up to 16 event timers, add support for the event timers.
> 3.Add dt-bindings and compatible strings for the X1600 SoC,
>    the X1830 SoC, the X2000 SoC, and the X2500 SoC.
>
> 周琰杰 (Zhou Yanjie) (3):
>    dt-bindings: timer: Remove unreasonable binding.
>    dt-bindings: timer: Add bindings for new Ingenic SoCs.
>    clocksource: Ingenic: Add SMP/SMT support for sysost driver.
>
>   .../devicetree/bindings/timer/ingenic,sysost.yaml  |   7 +-
>   drivers/clocksource/ingenic-sysost.c               | 403 ++++++++++++++++-----
>   2 files changed, 310 insertions(+), 100 deletions(-)
>
