Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77C4E21F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbiCUISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiCUISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:18:43 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B711C7D9;
        Mon, 21 Mar 2022 01:17:18 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id b24so16828240edu.10;
        Mon, 21 Mar 2022 01:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UPXEd69sTaiK/uNEn1bkYPH2H2f2n1BGPqtAGLVGAlM=;
        b=1vgb+KsYh+T5dcILb+vJEdQbg7Ty1oneWwHzd9AzA9StYZN01RHwKWiNaoqwcwndQo
         lNUPXK8NoShLKLn5WyPDh+033LaPCaIsUwL5EbZV83CnvyPlVcUaV122otEOo3odqOp0
         Q8L9UO79FfNYAvYpKr7Gf4Ag3mrD2sVn8Owi8/tEAFo4uchusGkxMp8Cto4uNSeTrE8C
         DAr1JuknVN9OZKAJaaIgv17Jc3AYRUankeG1ElaTjPyAckVIpra3gKcFKKIQ9RqjhAWx
         qDmEEYWfT39kqxMb6FAYPNjPhjNh8uNLym10A+YEOf3nbLf0ldhsJurJbGLW3l+8xbbK
         4LSA==
X-Gm-Message-State: AOAM533xAJq7GvMLQPeQ9Ab8REMnWwprm+oDskzoNjPqDuYTkB+HGWFC
        llmsHRrwj+N9ozzZHbCaMdA=
X-Google-Smtp-Source: ABdhPJyWMXLY7z5rSMdohaPlv2/J6RBymfAfq4g9TdxYDtEo9oJQIIYQ1+HwNjN0P3ynt7HJZKzPkQ==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr21227589edw.113.1647850636901;
        Mon, 21 Mar 2022 01:17:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id nb6-20020a1709071c8600b006e02910f818sm323062ejc.157.2022.03.21.01.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:17:16 -0700 (PDT)
Message-ID: <8331991b-90e9-1649-8faa-4f42b4318488@kernel.org>
Date:   Mon, 21 Mar 2022 09:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
 <91b6660d-c22b-0679-4cb9-6ebba9066545@kernel.org>
 <b2ffd5d0-6cff-3ed1-cdca-e93ca1c6d5d0@alliedtelesis.co.nz>
In-Reply-To: <b2ffd5d0-6cff-3ed1-cdca-e93ca1c6d5d0@alliedtelesis.co.nz>
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

On 20/03/2022 20:51, Chris Packham wrote:
> 

(...)

>>> +
>>> +patternProperties:
>>> +  "^sdhci@[0-9a-f]+$":
>>> +    type: object
>>> +    $ref: mmc-controller.yaml
>> This is unusual schema... What are you matching here? Are these children
>> of this device?
> I was going for compatibility with existing uses. The 
> mmc-controller.yaml schema expects these nodes to be mmc@... . But all 
> of the existing usages of these bindings use sdhci@... as the primary 
> node. I could make my example use mmc@ to squash the warning but I was 
> hoping to be able to do something that didn't make the existing usages 
> invalid.

Please do not create inconsistent bindings because some DTS are
inconsistent. Change the DTS and align them with generic MMC schema.
Node name should not be considered an ABI, so it can be changed in DTS.
Some systems unfortunately break (usually Android and Chrome like to
encode node names), so then it would have to be individually discussed.

>> Looks like you wanted allOf. See some existing examples, like:
>> Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>>
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        oneOf:
>>> +          - const: marvell,armada-3700-sdhci
>>> +            description: |
>>> +              Must provide a second register area and marvell,pad-type
>>> +          - const: marvell,armada-ap806-sdhci
>>> +          - const: marvell,armada-ap807-sdhci
>> This looks wrong. Either these can be standalone properties or in a list
>> like in your last items below.
> I was trying to allow 'compatible = "marvell,armada-ap806-sdhci";' or 
> 'compatible = "marvell,armada-ap807-sdhci", "marvell,armada-ap806-sdhci";'

But you have here 807! Both 806 and 807.  So is 807 compatible with 806
or not?

Best regards,
Krzysztof
