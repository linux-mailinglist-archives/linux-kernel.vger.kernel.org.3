Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402B54D019
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbiFORhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbiFORh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:37:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E24DF4E;
        Wed, 15 Jun 2022 10:37:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k7so1645717plg.7;
        Wed, 15 Jun 2022 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AKaM03SJ597JVB1Pipkp8OU8PC118YiuD4mRMUlG+Bs=;
        b=M/wpLHqdGUntdkNI6lOBiMNdFJGbEL4/0TkRYCDaumdmjwtxucbWiIqMspOVhJYGCY
         xFNbZjff/47wKSedl/Ubf3lwnEUbXQ8uIV3xXLkYpUYwEfPL1oJdVzbKiWVqhz8uXn3U
         585TQR53Gi1qb/z4BEWsYmV64gBvQ1a32VGCL5cGzsCEuGeURvaWTycYeLq6UFgOkbdn
         8APFRokl1mblswXloleVQ7sV9FIDhnti+IJVwU0mTxk/AomhMd2rzsCJwDAsEMTUPx21
         PWyvETdjF+jM5jH0m+aMkBXmjG38s1MkcUj4lhRsF6m/tHHz29FeCV8n2blV8BBex+oZ
         aKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AKaM03SJ597JVB1Pipkp8OU8PC118YiuD4mRMUlG+Bs=;
        b=HePw7mhyUjEEqtHwDqkTns1F17nryAEQ/BMWheJnKfWC/agVbOaZUYYD7Yul+AMdBm
         RH4Y/DwYGUiUiAa1ON3tn7UgkwhvJpBpQs+x3Cx+DWfIOJkDg8B2Dp3e/Bozoz7IJB+2
         oFzZjnutKc3kfsFaxHAm4Osr8qG1ANxkyr7KNZCZuK8BwDOWY+y52rMrY6puhVr5Ay/y
         UyI/g/e0LKmOxXMUPMz87TKlBZw5PBx/2sa+1SviVWDqp8eA98T1QEc2Iwj5cG8fJdws
         iHp0HSRiTTJQXpGnxXsab1QDOPr1hvZ91pXs4c/EYc5p12cCqKnJOxHGIH8MJGRqgeW8
         IQqg==
X-Gm-Message-State: AJIora8vLdCPxO2dWUGkA/NKy4nftDMnUNKGgJ/L8a3ra5D9LV9uLdBz
        ZPbC8vaHv2P7HtuhPepX1q6jVjHN3i4=
X-Google-Smtp-Source: AGRyM1viQDtcrHegAll7Rzja0dhemTAUjiE72iEwyGxIP9Cq0FS+Xzh6g9pbqr9iY/9E3Zf0veBqzg==
X-Received: by 2002:a17:903:2281:b0:167:56a9:935c with SMTP id b1-20020a170903228100b0016756a9935cmr727364plh.27.1655314645911;
        Wed, 15 Jun 2022 10:37:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jj18-20020a170903049200b001634d581adfsm9538863plb.157.2022.06.15.10.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:37:25 -0700 (PDT)
Message-ID: <ed476cf9-d7a7-d312-4574-ee41a86fab7b@gmail.com>
Date:   Wed, 15 Jun 2022 10:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM6813 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, f.fainelli@gmail.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220610001534.14275-1-william.zhang@broadcom.com>
 <20220610001534.14275-2-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220610001534.14275-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 17:15, William Zhang wrote:
> Add BCM6813 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Rob, Krzysztof, can I get an Ack from you so I can go ahead and apply 
this series? Thanks!
-- 
Florian
