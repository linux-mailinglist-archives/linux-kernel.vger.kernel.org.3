Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF7588849
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiHCHvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiHCHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:51:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0724965
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:51:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f20so18027138lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+qiNOnMPVcTggFsBYHaEzoH71rIPx2WFWj8O2ocXAy4=;
        b=uq+URaz+toowYbgnRcqZtbVNfoJLMcGt0+mCMN6c4utMJEJaeA5YVcCVJC49LdS9NL
         d5+Xn4PJqdZqZkspXztypEG/BhOpaDb9Hd81lVM2j1UHQNaFd35LeeZe/SoZ+w7bEetC
         HWNCGeB+WRsF/UvjU2VEaipfognobec/W32odphoRvTj9ST3tgbNK2cMFTmUFrobwzv7
         q7ffRrFFHbw2Go1lxNzrS5Ls+C4mqXdGbwDbjnKCjy5AphKWp+ntdwYY8NiTkl3p7Pxx
         uuN73NbhqgkYqDkQo1vMKSr2Ef29rx/a/oBH/WIgrRjF3ZGBGpzDecFxWGzQi2/Me4EE
         x++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+qiNOnMPVcTggFsBYHaEzoH71rIPx2WFWj8O2ocXAy4=;
        b=kBTMzTwtB6zkhbaW7njtbVGRJmN1K8kO8CSpj13yNT936oNOuczS7n+iu/Spd4wjcq
         mfpfnQZ0mYT9bxd77IWwWGTrEpQ7Hlik58AIPU2DFoy13avEAvnQIm8sbhoi414LITlC
         v+2GNBki3dNX0kjTaA/RPxL5qEmd2LGRHZgcSGlx7LjH/zeRCjF+kkFxTYakL5qvf4J1
         1EtD6goua62F86JA8FGxLEH6D5gR2L6W8/nyH1KyIRjUh7HKYCBKfxjAHlLbSjqY4QSi
         uOFZQK4Q812J+Tzk79r69lcoErO6EnnVwfdzSzEpWp/0VMcUtRuAvroi7v74eUNZzN5y
         VGoA==
X-Gm-Message-State: AJIora/3DiR9C1tFKFLflYDJJTDtHNLZ27adEQmk10x6aHBLcWdLVDPD
        YWFJvSpyvhjL1cTFFweRsx31lg==
X-Google-Smtp-Source: AGRyM1siGEUEnyJJOowXE+Po+lvFcMlMH8ag+fSkZEu8Bp76hF8nWN1ylZYYQUMn2Mw72TmbBS0iFg==
X-Received: by 2002:a05:6512:12d4:b0:48a:8d45:7208 with SMTP id p20-20020a05651212d400b0048a8d457208mr9125479lfg.192.1659513064031;
        Wed, 03 Aug 2022 00:51:04 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b0048b03012d0dsm793539lfo.254.2022.08.03.00.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:51:03 -0700 (PDT)
Message-ID: <971ad767-68b7-bbb7-f147-c3cce24fbe4f@linaro.org>
Date:   Wed, 3 Aug 2022 09:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/8] Revert "dt-bindings: usb: dwc3: Add wakeup-source
 property support"
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-6-johan+linaro@kernel.org>
 <CAL_JsqL5ZCzfd06rxOdQodFjk4G3QpDCsxA5heM71x0q5d-hCw@mail.gmail.com>
 <YuokOn0KHEqv/CR4@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YuokOn0KHEqv/CR4@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 09:31, Johan Hovold wrote:
> On Tue, Aug 02, 2022 at 11:17:22AM -0600, Rob Herring wrote:
>> On Tue, Aug 2, 2022 at 9:14 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> 
>>> It should also not be used to
>>> work around Linux driver implementation issues such as how to coordinate
>>> the glue and core dwc3 drivers.
>>>
>>> For the Qualcomm dwc3 controllers, it is the glue device that manages
>>> the wakeup interrupts, which may or may not be able to wake the system
>>> up from system suspend.
>>
>> While the reasoning to add this may have been for QCom, having this
>> property for other users makes sense. On some platforms, 'snps,dwc3'
>> is the only node (i.e. there's no wrapper node). So I don't think this
>> should be reverted.
> 
> Fair enough. Let's keep it in the core child node then where we can
> still retrieve from the glue parent directly.
> 
> (I assume you're not suggesting also adding 'wakeup-source' to the qcom
> glue node, which is where the actual wakeup interrupts live.)
> 
> The glue and core parts needs to work in concert even if the current
> implementation tends to make that harder than it should be.

I think it can still exist in the glue node (so your next patch),
because as you said this is the place with wakeup interrupt, so it looks
like correct hardware description. In the next patch you would need to
disallow it for the DWC node.

Best regards,
Krzysztof
