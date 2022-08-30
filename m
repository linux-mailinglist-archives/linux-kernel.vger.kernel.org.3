Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5934D5A6BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiH3SLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiH3SLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:11:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB313F3C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:11:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m2so12871684lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0jx9VNj/HcW0dooShctB6tlNBtRfv946EPoOPim3t0E=;
        b=IdHkGy3kZluHn+s1pCS1fWDIsltwMDgJ5SLNDPu4jLO5nDxOv7HtdjosNkKuyV0DmG
         eUVjPmcsRIc71d5lUiyCBv5yz5iwuKITxlkI2CCTrVITfLANq+620vJrpokgFTnjMf65
         PPqxsSS+0cG9/10Su2NyJ/PoPuhyRXxyjcg+WLJwi+0JwWn4830Atw3YAVd9seGZ8bBd
         pQb455HbnE8H9AyoNrefVsPmjpWDZYG8ji2B4reou+a4cddd1nX5+NK/Opneeh+VVpgv
         0tybYtY7AnI1k1Wc5+hDcL2lPd/zK924fpvX3KRBLJpdU13SX0L3NR2Wv2HkylcGhsWw
         6Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0jx9VNj/HcW0dooShctB6tlNBtRfv946EPoOPim3t0E=;
        b=yg5qrv14AsZK3suEg78FM4nC28zU7HTieLB477101LQKbWrXrMbgxyYyxVTf7KYX3p
         Ir/eGUmDAMHHYug6THcMcGOqJivOOd+lIRLGea/j4HhtaDo2rOiBGC2Ol9i57mbZFOQt
         AmjsUy71ymVQqgJO5IPmN7s/ZtsI037z+iCsTNG0iAUGDKUrq/1P0tWjvcQuper4Usk+
         Oswa4/Qouy6/giiXUdnXLi9eBbEYI3VKlte42QvNoqKRHvPaIWzCQ1v0j5kCv9hTnUz5
         zGjwX9utCNveZKSchcGJeo8PMV7gw3eCzJo5jDp+1t7S91p0u63yM23TbaM8TDOUIxVe
         4HYQ==
X-Gm-Message-State: ACgBeo3uQ3PGKKLPMplPvarswmZn43MvZ5LgVnO8PczslnUAbvlwnj8k
        9vWNeCva360oQhkyk8SuMTxa7w==
X-Google-Smtp-Source: AA6agR4LS54/XWSxpR5JM4CrvVaGHIeYIc+KzFnzxBcHugfK4mmyTYOXAfXMhla6rcSZpaiqZFIh6g==
X-Received: by 2002:a05:6512:3503:b0:481:4470:4128 with SMTP id h3-20020a056512350300b0048144704128mr7794471lfs.303.1661883066495;
        Tue, 30 Aug 2022 11:11:06 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b00492ef074fc1sm1683629lfr.183.2022.08.30.11.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:11:05 -0700 (PDT)
Message-ID: <ce096b36-b678-63e1-e98c-7549f3df357f@linaro.org>
Date:   Tue, 30 Aug 2022 21:11:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
 <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
 <Yw5Qd7ZNPIc/o7+6@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yw5Qd7ZNPIc/o7+6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 21:01, Mark Brown wrote:
> On Tue, Aug 30, 2022 at 08:35:09PM +0300, Krzysztof Kozlowski wrote:
>> On 30/08/2022 18:07, Ban Tao wrote:
>>> DT binding documentation for this new ASoC driver.
> 
>>> +properties:
>>> +  "#sound-dai-cells":
>>> +    const: 0
>>> +
>>> +  compatible:
>>> +    const: allwinner,sun50i-h6-dmic
> 
>> Put compatible first in the list of properties (also in required:).
> 
> Can the tooling be taught about this?

Probably could save me some time in writing reviews... Let me look.

Best regards,
Krzysztof
