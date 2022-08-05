Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209358A9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiHELCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHELCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:02:22 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB61D300;
        Fri,  5 Aug 2022 04:02:19 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9F8D63EE91;
        Fri,  5 Aug 2022 13:02:16 +0200 (CEST)
Message-ID: <03f115b0-74ae-7793-5248-61df76ab184b@somainline.org>
Date:   Fri, 5 Aug 2022 13:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/7] arm64: dts: qcom: sc8280xp: HID wakeup sources and
 alt. touchpad
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220805092317.4985-1-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220805092317.4985-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.08.2022 11:23, Johan Hovold wrote:
> This series clean up the sc8280xp CRD and X13s HID nodes somewhat and
> marks the keyboard and touchpad as wakeup sources.
> 
> Included is also support for the alternate (second-source) touchpad
> found on some X13s laptops. Note that the node is disabled for now as
> ideally the boot firmware should be determining which touchpad is
> actually populated.
Interesting, what bootloader is used on these? Are you chainloading
something on top of Qualcomm's XBL UEFI?

Konrad
> 
> With some additional fixes it is possible to have both nodes enabled and
> letting Linux do the probing, but let's wait for a conclusion to the
> discussion about whether that is desirable before enabling them both:
> 
> 	https://lore.kernel.org/all/YuJXMHoT4ijUxnRb@hovoldconsulting.com
> 
> Johan
> 
> 
> Johan Hovold (7):
>   arm64: dts: qcom: sc8280xp-crd: disable touchscreen pull-up
>   arm64: dts: qcom: sc8280xp-crd: move HID pin config
>   arm64: dts: qcom: sc8280xp-crd: mark HID wakeup sources
>   arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disable touchscreen
>     pull-up
>   arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: move HID pin config
>   arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: mark HID wakeup
>     sources
>   arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate
>     touchpad
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 22 +++++++++--
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 38 +++++++++++++++++--
>  2 files changed, 54 insertions(+), 6 deletions(-)
> 
