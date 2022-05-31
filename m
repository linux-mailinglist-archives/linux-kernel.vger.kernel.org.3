Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F76538E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbiEaKJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbiEaKJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:09:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFFA880E2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:09:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so25623735ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S1vJ4EQxgb8CxF/TZMOJh3j8ysKIcc1uWIaMM56tARY=;
        b=MQ2r0968DRUUCPed8gMd5wzr3YkRRz4uHeMhTZbIGhCzNoB1A3RdIWdryLlNxvt3a+
         l7ff7EW9HeZhPzAN2XuL/bKpsUEOokmmHHhpwrFtX1U9Bjnaudvoj1xClG84cAZA8etJ
         1nEE7kHTxK8VU8u18lAP3Z09SH57smrqDwDzAA65jhjfK0R/UjRTepeFCtv0IcW6gbOB
         loRlFL3oxNG/VOvaI+EoBfWcIJLZ7TMN0m68G3+6ik03oogf9RH5jBf3jd0RMewj4eRa
         aIZSz3RUxXQbw2uDaB5MNMCmdVw79mbyma57bGWQIsPSe+eH+mTYSjUwlooAKgEPF45l
         /HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S1vJ4EQxgb8CxF/TZMOJh3j8ysKIcc1uWIaMM56tARY=;
        b=LAOQWS9d/zieys0Jiekuc0hC5sItOQBpT2tWW5tgC0rKCoYqTzktS/j2naKGw8hqsa
         t1nX8g5DGOb6bCTueVt9kvukUPu0YGZrmnz9hhaE0xrg7IIMJUk7Z3K0DZ54YXF98es9
         HWAJToTPrXpK09AByVoJ/luvFbnhJmFLLYP+J6QX1cmRaHAhhPmUKRR8qgkrD6PtcWXz
         tCaULiT2Bruqfc1ENxyqphsJ8I7/gyaGKYR2CNDyzUS3DTI3ZQijOwA1cvyltA1hyoFC
         AcpRdO+zzs8BhAAqR/Gsgie5P53rwUOvl3dWRtQNiwgoeDvM8GQEqj94wjyXnVky5fAX
         tCMA==
X-Gm-Message-State: AOAM533mshMKDrkSfBp+d4aUe0tLTHfvU9fyrQ/l+2u8JXK/Bh0xC6cQ
        h6yTv/GC2UWJGSNFruNstmd9Lg==
X-Google-Smtp-Source: ABdhPJx/50IRMlU00F/rYnkUzkndEh0B417cmSpGcaeV7ZCsrUR5344iDQbFh1kQrAGl+EU160hB1g==
X-Received: by 2002:a17:906:a105:b0:6fe:9a27:85c7 with SMTP id t5-20020a170906a10500b006fe9a2785c7mr49413448ejy.315.1653991771939;
        Tue, 31 May 2022 03:09:31 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u5-20020a50a405000000b0042d6d8ec1d5sm6212220edb.60.2022.05.31.03.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 03:09:31 -0700 (PDT)
Message-ID: <2a251708-b76c-17a9-4681-3c2c3c31beb0@linaro.org>
Date:   Tue, 31 May 2022 12:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/6] phy: samsung-ufs: move cdr offset to drvdata
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, linux-fsd@tesla.com,
        Bharat Uppal <bharat.uppal@samsung.com>
References: <20220531012220.80563-1-alim.akhtar@samsung.com>
 <CGME20220531012341epcas5p19b15b4916b210687ab6b46d6da0b2273@epcas5p1.samsung.com>
 <20220531012220.80563-3-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531012220.80563-3-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 03:22, Alim Akhtar wrote:
> Move CDR lock offset to drv data so that it can
> be extended for other SoCs which are having CDR
> lock at different register offset.

Line wrapping is too early
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Best regards,
Krzysztof
