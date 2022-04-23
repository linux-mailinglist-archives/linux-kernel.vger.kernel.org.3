Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74450CD05
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiDWStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiDWStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:49:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867681B5BCC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:46:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a1so8428990edt.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BE7waq8Lk7dT8Foyqp5jRqicX/Rtb6ukKEBR4TI5e00=;
        b=Lrhdgx3QfeUC8LXlshbtxKk+TlSDeeYoNDuAY4AnVS59QXMWblEhQ3vkvlnb6pe5TT
         /AzGkGLSJpsm2hyCR5win9QCWWeZZ7G/bjfDJUrHDjvt9TQhMLoXiqLvzQj1oajMlGwn
         dLLx2uUltxPJwwpfT2ovKB6XXxv1vbiyjVrhbiGFPFX/Zegx6SMx/4i3DqHbSfzE8LLr
         3uPLNU1PiygWa+Sc+E8VtpThpx0aBGO2wsbJrVvkebWqExKymQJ5LlPdU9LVGyvHEIq+
         uUyCNErr8iqZTAcQw5Gap+iDNNwg7a30dql35PsRAiBlghr8wh2B0uYctMph5UgZMiH3
         IDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BE7waq8Lk7dT8Foyqp5jRqicX/Rtb6ukKEBR4TI5e00=;
        b=s+uWLzrTrnQAxGTKsrHG/rzIISx8OioMKNzTaAVJEFUBVxv/bTGz4ywvXAAA1ZuG6Q
         rz3bnd2j9WVOIj4C+BkjKSV3ZYUNTdD20UcJfpJrLUTTm1igf7CcPJd+uXeXSNp/Ln53
         KN5UYbBmf4EMsbCsXxdBcFB9JCp6yQM8LUJIpylCkj6NUg54pGFvrma2Wu11ljZvgcQ+
         9PAKGTFN3IRozbj9VIrrK8yj7XIBDITGbm462UvVq3rceOIRFpCGlAuC4MLAM6vj4eUz
         v8O4Ev0SOf4bdfgkNWcscb6xbl2S+83QXoW0tyXVMHj81GtxezvAKlXM+x0uvc6Tm760
         1rdQ==
X-Gm-Message-State: AOAM530+Ciunvk+sNFBqyLLZ5MJ/9Jpid9wZxtAJ9zrvr/SkbnoCDAMp
        jdp8p/okbUlvINOzJLjKLDSloQ==
X-Google-Smtp-Source: ABdhPJwk2byNhB0fTOgcdb8QQvPrbR6yeB5tkaXKq7xNNRMT8ane5xnfdx9eIMjhjkhw0ZQH1cqIXw==
X-Received: by 2002:aa7:d916:0:b0:425:d75f:ae68 with SMTP id a22-20020aa7d916000000b00425d75fae68mr2132990edr.270.1650739576064;
        Sat, 23 Apr 2022 11:46:16 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090622c600b006f3876cd90csm96634eja.198.2022.04.23.11.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 11:46:15 -0700 (PDT)
Message-ID: <bf6d4735-8733-7ff8-e1d8-64e259fedb2c@linaro.org>
Date:   Sat, 23 Apr 2022 20:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220422192236.2594577-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422192236.2594577-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 21:22, Rob Herring wrote:
> Convert the Synopsys Designware I3C master to DT schema format.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
