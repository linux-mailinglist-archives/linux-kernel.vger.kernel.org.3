Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58047554CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358261AbiFVOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358083AbiFVOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:18:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171B3C706;
        Wed, 22 Jun 2022 07:17:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so34557196eja.8;
        Wed, 22 Jun 2022 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kdeSlF5fWHZ3xXKBzKY62W+xebc6UMKioDmTRwyUM5I=;
        b=a3an+DWnKpt2DOtE2474+dpyWuKuuqp8cZVdW/LNxjfmHudnzTYBQ5HGDjGCVHI6TK
         0YV0twS6tEDlqOqIbncsXYNFrMZheYXU4f45+TlMmfeFRtipFBJYAYol6gd35vXM8nm8
         21/TujgU7Bj63LzBSs/dwhtQvHlL2M4DHxSYsb7KjZ7DHD1uzVd5W8oG2CjyrrC4H6zK
         ZTkfw06DnQzzHhjH8Jo2zsf4rdcxpeHiMWlUbV0EVoxy112jL3kXMCHfFpAg6cax4NN0
         hlSZD8qc3NZfXs4/WV6vDg3bVSM1M5wUUL0THtu1GlnTBt8EHGQaDMMVy72ur6G1utWo
         AnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kdeSlF5fWHZ3xXKBzKY62W+xebc6UMKioDmTRwyUM5I=;
        b=cuLrnSirt8dGrtciiW0aZSULLKY3KhhQ3g+YxGFLnECMJUhpE8B0Q/1yGTOorEmiiP
         J11W4NaY50htP2o72zbZcWecaao1c9gwdCx7JPU6Ep5dVBVRBq3V4BnDxouXbUbNNboD
         gv1bal/1GqIkDWSVSEFV+PfzgGRSkfwjopMJIUXsmWAgdZuq4SxeIuKvFtmGDy2CZ0vL
         nYcpk2chOraK+hGlpxr16YD6ynX/qQTirQRh2d62tYxsrab1MTgZ+uhdWeRi3Rbij305
         gomfa0pfsYFdAG5pD9jKPbHHUEK5V9c1HpG9dZn+jlu+6xOcUJ8jmzKwCrzhKkiSPYAB
         Semw==
X-Gm-Message-State: AJIora9msSMzmKbYoPlkXzlCxBRDa5SU7uJVTsxcg98bKdFfJLQe9Qd0
        db+cc8r4VD1RpCd5eulIFvE=
X-Google-Smtp-Source: AGRyM1tzJAEA91jxTi42bg0jzLDgIiPpJr86EGq+c8M1jJUUBWaaiyXJ/8e9nNQgCTcL9ByigtTVdw==
X-Received: by 2002:a17:907:1c07:b0:711:c966:f02e with SMTP id nc7-20020a1709071c0700b00711c966f02emr3441603ejc.221.1655907446732;
        Wed, 22 Jun 2022 07:17:26 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170907784d00b006fe9ec4ba9esm9419558ejc.52.2022.06.22.07.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:17:25 -0700 (PDT)
Message-ID: <ec6b910e-01fd-94ef-945c-31d48b2d47f7@gmail.com>
Date:   Wed, 22 Jun 2022 16:17:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt7622-rfb1: remove wrong gpio-keys
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220617232124.7022-1-krzysztof.kozlowski@linaro.org>
 <834af774-ecdd-1929-86eb-6a814c5d774c@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <834af774-ecdd-1929-86eb-6a814c5d774c@linaro.org>
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



On 18/06/2022 01:22, Krzysztof Kozlowski wrote:
> On 17/06/2022 16:21, Krzysztof Kozlowski wrote:
>> gpio-keys (regular, not polling) does not use "poll-interval" property.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v3:
>> 1. Correct commit msg (Matthias)
>> ---
> 
> Eh, jetlag hurts the brain. This should be [PATCH v4] in the subject.

No worries, applied now. Thanks!

> 
> 
> Best regards,
> Krzysztof
