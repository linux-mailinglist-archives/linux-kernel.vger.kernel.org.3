Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9F574554
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiGNGwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiGNGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:52:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794D2A709
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:52:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u15so1041467lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aYPGRpp7bIQdV/ckAaXkQJsssasqnsD/N9w3qRFAT6U=;
        b=wgX14qexFQO+kAijrErz51JW3hgW2tbgAyMwAvThPzg8Opnblr94iDhWx78yH27IbK
         TX/DYstNHSRW1kTWf6qYvWq46+QknyvO/Ek1qflJrjA0ElGsJb6575qFcL63L30lAdun
         Runu04uz4Xqm3VlD0DPY21jbBPj721/iHEV6VCPJo3xe/nPBP7KEGT/wcPzWWjyKdjQw
         gxJrh+iwRushDNf8WIKGKZ2Mw4nvoiUwTPWnJzNVKaOYsnWxJHKr2ipgDwnyNesYppUk
         cDS7uPRX1Ud6RMWIwepSj7PyGP/CWbRiJIvhiU03ihO02+vhuETnRGWptKuGsjaP+8aF
         KigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aYPGRpp7bIQdV/ckAaXkQJsssasqnsD/N9w3qRFAT6U=;
        b=jHmdq5sk2tBp6JvBwrsLYvFQAZ5s2YPKOPBP80PvikjYlbRjENuv0WaO2Wg6fXubDc
         zzx/oJDFDRj/5TC5JdXxC1xGZ5ikn2mIYPgM0sJfRe7GzwOmftQEZTZgRKoo4qgPPRVT
         44fJJZnjdBTY4H4CZOcgFoo/YCgpMXZmpBspa+22LfjQxr9XaiC2X1AYQztVOaKWY6PP
         sAdfWw5WY2N3W6mI8+7H6hdSVgF2a2a6HW0ZiMHwPxgU+YssVDtu2zz31CNiDLIOfWWl
         wBSVpu7XxMLeF59YD3btp7b48q3bYDpydDiQDpeFtF0cKFWgld4o5nNYFULXiWM4vSPa
         eQEA==
X-Gm-Message-State: AJIora+0oZBnyT16C5B9xUHszSMEe48i0vHIoLzjD390zWWKsCi2ubso
        Gm3TfTTVpTHY8jJ0ON1RwMU8d3+8vp4veQ==
X-Google-Smtp-Source: AGRyM1s47IQ7CpqFqIPGIwgSCkWRfPYszglUVlSs6RrOfiEWxegvSvOWabsxXZnLk9FYVH7642gAoA==
X-Received: by 2002:a2e:9941:0:b0:247:dce8:b0ec with SMTP id r1-20020a2e9941000000b00247dce8b0ecmr3801510ljj.404.1657781533192;
        Wed, 13 Jul 2022 23:52:13 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id t13-20020a056512208d00b00482bdd14fdfsm198275lfr.32.2022.07.13.23.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:52:12 -0700 (PDT)
Message-ID: <f3c98e31-7c68-34a6-f492-95c1b6eeb625@linaro.org>
Date:   Thu, 14 Jul 2022 08:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v18 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713084139.2810115-1-xji@analogixsemi.com>
 <f9e1ad3b-d6ed-7392-2fd9-ca6ff0417b16@linaro.org>
 <20220714020238.GA4276@anxtwsw-Precision-3640-Tower>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714020238.GA4276@anxtwsw-Precision-3640-Tower>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 04:02, Xin Ji wrote:
> On Wed, Jul 13, 2022 at 11:28:16AM +0200, Krzysztof Kozlowski wrote:
>> On 13/07/2022 10:41, Xin Ji wrote:
>>> Add analogix PD chip anx7411 device binding
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Xin Ji <xji@analogixsemi.com>
>>>
>>> ---
>>> v17 -> v18 : Change node name from "usb_typec" to "typec"
>>
>> Node name was anx7411, not usb_typec. What are you changing here? The label?
> Hi Krzysztof, sorry, I'm confused by your comment, this patch followed the
> other dts example in other yaml file and passed the dts checking by
> command "make dt_binding_check".
> 
> Do you mean change the the node name "anx7411" to "typec"?

Yes, since the some revisions ago I asked to use a generic name for the
node (generic node name).


Best regards,
Krzysztof
