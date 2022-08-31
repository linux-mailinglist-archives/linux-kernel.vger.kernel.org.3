Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39A5A7622
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiHaGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHaGCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:02:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD7BB926
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:02:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b26so6613487ljk.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nbGcB33f3vtSsFvUomQd2O7+yHjb/bY+6jPg//hkM20=;
        b=JQDQPAfJ9E9k/gZ9UxWAz78BzOxgUSk9SJBPO9GcGvxkl7m/q5jucRtpr2Xj7J52iv
         COILzG1zqi7xot1XoMLVfXcsJ+nezIUJtiB6JU8C2DH7zbJC2fqkbq1NS2lXbBeMnNWm
         HZR1fMg89rEPz19W1mXqYUe2iAwnFvEIa64Ej0npJ8nTQPyz4x8dlOAwqaZmeAOI0jWh
         eRWr+2zUaTSk3M5LLmPkahWkNYt/7/kDO452Fl3Z7Oh5MN9WNNBTDn/sI1vZB30qOxJp
         YyWauDaNk52I4pi63pkNJSQtBbUwMN0VRZdmi/G/O13lmZb5E+lx7KAiFcnL2YMQGSDR
         NDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nbGcB33f3vtSsFvUomQd2O7+yHjb/bY+6jPg//hkM20=;
        b=mspBNA3c/LCSQqjNcd7fEabrzvmTOimQ9j4xlWjz5PEUj1fs3+8t8MjnRqHyLEvgzS
         9HAIl3SjPRn1zenXu6dIcghcgzDCs5+z/aNsn9u44nMEewcoCznlxYgjbZaaDlP+4Fi/
         jMlj8WuG9TLGIaSXYlLdgw5lpA+tH4Jp0lOpCizRS2HEAu9KhVTM9cIHqkb7tpA4ADby
         k2pmzMs515HIXAkIJ7eX4Ik/a48kRzZZBp7+dB7MThADICANE6IsLiJzhc33QNMXutgA
         OuYdeEaX1vtdGdDOV0U3ecZHHGtY+TpmF+qqi7jErr8tF5rvemYsUfWWVKhihmp4WDj8
         D45A==
X-Gm-Message-State: ACgBeo3iLyz42POGTG4wUgA7VlSyMoOJefXwz7eImpnzVKQQx7jS2jC4
        Zp6+ySoKm3BHRKlquGLmm07K5A==
X-Google-Smtp-Source: AA6agR6WkZsu4SBuQtp7SwPb2bib2k7rEr3JJpVbNcdOjhqQLSDhhBa0hL9scYuMfjpcRFIk6H8mEw==
X-Received: by 2002:a2e:3112:0:b0:24f:132a:fd71 with SMTP id x18-20020a2e3112000000b0024f132afd71mr7670629ljx.522.1661925738915;
        Tue, 30 Aug 2022 23:02:18 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25fce000000b00492f1b2ac0bsm1867976lfg.101.2022.08.30.23.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 23:02:18 -0700 (PDT)
Message-ID: <82576790-9fb0-ee1b-2308-fbe292068bd9@linaro.org>
Date:   Wed, 31 Aug 2022 09:02:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
 <20220829080830.5378-2-chunfeng.yun@mediatek.com>
 <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
 <d30353e4dbb785c3ce31ef54b791bfe3d23df904.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d30353e4dbb785c3ce31ef54b791bfe3d23df904.camel@mediatek.com>
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

On 31/08/2022 06:14, Chunfeng Yun wrote:
>> These bindings are expected to be
>> usable/applicable on several devices, so units, not register values
>> which can change between devices, are the proper and reliable way to
>> describe a feature.
> I prefer to use exact level values, but not the inexact values with
> units (e.g. -percent, -microvolt).

What stops you from using exact values - bp?

Best regards,
Krzysztof
