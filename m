Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF8B571F86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiGLPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGLPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:36:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CDBFAF4;
        Tue, 12 Jul 2022 08:36:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o18so7882595pgu.9;
        Tue, 12 Jul 2022 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D62EEaJdJ1cUDqfOx+/9az3sZV4zojbFZZeqG8QPACA=;
        b=pPihGnCaQ8cg4w9ldLfV/i3WKugrLc0QWCh/PQl9YbPVFL3Lr2UWaZYamHmhOSy+z5
         6kd/s6iACNpW3siXrot7bnlQbK1UEWaVvShA1bj88SSom3/SWCY2SWBAu4In9dDzJruR
         7LpD+fCGACefbn/FGfiIwamPAESY6hD4RedrmqZ5NI9N0X2x1VEMZFHdi15rSu5pNuoe
         +kDi11Xgmfzl5z/FPbx+DOAzN/QamSMltJOzXMBTP47kzvhHn8hn7MsYseXR/h1SoO6/
         Npamb8b+ZWs+QsDJ+nEAAdmgBnE7dy7t1vYUqZap2QePe7H7cJjSlsCc4deJDZ5hO9q4
         xfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D62EEaJdJ1cUDqfOx+/9az3sZV4zojbFZZeqG8QPACA=;
        b=olbpYgxyO4d6pCVaBr6zb0q14WKnDKLpyrXAaYAwTJr+Lzn5WEAoeN4pYUcSaPYzzh
         zXh1KoiEqBTGTT53MJnMaH8sihezHM6yvCEzTko5TXlvXQMSdKby5eqoh21s6l8uNrAJ
         1KhFt59dO/Wwy757Ck9RzL3d8/jneLx/iGHAty+ja/zz/qCk5x4r28dYFlKNMB2XtrNk
         zpV2lPWwLKtl+NC+/QuKtK9dkaLAz8NK1cMOukeIUyfXCl3J1I+OKXYqcYIKZabPZuqq
         5iSIHeEycuOfYjtGXnFa9RsuGgfUrcHJN5cKi8WeKcBC7XH8QvYoMsVmVX7hzUN8ZbiM
         1qkQ==
X-Gm-Message-State: AJIora+60EoH1eqXZ44CS/Jq39QEGHWmMZH9lkeL+/oV9SfgQKQ7Dam5
        HGmjrIoEMnIgUwIW1EtwA5k=
X-Google-Smtp-Source: AGRyM1tluCYwfEtElbpLtsdITpCG6+RpxuiTKPvI5GF5WI1YAPknTx8/9d7FprFKfKYM/f2ciRnDng==
X-Received: by 2002:a63:4619:0:b0:419:83a8:bced with SMTP id t25-20020a634619000000b0041983a8bcedmr853782pga.319.1657640216474;
        Tue, 12 Jul 2022 08:36:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm3994068pjb.2.2022.07.12.08.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:36:55 -0700 (PDT)
Message-ID: <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
Date:   Tue, 12 Jul 2022 08:36:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-4-william.zhang@broadcom.com>
 <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 00:47, Krzysztof Kozlowski wrote:
> On 12/07/2022 04:11, William Zhang wrote:
>> Update compatible string based on the new bcmbca binding rule
>> for BCM4908 famliy based boards
> 
> Typo - family
> 
> Please explain why breaking the ABI (and users of these DTS_ is acceptable.

This will be largely targeted towards Rafal who supports these kinds of 
devices with an upstream kernel. My understanding is that this is OK 
because we will always ship a DTB matching the Linux kernel, and I 
believe this is true for both the way that William and his group support 
these devices, as well as how OpenWrt, buildroot or other build systems 
envision to support these devices.

Rafal, does that sound about right?
-- 
Florian
