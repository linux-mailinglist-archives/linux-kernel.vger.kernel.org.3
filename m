Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396B95523FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiFTSf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiFTSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:35:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBAF1EECB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:35:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so22746727ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DyuNPVuSNowzrm63j1zsZJOThbj5GObu7cLWAKANMVc=;
        b=pbdIFkiuQqNLXWDkXm0ZZlPgMwWln0kuPO3GqebuD6FpRbecakmMC9pmVmX9e7g/gr
         z7rxpqJjJePcy5F/YNjdX0w4ynSTIr61n7l+DWPCwX20nXn05QyvSI4lQZMjE0wazSPb
         EZ3+oHePxJcAmU2lNDmbGpO4zaQqKLwrobBerU4FQeUOWcEKVZMeXbk0eHXJi0xXQpds
         JBd23DA5ctC/COOo3SEX4YDX1Dupd7P8rehz+AuWb+/w1L+pigbtyqwDxD58dfEFWV9N
         C94bWle+erS3g6LzNvYpcpeVVEz/jNhBW/26pIOGT7xnqcGWrjvLUBGB5aa85vAgmZU2
         FXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DyuNPVuSNowzrm63j1zsZJOThbj5GObu7cLWAKANMVc=;
        b=zkm3Mh14S1N5IzdzUsGatgS9gSBOUSdW8JHkqIkNzv68kn7w2YGx789eg+C1LAdI1l
         /pCvkdv4UV9dePQNqzpW3S/RdsLIwg16O3nJ+8KUI/nlrlaz/diSbdhekTa8/PzVofdp
         zyTVJiTsPlqVzi0dhOt8yTrTAAp0IGpOH9LgoT/Dbh4CdP/MPujV7lkc7xpZIkfvUQAJ
         eAprrxBSV83otzMwgT3IZQnv7OjgatLOK0PYEQ9/QxmxBIgVZg0stR5Ra4AehQ24d698
         N0cCzI/ajNOZWDeNMyD5V9qOiRlSxkCf9r00lbF36rY17wItNPiHYslZKw8Xd97V0IUS
         BObA==
X-Gm-Message-State: AJIora9rqdwTaZuIoNM651I/ZXPKLAETa+1ET71s7WdZxZW3WND0KqA7
        lu0d/ktxJht1bT7JUeRmE4ooOA==
X-Google-Smtp-Source: AGRyM1vRDkQYO1pg9ZiRuIjA3okLtAlzs+qA/W4WQkKiGYLXITM9Otidvg2yY0cS5IPwrALT6s/X3g==
X-Received: by 2002:a17:906:221b:b0:708:a007:5a77 with SMTP id s27-20020a170906221b00b00708a0075a77mr22461190ejs.566.1655750151701;
        Mon, 20 Jun 2022 11:35:51 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906315300b00704cf66d415sm6481779eje.13.2022.06.20.11.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:35:50 -0700 (PDT)
Message-ID: <c92b0b51-0e59-72ab-5306-ccec92b0cb94@linaro.org>
Date:   Mon, 20 Jun 2022 20:35:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] remoteproc: qcom: correct kerneldoc
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>
References: <20220519073349.7270-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519073349.7270-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 09:33, Krzysztof Kozlowski wrote:
> Correct kerneldoc warnings like:
> 
>   drivers/remoteproc/qcom_common.c:68:
>     warning: expecting prototype for struct minidump_subsystem_toc. Prototype was for struct minidump_subsystem instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 

Although these warnings are not that important, they are still warnings
we want to fix to be able to compile with W=1.

Is there anyone willing to pick it up? Any other comments?


Best regards,
Krzysztof
