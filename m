Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB484B9117
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiBPTU7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 14:20:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiBPTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:20:54 -0500
X-Greylist: delayed 857 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 11:20:41 PST
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1963E2AF3C5;
        Wed, 16 Feb 2022 11:20:40 -0800 (PST)
Received: from [100.55.237.147] (unknown [106.121.183.245])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxvuACSw1iK0cCAA--.7848S3;
        Thu, 17 Feb 2022 03:05:39 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 2/3] MIPS: Loongson64: dts: update the display controller device node
Date:   Thu, 17 Feb 2022 03:05:38 +0800
Message-Id: <911122E5-27A8-4584-987D-A9F908351800@loongson.cn>
References: <76e3d3f2-c457-2940-10ea-834f13e526cb@flygoat.com>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>, Li Yi <liyi@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <76e3d3f2-c457-2940-10ea-834f13e526cb@flygoat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: iPhone Mail (18D61)
X-CM-TRANSID: AQAAf9CxvuACSw1iK0cCAA--.7848S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Aw43tr18AF17Jw43Jrb_yoW8XF4kpw
        13Ca4fKFsrJF9rG3Z3tF18Wr15ZFWrArnFgFsxtw17WF9xAa1jvr45KFs8XrW3ZFy8AFWj
        v3yrKrW7KF1UCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUjjYLDUUUUU==
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh，sorry for that. This is what i am write for our downstream 4.19.190 kernel，I write it long time ago. It shouldn’t be included in this patch set. Please ignore that, I will remove it at next version.

I am sorry introduce “bug” again.


发自我的iPhone

> 在 2022年2月17日，上午2:44，Jiaxun Yang <jiaxun.yang@flygoat.com> 写道：
> 
> ﻿
> 
>> 在 2022/2/16 18:17, Sui Jingfeng 写道:
>> From: suijingfeng <suijingfeng@loongson.cn>
>> 
>> The display controller is a pci device, its PCI vendor id is 0x0014
>> its PCI device id is 0x7a06.
>> 
>> 1) In order to let the lsdc kms driver to know which chip the DC is
>>    contained in, we add different compatible for different chip.
>> 
>> 2) Add display controller device node for ls2k1000 SoC
>> 
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>> ---
>>  .../loongson/loongson,display-controller.yaml | 114 ++++++++++++++++++
>>  .../display/loongson/loongson-drm.txt         |  16 +++
> ^ Is loongson-drm.txt intentional?
> It seems irrelevant....
> 
> Thanks.
>>  .../boot/dts/loongson/loongson64-2k1000.dtsi  |   8 ++
>>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |   7 +-
>>  4 files changed, 140 insertions(+), 5 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson,display-controller.yaml
>>  create mode 100644 Documentation/devicetree/bindings/display/loongson/loongson-drm.txt
> [...]
> - Jiaxun

