Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011EB5163D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbiEAKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbiEAKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:49:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9963C73C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:46:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so13689380edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9qOu9Cvk/rQS/773XlxjM7JnBslFeXLdPBuq74VV3jg=;
        b=nlPKmT70hbR0MrjNXx2aySew2ZrKPYMjoF1vO0zHZ5m03q345amsb4c9O0ADsfdIBW
         LgPuoG8YJcKYumhBSO14hIUki2NIX597SDoxnM6/SodzPRloOXv4PoE2IeaQQ7REO/Ne
         HGrzwJucMi1iA58JZTXoNI5BzbaQF8p4BPQpQ2oWJpnyHbUKip0v9v/mzBpPLVKSHwMP
         Ce6NMKMDq1j+KNu8oRc0sTKa5g0LCacWgGWnllXJpoLDUYhkJvnxTOxzPIiegbfZAGkV
         en/PAI3uEapvtRoMeHNouI+vH6UPV1fVvun5Jpfl/VVwzlNJGmjXWy2wxO3MjOYrUC70
         Js8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9qOu9Cvk/rQS/773XlxjM7JnBslFeXLdPBuq74VV3jg=;
        b=LUVSnEAWou1hVlsVLgyApXGgtdJAZn12bNooYMKQucATAobWHR43lF4s+k1DadjT4/
         8DLGyv9AegtlndIfdNvJs5G/2lmy3x6QrY7aR01BwvRXGOoIphINYMoRI9pXt710WNxo
         Ht8tSX+0rrXdjnn5FeJ8hEEcqXQfKnB7cn5bpsHtMa55x0YU8+iQd2SZnWUMy9Wyrqkh
         2thpqu1wYJ9FgAdHc0qwU+qWGErkMP9ERHZdMWRyoDz7bex2yDiSJZ1fEzn+9RrInZz+
         seaZ7dk6tslW6p4ueOPhbQVfV8kE5PgniO9ctqzacOXJrHoolRzbbNsf4ghDRxLvgFQm
         537g==
X-Gm-Message-State: AOAM531lgLJ3rbEuNC77L+u6R170uZTupiYeK6lAuYUrXrFxMNAviMNl
        vSlHHkLvzhOHo1WE27bXEGeF8Q==
X-Google-Smtp-Source: ABdhPJz6vw3rvue9OR5zhB2gQ29VJSBr9KsSJnbuRO3PrO76PesRzgpB5WI0ENM04kL9zEeN40LN8Q==
X-Received: by 2002:a05:6402:2291:b0:425:deb5:73be with SMTP id cw17-20020a056402229100b00425deb573bemr8197311edb.392.1651401985401;
        Sun, 01 May 2022 03:46:25 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id dq10-20020a170907734a00b006f3ef214deasm2484120ejc.80.2022.05.01.03.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 03:46:24 -0700 (PDT)
Message-ID: <00577fde-9c13-5a4a-006e-8bbeb3ebfb11@linaro.org>
Date:   Sun, 1 May 2022 12:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/8] dt-bindings: riscv: microchip: document icicle
 reference design
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>, krzk+dt@kernel.org,
        palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220430130922.3504268-1-mail@conchuod.ie>
 <20220430130922.3504268-5-mail@conchuod.ie>
 <258640cd-01e3-2a9f-b2a5-79b2b6cc4f59@linaro.org>
 <6477d21c-206a-f062-793a-7dfb801aadd7@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6477d21c-206a-f062-793a-7dfb801aadd7@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 12:41, Conor Dooley wrote:
>>
>>> +      - items:
>>> +          - const: microchip,mpfs-icicle-reference-rtlv2203
>>
>> Why is this not compatible with microchip,mpfs?
> 
> I guess it should be, I'll add it. Thanks.

Then it should be just part of enum earlier.

> 
> 


Best regards,
Krzysztof
