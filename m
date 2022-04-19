Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059E506811
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiDSJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243891AbiDSJy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:54:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1120BFD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:52:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lc2so31701591ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=1B6WyQfVjw7N6L2LTydTdy2xPWMiQ2cPzZki3Q8cLBY=;
        b=MfzDvA+IYpfNtxDU+I8IcQddXki3Um7STFmnMqV2z7vtdDXa/q3QlRmV5uTJB45a4K
         oYVqxiZWJq+95SKgL9/Fw0WCYKvZEcFVw3Nwsc2bhVnfohhIXm3TdJoYPA6lGsvDWU88
         IrEh8dAJVWOSSE7OQSENLZx6ZAhZD+1WnBlijGbg6H5en+sNv1bpcPBGQo4XOSKTIiSY
         UjcGPDsSiwhEFSfUXHGP8P82QgXQHx+hcDd9vVJ9XW/1iiOIBEqWLlnIPz14cO0m+74f
         taJk49+3i3EY1UM7FTN2fbqzFw3WwFWfvGGf1vA5QPkdGH4uu6lI0b9DZoaKZ9AfkEVJ
         ksdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=1B6WyQfVjw7N6L2LTydTdy2xPWMiQ2cPzZki3Q8cLBY=;
        b=kGB80OySgDWNgntBQO+8o9Z0rNjcM9ah3GY/O8iPgat5KFn95lilbccAJBBXHsyYts
         A4iEPlaoKoeZvh2JtWGEkkT+7L/J8XQ24Oc269127ASQQ1V5XppPOE6kKoaUaKInB91j
         f8FiJEIF9lSbj7GZ9lUgVCpYAI7hSHiNyOI+ElYCAafkSWNmvCRXHLq873sm3cIfV1Br
         Q7N19PcLk7MhSw3Vr8ldZS4tBejIjnA+dFAPvC4vnIduf6sYnh5RrK+d2HjPqxKiCHrZ
         nzyBMaMIW4+0b4TNz7eZjSjcagxGy2VYp69YvNzYufWVVw3St+TsLurDesn8pijr7X6t
         S5xg==
X-Gm-Message-State: AOAM530AYeITaPydenLL571Xi6pwHlaDEc8qr5f4b6IvYSGSquTd1wDg
        qmMLyk5IOzZQhqhCOkPohGczIA==
X-Google-Smtp-Source: ABdhPJxXLO/pT43IWgn5O8CB9FeYYuSkK1ApSLUQCUMEdYJoi0dtj9u3A4ZKSNLhTWimApW8fnIXIg==
X-Received: by 2002:a17:906:6a16:b0:6e8:a89c:6bb8 with SMTP id qw22-20020a1709066a1600b006e8a89c6bb8mr12641916ejc.476.1650361934765;
        Tue, 19 Apr 2022 02:52:14 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm5442932eji.67.2022.04.19.02.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:52:14 -0700 (PDT)
Message-ID: <42d019a1-7cb7-d9fb-c974-ce54ccdce5eb@linaro.org>
Date:   Tue, 19 Apr 2022 11:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jun Li <jun.li@nxp.com>
Cc:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
 <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
 <VI1PR04MB4333FE5742667FBE8AAACD2789E79@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB4333585DED292C3AC920B21E89F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <CAGE=qro_cWtZe1xVz0MrKXaKnhN_RU+kVPwtLdVj1wsjpSDMjA@mail.gmail.com>
 <VI1PR04MB43330369E23F47E26248853989F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <3dafc432-849b-0a78-f3dd-954d88c74a61@linaro.org>
 <VI1PR04MB433336414971E5EB6F4BAA8389F29@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <60955707-aabc-5313-aeb9-d65453538de0@linaro.org>
In-Reply-To: <60955707-aabc-5313-aeb9-d65453538de0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 11:12, Krzysztof Kozlowski wrote:
> On 19/04/2022 10:51, Jun Li wrote:
>> My test config is making USB_ROLE_SWITCH=m, but PTN5150=y
>>
>> So with below header file: 
>>
>> #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>> void usb_role_switch_put(struct usb_role_switch *sw);
>> #else
>> static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
>> #endif
>>
>> Will have link error.
> 
> Yep, true. I cannot remember the solution for that... With the select
> you cannot disable USB_ROLE_SWITCH. With "depends on X || depends on
> !X", one still cannot disable USB_ROLE_SWITCH. However this is a common
> problem and I am pretty sure people were working on this. :)

Use:
depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH'

this should solve the problem.

Best regards,
Krzysztof
