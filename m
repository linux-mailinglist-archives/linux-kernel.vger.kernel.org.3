Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E074F55C8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243767AbiF1IKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiF1IKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:10:03 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F4275CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:10:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 59A933F775;
        Tue, 28 Jun 2022 10:09:58 +0200 (CEST)
Message-ID: <00aefa9b-5d91-629b-9fa6-fadd6df5a469@somainline.org>
Date:   Tue, 28 Jun 2022 10:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s
 devicetree
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YrMVqifgV4kZaP7F@hovoldconsulting.com>
 <20220622132617.24604-1-johan+linaro@kernel.org>
 <96394aa2-aefc-63c4-d86f-15c06d092d75@somainline.org>
 <Yrq1FAscp+jE7GQs@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <Yrq1FAscp+jE7GQs@hovoldconsulting.com>
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



On 28.06.2022 10:00, Johan Hovold wrote:
> On Mon, Jun 27, 2022 at 01:38:47PM +0200, Konrad Dybcio wrote:
>> On 22.06.2022 15:26, Johan Hovold wrote:
>>> Add an initial devicetree for the Lenovo Thinkpad X13s with support for
>>> USB, backlight, keyboard, touchpad, touchscreen (to be verified), PMICs
>>> and remoteprocs.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Krzysztof's tag wasn't here in the version I posted.
Patchwork recently started pulling them in automatically when
downloading a mbox file.

Konrad
> 
>>> +	reserved-memory {
>>> +	};
>> You still haven't explained this weird node (I don't believe
>> the thing doesn't mind you poking at 'secure' regions, and even
>> if otherwise, it is unused for now).
> 
> It's just unused for now, so sure, we can remove it until we need it.
> 
> Johan
