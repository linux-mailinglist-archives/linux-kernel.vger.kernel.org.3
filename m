Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710F959E608
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbiHWPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiHWPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:32:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFB250D83
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:17:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so17587757edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MrLxb4E2DjxfMfHqX0aKpuYkCzfN45dEHvfq2u/Glfc=;
        b=oMu9LroE0RFKYUnrnUWRhbLqwE9SXGBkir2MBGkEE7vrSFbD1xoFjCFMdpG2eTJQq8
         GpWfKMT1LLuh0BLCNuyWdS35eZ+BbWTHta3HmqkrPOXvdth/lE7EhwIL7TL1dieNQI5u
         OhlZY3yoAKcJCmjiRKB7vWei+EB5dlzhS6au8bsxgqgLHKO2XnM1/ioP15HhbEQJlz93
         M5ZW7Fmu47MTlftRuoeWk2DqzbXvaatLwOl/NyauE9Gcv5TbFw0SBa7vOcLs3sS2rVEn
         Uuo0Zuy8gQUg7RiiWjfryxeinpc5E+uyw4sOGHaZgKTHRyCpEzE6jT5ep29j867EkRVJ
         bCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MrLxb4E2DjxfMfHqX0aKpuYkCzfN45dEHvfq2u/Glfc=;
        b=4SvD6Kb6GYlcOfZ2O2eOsiyexzIrzRLrVkCkbjI2arj5Tez4fkEM8IZWv/+gaNo1+M
         d6NEK8B2aZZ5y2i+ibhrGV/NKGLA44jXDXyUpVbG1von65sD0wMAqrut38odhgf5pEyJ
         3OUPquCYBucB2z48xK61Ycw5unXAJdZFbdr0I/yEt4IVjNYWN2sCylhtBegUXYOe2D6E
         I+vBIA2BFfntNwgsC4k5niyYjr8C2RzPcg0VT62sN650S2DWiHJSlVj9+w6nlkHAn6Am
         8VV5Kdog5r4iqWb35HkSUFV6jSIatClueP2wGTwfUcfZncfb28CEFWrNMfpeIar/2/5W
         t2nw==
X-Gm-Message-State: ACgBeo3D1oIESPTf4PnltzwNJ86p5/U6Rc2sBPrHegpTpU1AN1MSjdZH
        BG3IdEcqtHsGFK05hhPGfM23ACohF60xreXB
X-Google-Smtp-Source: AA6agR5tvu9knEhQdwzyYF2Q1oGh+SSN0iH2VVVvmeqNz9MLv8SEOAHKU+FHbuM9D26qpMR1MObYRw==
X-Received: by 2002:a2e:505d:0:b0:261:ce76:52b7 with SMTP id v29-20020a2e505d000000b00261ce7652b7mr2327656ljd.286.1661252943789;
        Tue, 23 Aug 2022 04:09:03 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a056512210900b0048b1d92991asm2375015lfr.303.2022.08.23.04.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:09:03 -0700 (PDT)
Message-ID: <2c14cc93-ae8d-365d-ac58-2e615d359fd7@linaro.org>
Date:   Tue, 23 Aug 2022 14:09:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-4-ciprian.regus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822125106.1106798-4-ciprian.regus@analog.com>
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

On 22/08/2022 15:51, Ciprian Regus wrote:

(...)

>  
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index f4d939cfd48b..0e86e38248ee 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -12,6 +12,7 @@ enum chip_type {
>  
>  struct chip_info {
>  	u32 resolution;
> +	char *name;

const char *


Best regards,
Krzysztof
