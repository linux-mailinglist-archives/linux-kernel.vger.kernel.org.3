Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26B54841F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiFMJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiFMJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:47:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D530819280
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:47:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so2744623wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QBbQ5RlehgZnaAFrfhn8bcmuDJisLZ8n0VZI5+tVYd0=;
        b=Z3v0eSGeIIXyS+chr/DHZqDXVP9ghpBeOpyTPZnRzgvBMK2KTKcmPqiJQKdaYyAUFN
         /5I3VKtpsPS2LnAfqV4Wt5PnVqFDqh5lxiRB9AfwBzQFucpd0XxU++wTExjO1rPgcUJh
         hRDUoFoC0QnkrGyym9py85jy3rwrZS78VeOvzaiWNOVeoK0jOGfMUm9kRZ4gYAcJx1qO
         eWsCODyQWnmNHe5Nj00hoLKS0IdxF6kO8DPpvf65RTkwf/uBvbsNghF5OQ+XT0+KoA8l
         Q/Pwj0p60nA7MvqurDqt35ZXIfidOhub5Ukw59AbL3imUl8oD+xQ3l9yVVvUC4mC98ne
         DuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QBbQ5RlehgZnaAFrfhn8bcmuDJisLZ8n0VZI5+tVYd0=;
        b=nRGiWlfirihrgnDrgjKj8BnY8XxPTJsFnm4lYZtwt2qN5yHgsrrkPhnLxvKZ/53Il1
         5nJ6VY/oeu2PQzlDZYvtd5les2e9bOoE9aiMRN5/9Z5JexrA5Vf6/NYcdoPufuplTfNx
         TqmbolHPlf8SE+u/hYQGmfC2q4Sg4/d8Id+O/pMqoM2otM7ySb9AhFh9YbLuU2odcUAP
         s8wWF6xp6ck9DJ7YfG69F7dBYfCtrEWkIpTVTOHvIgVqtKHtetZvgAqWWDoo7vI5o99V
         AY9r/hLLa2yza3yL0F+eVsJd8wqyA3DdcZ5kf0miDuOGl51Iv1+mUx3FNRTZHRxLjYDB
         lghw==
X-Gm-Message-State: AOAM531YtQ25L+peFptXpZZ7fUH8Y26sdDKjpwAoW+YrwJzDH7FTWL9Y
        X0N0jiBAKahZUTnh7TsYAZxYbQ==
X-Google-Smtp-Source: ABdhPJy7gGaJAsLK4y+fIQ/Ft4Fmg9Bv62EVmuuU3nkUVCLfFTuDLBrT56zqaFARL7o+XzGT3C/n8Q==
X-Received: by 2002:a7b:ce98:0:b0:39c:4dc7:6707 with SMTP id q24-20020a7bce98000000b0039c4dc76707mr13988444wmj.51.1655113630472;
        Mon, 13 Jun 2022 02:47:10 -0700 (PDT)
Received: from [10.227.148.193] (80-254-69-65.dynamic.monzoon.net. [80.254.69.65])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b00397342bcfb7sm8762339wmf.46.2022.06.13.02.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 02:47:09 -0700 (PDT)
Message-ID: <71874de3-10f3-aad5-6f86-373f13bf4d90@linaro.org>
Date:   Mon, 13 Jun 2022 11:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/6] phy: samsung-ufs: add support for FSD ufs phy
 driver
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Bharat Uppal <bharat.uppal@samsung.com>
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
 <CGME20220610104350epcas5p2a42643432e60d7ba18f2a2afcffadfaf@epcas5p2.samsung.com>
 <20220610104119.66401-4-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220610104119.66401-4-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 12:41, Alim Akhtar wrote:
> Adds support for Tesla Full Self-Driving (FSD) ufs phy driver.
> This SoC has different cdr lock status offset.
> 
> Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
