Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F64FE5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357610AbiDLQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357576AbiDLQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:30:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47675D5EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:57 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so38369085ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NDMWPs4S7zilupRHZRh1G0PStgWMtqHNX86waZCmVE8=;
        b=dLqmb6kJL5mNPwhuzfsZIOYf5d4DggnddiZ5T1YazUghckPybZmqFE+PE1EBKvLGoI
         WJLC9SFdCWvTV3ielnSpXSBbtdLZxodidqSypOgcBqEQyxnzI8Y8N+t6+F8VJrV7mGLu
         ufIm5LiSViEmjJR7el+bjssJ218/plCuY61Q8hsfp1C9xEZpJnx5Jengqphk/6btlNHx
         nFAEYhMCaySp7kk/buf0tZYPTsPmitigjeJTNE6mNi9fjNezM7a4SYW+P41QzbpE9ZD6
         yNI81MAGKHX7EmhPxVGLcyH5OyKtY0IiP7BQFQapa12TpyyXteQdmdOvhyGpHhA2Ls2o
         VQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NDMWPs4S7zilupRHZRh1G0PStgWMtqHNX86waZCmVE8=;
        b=uoai0AYe1gvJDH/4kYWCpGt0xtPX8e7qJbkvbEpCaybxH5xTwlYfTuSo61/UtNuLoN
         Kqm6+9F4NLoU+5EQtBSgxZ8tP0exRpUm9NkCiYLRcL9lvcBYvF8l073QM5Res3fCRZyU
         2wAJ0JAJOQhCUZI/jRAgCfe1dAOq+wVMo1TQRApHPLANAOSTbv+QJWAzJogAf/AHotsr
         c+Qz10gDUmzpNEq2KJe2dEAj+pdgqYWdtIqbVUocSwEIpFPdWZjWRlg2SIHeeqgcsEh9
         iSj+a8QRH3N7hGXpSMSVsC5uBgbFPjHgECPiPwSVdsk3WNFYnqRLQJ+uhMS/dtDC8ZaD
         zBKQ==
X-Gm-Message-State: AOAM5304hNYg1kQ2w5tcmiK865y4fR0IqXULZy4Engl+icIAbxGcrApG
        zmzkDMPU/xT1PxxpKJm8giz+Mw==
X-Google-Smtp-Source: ABdhPJxOgxov+X+zXtcd2ayLa52f1FP4vBidDROaYaMLhZJo1c4KNN1Dn13j9jc1Pkv6HT2SJxILKA==
X-Received: by 2002:a17:907:e87:b0:6e8:42ef:86d9 with SMTP id ho7-20020a1709070e8700b006e842ef86d9mr22736713ejc.59.1649780876063;
        Tue, 12 Apr 2022 09:27:56 -0700 (PDT)
Received: from [192.168.0.197] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm17267681edb.47.2022.04.12.09.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 09:27:55 -0700 (PDT)
Message-ID: <60a9a401-7d1f-5100-7c3d-45452ebfa2ae@linaro.org>
Date:   Tue, 12 Apr 2022 18:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] ARM: dts: add dts files for bcmbca soc 47622
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     Samyon Furman <samyon.furman@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Tomer Yacoby <tomer.yacoby@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
References: <20220411172815.20916-1-william.zhang@broadcom.com>
 <20220411172815.20916-4-william.zhang@broadcom.com>
 <ed806d35-3613-4f9c-54ba-b31fc5ed91c8@linaro.org>
 <147e23b6-c5a3-a9fa-c0e1-defe906e42a9@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <147e23b6-c5a3-a9fa-c0e1-defe906e42a9@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 17:37, William Zhang wrote:
>>> +/ {
>>> +	compatible = "brcm,bcm47622";
>>
>> This does not match your bindings. Even if it is not used.
> Did I miss anything? But it matches one of the compatible strings in 
> brcm,bcmbca.yaml.

Your bindings expect that this compatible is followed with "brcm,bcmbca".

(...)

>>> +	periph-bus@ff800000 {
>>
>> just "bus" to be generic?
> This node represents the peripheral bus in the soc. Would prefer to use 
> the specific name unless it is not allowed by the linux dts.

It is allowed but the Devicetree spec explicitly asks for generic names
and gives example: bus ("2.2.2 Generic Names Recommendation"). Specific
names are discouraged.

Best regards,
Krzysztof
