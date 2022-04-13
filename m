Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042254FF89B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiDMOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiDMOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:08:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9260D9E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:06:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so4150709ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xclQowK5QbwCO5KzYmDKXFep6DHLbWkFBjvXdbQJZDc=;
        b=luU37E/8JMHNl4VHIi5MneOzNwctGyKeslQDkG2RJbONP2cISPuohPncjJCMISpSLd
         JE3lw44w2pubOWRq01DpTW7/WUf4ORBprY9WXREI+Zpr245SkV+0ZNn3PCyCbsLHC7d0
         s/2eltfPiTse6V0nmcMriwjg+HJ4L6u73/D4uQDNJf30JY0vLCKkZIyhI+rf/5qVE68z
         KaH6hUAP390HKfdQNawuQeDGju8SxI6imDRDEm4rwN+4bP3ubagIQZjrK93/24UoNF7t
         Kpfsbvy03tUbdmpahzFBQD292jb53r5SIVjUB2XvsKg7sQfZr3UAwNR4nx5huS2NyDxf
         R8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xclQowK5QbwCO5KzYmDKXFep6DHLbWkFBjvXdbQJZDc=;
        b=ted63oqE1TXRD2QV6N67kGtH5ppMWeWDAYSwcQfCUegwI1LdTmgyT9ZDzpO56JSJGN
         0Kk2viaMbVFASKgM4a1dvOUYoaoRVWwAWNicTM8PWuyU8IyZlcacW2Gj7Rf0oPbTmNhv
         m/o2OXjIy1MxGVDJB0WOkFC3wp7DvlPHsLqABeuzT4dn7/CG1Y3wj3RIOVVVDkE2UApY
         mXmpmiJ8utQMPXguUooC6sebc+FsNxffRXncS0byGs42PkjB39mUaOjH1IT+9NXunlYE
         bJc2NVnNDYtntRxD/8AJ0Os1EaJxhSj7pTljxUIuxkYSZoVgylhc//eongDpxqCsH0fQ
         fSXg==
X-Gm-Message-State: AOAM533YQumeWzOD/B1cHYRtOZcc9LA84sjIxwCemMBYJPnAu5+ImaeI
        Z9DCb8jo+d68IJ9VIN0yBdOWLw==
X-Google-Smtp-Source: ABdhPJzjr+0cuBz3KT6Z5/dHflarKqX3dFwJjKeJYoA6U7QJ3txgow0qPdJbiQNrXxDeHEiDBBlb1w==
X-Received: by 2002:a17:907:16a2:b0:6e8:d283:17d0 with SMTP id hc34-20020a17090716a200b006e8d28317d0mr1658785ejc.445.1649858784172;
        Wed, 13 Apr 2022 07:06:24 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d13-20020a50c88d000000b0041d8c0440ebsm1208244edh.95.2022.04.13.07.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 07:06:23 -0700 (PDT)
Message-ID: <ebfe563c-5c3f-d69f-39a3-c8c79616f060@linaro.org>
Date:   Wed, 13 Apr 2022 16:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: hwmon: ti,tmp421: Fix type for 'ti,n-factor'
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220413134729.3112190-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413134729.3112190-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 15:47, Rob Herring wrote:
> 'ti,n-factor' is read as a 32-bit signed value, so the type and constraints
> are wrong. The same property is also defined for ti,tmp464 and is correct.
> 
> The constraints should also not be under 'items' as this property is not an
> array.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
