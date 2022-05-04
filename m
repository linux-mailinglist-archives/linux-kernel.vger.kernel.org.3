Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6585E51A2AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbiEDO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351533AbiEDO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:57:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCE24593
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:54:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dk23so3376469ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=b4reLFnLGstNl8yU7ElXfhLVkJOlPPnUu0vbq9yYvVM=;
        b=YSpRdjiyUkwTdZLN4Z9w1pNgbJtq8Rk/uUbwQkfYPhtUSaiPR5A45z4JD+HKiSyURe
         U/1mOZp/r21+TSeaOzQd0He+Q/FyUZ48mJUbuQM/7xvn1LGgxeEvPU52Ss1n/GZm7yxl
         CQ/1DZVf5RXKhXPbfBkLNlng0c6Pj5JsCEkiSy8MyVSZd+Tb4a2kBAneQ6ZX3mdc5NR+
         Zz2A8g2mswkCL7I8ESlxzv4P+X05pAk//fVWA/e5hZE7g4nk28ezQ/psV8LEAVdg6Aou
         GAONygP4QDmwIeb+CixxNctM38FKPw4j0tG06byJt6Z73RKN5E7V8RhWzLfCzxs02wmp
         0wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b4reLFnLGstNl8yU7ElXfhLVkJOlPPnUu0vbq9yYvVM=;
        b=VhwOUF+Kbvkir4JhFazv3BymW4hyi/9MymSP4qwmDMPhBx4Nr4MNsEUKwCmB/glCRV
         d3u8OPhbNrDylVO8Q+jlOQFydPEw5dKcao4VDfj5BhrFIhGTzB5fc4eeN3lGN0JoLR/z
         nvm0wsR3wz7H7P5osD58gsMWS6As/Kh1YwwZHwEVlv3Wv5QEwtRKSWpuBmL1MngizjVa
         mqZlXXhQvEY7a2VVJi3UGAo3wCZggA4BY5f1Uc0cFBkGGP5fonpQ301iH2W7XsN6RqO1
         aaFCsoGu6mfgncCPWlNDFOMljXXKAMxiPuOVvzDp0eWAiQ4xuLjMSZyPg6TfYerQBhTh
         aD6Q==
X-Gm-Message-State: AOAM530mtZ03tCwMKXrFwsysVT+YDrr8AeGYmUcS8r4dPXO26XHuWFiR
        NSQ9VQudLw1kRbHnXY1Giks63Q==
X-Google-Smtp-Source: ABdhPJyZg0q1YLmYUSx0xZRrSUBIS7r/5i2ghubZXjjmKv2kBNPRppV/MR81N+8c55cp1KYwzoqmsA==
X-Received: by 2002:a17:907:d91:b0:6f4:c817:d492 with SMTP id go17-20020a1709070d9100b006f4c817d492mr2613993ejc.407.1651676041936;
        Wed, 04 May 2022 07:54:01 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006f3ef214e7bsm5849395ejc.225.2022.05.04.07.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 07:54:01 -0700 (PDT)
Message-ID: <45e55d3e-f29a-81ee-6673-a05da377e798@linaro.org>
Date:   Wed, 4 May 2022 16:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] dt-bindings: intel: add binding for Intel n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com>
 <20220503194546.1287679-3-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503194546.1287679-3-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 21:45, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add the binding string for the Agilex based Intel n6000 board.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
