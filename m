Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78C7583E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiG1Lyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiG1Lyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:54:45 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600A1AD9F;
        Thu, 28 Jul 2022 04:54:42 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 74DCE2007F;
        Thu, 28 Jul 2022 13:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1659009279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBk6SGTBwPTuekVWue/fCOOAmcq+VPJhMxPeqTg3xG8=;
        b=u2dtBhDzbDSR4Qn6z3T0tQCuFlFkb5hjb/AiSMjtxmbkrbSB8cr75uFFih7PwC9sBzPV7E
        J9gAc4bIKmeTbIXN3XCGUkxO76zinQNpOCiZvva3uPlLveeFF7TfQj3BayN6JCb8c1TbqZ
        xlJ+F1E0Pf9mXeonLe0zQq1vD+rh+X0=
Message-ID: <875f6675-9d28-7ca2-704c-4d1a6c69a21c@ixit.cz>
Date:   Thu, 28 Jul 2022 13:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0
Subject: Re: [PATCH 3/3] dt-bindings: phy: add definition for MSM8960
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shinjo Park <peremen@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220728111740.30595-1-peremen@gmail.com>
 <aef9bae5-b72b-d520-a8e5-8f6a838775eb@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <aef9bae5-b72b-d520-a8e5-8f6a838775eb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 13:47, Krzysztof Kozlowski wrote:
> On 28/07/2022 13:17, Shinjo Park wrote:
>> Document the changes introduced by MSM8960 inclusion.
>>
> 1. Thread your submissions.
> 2. Use subject prefix matching the file.
>
>> Signed-off-by: Shinjo Park <peremen@gmail.com>
>> Reviewed-by: David Heidelberg <david@ixit.cz>
> It is a v1. How the review tag got here?

We have a Matrix channel ( #linux-apq8064:matrix.org and downstream fork 
for apq8064/msm8960 [1]), so I saw the patch before it was send to ML.

David

[1] https://github.com/apq8064-mainline/linux

>
> Best regards,
> Krzysztof

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

