Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96FE5090A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381820AbiDTTs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381688AbiDTTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:48:23 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E41B1C913
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:45:35 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5FB233F8BD;
        Wed, 20 Apr 2022 21:45:33 +0200 (CEST)
Message-ID: <eb54c810-8121-7de1-e2cf-008bd59552ce@somainline.org>
Date:   Wed, 20 Apr 2022 21:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node
 - add 'vdda-pll-supply' & 'vdda-phy-supply'
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, bjorn.andersson@linaro.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
 <997f91b9-c22e-41f0-300b-92559bc7896e@somainline.org>
 <CAH=2Ntw7Zy8nyDwNEnYQ=j=+25hjZsw3TGUW2TmT3+FvrLNu=A@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <CAH=2Ntw7Zy8nyDwNEnYQ=j=+25hjZsw3TGUW2TmT3+FvrLNu=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/04/2022 21:33, Bhupesh Sharma wrote:
> Hi Konrad,
>
> Thanks for your comments. Please see my comments below:
>
> On Wed, 20 Apr 2022 at 22:30, Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
>>
>> On 19/04/2022 22:58, Bhupesh Sharma wrote:
>>> As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
>>> 'vdda-phy-supply' supplies denote the power for the bus and the
>>> clock of the usb qmp phy and are used by the qcom qmp phy driver.
>>>
>>> So, its safe to assume that the two regulators are the same as on
>>> the MTP. So let's wire them up in the same way as the MTP.
>>>
>>> In absence of the same 'make dtbs_check' leads to following warnings:
>>>
>>> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>>>    phy-wrapper@88e9000: 'vdda-phy-supply' is a required property
>>>
>>> arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
>>>    phy-wrapper@88e9000: 'vdda-pll-supply' is a required property
>>>
>>> [1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/
>>>
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Cc: konrad.dybcio@somainline.org
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: Marijn Suijten <marijn.suijten@somainline.org>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>> Changes since v1:
>>> -----------------
>>> - v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
>>> - Fixed the commit message to read usb qmp phy instead of ufs phy (which
>>>     was introduced erroraneously in the commit log).
>>>
>>>    .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
>>>    1 file changed, 25 insertions(+)
>> Hi, I actually threw together a patch with [almost] all RPMh regulators
>> on Sagami quite a while ago (if thunderbird doesn't explode, you should
>> find it as an attachment to this message), but I haven't sent it, as
>> pm8350c_l3 and pmr735a_s3 are broken on the .c driver side (the step
>> numbers and/or values are not correct), but Qualcomm in their infinite
>> Qualcommery will not let us, mere mortals, access the PDFs that contain
>> the correct specifications, so I have to wait for somebody with access
>> to them to pick them up. That said, the values you supplied seem correct
>> (say for lack of allow-set-load which will bite when (if?) UFS is ever
>> functional upstream on this piece of Japanese engineering), but adding
>> the configuration of all regulators at once just seems more complete to me..
> The complete set of regulator enablement was something on my mind and
> which I tried before sending out the smaller (only relevant to USB)
> patch.
>
> My main concern was leaving the upstream kernel on the board in an
> unbootable form, as I don't have the sagami board to test the changes
> on.

Yeah, messing with power rails on somebody else's device is stressful in 
general, especially with downstream kernels #including 9999 other DTs, 
it's really easy to make a mistake.. Personally, I sometimes even dump 
the regulator settings from syfs on a running device just to be ultra sure.


>
> That said, if you intend to send the complete regulator enablement
> patch for the sagami board, it would be probably better in the longer
> run (as currently any change to the common binding, dts or driver
> files is held up by "make dtbs_check" warnings during upstream
> review).
>
>> On a note, USB - among other more or less necessary peripherals - along
>> with its supplies, is brought up in XBL (or bootrom if you jump to EDL),
>> so not setting these supplies in Linux does not bite in any way, shape
>> or form other than "make dtbs_check" screaming.
> I agree. If you want, you can include my simple patch as the followup
> (just enabling the right regulators for the usb qmp phy), to your big
> patch (which enables the complete regulator support). It should be
> fine as well, as we eventually want to use the regulators defined in
> the 'big' patch for some 'real' peripheral nodes like the usb qmp phy.
>
> Please let me know your views.
>
> Regards,
> Bhupesh

I will send this patch (of course rebased) along with the 
add-all-regulators one, once the .c driver is fixed then.


Thanks,

Konrad

>> I'm not against this patch, but once again, even though this point may
>> not sound very convincing to you all, I think it would be "nice" to
>> configure all regulators in one go.
>>
>>
>> Konrad
>>
>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>>> index 90b13cbe2fa6..238ac9380ca2 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>>> @@ -3,6 +3,7 @@
>>>     * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
>>>     */
>>>
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>    #include "sm8350.dtsi"
>>>    #include "pm8350.dtsi"
>>>    #include "pm8350b.dtsi"
>>> @@ -75,6 +76,27 @@ ramoops@ffc00000 {
>>>        };
>>>    };
>>>
>>> +&apps_rsc {
>>> +     pm8350-rpmh-regulators {
>>> +             compatible = "qcom,pm8350-rpmh-regulators";
>>> +             qcom,pmic-id = "b";
>>> +
>>> +             vreg_l1b_0p88: ldo1 {
>>> +                     regulator-name = "vreg_l1b_0p88";
>>> +                     regulator-min-microvolt = <912000>;
>>> +                     regulator-max-microvolt = <920000>;
>>> +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>> +             };
>>> +
>>> +             vreg_l6b_1p2: ldo6 {
>>> +                     regulator-name = "vreg_l6b_1p2";
>>> +                     regulator-min-microvolt = <1200000>;
>>> +                     regulator-max-microvolt = <1208000>;
>>> +                     regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>>    &adsp {
>>>        status = "okay";
>>>        firmware-name = "qcom/adsp.mbn";
>>> @@ -256,4 +278,7 @@ &usb_1_hsphy {
>>>
>>>    &usb_1_qmpphy {
>>>        status = "okay";
>>> +
>>> +     vdda-phy-supply = <&vreg_l6b_1p2>;
>>> +     vdda-pll-supply = <&vreg_l1b_0p88>;
>>>    };
