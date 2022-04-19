Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D9506D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbiDSNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiDSNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:33:10 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E8E0AC;
        Tue, 19 Apr 2022 06:30:27 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23JCeESq019632;
        Tue, 19 Apr 2022 15:30:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=yVMrm4zWjinomEQt6Qi0CU02yE86wEnfHBQgY0IOHqc=;
 b=nFB0m7eyQ1BHx2n5SeGnAyqflzmTnnBNt+gQV/xjoQu3LfSq5YTU/69SkKOGdx8nIkZw
 FJDjxEa7c6hypgNU62Y2i5lXOiwstXJFhQXwEzPSGk+oLP1gix327yzSG4PJtArSM9QN
 da/63nkP+2s0tc5n1zbnPWpeTc4ZTIKeXoaKXtPc9LNEOW4idvqv71gy55RIzWcCZjST
 x+pKEQUqIEgFmzJD0zSH3xYCj9uZVlJxqWng+8wBja2Fi+3Gpz6+HWBFQ892PJY3DIg/
 Hr93FGwT6Cd6yJMuyNMRMxcye3UQv/YXpIxBI4+g+F+DuHbMYIkUA+Q6FmTKcuGsvsxl PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fh09kr17x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 15:30:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1EFB100034;
        Tue, 19 Apr 2022 15:30:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C7E742128DC;
        Tue, 19 Apr 2022 15:30:10 +0200 (CEST)
Received: from [10.48.0.142] (10.75.127.46) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 19 Apr
 2022 15:30:09 +0200
Message-ID: <c40b818d-1036-8068-2ebb-a6f1eab4d738@foss.st.com>
Date:   Tue, 19 Apr 2022 15:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ARM: dts: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        <soc@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
 <d0d9c16f-4668-1263-49fa-e51648c8c098@foss.st.com>
 <8798d7bb-6480-90ef-90fd-d7ff7d7beb2a@linaro.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <8798d7bb-6480-90ef-90fd-d7ff7d7beb2a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_05,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 15:10, Krzysztof Kozlowski wrote:
> On 19/04/2022 15:03, Alexandre TORGUE wrote:
>> Hi Krzysztof
>>
>> On 4/7/22 16:30, Krzysztof Kozlowski wrote:
>>> The node names should be generic and SPI NOR dtschema expects "flash".
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm/boot/dts/da850-evm.dts                  | 2 +-
>>>    arch/arm/boot/dts/dm8168-evm.dts                 | 2 +-
>>>    arch/arm/boot/dts/spear1310-evb.dts              | 2 +-
>>>    arch/arm/boot/dts/spear1340-evb.dts              | 2 +-
>>>    arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 2 +-
>>>    arch/arm/boot/dts/stm32mp157c-ev1.dts            | 4 ++--
>>>    6 files changed, 7 insertions(+), 7 deletions(-)
>>
>> Thanks for your patch. Is it possible to split it per vendor
>> (TI/STM32/SPEAR) ?
> 
> This was a part of a bigger set where most of these I split. However
> here split would be more churn for such simple change, so I combined them.
> 
> This was already picked up by Arnd:
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=for-next&id=56147a156e7e2f50bef695efe6cc4fe8e91c40dc

Ah Ok, I missed that Arnd took them, sorry.

Regards
Alex

> 
> 
> Best regards,
> Krzysztof

