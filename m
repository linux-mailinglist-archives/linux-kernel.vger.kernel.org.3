Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4392448856D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiAHS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:56:56 -0500
Received: from ixit.cz ([94.230.151.217]:51166 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232365AbiAHS4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:56:55 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2BD3C2243C;
        Sat,  8 Jan 2022 19:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641668213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aJ10w6+42BJVTFqDcrmvsCYXSpOMsQ1znw8zHssXl2I=;
        b=d85huZPiP7U8a8Ic4elb8mqtj1lMgZNk6hzc4tRhBWKdxKox9Qzb2z9kFe3ow8gHk4mSYP
        LJAC08oaOzFp6zzyZORqu9jWmhl9UEjCMoGK13tNVda7h0nUUCq0G6OCrJ59NizK7o5Ac1
        Kwxw6COYUXdutCVRN/fJ+zV+UI9r7OE=
Date:   Sat, 08 Jan 2022 19:56:47 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add Qualcomm TCSR registers
To:     Rob Herring <robh@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <NANE5R.VEKBJ1CUXFCA3@ixit.cz>
In-Reply-To: <YdTHJrqjt5IPhoM2@robh.at.kernel.org>
References: <20211225140708.22000-1-david@ixit.cz>
        <YdTHJrqjt5IPhoM2@robh.at.kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should I go path specifying MFD or though I could just add minItems: 2 
and maxItems: 4 to the list?

What you think Rob?
David

On Tue, Jan 4 2022 at 16:16:06 -0600, Rob Herring <robh@kernel.org> 
wrote:
> On Sat, Dec 25, 2021 at 03:07:07PM +0100, David Heidelberg wrote:
>>  Qualcomm devices have a set of registers that provide various 
>> control and status
>>  functions for their peripherals.
>> 
>>  Modification:
>>   - dropped "qcom,tcsr-ipq6018", "syscon", "simple-mfd", since it's 
>> not
>>     used anywhere.
> 
> There is about to be. See:
> https://lore.kernel.org/all/b5053b42f73e574f48cf860a8e225d6b1939d216.1639499239.git.baruch@tkos.co.il/


