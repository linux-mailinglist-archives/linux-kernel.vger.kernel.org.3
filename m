Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC755295A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbiFUC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbiFUC30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:29:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7DA14011;
        Mon, 20 Jun 2022 19:29:25 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRr5X3FcNzkWPK;
        Tue, 21 Jun 2022 10:27:44 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.125) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 21 Jun
 2022 10:29:23 +0800
Message-ID: <62B12D02.8000707@hisilicon.com>
Date:   Tue, 21 Jun 2022 10:29:22 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, <soc@kernel.org>
Subject: Re: (subset) [PATCH v3 09/40] arm64: dts: hisilicon: align gpio-key
 node names with dtschema
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-9-krzysztof.kozlowski@linaro.org> <165572367262.35195.16654742647500367074.b4-ty@linaro.org>
In-Reply-To: <165572367262.35195.16654742647500367074.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/6/20 19:14, Krzysztof Kozlowski wrote:
> On Wed, 15 Jun 2022 17:53:02 -0700, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern
>> (e.g. with key/button/switch).
>>
>>
> 
> Applied, thanks!

Thanks!

Best Regards,
Wei

> 
> [09/40] arm64: dts: hisilicon: align gpio-key node names with dtschema
>         https://git.kernel.org/krzk/linux/c/111b4da2c2fc2551ecfe466616089e1223dc7ac1
> 
> Best regards,
> 

