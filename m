Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47C50B0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444619AbiDVHE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444426AbiDVHEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:04:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB62BE21;
        Fri, 22 Apr 2022 00:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBC2FB82A99;
        Fri, 22 Apr 2022 07:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDE5C385A4;
        Fri, 22 Apr 2022 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650610889;
        bh=21Yl4xxhiWqKplYqfS+Y99XlgN55K+6oS3DyARdUs4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JHv2sUfPT5E3Xt43uAbQdIR65LGFiab4UCBFrJovFH4Ar0GVM9ec8zwTyWUiHRXnY
         xzGuwbcoLatbwti/gMFOM9cYHkdKayr9a2Gr30eliPJC3GmiLZwjp6/doleJ7Q+yfR
         uDA30IHk5qsSoR0llts4WM1iqnxIhUODioI8bHTYK4eezUwf3N02q/cHI7oKAtJ1hZ
         ikCBrNlyFD3lpL15W362ftXJ1oT6dyaCFrWMHjJyJ7FxlC0uihMHAIa+m5uCO8whgJ
         t7uXmCT0wmBsYNwNL279LAq3zqmU3HDPOOSbdKhZNogr9wlgdjLAO8IBVqJyTJ2fQy
         X0+8JcxzHvpWA==
Message-ID: <e54804ee-15f8-36a1-bbc5-9a218a4aec56@kernel.org>
Date:   Fri, 22 Apr 2022 10:01:24 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 3/2] arm64: dts: qcom: sc7180: Remove ipa interconnect
 node
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220415005828.1980055-1-swboyd@chromium.org> <Yl92UkRwlQsd71mr@ripper>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <Yl92UkRwlQsd71mr@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 5:56, Bjorn Andersson wrote:
> On Thu 14 Apr 17:58 PDT 2022, Stephen Boyd wrote:
> 
>> This device node is unused now that we've removed the driver that
>> consumed it in the kernel. Drop the unused node to save some space.
>>
> 
> I'm expecting that merging patch 3 and 4 will work, but cause sync_state
> to not happen until the driver changes are merged.
> 
> Can you confirm my expectation? And perhaps confirm that it's fine for
> Georgi to pick the driver changes independently of the dts changes...

I have picked the driver changes, as the boot failure definitely needs to
be addressed. The sync-state might not happen until we have the DT changes
merged, as the framework is matching the count of probed drivers with the
count of providers in DT.

>> Cc: Alex Elder <elder@linaro.org>
>> Cc: Taniya Das <quic_tdas@quicinc.com>
>> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
>> Cc: Georgi Djakov <djakov@kernel.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

Thanks,
Georgi

>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index e1c46b80f14a..1ff96ef30e3f 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -1421,13 +1421,6 @@ mmss_noc: interconnect@1740000 {
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   		};
>>   
>> -		ipa_virt: interconnect@1e00000 {
>> -			compatible = "qcom,sc7180-ipa-virt";
>> -			reg = <0 0x01e00000 0 0x1000>;
>> -			#interconnect-cells = <2>;
>> -			qcom,bcm-voters = <&apps_bcm_voter>;
>> -		};
>> -
>>   		ipa: ipa@1e40000 {
>>   			compatible = "qcom,sc7180-ipa";
>>   
>> -- 
>> https://chromeos.dev
>>

