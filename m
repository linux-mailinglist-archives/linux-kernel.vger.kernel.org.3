Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EA55970B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiFXJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFXJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:52:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF0794EA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:52:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ay16so3605710ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rivE4wr8UJbawIIZz5aCEb4ZT16feQhkHfAphnrA6WU=;
        b=uGneM71SQXFdic/t3HGx3tsStz5Qf4y9dXBWUgspI0995RcXcn4IYS7syHPwcRyVUc
         WwGFfefcpd48S8sI74mHc12zc3vJBPS4ChSzrEmrbXI+odU+6jNV4KZuueSe+tx15RU0
         jd6uKblRbSC0jmWgPQBhh1VsW20Wrbp/ByeZRchbsguXhCvKD+M7Ros6v7KiAuhmxTBA
         iekZXm1+h/Jhm92dnXnUZ7ybm4m0I4fd4Lcsc1ZVA5CrYz1yZtIccQUoF4aM8//TMKQY
         6VzED93Rbd3e66t37ayYGrNp5rjkpoiSBfkisrvrgbdxL5UjQ5cAdrLJ8LKX/6ha9PMp
         DK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rivE4wr8UJbawIIZz5aCEb4ZT16feQhkHfAphnrA6WU=;
        b=IWjkxTFxo7LXTvL1WTLvSZHXwXvKJbdk+mAmecIFX/DfjqZAH7V9+ak5UdyU8eEfiu
         +idlvj7GNgjm0yH21L7unjIyMdin5/QMXlbjo4QZU6oQIaWkWPORUqjT+MsQggRF7fPX
         W01LniojboZyyxJXnsAMcfe6yQJwQskZpI6MuOjJxvbIFXFDgnn8FkCr3Uc/PEaSWBAo
         jK8xI7Y4eijGJJrCKbn4ffp4DpaxOpBSRRJ2x0bOM2V4FwMYsDtMVkUFDR1pTJxH3Izq
         mgcaVRBMAKgSATJ12a+BNzTi9SaGuC/wllmr2f0dOh/dDtvNrDfNL5cN9pGHSjG7RnSQ
         7/dQ==
X-Gm-Message-State: AJIora+fAFlJXx4aNW65ET+9BplA9hono5IY1ohOFhlL4fpIFob7PGKD
        FZqA4hfE7RDOkATr/6G0hSdwNA==
X-Google-Smtp-Source: AGRyM1thP2j2F1e2C7KdSKxzE1Ry8ZMuQ/aeS7RCYjBG/O6aI3BQ7HnUd6GUGN4g3imvS3JUTHQHwg==
X-Received: by 2002:a17:906:76d7:b0:726:31da:55a with SMTP id q23-20020a17090676d700b0072631da055amr2041726ejn.607.1656064335085;
        Fri, 24 Jun 2022 02:52:15 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b15-20020a50e38f000000b0042dc8dd59c7sm1596608edm.51.2022.06.24.02.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 02:52:14 -0700 (PDT)
Message-ID: <26cdc24c-e0e8-1059-f6ca-11c08615eeca@linaro.org>
Date:   Fri, 24 Jun 2022 11:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>
References: <20220623182542.1116677-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623182542.1116677-1-robimarko@gmail.com>
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

On 23/06/2022 20:25, Robert Marko wrote:
> Convert bindings for Qualcomm SCM to dtschema.
> 
> SoC compatibles that were used, but not documented were added.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

This was already submitted:
https://lore.kernel.org/all/20211218194038.26913-1-david@ixit.cz/

David,
Do you intend to work on the bindings you submitted before? There are
several pending on your side (things to be fixed), so I am not sure if
work is abandoned or just waiting.

Best regards,
Krzysztof
