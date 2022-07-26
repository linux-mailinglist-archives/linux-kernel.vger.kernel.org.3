Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81AA581084
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiGZJ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiGZJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:57:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5142F039
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:57:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p11so17052360lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I73BOjVPhMR1wc1m6D3pt9KtMoseeendX/4GKU5hxhU=;
        b=uEAVBlqVVpEO4CRjG+b8EQKwATuT7yiqOEkQv2ZTiLFyrJ2jiaeYPaMsuRlf6yjGgI
         ZJMG1YC33LrAUnOLH0nIZwePRnjLOcyXgb5hUEmvl/VN0qoOyXr476hzGEvNh9WAbOgg
         HOmiqK27ag6K9Va5mWQyMOG4FYVmDG9FefW5OasSubq2C8mu++pER4+2qanR+JG5faBM
         F6yTP57/+k08+9lUA2BdtAR4Baq509d11FRvQSade9qtzPtSEB/RRK9P8nD3D174hQAC
         od5Bui/cx6nCgtoU7ZnLVGaHE73DLFShMwVJLzuV1kxlf+ShM1s8kLlPRbt3OymhUCb3
         xB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I73BOjVPhMR1wc1m6D3pt9KtMoseeendX/4GKU5hxhU=;
        b=vNCUeeLzR+D3e1ai0INvk9yT091H3WP4KL/7FF0gEi6/cAM2ln8YesD5o745XqNJet
         /XCC1dVYi+BkIKs19WpMZHifElPrG9U7Hy2o6xHaIukqfclVNYchJNfYKe3rHWUmvV9e
         SitpQyp83/hS04BhS3YP5rYxNO7PGHBJnLF0SHPBnx42FvGQm/AhO6KLgKbMR3un3usg
         4TGtK/IPSFul0sCmTfkdREECrFSXeI4auLNr70/Iwq1w+UsWa9avq1aMKEPon96d+40/
         qPJ1gaa59yVsCh/id5lKIVKNGPsxMv+QGCE85i1Tr9+Gfi6tNVdXnnszhqWZc/AfEKG4
         G81A==
X-Gm-Message-State: AJIora/U0/kfjBGYFIGJCTDeu2W/kLyWJxXj5eHcqeBdBv+gI8Zk2bIO
        XOfTt8JhFxSmlf1n12cuf4V8OA==
X-Google-Smtp-Source: AGRyM1sK7VXFeDB7oQjs/mToNuKVBnT8UhRL+0xdhS1pEpYSUMMEDkLwMhuiBIzgXwdUH2Gx8I5lRg==
X-Received: by 2002:a05:6512:1288:b0:48a:aa31:2838 with SMTP id u8-20020a056512128800b0048aaa312838mr424327lfs.683.1658829426372;
        Tue, 26 Jul 2022 02:57:06 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512325400b0048a98b7bad3sm605377lfr.197.2022.07.26.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:57:05 -0700 (PDT)
Message-ID: <d34ff61c-d9b9-9f34-a00f-34a0304e47ee@linaro.org>
Date:   Tue, 26 Jul 2022 11:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-2-tmaimon77@gmail.com>
 <20220725225650.GA2898332-robh@kernel.org>
 <CAP6Zq1j0pKHsX20t4ep9-6B_5pTe5MzkU__245F6tW7wFJESiw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1j0pKHsX20t4ep9-6B_5pTe5MzkU__245F6tW7wFJESiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 11:30, Tomer Maimon wrote:

>> To answer your question on fallback, just put:
>>
>>     "nuvoton,npcm845-pspi", "nuvoton,npcm750-pspi" for NPCM8XX BMC
> In the document?
> because I don't remember doing so in other documents that I use fallback.

If they also you fallbacks, then the other documents have now incorrect
text.

> I need to do it in ymal files as well?

Depends on what you want to add and what you actually added... Let's be
specific - point to specific commits or files in linux-next. If they
were not applied - give lore.kernel.org link.


Best regards,
Krzysztof
