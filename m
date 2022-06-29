Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3555FCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiF2KJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiF2KJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:09:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BD95BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:09:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sb34so31462771ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kOG/JWVNyRXNOwvqncCg98QGjyVndApeAsoNFJ9EEpc=;
        b=SPvyCOHRGBOoglOkiGybHP9AxC7uH5ADu5JYsZACdKgu+GIyr8qXjrpDZav1ZXXEwD
         cmhsaaPiURzR690pIeowX419mkA02VnjOyN6ww3AwPT9nU5TxnPiQ8G4MZrqe3LmOLS0
         gl/vk5aOuqRWYP/3Dn2NLCTpv6+PWjF/Inh2fZmBCgdwQ6zlvRfWtFUGO53i25V8dAXv
         OFQ9UyZQRSlhAm4b7Xc1qmOjbkPfOagQ1FH+WiXjlgPf+kabMOAnVLM8Nz/4+Oy0Jb0e
         7u6N6ymDO/TO1+iC3cHkC5D8d/iV0j8r6xfjMViSBK2ZWPx7iUZG79CkmhZ9P0aJjEsV
         WX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kOG/JWVNyRXNOwvqncCg98QGjyVndApeAsoNFJ9EEpc=;
        b=sNe6aN+1vf1YjiW3S8YwNsLwofze4yuza+tX9+ygcckESM17ebT2FGUAq1TWe5dkCt
         1CeGAB7f2LqETiD+1SwAgHgQcJEP3po1HhBDa5jil4l6+THkRr0EO247cPq9+hLqi5IK
         HbYnKbjB6VdwpAwV9W7VgJ869/pHtrwLmSTjvTFYiymRlos8yulOjhFx48K7KsFC8teR
         yDbR3GbeSnlXzzXStyBnO+BfSGvg0hk/HGAS09wC3o5Lozw3bZCwzPhp2iZPskIdtNnv
         +ESt94lvFkstfB1Je0jQfGwBG2OjoYukx/1LOTcTwOyNpIjJCy88Ccdbfok40POmNsgK
         OfPA==
X-Gm-Message-State: AJIora+1FRw7hpRVghcjuRb5nfgfgwArjos6fhn9vHDHVSfK7jcpeNN/
        hcyuX5Id7IDvx8VbLA9WrpVJ3w==
X-Google-Smtp-Source: AGRyM1uEUkF2oU02+y1bX9QnKwHMZrY4AIXAQRxfR95jbf6nQFrDRgVaghWhX+n7kh6qDD/vb6dszg==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr2658240ejd.174.1656497347822;
        Wed, 29 Jun 2022 03:09:07 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r14-20020a170906c28e00b00722edb5fb53sm7578893ejz.116.2022.06.29.03.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:09:07 -0700 (PDT)
Message-ID: <7f7d7aa1-0aa2-0ee1-762d-e47aaa5548e2@linaro.org>
Date:   Wed, 29 Jun 2022 12:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Cc:     git@amd.com, git@xilinx.com
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628054338.1631516-4-appana.durga.rao@xilinx.com>
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

On 28/06/2022 07:43, Appana Durga Kedareswara rao wrote:

(...)

> +  - compatible
> +  - reg
> +  - xlnx,magic
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tmr-inject@44a30000 {
> +            compatible = "xlnx,tmr-inject-1.0";

Ah, and one more - wrong indentation. Use 4 spaces for DTS example.


Best regards,
Krzysztof
