Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3458FCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiHKMsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiHKMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:48:37 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E82981C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:48:32 -0700 (PDT)
Received: from [192.168.1.101] (abxh187.neoplus.adsl.tpnet.pl [83.9.1.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3057F3F4E9;
        Thu, 11 Aug 2022 14:48:30 +0200 (CEST)
Message-ID: <736b8e63-3d81-c34d-f693-7dc2120dd885@somainline.org>
Date:   Thu, 11 Aug 2022 14:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
 <62efbb68.170a0220.88a00.8207@mx.google.com>
 <3515103e-8663-1df9-a184-a383cc0d6aa9@somainline.org>
 <62f158b0.050a0220.9281c.1da3@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <62f158b0.050a0220.9281c.1da3@mx.google.com>
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



On 8.08.2022 15:35, Christian Marangi wrote:
> On Mon, Aug 08, 2022 at 12:55:36PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 7.08.2022 15:00, Christian Marangi wrote:
>>> On Mon, Jul 18, 2022 at 06:18:24PM +0200, Christian Marangi wrote:
>>>> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
>>>> some additional pcie, sata and usb configuration values, additional
>>>> reserved memory and serial output.
>>>>
>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>
>>> Any news for this?Unless Qualcomm naming was different back then, you should simply merge
>> all of these changes into ipq8064.dtsi, as v1 is often the pre-production,
>> internal chip revision and only the last one (or the last and second-last)
>> are shipped in production devices.
>>
> 
> Mhh, this is not the case, there are dev board based on v1 and we also
> have some device based on v1 (that have some difference for pci and usb)
> One example is a Netgear r7500 where we have 2 revision one based on
> ipq8064-v1.0 and one based on ipq8064-v2.0.
Very interesting.. but if there really are devices shipping with v1, I guess
it's the correct thing to keep both.

Konrad
