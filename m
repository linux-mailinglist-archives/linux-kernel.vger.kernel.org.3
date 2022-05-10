Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE7522196
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiEJQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbiEJQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:48:32 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F8293B40;
        Tue, 10 May 2022 09:44:29 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AGePCg015065;
        Tue, 10 May 2022 18:44:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=r4qTkZ8EQGv/yqw+JGJ7ZdEQprrs98g3mPK+h16AjJc=;
 b=J9bMKt1m+CV2Gg3g2n5OaT95xjhN1hHBhgcTwS5j24GQWVnsrfndb5o1LQHRM/JpeCfY
 tSdDrJDUJBQa/J3liEw8pyXDfkQkBcxOYt2gSL/q5RUJ1BGxlB07ypeH0RqHFj+GN/0H
 6H71e5d+tMe3sbxX5L04VPgHO+QZm11zOxZhsZCT+Z9TYPuz6WKkCCJyVtpCadax9lfn
 Woe/5oELvwRjHyJVucdTWGF7houC+LeyL+RTpvtbSGauMh1/vLZOwnjxfrrITCzP8vaA
 mgjjNplJoqHs+rdBj13VlrqkOBanWebhck3PBybXw02nCBkZWX8Az8YVst/hGf41fHwh fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwg411f7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 18:44:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9009B10002A;
        Tue, 10 May 2022 18:44:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88AAC231533;
        Tue, 10 May 2022 18:44:20 +0200 (CEST)
Received: from [10.201.21.93] (10.75.127.45) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 10 May
 2022 18:44:20 +0200
Message-ID: <b64e6662-5fd2-5223-1e25-15217d75d06a@foss.st.com>
Date:   Tue, 10 May 2022 18:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: clock: stm32mp1: adapt example for
 "st,stm32mp1-rcc-secure"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
 <1652123805.754133.27398.nullmailer@robh.at.kernel.org>
 <ddd5d5b2-32a5-6464-80a6-0054c376dd96@foss.st.com>
 <Ynp9Pu+ZqjaBu8ne@robh.at.kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <Ynp9Pu+ZqjaBu8ne@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_04,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 5/10/22 16:57, Rob Herring wrote:
> On Tue, May 10, 2022 at 09:47:05AM +0200, Alexandre TORGUE wrote:
>> Hi Rob
>>
>> On 5/9/22 21:16, Rob Herring wrote:
>>> On Mon, 09 May 2022 15:46:58 +0200, Alexandre Torgue wrote:
>>>> For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
>>>> required properties.
>>>>
>>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Error: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dts:27.33-34 syntax error
>>> FATAL ERROR: Unable to parse input tree
>>> make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.example.dtb] Error 1
>>> make[1]: *** Waiting for unfinished jobs....
>>> make: *** [Makefile:1401: dt_binding_check] Error 2
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See https://patchwork.ozlabs.org/patch/
>>>
>>> This check can fail if there are any dependencies. The base for a patch
>>> series is generally the most recent rc1.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit.
>>>
>>
>> I just updated dtschema and yamllint seems to be well installed. I don't see
>> the see above. I wrote this patch on top of my stm32-next tree. Do I have to
>> send it directly to arm-soc in order to be merged on top of my latest
>> pull-request ?
> 
> That appears to be header related AFAICT. Maybe you have header changes
> in your tree. The issue this is fixing is in your tree, so it should be
> applied there.

Ah yes! CK_SCMIxxx have changed in my tree (merged in arm-soc tree) and 
this patch is done on top of this change. So has to be applied in arm-soc.
So I just have to send it directly to Arnd and arm-soc ?

Alex


> 
> Rob

