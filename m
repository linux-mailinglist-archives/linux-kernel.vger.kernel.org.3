Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A5515698
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiD2VT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiD2VTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:19:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB97CB1E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:15:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i19so17614610eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oPrD1XGbang8k816Th3p/Nj4GCK9njWNLC8Vq1NS2RE=;
        b=neKGjTr3n7UAuvdKqKsheFhLwxkLfP+/N0vjjiQyv2/cFbVSYm5LdaK5tZSnUHtE+Z
         Ua/Q/0uGmfGWSkHKWJ5UVm3vkrMZEs9BcfZifPyIzgnRQr4nPUSz9qrOQbLhWJLk5fPc
         rbrcWW5IOhv4fWg7XvP1mw/43vATHVzH33yr7Hve3ZwVxnJJIZ4DAQxOdwZbcFE3ChL8
         Mc2igNBA/d0Ye3C5aP7VrSbaFyDMrKFKXTZGqfA7yPvhbtij2YH1l9vthfY/7p/UExV1
         6bEttc8q12ICPUX+3aswm0yQcSu4oIHQIIha8E2rLbunU2CQ8i25q75pBWwIjhlmmVfW
         5+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oPrD1XGbang8k816Th3p/Nj4GCK9njWNLC8Vq1NS2RE=;
        b=ihDPKUt/r7ftT5g7GhBgfDkAVazQGDHp94+Lf8bISu6IrmL2+SJAZxJfL0zd6GYV7V
         LWQRNVpy4ESkwsgLepSwBbHLI42cdQel9lapGfJwWWPqAygw48HPHRMAcQhT3akq0A73
         LC9WkLWGLxaH8Fs9mEIEp/2fp9jE199hNeL+u2NOMDj2oVOSR6RFqbBzGcpZIyshsYOS
         /yAghD4dQc8qL69fmkSFO0+x0T7DmZSpo1w1Ze5Mi3XLg0zgIQAJ6QR8LQyd5VpH0nvm
         kC9tkdsR9u26PvnQSt0YQvWbMt+K+iPH+hF6jVilhiBDc8ZMHh1magnYIESV2I15BuuZ
         WM1Q==
X-Gm-Message-State: AOAM533XU912JhKSClIlwXN5Dh6AWq01QbHXtbaYshM6GWzN9Gwr2Ga9
        QggjYoJ+Cfc86tWWNokLF3nWIg==
X-Google-Smtp-Source: ABdhPJw0F/QZ+C/PT+4+BxxppDaR/sWurRfERZJALzRtLZQbYQEulUbEO8LcZnG45RXaA27Pl9DsAQ==
X-Received: by 2002:a17:907:97cc:b0:6df:83bc:314c with SMTP id js12-20020a17090797cc00b006df83bc314cmr1109329ejc.587.1651266955853;
        Fri, 29 Apr 2022 14:15:55 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e37sm977203ejb.157.2022.04.29.14.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 14:15:55 -0700 (PDT)
Message-ID: <0555284c-41db-9b52-ceb5-0625c77f99ac@linaro.org>
Date:   Fri, 29 Apr 2022 23:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/6] dt-bindings: power: supply: qcom,pmi8998-charger:
 add bindings for smb2 driver
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220428104233.2980806-1-caleb.connolly@linaro.org>
 <20220428104233.2980806-7-caleb.connolly@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428104233.2980806-7-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 12:42, Caleb Connolly wrote:
> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> driver.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
