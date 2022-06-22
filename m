Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA5554F87
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358490AbiFVPj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357795AbiFVPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:39:26 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE42E0BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:39:24 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DE60B1FFEA;
        Wed, 22 Jun 2022 17:39:22 +0200 (CEST)
Message-ID: <5158fe83-88b1-1081-df7f-4118ce6f5ec0@somainline.org>
Date:   Wed, 22 Jun 2022 17:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
 <YrMccQXwsz/zC/gl@hovoldconsulting.com>
 <9d0c1897-195f-0548-ea5d-ffc35768f518@somainline.org>
 <b2c9faf0-95a8-772f-c211-f1599b35f8f8@linaro.org>
 <51965fa3-d146-70f1-2ad8-db6197989348@somainline.org>
 <YrM0vhXpY3uWgprs@hovoldconsulting.com>
 <e7d9150b-8332-6394-f6cf-0e59d0cf931b@somainline.org>
 <YrM3KX3HLjsYrQvf@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <YrM3KX3HLjsYrQvf@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 17:37, Johan Hovold wrote:
> On Wed, Jun 22, 2022 at 05:30:24PM +0200, Konrad Dybcio wrote:
>> On 22.06.2022 17:26, Johan Hovold wrote:
>>> On Wed, Jun 22, 2022 at 05:10:50PM +0200, Konrad Dybcio wrote:
>>>> On 22.06.2022 16:48, Krzysztof Kozlowski wrote:
>>>>> On 22/06/2022 16:36, Konrad Dybcio wrote:
>>>>>> On 22.06.2022 15:43, Johan Hovold wrote:
> 
>>>>>>> No, quite the opposite, status go at the end.
>>>>>> Then all other device DTs should be updated, as in dts/qcom/
>>>>>> everybody keeps it first in non-SoC/PMIC files.
>>>>>
>>>>> The word "should" is a bit too much here, but I agree, we can update all
>>>>> of them to match one, chosen approach.
>>>>>
>>>>> However the location for "status" property is more important for the
>>>>> definition of nodes in DTSI, because it's the least important piece
>>>>> there and also kind of expected - here go properties + I disable it. For
>>>>> me this is more important.
>>>
>>> Right, and this is the argument for keeping status last, something which
>>> is well defined.
>>>
>>> If you look at some of the qcom dtsi it's hard to determine whether a
>>> node is disabled or not because the status property does not actually go
>>> "first" but is rather typically mixed up somewhere in the middle (or
>>> upper part) of nodes.
>>>
>>>>> For node redefinition in DTS, I see benefits in two approaches:
>>>>> 1. Let me first enable the node and then configure it.
>>>>> 2. Let me configure the node and enable it.
>>>
>>> So for consistency, just put status last everywhere (dtsi and dts) and
>>> be done with it.
>> That works.
> 
> Actually, it looks like a lot of the qcom dtsi already do this too (i.e.
> put status last). The dts may be more inconsistent on this matter
> judging from a quick look.
Yes, as I mentioned this concerns the device-specific trees, as
the includable ones are (or well, should have been made) fine.

Konrad
> 
>>>> I looked around non-qcom device trees and it looks like the common
>>>> consensus is 2. Although I personally visually prefer 1. and it's
>>>> been used in all qcom arm64 DTs to date, I don't think there are any
>>>> blockers for us to switch to 1. going forward to keep it consistent.
>>>
>>> You mean inconsistent with the majority of dts? ;)
>> Not like anything involving Qualcomm was ever consistent or compliant
>> with the majority :D
> 
> Heh. :)
> 
> Johan
