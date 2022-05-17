Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC69529BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiEQIN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiEQIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:12:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE83F30A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:12:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n23so6403537edy.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=P1/3wXxYbYTAOCOt5Fz9k9RjZuPl9icdRpW/+L+jIGc=;
        b=m4Of4NgGuaJQIyikdXy62BDhj89m58NAqH9luHRJZg0bpmHq5TbhH/UR86pgRNC8AA
         VYC2g7SJ6aXGyK3QAK8bq1X1QtMpo/o2dtbSlTwHAAVmb8WzdI5HLUF7suH2cdhbrhRp
         kkIUU17LIjE8Kxe0yIjxjhB5B++wFesP859XtELY8Wht6GwH2XSlUvnDqFW+8vxpgRtG
         RRD4l+IBRWmu5pAD2Sb3FfKMKe5W2UHRYQaiT95jhral9WLLlfZATgDbUvrYukyThZ6P
         VjJ8Get9dDIf5YBDS/yirOyOWNzJWz2Ldp60Q9VuMq1AOefR+UzxSw02/dxdEBgmojZb
         18OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P1/3wXxYbYTAOCOt5Fz9k9RjZuPl9icdRpW/+L+jIGc=;
        b=ppVLfFpKkYmtnMGM7mvhnQVECBWQiGzMjwY7xpMk8ZyxOorjyqD6TWMLhQQZ3XZvCe
         jGTQzeyV3BJ2/sMATb/4UIxyMaG7S0dEIaH6/Bf6D2i0ExWnjnzBlJyVmmHs7OU+4YmW
         KFEQ9OBPUmJm5TshXrYrB/5zNDSQ0Ye6hDASiLA0B2bUij3lMj0SHg/wuF9g16RW1eYe
         1B3In9GXi88GmWNbuqg9p1Cpihaematit5oD91owF0H5m672mD43l2nDAT3tiR3JlXYN
         cn6D9zbk3cS02g9lxPLhhFfzoW93Xo1q38yoIxaDn0Qq749JCQRHlpZPrS3nH9m2Nq6C
         7Ndg==
X-Gm-Message-State: AOAM5323Wr0hW+QDyD6z/hN9E0vO/tf4T9GwRasgFERU6v3eJ8Y9ZHTX
        Hl1EYdxXBX1aWfAPgKxT51/OMg==
X-Google-Smtp-Source: ABdhPJxbcRBJq8zQ6TKtk7Zv0EnZS2IcrCkDqo0aU9SMvYY/kd+EeD6yKz9UXQcpTfTTLU+FY0oroQ==
X-Received: by 2002:a05:6402:ea8:b0:42a:8b26:3a77 with SMTP id h40-20020a0564020ea800b0042a8b263a77mr15668621eda.154.1652775129439;
        Tue, 17 May 2022 01:12:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t10-20020a170906268a00b006f3ef214dc3sm739830ejc.41.2022.05.17.01.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 01:12:09 -0700 (PDT)
Message-ID: <5a3d5a11-b002-b8f9-2827-6b0677d2b91d@linaro.org>
Date:   Tue, 17 May 2022 10:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/11] dt-bindings: clock: qcom: ipq8074: add USB GDSCs
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tdas@codeaurora.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220515210048.483898-1-robimarko@gmail.com>
 <20220515210048.483898-8-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515210048.483898-8-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 23:00, Robert Marko wrote:
> Add bindings for the USB GDSCs found in IPQ8074 GCC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
