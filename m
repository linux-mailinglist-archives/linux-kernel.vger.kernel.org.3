Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44A5AE07D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiIFHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiIFHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:03:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901566F557
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:03:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bt10so15989059lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vh5dKJp8XgybaVsAxsDRTMhVft4uU9zUN/Q42DYvyOQ=;
        b=K0mgYUOSou8QTlHcWhgwVshbgWLtJ1Eab3Sx8oxOBkZ35lLxyfk1myRr+wT9OIrm1f
         SvN4RyuEgytQQ0ubS/YvvQIU1TqX6GeWdCuiwYLZ4LanwnEOqBaL77rIgB27zfnCRjDQ
         8SA8G3pploFaxzyEC+vZEb02+7lIrGH6Cpx6Wt2kdNtIxceT4pFXZ6pwL1MBYFVOCxeY
         9VpZqwwbyDjHLawD5I74XsZSkBrtABF5/TdSBkiYhpl3Bo8ER7bi6kZt7tiURx3NQR9a
         +hfPVuGG9n25leSTr+lhBXP7Q20h/5chBiiuXWsIoyZr3YKP4nL60Zc/nczXceCMgAh5
         xjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vh5dKJp8XgybaVsAxsDRTMhVft4uU9zUN/Q42DYvyOQ=;
        b=WNA83ATuPtINlDZsAV5p9QmRJ/v5Ihdk6bYJ5tPTm4/m1Voq1qPas+jSBI5DfkSMBI
         P7fHgIyU/VrPWjEOt1eFM66Nax9F3l0b98gVVZZBS/T7agRPs6vOC35ypJXb37OZx/RA
         YxgD0VPusQ/g4jxyQ6ezvAcPGVQywjeRp/K3MIq9uYq97gh71kxOQZbMA2Tx5lh3jqCT
         qbmGwO6ufoc0SOb4cYh4ykoUpyfsk48o3QV8UCHWcUJTcm6dwCtaBwjY2paDC9151L0M
         YsoE7fcsV99lGGCoENWKtGDinXNsh3wIDvKTHja6yFZnZ/zbx1tdtqlhoXgnqBh4voRD
         IzIg==
X-Gm-Message-State: ACgBeo2RqwFnThRTMnccnSe5Q2AQIwpK3Rsc19UoIcCoEVQbGQt7BtdF
        9ESgUPMhGMkU4hhTS7fH6cT9PA==
X-Google-Smtp-Source: AA6agR7mE1s888VxyPAUOKHJ7M6JWPPOgX1u4M252CbSe02wYFJxALmb9mClXYAbaayos/k2RVPNPQ==
X-Received: by 2002:ac2:4e15:0:b0:48b:7a5f:923c with SMTP id e21-20020ac24e15000000b0048b7a5f923cmr18784649lfr.134.1662447789099;
        Tue, 06 Sep 2022 00:03:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea447000000b002648152512asm1716340ljn.90.2022.09.06.00.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 00:03:08 -0700 (PDT)
Message-ID: <93600263-0211-9286-9043-fae5b017d15b@linaro.org>
Date:   Tue, 6 Sep 2022 09:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J7200
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, kishon@ti.com,
        vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220901085506.138633-1-s-vadapalli@ti.com>
 <20220901085506.138633-2-s-vadapalli@ti.com>
 <4b681c03-7f5a-0234-2276-316e0bad1de5@linaro.org>
 <44339382-c4e2-26db-de5d-263ae5a585b8@ti.com>
 <4e61b63b-74ac-1682-968f-17e5d8db7ce6@linaro.org>
 <dfa9e613-054e-cffc-747f-27842e825cc8@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dfa9e613-054e-cffc-747f-27842e825cc8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 07:02, Siddharth Vadapalli wrote:
>>>
>>> Please let me know if the above description is fine.
>>
>> Hm, but that's a phy node, not address of register... Isn't this a phy
>> node representing the phy of the CPSW MAC ports?
> 
> Despite it being a phy node, the phy-gmii-sel driver actually uses this
> node to obtain the address of the CTRLMMR_ENETx_CTRL registers which
> correspond to the CPSW MAC configuration and are therefore unrelated to
> the PHY. Please let me know if my suggested description would be fine.

Either I miss some more pieces or this is wrong design. The phy node
should not be used to pass some addresses somewhere. It is used to
define a device which will be instantiated (as parent is simple-mfd). If
you use it only to obtain some address, not to describe child device,
then this is wrong property type.

Best regards,
Krzysztof
