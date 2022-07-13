Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C999573B40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiGMQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiGMQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:29:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873752B614;
        Wed, 13 Jul 2022 09:29:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15so12814110pjh.1;
        Wed, 13 Jul 2022 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3l+uleoAPt8BxfVBFyrnEYeSqQSnYyMWqVD87CGK33w=;
        b=c9EahvZpuYw1Reguire61QGDyhdSmRRFTiN5xYDrePD0BCAWlEEqgpFdz/tboQExF7
         bpIP9fyWEfopcC6uVUPo6OUt3vHNHftJYN+qh/14jesxSUW8wIcfsKDl0rDSh/LL+GDr
         4/oqmeLCy0splGy6ZCvbG7wmpMZhoqlwlDw5EDDL5T7BYut8xRkxrgVnMIMH6GzS+IXX
         uhlnH1fnBanrRbw3kX1+p6fLbkNrYZ7zDXOkhxPWY5+UJkk1anoMBnfiCHAT3vmxESly
         5wnmqk88c9/qaWzKZ9fF+mp/wsRG8OJxkXnR09BbFCHr6tRBcWildc5WemnvAXNNa+Xw
         Aq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3l+uleoAPt8BxfVBFyrnEYeSqQSnYyMWqVD87CGK33w=;
        b=ncOoz7mEVDgC/bI7EqV6ruXK9H8OGiR89kfPGjVgpZfnnyHPuUOIw7YfEuRHyFYd8J
         ka5XfXAX1LqgSL6wpymQJvDvO5fiOW2Mzr3GOiSpZsS+YOK9b+COHaxVodD/KDB3T5ze
         aggxHK+VJgreRzRATQM7kdpy7Wxwe0lorAaiYa5Dsc929SFMbiwkZtAzKpUh7bLv4wpC
         Cx9A4zu4Z77RHeBup+3Aypz/jjuxrAiJaCVQGZ7vRVcLFPFwMlKAGh+yUe58C8e8+gUD
         JGPBQZ/YP+vN63ajKp2wbwfk8dLcSSTCO19TMp3RVBGgQwkneT47fgoMln+QG3Gkidrf
         GYQA==
X-Gm-Message-State: AJIora91Cnnqjv5YrXrJz3w65V54mxngCuvt3Hi1JztNuzwcJXPXjb+z
        tqMZTCvNtv1A92TrHPpRjPk=
X-Google-Smtp-Source: AGRyM1vhA1eebogPmExtb/BUe38Y58U5j92SFwtL1fJRZ7Pf7Z3mryF+BoNTgBpBt6EyeMUqrM/d5Q==
X-Received: by 2002:a17:902:f7cc:b0:16c:10a6:9e25 with SMTP id h12-20020a170902f7cc00b0016c10a69e25mr4008048plw.162.1657729797971;
        Wed, 13 Jul 2022 09:29:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v11-20020a1709028d8b00b0016b90620910sm6210028plo.71.2022.07.13.09.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:29:57 -0700 (PDT)
Message-ID: <5bab132b-d6e2-045d-3960-0ece99da9723@gmail.com>
Date:   Wed, 13 Jul 2022 09:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: bcm4908: Fix timer node for
 BCM4906 SoC
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220708182507.23542-1-william.zhang@broadcom.com>
 <50bd9abda381ebdcaea41d116b4baa9c@milecki.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <50bd9abda381ebdcaea41d116b4baa9c@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 23:49, Rafał Miłecki wrote:
> On 2022-07-08 20:25, William Zhang wrote:
>> The cpu mask value in interrupt property inherits from bcm4908.dtsi
>> which sets to four cpus. Correct the value to two cpus for dual core
>> BCM4906 SoC.
>>
>> Fixes: c8b404fb05dc ("arm64: dts: broadcom: bcm4908: add BCM4906
>> Netgear R8000P DTS files")
> 
> Well, one note. You shouldn't line break Fixes: line.

Took care of that before applying the two patches:

https://github.com/torvalds/linux/commit/b4a544e415e9be33b37d9bfa9d9f9f4d13f553d6

https://github.com/torvalds/linux/commit/8bd582ae9a71d7f14c4e0c735b2eacaf7516d626
-- 
Florian
