Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78985A3641
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiH0JVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiH0JVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:21:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD9AE58
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:21:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q18so3593324ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=q7Ikynj4nNNIvdVXeyhtGitK3OC8iSFGzk+Qet79628=;
        b=HLSvceKDscDXEx3fym/v2tvYpG8WiIobbxGsziM6Z5uOiktXKZfJ5FCBigVt5mmgHd
         +0O0OhT5i+n0f3zcLhmLq1DzS/r7jYVCbMEShEQnM851IqznDXgiVR/www91NXmTinjS
         WbnquEXbgbuFYUM19KQz/X+ZmJtFTybtgKpvGBeKLC1KsTfOvZ9w7IQ9gj8RWDJIvJHb
         KSptHjMSbf28TfmbXhtz8lwXG6i0Dl6dyTbununkqT8k012Azv5FcXvhwzNS8ty6dPPO
         3JUuc6Jhg+kj4V091W8JG9VLLUqFFnBnwjfwONsMK72mDD6eGxTGfVns4ccb9/wnjDhx
         Jg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=q7Ikynj4nNNIvdVXeyhtGitK3OC8iSFGzk+Qet79628=;
        b=mlAdWSErc2Utw/1j/pDQMNaj97ZTlOBLaVmUc4nnZUhNVpkGOEMSQ4wl8JptEYV9Hr
         m/0+clf1mcz2BbVDvlijUVgibN51HPZS/KpxlV/KefqYC6jIMDtXHqgBTzqkr6uLmIY6
         UF+6tbSLKye8nXvLSd9OINJO1yy4Hqd65Vqi5zULL3bHynqp1ZLYeMvEQcrXRbCI6NQm
         KTqQ0Bfix6+Uykw5d3BGIOT8CJ6sh58hT/1uKRJQO8mIEHCDxMSN0nuuOQL6wmaSqcWA
         Mj5lEEUgPghv34g3cgxiFzb52a1O9jF/1OxgkzjeKctVOZCxVU4RUyq28t4/EZu5H7Jw
         atjQ==
X-Gm-Message-State: ACgBeo3rDQdJBr+3hIKswVjDFcp9gRmG4rrMOMkJPAXKzPWBDDQWT4Ay
        LOVKBGRztslL3130Y5JRJ6Lllw==
X-Google-Smtp-Source: AA6agR410TJyPm1w/2J1z9GmQhGxG/NdoMgKQMew1CctZvxTUs5Dnk/ttTa04Jd79EDLDE05PUyyog==
X-Received: by 2002:a2e:92c8:0:b0:25d:6ddf:e71d with SMTP id k8-20020a2e92c8000000b0025d6ddfe71dmr3145798ljh.170.1661592109487;
        Sat, 27 Aug 2022 02:21:49 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id f18-20020a05651232d200b0048af2fe78c4sm627121lfg.3.2022.08.27.02.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:21:49 -0700 (PDT)
Message-ID: <ab8bd3b6-59f8-4a24-0328-21cb7515f58b@linaro.org>
Date:   Sat, 27 Aug 2022 12:21:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/9] dt-bindings: riscv: microchip: document icicle
 reference design
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
 <20220826142806.3658434-2-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826142806.3658434-2-conor.dooley@microchip.com>
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

On 26/08/2022 17:27, Conor Dooley wrote:
> The icicle kit reference design's v2022.09 release,made some changes
> to the memory map - including adding the ability to read the fabric
> clock controllers via the system controller bus & making the PCI
> controller work with upstream Linux.
> 
> While the PCI was not working in the v2022.03 design, so nothing is
> broken there in terms of backwards compatibility, the fabric clocks
> used in the v2022.03 design were chosen by the individual run of the
> synthesis tool. In the v2022.09 reference design, the clocks are fixed
> to use the "north west" fabric Clock Conditioning Circuitry.
> 
> Make use of a new compatible to denote that this is not backwards
> compatible.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
