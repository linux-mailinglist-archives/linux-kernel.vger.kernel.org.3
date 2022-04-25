Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF350DAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiDYH7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbiDYH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:13 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBBDF1;
        Mon, 25 Apr 2022 00:51:21 -0700 (PDT)
Received: from [10.0.0.209] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 150CE2007F;
        Mon, 25 Apr 2022 09:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1650873079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcuXepEWcmZJ35pGcNKVyIGil4yYREVIpbEFg/kZi+g=;
        b=rjWtzKLvpN6OHY+zmwSG9ppUW1EHiMKywdm+jVLpsotohRX8y+lAAQh1ypi9rUC17NPrkq
        VFLWrIMyb2QNyW0ZjHXttgfShXRWm0/LRljacl2H59pGiFgnOYuLCwubQOT+XSkS4F4vyW
        WQjKq39QqP52FGmqHSyFTDDkuf1sfos=
Message-ID: <a2892001-1658-9cec-65bd-d0ab1568e6f7@ixit.cz>
Date:   Mon, 25 Apr 2022 09:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/3] dt-bindings: mailbox: qcom-ipcc: add missing
 properties into example
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220424131522.14185-1-david@ixit.cz>
 <20220424131522.14185-2-david@ixit.cz>
 <5bc96cbd-cc5a-9ddb-4756-9f94324f00a7@linaro.org>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <5bc96cbd-cc5a-9ddb-4756-9f94324f00a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 16:43, Krzysztof Kozlowski wrote:
> On 24/04/2022 15:15, David Heidelberg wrote:
>> These missing required properties are needed for
>> smp2p binding reference checks.
>>
>> Misc: adjusted examples properties formatting from dtsi.
> I don't get the "misc:" comment. What is it about?
I used same formatting as in dtsi where the node is used (cosmetic change).
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks
>
> Best regards,
> Krzysztof

-- 
David Heidelberg
Consultant Software Engineer

Signal: +420 608 26 33 76
Matrix: @okias:matrix.org

