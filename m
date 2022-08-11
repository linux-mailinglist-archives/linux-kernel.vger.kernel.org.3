Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53C58F9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiHKJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiHKJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:00:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204E93510
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:00:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d14so24641563lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5WjgcK5eYVPFMLFJ11aVeFu0Bby9kbbjoEryld0yZRM=;
        b=IjMYLXXTgqW2YJAI8+nq7IHzhh2jmwEYXPd5d05xMSxhXA7m0HLnwpOgH0Z2azqYlo
         f7rxHCdZ5BLkXtkSdqwwVqxWZ/xxAumK9pjsvnKj94Q1fRi0f4Y//bmcVZUvW4DeRGgy
         zcREEStRNU3KFKnzTl639hXXoBJY1DEBIeSuOLGvqv7HBwiw6KyAykQlOUp+Bjs0C+Ek
         1aVx7wYJB+cqwlfB53/p8vNURnAONFYWHKEs6FY9Jn1my1ZylOpn/TJneY+tKLG76POg
         vcO81I5/Gf0Q3eLZR/LL6pHqeUULCMpg7zxADRQ77j1CM4M1pVgOdI7o7fC4WSmBsWwz
         ut2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5WjgcK5eYVPFMLFJ11aVeFu0Bby9kbbjoEryld0yZRM=;
        b=jZjm95RJ/6x4oN4YhrMBexqsSScmnuZ0359xwGJtSb8BMefQU/gya3vUqqDFnQKEIQ
         zSdaxxTylEzFcsrdPdbbI1C+TkVrX8Plr/zs4S6alk5+OjpplMQZ4btlX62tZO7/M7Lg
         eZy49ptmd5fbdOg5T1olksIDiPF/4Eg00Vnse6V3wj57u59DFDIkP3nA9pT3IDzxxn09
         LupR2E6lGd2Hq/68LN0WXyuejAY/ZVnGtOiGh2XOSPb5pjmvQD3PuQca/6Gtlzr9K30o
         hM6Ze5rKWn9PdgIAyVe+4kmJIqnqmGpr1GRmlr322ypchjwtJVi+7FhNk6s4hLGTvwW8
         VDaA==
X-Gm-Message-State: ACgBeo2VJbAZugn4tGPgW7cfD3SPL0ivi7Xney6bP2aEU4CeJI4f2fhS
        e+IJRDke0jtGMLKutAEzkUl18A==
X-Google-Smtp-Source: AA6agR6S5yUrkTRapcPMXpUd01M/KOAE0CJfD3/X8dJUf0WmsecENjUCniEzdzXJG0kjhW/Ca0HNPg==
X-Received: by 2002:a05:6512:3fa8:b0:48c:ffd1:625d with SMTP id x40-20020a0565123fa800b0048cffd1625dmr4637794lfa.251.1660208402628;
        Thu, 11 Aug 2022 02:00:02 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id v13-20020a056512348d00b0048355942defsm630300lfr.249.2022.08.11.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:00:02 -0700 (PDT)
Message-ID: <ec906e4d-776b-1a96-bcda-c53c0b338562@linaro.org>
Date:   Thu, 11 Aug 2022 12:00:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees for
 MSC SM2S-IMX8PLUS SoM and carrier board
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220721101050.2362811-1-martyn.welch@collabora.com>
 <20220721101050.2362811-2-martyn.welch@collabora.com>
 <eade56c1-bf4e-0ece-9b67-02f01a95c741@linaro.org>
 <5d2aacb5b0a06a4ad63fe28f4b34e4fb41f955f5.camel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5d2aacb5b0a06a4ad63fe28f4b34e4fb41f955f5.camel@collabora.com>
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

On 11/08/2022 11:49, Martyn Welch wrote:
> On Thu, 2022-07-21 at 18:34 +0200, Krzysztof Kozlowski wrote:
>> On 21/07/2022 12:10, Martyn Welch wrote:
>>> Add device trees for one of a number of MSC's (parent company,
>>> Avnet)
>>> variants of the SM2S-IMX8PLUS system on module along with the
>>> compatible
>>> SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of
>>> SoMs use
>>> the NXP i.MX8MP SoC and provide the SMARC module interface.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>> ---
>>
> 
> Is there anything else I need to do to get this ready for inclusion?
> 

One thing could be - do not ping during the merge window. :) And if
pinging be a bit more specific whom you ping.

Best regards,
Krzysztof
