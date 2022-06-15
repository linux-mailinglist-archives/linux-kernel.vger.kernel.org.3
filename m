Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E954C042
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiFODpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFODpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:45:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE0483B0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:45:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so862522pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qTZ8ABJgEFJoCnGKxpfy9Q/YCSgArcV1xo2v8WGT7bM=;
        b=N3DQJMwi+RR2V6NEN+fm4PMC4Hw7ZEN/1OP2cVr7SNUgziO0ONmCWspCG6QgzbaCET
         Ey3IyROfu8arKotjgniYSoS8vP6dnmopvoUa1HScW6LZkGGmOBEIlBSwyyWho8CtGwqU
         Hic0xdzYJcA9S6y0Yy2BxqUl5ixwS1o6tgbir5pOf15ljb/KTy/LE9EAybUPKIDvYhh/
         xymLKn+PsTFsgrEzGx0gPHunRiLuxlctfTJJLD4siKIeIOgb6LPnowmJC6FccVgAKaNl
         Pq8Z91mOg47joC4m9Ii7m95PwL8BmUao6/yIKs2Z8E0vTcDnpqy2NeM1i/voC2Ka/Z11
         VDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qTZ8ABJgEFJoCnGKxpfy9Q/YCSgArcV1xo2v8WGT7bM=;
        b=vHGdJT0dynzusfttvGr4ENRzmAX+lo+86sG4MzFnQ3unGBZT7vgdPZvTtxZ1l0zPPY
         ZlrXa2HTmS4f0PXS4TWPzJOO9QwsRkLQ/cshmhSqlKkNH0VQxyBQYyHr9wDSkobX4UhE
         A/WZZwNqpuuWWr7LUSBdCKIIZwwkVj+eDD/z8MLSySt1pxi2ohEWQz/haI9bqvJfUi+/
         VOiCoJpeKG3YRnzsDHoBtxxqb0FGNcb4ow61qN9RGFW5L657KxjPG2cxsFgK49XP//u+
         l2lv2ia0HL4uk693tukyTmqYNtRi+pFepDpIKLTvcpnSfD/Lxh3AqwQc+xkJ2ONOgPs5
         bL3w==
X-Gm-Message-State: AJIora+EhFBL8HWJxRD2NJjUnANIU0Ga5w4QG3CMWH6eZudo71STNxc5
        ZbGuZKeCrODVolAC8Omw2DQ=
X-Google-Smtp-Source: AGRyM1vKSFpSn/yCX3P0y3wvcsbVAw1zZxHlKiRpOWBNU6Hrl6d+XMg7n2Ti/RUA6FysOCQxo9i64w==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr7894335pjl.245.1655264714367;
        Tue, 14 Jun 2022 20:45:14 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id u64-20020a638543000000b003fd7e217686sm8732667pgd.57.2022.06.14.20.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 20:45:13 -0700 (PDT)
Message-ID: <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
Date:   Wed, 15 Jun 2022 05:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220330150551.2573938-12-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2022 5:05 PM, Cristian Marussi wrote:
> Using the common protocol helper implementation add support for all new
> SCMIv3.1 extended names commands related to all protocols with the
> exception of SENSOR_AXIS_GET_NAME.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

This causes the following splat on a platform where regulators fail to 
initialize:

[    0.603737] ------------[ cut here ]------------
[    0.603752] WARNING: CPU: 1 PID: 1 at mm/page_alloc.c:5402 
__alloc_pages+0x6c/0x184
[    0.603797] Modules linked in:
[    0.603809] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
5.19.0-rc1-g44dbdf3bb3f4 #42
[    0.603818] Hardware name: BCX972160SV (DT)
[    0.603825] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    0.603834] pc : __alloc_pages+0x6c/0x184
[    0.603841] lr : kmalloc_order+0x40/0x88
[    0.603851] sp : ffffffc00a40b850
[    0.603856] x29: ffffffc00a40b850 x28: 0000000000000000 x27: 
ffffffc008d60404
[    0.603867] x26: ffffff80c1e3e1a8 x25: ffffffc00877bd78 x24: 
0000000000000058
[    0.603878] x23: ffffffc0081921a8 x22: ffffffc008cb04b0 x21: 
0000000000000000
[    0.603889] x20: 000000000000000b x19: 000000000000000b x18: 
0000000000000000
[    0.603900] x17: 0000000000000001 x16: 0000000100000000 x15: 
000000000000000a
[    0.603911] x14: 0000000000000000 x13: ffffff80c1e3c20a x12: 
ffffffffffffffff
[    0.603922] x11: 0000000000000020 x10: 0000000000000880 x9 : 
ffffffc008159dac
[    0.603932] x8 : ffffff80c02708e0 x7 : 0000000000000004 x6 : 
000000000041a880
[    0.603943] x5 : 0000000000000001 x4 : ffffff8000000000 x3 : 
0000000000000000
[    0.603954] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 
ffffffc00a32d3f2
[    0.603965] Call trace:
[    0.603970]  __alloc_pages+0x6c/0x184
[    0.603977]  kmalloc_order+0x40/0x88
[    0.603984]  kmalloc_order_trace+0x30/0xd0
[    0.603992]  __kmalloc_track_caller+0x64/0x19c
[    0.603999]  devm_kmalloc+0x5c/0xe0
[    0.604009]  scmi_voltage_protocol_init+0x14c/0x2f4
[    0.604020]  scmi_get_protocol_instance+0x128/0x1f4
[    0.604030]  scmi_devm_protocol_get+0x64/0xc8
[    0.604037]  scmi_regulator_probe+0x5c/0x42c
[    0.604049]  scmi_dev_probe+0x28/0x38
[    0.604056]  really_probe+0x1b8/0x380
[    0.604065]  __driver_probe_device+0x14c/0x164
[    0.604073]  driver_probe_device+0x48/0xe0
[    0.604080]  __driver_attach+0x160/0x170
[    0.604087]  bus_for_each_dev+0x78/0xb8
[    0.604095]  driver_attach+0x28/0x30
[    0.604101]  bus_add_driver+0xf4/0x208
[    0.604108]  driver_register+0xb4/0xf0
[    0.604116]  scmi_driver_register+0x5c/0xa4
[    0.604123]  scmi_drv_init+0x28/0x30
[    0.604132]  do_one_initcall+0x80/0x1a4
[    0.604141]  kernel_init_freeable+0x220/0x23c
[    0.604149]  kernel_init+0x28/0x128
[    0.604158]  ret_from_fork+0x10/0x20
[    0.604166] ---[ end trace 0000000000000000 ]---
[    0.604194] scmi-regulator: probe of scmi_dev.2 failed with error -12
[    0.604792] arm-scmi brcm_scmi@0: Failed. SCMI protocol 22 not active.
-- 
Florian
