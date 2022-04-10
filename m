Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A164FACAB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiDJIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiDJIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:17:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728612A96
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:14:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so2044322ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ocwG8BUupA0c7ngkbVIRkowdsSBmAJkxH3Uq9ZfLtFA=;
        b=ZT1T5kvX23OeR/oEtBIM5SXEif+djqD2K2O7ahGHOY4JJFhq8cFilcqTebMLFuKnyC
         Euc/j7Ij9guEHOTr9CPFKD5Bvk6XiBSoNMRXsWGaSujpiFLsE7p/HZVegO5G8YFp3tFd
         i88V49F8SoOsxqrexpDDfgycaq/1U+f4HW4r36DXoQ6VEEd82DsHTBFRvxQR9LP9yrnY
         rCMP2S/eqfovdzTG9RkXUbrEF0RWAlIgfXq4imI6znvPsSkVNhiHUvfgVEEVmP3h8spp
         EzWgUB78mp5jOYuNlQhj4TP/TiEp0K+3sZx8ytwjzh0GyvdYZ4iUCq+bD6nWES7zQdZ7
         DCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ocwG8BUupA0c7ngkbVIRkowdsSBmAJkxH3Uq9ZfLtFA=;
        b=xqmIPIXHaBBr/6c5kEwuc04be7nASv1n/ILt781xGaBhGUeNYo9DF/ExrW76fYCLBt
         aihEGvi/zPWOkzPEMmlJdiSRApTCdBqiCK2BGjUODkQ9tULyOFjG+3O1O39wrp3iK1yq
         rC3Jz6a+bc/tcZIgYGZNvqKDGUFC3x/A/IF1TLZa4NFY6LrKMPw37mdL8ar7gBP0Hja2
         EUkv/zfPdtm6p7wka6hBU/FCRiHT1Xw9CqWU5Nm/+HxvISEjbexgOL4BF3/Ucz67Fk/g
         LuGC80v0VDcSq/H1pXA1OktbOLUmrIN9mJy04ccOPX7KILEIvIC/ZfTibYOWE5eTBBAg
         iGdw==
X-Gm-Message-State: AOAM532WtpUZliVbuyCYwTXnHCAU7rwuxEXcmHK1ewn1xggpFeRQrsWW
        XcPqw+1+JHgVjHEZSI5eumqx9w==
X-Google-Smtp-Source: ABdhPJwiRoInrgMIGnHeSp8In8dbE9mUih20/nJXBR7jr/dYvOIE4073mVFhS82a8jtMWgSoAqJyQg==
X-Received: by 2002:a17:906:c144:b0:6e8:1bb:3b54 with SMTP id dp4-20020a170906c14400b006e801bb3b54mr25808371ejc.547.1649578488308;
        Sun, 10 Apr 2022 01:14:48 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709067e5900b006e7fe2a1308sm6583308ejr.48.2022.04.10.01.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 01:14:47 -0700 (PDT)
Message-ID: <73607ee6-a6bc-1f18-1dc1-d3e916f0e8ae@linaro.org>
Date:   Sun, 10 Apr 2022 10:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for
 Sercomm parser
Content-Language: en-US
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220406195557.1956-1-csharper2005@gmail.com>
 <20220406195946.2019-1-csharper2005@gmail.com>
 <8d0d8b27-35ff-3693-cf80-897b80c26b4e@linaro.org>
 <57bebf2f-af4c-b2d9-10e5-19e5104946fb@gmail.com>
 <29cfa017-bbaf-3aba-fe1d-06771957dbaa@linaro.org>
 <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b391399-984b-7a63-3265-62ef09caec39@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 20:04, Mikhail Zhilkin wrote:
> On 4/9/2022 3:43 PM, Krzysztof Kozlowski wrote:
> 
>>> I'm not sure that "scpart-id" is necessary here. "sercomm,sc-partitions"
>>> is necessary. I'm going to add vendor prefix in a separate patch. Is this
>>> ok?
>> Yes.
> 
> Thanks!
> 
>>>>> +required:
>>>>> +  - compatible
>>>> Missing reg.
>>> reg isn't required. Parser can read partition offsets and sizes from
>>> SC PART MAP table. Or do you mean something else?  All is ok
>>> without reg definition in "Example" (except the warns that reg property
>>> is missing).
>> reg might not be required for current implementation but it is required
>> by devicetree for every node with unit address. Do you expect here nodes
>> without unit addresses?
> Only "partitions" node has no unit address.

This confused me. Do you have a child node named "partitions"?

> All subnodes  have unit
> addresses and therefore have to have reg property. 

So all of them need reg.

> I've just realized
> that "fixed-partitions.yaml" is almost my case. It looks like I can
> copy'n'paste  "required" and "*properties".
> Do you mind if I don't reinvent the wheel and reuse this good
> practice?

Re-using proper stuff is good, but just don't blindly copy. You need
still compatible and reg in required properties.

Best regards,
Krzysztof
