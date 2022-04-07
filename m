Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B064F778E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiDGHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiDGHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:34:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D2177D38
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:32:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d7so5329185edn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+EUKtGXqpzIiuM97OU9EnfIBqXUuugdodntp3RmpB2g=;
        b=MLD6Pa+acykChUKYnfN5TlyaI2DFI3571kmJ0xwMHyfkfJkDEmnAFhXVSgHmKhSdUU
         CZQ1lyks55pzyVktHVoYFbNKKG8kXahI6EhIs8eGSfn1O9f3ntDxN5C6Y/zTn90o+YQ8
         EhWiMs6RJVWYj0ehCvlPSAWsXpJ9W0C3Nw5DvvPo0IdrQvYQyWS0yh/3cKz7SAE5VvtF
         3CeyNI4eGh3tkj20VQ95XOGK8FZFWFF3B6WEUxCxFGdxVPMnAW9+8iZdoBEKMk7ogPHa
         92G465mJCWogofCCre/3YYA+mwoaqVb026bmzJ/K6K8lcgj+t+xx5V3ZEDCeftNXbHDo
         wlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+EUKtGXqpzIiuM97OU9EnfIBqXUuugdodntp3RmpB2g=;
        b=4dz0N1HAs2P3U0NtHX8afinA9aDLgxRsrV9te7rQfN4rBlAjQwNTpxk8+hRSC0noH4
         P50WtscvQqiElBn3AYyAVEttBsgz+8eCCP7/9ZjW/sM60v1sO0H4wfh0u7dyxjwEZKOQ
         al2J8jmnZWB0jn6l26KpPFlDv5rKeYym2fUWvIrcOTpZ3JDW6yZ6rrdOb3Xs36fbY7Fl
         cdfocA6hqqDIpqkz3QxGIFVjgoqQDG4Re8EsKpasq1yiGJvHerZAjSz0Wnm53HUIbT/1
         d2861XGrF6fRpnQd0fiiMeaWVcEZPgvJQ8xZS0ufhcEgmoOg/1QAxi8qR1V4KLGcI+Q5
         rl1A==
X-Gm-Message-State: AOAM5315wGe0V//e4b+iHx9Jid+6nSx3S38rLzFgO0QyLz3CpuPJbwm6
        Km16yT4fQaEV+FVmeBGd/zOWWA==
X-Google-Smtp-Source: ABdhPJyIpHoo5CyU+omZm76Ir2AEajIb5A/rhFDOmn6KNjdwWWGCZXA1IvhboAVJ40Su1x4Bx+KhiQ==
X-Received: by 2002:a50:f106:0:b0:41c:d793:3ae5 with SMTP id w6-20020a50f106000000b0041cd7933ae5mr12892876edl.390.1649316768155;
        Thu, 07 Apr 2022 00:32:48 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id lj11-20020a170906f9cb00b006e8402c3379sm32496ejb.58.2022.04.07.00.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:32:47 -0700 (PDT)
Message-ID: <f3f5c297-a94b-9544-5673-3da3188623f9@linaro.org>
Date:   Thu, 7 Apr 2022 09:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] dt-bindings: dmaengine: qcom: gpi: add compatible for
 sm8350/sm8350
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20220406132508.1029348-1-vkoul@kernel.org>
 <20220406132508.1029348-2-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406132508.1029348-2-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 15:25, Vinod Koul wrote:
> Add the compatible for newer qcom socs with gpi dma i.e qcom sm8350 and
> sm8450.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
