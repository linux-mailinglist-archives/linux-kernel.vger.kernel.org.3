Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E24CA648
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiCBNsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:48:35 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31A3914E;
        Wed,  2 Mar 2022 05:47:49 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id h15so2325964edv.7;
        Wed, 02 Mar 2022 05:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AcALeRLgruJraoqYkSDWeD6cogilR50XrL0fln3VffM=;
        b=Zt/DO+Bq20//tVb2JU+hu8hHyEkmNc1bCqbD+5AM+Cc5TzPLsHYHf8Ecjg2JQ2TAcM
         xdLnPGzSZJIlB1Etlp6Q8H28Ft7xBv0kRPV6MnqFKPDPxcQG4gLWXfEW/g6/SeQq5Jq0
         cJWyIcE6vBvTq9qMxPUnLbJrj3uwx9PWJGEjabaN/Z+6E9Hk4ocbuSDmcpuxF7l/TcbR
         6Joh9pPAYeBCTZx4QJ/s9RPN5QKF9EYoyfFSxxJLxBNhw0ngP7oR7eze2+blMf9RHpDa
         mwcwewOu0RXHn3pTlW+EuvImKy5LfoaK1ND3JETVwDX5QeYKBi/Ak7dvHUqKT5VMhn72
         xBIg==
X-Gm-Message-State: AOAM530wSp+qQftMjLT2l/+oX1MLFIxVnIsf+qt9L/wv+IkWjVpm3cI9
        tje5s2moolIG/7FeFG6rIb1RFQgwYBQ=
X-Google-Smtp-Source: ABdhPJyLon6u9lLsCunawYR20XfDf0xqCgLlH9uQfjZDDHBev+/9Kxx+h6PWJ1DRu4mFMN+J2Sl/Iw==
X-Received: by 2002:a05:6402:520c:b0:412:7f7d:b06b with SMTP id s12-20020a056402520c00b004127f7db06bmr29985652edd.91.1646228867527;
        Wed, 02 Mar 2022 05:47:47 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id l5-20020a170906644500b006ce6b73ffd2sm6364627ejn.84.2022.03.02.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 05:47:46 -0800 (PST)
Message-ID: <5476022d-6cac-82b4-b17e-23160689ea38@kernel.org>
Date:   Wed, 2 Mar 2022 14:47:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220302123817.27025-1-potin.lai@quantatw.com>
 <20220302123817.27025-3-potin.lai@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220302123817.27025-3-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 13:38, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
