Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D477595876
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiHPKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiHPKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:34:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5EC889D;
        Tue, 16 Aug 2022 02:26:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so12721203edc.2;
        Tue, 16 Aug 2022 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=lQavYR1DZVq5XW1RfvfwaMPSqcKo4wtNK2FvdVYRRiw=;
        b=kSJjKHO1Ts2egWBbe1C59rolcVhl25nwBxdHHt+BfW74kXoG+v3KUyz40zr1FZ/Rtx
         XhX6AEZoWcywVft+mZB8eaeS2q0K0OZqxFGNHjpJW+325T5QUcqRf5jt08F9+nOXCmVm
         0hEP9X/L1R4dxyv5Cs70qbfIzWpYHFYNroXKcmWc+Ts5YfP6yjuYOP/8nxlIx1Ws7Lf0
         bhysQ27hqnb8QW6RCkCb8XPUPVF3emgmpTHiNxp113mF22rdeOcCV9I/+7Sl6VkBfekX
         0CKM0ySGicZN1w+v3MP7XKPQjS4O+P+8U3OReiDTlJdMWXpe/U5LzvmuP/Nit4HJcVYv
         R2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=lQavYR1DZVq5XW1RfvfwaMPSqcKo4wtNK2FvdVYRRiw=;
        b=1USMjAJoRfugXMGJhc9mOkjaniWbWzUFZ4m5GLScdykXhbaj87kg7H5IYeFxbns+3A
         3KKvFV/+ZVGr7hSqWmRiX0YRBjALIPLqldDTD/pw+4WwjO8UoMPWMcXojUII6cvRdfEV
         JPbj4tyhtyzhqYCPo4jzTIPkwlcSt0KA5Y7HnzLa/6H+sYIT7KN7wOP1EBbNRCfhnmAM
         74iD/WsT/rwF2QR3IxIoc/tNVPv6lnjOpgRXK46RgwC1oXrJcoQOym/mkrBXhYlKQiah
         MlQ8alzpLReH3nid0rkiS/iVdBVgM6mBNi3Vw+4kMC0oDSnYbZot0OkcpoU4HbODEx57
         gtMg==
X-Gm-Message-State: ACgBeo0pqAa9DFtqobn8191FzJsKyFATFAykK33cgxpJ8Hm/jGqGUnCT
        N+sLJb99RrNZSG1fOf+fZdg=
X-Google-Smtp-Source: AA6agR7lurC8h894L7K1sVne44fBceCPThkML/hHPvS14Tz7FZvHA6Qb6beC2g50oaWIJLyCJLd6zQ==
X-Received: by 2002:a05:6402:26c5:b0:43e:2f1b:31c2 with SMTP id x5-20020a05640226c500b0043e2f1b31c2mr17741424edd.424.1660642009160;
        Tue, 16 Aug 2022 02:26:49 -0700 (PDT)
Received: from [192.168.27.150] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id o10-20020a056402038a00b0043a7134b381sm8118956edv.11.2022.08.16.02.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 02:26:48 -0700 (PDT)
Message-ID: <39a59ca1-642f-40de-f71d-842f9753372b@gmail.com>
Date:   Tue, 16 Aug 2022 11:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot,env: add basic NVMEM cells
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tom Rini <trini@konsulko.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220703084843.21922-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220703084843.21922-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.07.2022 10:48, Rafał Miłecki wrote:
> U-Boot doesn't have cells at hardcoded addresses. They are stored in
> internal format. It's still important to define relevant cells in DT so
> NVMEM consumers can reference them.
> 
> Update binding to allow including basic cells as NVMEM device subnodes.

Ping :)


For a reference you can see Broadcom's NVRAM (identical feature):

084973e944bec ("dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=084973e944bec21804f8afb0515b25434438699a

c8442f0fb09ca ("ARM: dts: BCM5301X: Add Ethernet MAC address to Luxul XWR-3150")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c8442f0fb09ca3d842b9b23d1d0650f649fd10f8
