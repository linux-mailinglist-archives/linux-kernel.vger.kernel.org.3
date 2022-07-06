Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F5568985
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiGFNcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGFNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:31:58 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2223BD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:31:57 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E39263F7A6;
        Wed,  6 Jul 2022 15:31:55 +0200 (CEST)
Message-ID: <36a68a0b-0c18-deb5-609c-2128aa3fc21f@somainline.org>
Date:   Wed, 6 Jul 2022 15:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
 <8a394fa3-92fb-d162-b4ee-df010a09aed0@somainline.org>
 <62c58a60.1c69fb81.25b26.e72a@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <62c58a60.1c69fb81.25b26.e72a@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.07.2022 14:56, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 03:03:32PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 5.07.2022 15:39, Christian Marangi wrote:
>>> Mikrotik RB3011 have a special configuration where the regulators are
>>> not the common smb208 controlled by RPM but they use a TPS563900
>>> controlled via i2c. Disable the smb208 for this specific device.
>> Ok, so that answers my question from the previous email.
>> Please define the SMB208 regulators only in the DTs of
>> boards that actually use it, as it is not a SoC component as
>> far as I can tell.
>>
>> Konrad
> 
> This was already discuessed,
Yeah sorry, I didn't notice earlier and started reviewing patches
that were already reviewed by others.


rb3011 is the exception, qcom for ipq8064
> recommends to use smb208 but gives the option to implement it in their
> own way. So again we have 28 device with smb208 and 1 device that use
> its own special way...
> 
> Wonder if a separate dtsi can be used for this if we really can't put
> smb208 in ipq8064 dtsi?
There's msm8916-pm8916.dtsi. You can follow.

Konrad

[...]
