Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158552A452
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbiEQOIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbiEQOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:08:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865513E0C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:08:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g16so21924321lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ILPQc7G+oPlM/aZP4m6NBhLYqFjSTocczgW3af4op68=;
        b=PE0JV6pDh4rHpGkCg1JqfCrHmzxmw7W7Qyd2ouQl31by/orybXkuDp+LYNUJnW0YAG
         gbapK+/sRL5cVKr1ZIDwjrJMXsSOzHFGNn+wuLKiMyY/Ja+vxqqwzauLl1sOfOR87fPE
         ZB5Ya95oWKEVOK+4qG1lmjSP/UgREmLZORaqoI+0ARqwiOI3ylXI1OrmwvfJIVJ+s+zm
         jgkTnIeNKvWg793waaxKfpfGTRrYzU88uPEwCeWDm7pDEBDRakDyblxoj0jtACfCWwEd
         pi3r05xkqDeTfbUjUvhKNRuGA3WSqjWdY3wWd1lmqFG2iR2S2VPbYSCeg+r18WGv9zCe
         hetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ILPQc7G+oPlM/aZP4m6NBhLYqFjSTocczgW3af4op68=;
        b=ZQhV8z3XHvo9jgL+e2Tin2ZPtPs8cR2ZkPizAsGQp+mA2Myk6QGfYWMcknkdR0vNuK
         m29w17F2CO7rqgbfzE2i27TctOgtgQovmpnNTZVwy2xvhHB7dLUkwSlIESDotuaDzLCK
         z9hyqh5qf0GadlOO8At6gI1ALEpDiEwkpAO2DzfCd5z5o3Mt1LA3ThniVQC5lTR6k1Nl
         PnaQZT3vyqWsKiJk3Mo5kCOYgTdcf0gJkcGrZbtQSM065COF4vr5xRbg6aPUEAb/XprX
         bsDzTrmN2xlosjlTlJchRjF5zNzKVdaB9EEp8fVSj1L68+1nzsOCCr/iCgyZNyTBDmri
         JT7Q==
X-Gm-Message-State: AOAM531Ce1PlDH1vUaQE/xwq9aWEcXYqmdGP6T38BHUflGsrya1iq4/T
        0pF9UsLSNmqmY8TkjFH//0ELxQ==
X-Google-Smtp-Source: ABdhPJxtqwhZWJ7dYHgMkZjWCVF34+2Hgq6B9aXDbdtKuyujaW+ust3Tn4JGyVEsqcwnFCqS839YWw==
X-Received: by 2002:a05:651c:893:b0:249:4023:3818 with SMTP id d19-20020a05651c089300b0024940233818mr15040800ljq.44.1652796483809;
        Tue, 17 May 2022 07:08:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u8-20020ac24c28000000b0047255d211c7sm1597601lfq.246.2022.05.17.07.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:08:03 -0700 (PDT)
Message-ID: <2eb61c98-6e1e-1fea-4af6-7a9deff11b11@linaro.org>
Date:   Tue, 17 May 2022 16:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: microchip-otpc: document Microchip
 OTPC
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220517125822.579580-1-claudiu.beznea@microchip.com>
 <20220517125822.579580-2-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125822.579580-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:58, Claudiu Beznea wrote:
> Document Microchip OTP controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../nvmem/microchip-sama7g5,otpc.yaml         | 50 +++++++++++++++++++
>  .../nvmem/microchip-sama7g5,otpc.h            | 12 +++++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml

comma after vendor, dash after Soc, so:
microchip,sama7g5-otpc.yaml

Best regards,
Krzysztof
