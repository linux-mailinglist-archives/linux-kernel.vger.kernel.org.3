Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCB523C44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbiEKSLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiEKSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:11:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F801606F3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:11:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so3511463edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B1sIommB5oiopHgf7KLQUzUatFJzc302ngrnM99CnbU=;
        b=Bncm1ERZjlJ+C2I71BhUNNvrXo+iHTAiA5u+snQ3KP3WhoLiPOVk3UUcEFxCrbc3YL
         oJd9CfUY9MfEb9TRmtBQm+tSNWQCSIfpzzZC8ZFUpiBl2yhENsNmzUohewRc5OcOK1Q/
         AzuSt2dN3/CNM3XGzcostHznROhsNuHr3LLYv6dZXVNwd5FKo+SJNAErujYdxIF3Ywhw
         NryiSYLfP73Fz2gCjZBALqkKzoWvqb2heHCTgVqdcsz4jRNiq7A4y4ktvw2sLAhUWfIb
         NBoEdKWCHn67IPzIw8jdGuVvT7TXUTpuUoUS9dwMAOfisyXp0SlMzKyMKgJkpKuV+d0R
         nW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B1sIommB5oiopHgf7KLQUzUatFJzc302ngrnM99CnbU=;
        b=eH2EDoms2TJyzwy2v9CmAOu6t8Tiu+psTfjfjsA8P/g4PMDnO4XaJMhkiVHmQOSZGs
         ETOiCPsKhWEH5nkO0TThPEeH3IGwgNqqcKhB1tKk0Oewo4n/EGWfyDEIHuiCOmWodR6V
         5R17ZpYSIjbsQ9WaUMd2PV6/wycEpJwh8EtmqA5cHCbvU5gkxJXIsvIg2XF1HM0TgQze
         yOmPhi62ZPD2PoZRtSaVCUgq5BKHtmBdy/9NNc3iCE/pS7IvEBGlR4xB13ad4+mozPDH
         BpDvM6OhgTgf0zpMI19g9PDzhSEArj26zjQW8ZM/rnEBoTDSDsj4Qx1M0SrLrWvwnIYu
         MflA==
X-Gm-Message-State: AOAM532MYgflCDFJJbXiz/vgfKSBkitpXCtacXRWjWllWhw0FTFwVkcE
        bKToKfYNfdkbnP7B/N7a4Ounng==
X-Google-Smtp-Source: ABdhPJyiDHzyY4rY+mnga9H3oSlY4ujZN6q06J9yJ2WZTAhsRJ/Dn4dfk2ee36mq5zINyyfgkHsSLw==
X-Received: by 2002:aa7:c849:0:b0:427:d464:e66f with SMTP id g9-20020aa7c849000000b00427d464e66fmr30417861edt.411.1652292702040;
        Wed, 11 May 2022 11:11:42 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id sb12-20020a1709076d8c00b006f3ef214e04sm1213887ejc.106.2022.05.11.11.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:11:41 -0700 (PDT)
Message-ID: <81365629-6cf0-f320-e684-4fb40b829399@linaro.org>
Date:   Wed, 11 May 2022 20:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto
 remoteproc node
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220510042654.71152-1-sireeshkodali1@gmail.com>
 <20220510042654.71152-3-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510042654.71152-3-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 06:26, Sireesh Kodali wrote:
> The smem-state properties for the pronto node were incorrectly labelled,
> reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
> the stop state to be used.
> 
> Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>

No blank lines between tags, please.

Best regards,
Krzysztof
