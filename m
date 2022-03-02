Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C154CAC66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiCBRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiCBRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:47:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEAF3D19B1;
        Wed,  2 Mar 2022 09:46:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73AEC139F;
        Wed,  2 Mar 2022 09:46:48 -0800 (PST)
Received: from [10.57.21.27] (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687AE3F73D;
        Wed,  2 Mar 2022 09:46:46 -0800 (PST)
Message-ID: <b040ea6c-5fdf-b68a-a580-d2d0095a33de@arm.com>
Date:   Wed, 2 Mar 2022 17:46:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/5] dt-bindings: opp: Add "opp-microwatt" entry in the
 OPP
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220302112917.27270-1-lukasz.luba@arm.com>
 <20220302112917.27270-2-lukasz.luba@arm.com>
 <Yh+tKe7oWCpmj5MC@robh.at.kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Yh+tKe7oWCpmj5MC@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/22 17:45, Rob Herring wrote:
> On Wed, Mar 02, 2022 at 11:29:13AM +0000, Lukasz Luba wrote:
>> Add new entry for the OPP which provides information about power
>> expressed in micro-Watts. It is useful for the Energy Model framework.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   .../devicetree/bindings/opp/opp-v2-base.yaml  | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob for the review!

Regards,
Lukasz
