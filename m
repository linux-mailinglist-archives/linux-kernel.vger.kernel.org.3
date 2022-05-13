Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92930525E15
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbiEMIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378559AbiEMIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:46:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A41AF29
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:46:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so4376673wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=dPgyd7uZY4Uz9Bjj+rFN7gsuccpSyn+jTU1i4va1GEg=;
        b=hapYVwQuMkgtMmuCf+y3gwDE0wxXgpla234lTXA2Q6XJOajRawoyiHlaXEO9xmSdSb
         ssUC14S0JExNH/IVQPV2adgqeDmbwRi9MGWMkXC7MYiCjntv4QOjly+0+7K97Z6V2Zh9
         Nns/Q0TxwhDibVt0M68CyZVKHRG8/TajkbTR9F1nmiiMgtOSn42OHF+K92cgU09R6zQ+
         72XaKGXWrB9b8uP9mvP8xGdf+9EJAzi4OV5YDkDD6T6g53bxImlv7Dxh4CASRpGYN8EA
         fDSUOvZN0MjbgY4mcOfqjXclPISLGew4jdwKAafvgM7HyA9ETpYUUO2akcptwxEJRx6G
         YyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dPgyd7uZY4Uz9Bjj+rFN7gsuccpSyn+jTU1i4va1GEg=;
        b=DQvEJDEeLQswhMlokzqzvj2oct6NMhZ2xe5JDRfBW+8k0QI/gmvJ3iEfOzUbXaS3XH
         rGN8XrpzBAEXVMSDlewJPuA8LwZzFvfYQWxYZOsJ17QsmSaO7HPB1hoYrX0b0PY9jh1Z
         c0B259iFOExQgy3e1gFQrLTUWzrPANFR7rVaZkGOTLcN9qrcU9jIDnH8xhf7rrjCjMFj
         oj0qyg1+8f3+JCeP6e+JASYyHvSsh61dRRSZ9hXGj+ENlye7XWDoYQTqWc1xXgKjUsi+
         fKx6w/y+E+Ev5L8aH7qQyQkEsx4+0S/1skW1xkpVvlsQ4jU0VeGfuW17fXJS/zELj2F7
         UYJg==
X-Gm-Message-State: AOAM5335RrEXniIknJC3INnaFwv55LnBaXziMK0Lm3gVZFPGeKNKIeVO
        9tGsVycsGOfMIVReBHqiRLB41w==
X-Google-Smtp-Source: ABdhPJzuCGWi1DW29CYLVjuNRKTn3qdx8ZoEI0i0VosdSNXnXREwlPbnwiS7NFDOmZ4QMNsD1j4jxg==
X-Received: by 2002:a05:600c:4144:b0:394:1972:1a73 with SMTP id h4-20020a05600c414400b0039419721a73mr3465913wmm.71.1652431560121;
        Fri, 13 May 2022 01:46:00 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c65-20020a1c3544000000b003949dbc3790sm1760814wma.18.2022.05.13.01.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:45:59 -0700 (PDT)
Message-ID: <cc91582b-9bb0-3b78-38ac-979e2614bc23@linaro.org>
Date:   Fri, 13 May 2022 10:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/11] dt-bindings: marvell: armada-37xx: add Methode
 eDPU compatible
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-10-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-10-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:49, Robert Marko wrote:
> Document compatible for the Methode eDPU Armada 3720 based board.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v3:
> * Alphabetical ordering


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
