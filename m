Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07E4C0030
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiBVRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:30:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D06E1704FD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:30:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h6so34733838wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xdle3NM3CU4BZdopDJ6LB2rKjSuUOgbJMe94mjOz2n8=;
        b=gM4Uen0m6XIHew0eIrTxRHjIWKYzx4CtYMCmG0QNNXHsxVPq/SVwiyR93sO0/GwqFa
         ajYOFP3gAH9ivXDhwe2uGxoHwY7VkDU/u4jKv6CUsICDfc5+52oSM4ix5IpZSSESXEZ7
         Hvd1XxfGrAyiSNgRgnnAyTSzKPKTtRWzApkWHB2A0OfjAjICFd34q3RHt7xqRU/vgyPV
         Rx4lVJs8XWOsiQt3hhpWjS0ehNoWr+Q4YEMJjkzSXo6ggwJ/aPEh6s3EP2t9ycHgi7XO
         L0tLzteHHfpqfRIw4ugOmJC38F48jonH2yYCZ3/yfw/FphwOLhUkGmi1H2s1N4aNkNyp
         goXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xdle3NM3CU4BZdopDJ6LB2rKjSuUOgbJMe94mjOz2n8=;
        b=YVXHHgdXI97dP+nwooCuNopHJOUtXQbmvltkzFECjrXeqAg6089eZt1AOpBuqpGDPG
         pGgDx29tpgarhO/I4MOrqU6ln5JaeYSi6fAyiawH+51tQ7Y9SCqA4urjFvE+cjyZG8H+
         N+fCJKhj0bxRS5gwdEZOg6ndNHPn15HO8y2lHP05yBFUfzR9YjFLQJGJuSQy+BTIAaHf
         FUxwn2wX2tfsJTjI2hO0ZWMNrseRg5qqZGgkWY+nahKqoSMKJXGBU96exj3tHYR9Ooxb
         YnHMnVevd+9VZGgMv6qApj3MS2WM1c/Gn5yOOcu1+qvWi6JsPBPnUI7Tftx2KUxo7NR1
         z7pA==
X-Gm-Message-State: AOAM53351nDUcoPJbjMwMYELrP0bCGGCDJWEYspF/B8oc44YPT1yGsPD
        XsljE3khLdCiAjoVAE8PQS9FnA==
X-Google-Smtp-Source: ABdhPJz1/QJ1Dx0cOFcGl+VO4hubpE5MFo80Bmr7PS7jHQ27mUKMvlyYwl4klaKCzl1yj4LCG75VHw==
X-Received: by 2002:a05:6000:1882:b0:1e4:be96:8816 with SMTP id a2-20020a056000188200b001e4be968816mr21375654wri.277.1645551012688;
        Tue, 22 Feb 2022 09:30:12 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id b2sm34923970wri.35.2022.02.22.09.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 09:30:11 -0800 (PST)
Message-ID: <6230f480-a8cb-6807-35eb-b5ee407297f9@linaro.org>
Date:   Tue, 22 Feb 2022 17:30:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmem: qfprom: Increase fuse blow timeout to prevent
 write fail.
Content-Language: en-US
To:     Knox Chiou <knoxchiou@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Evan Green <evgreen@chromium.org>
References: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220107103056.1.Ifc6ce6bb655ddb8ebbb0f340fcaaa58369bb009c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 07/01/2022 02:31, Knox Chiou wrote:
> sc7180 blow fuses got slightly chances to hit qfprom_reg_write timeout.
> Current timeout is simply too low. Since blowing fuses is a
> very rare operation, so the risk associated with overestimating this
> number is low.
> Increase fuse blow timeout from 1ms to 10ms.
> 
> Signed-off-by: Knox Chiou <knoxchiou@chromium.org>

Applied thanks,

--srini
> ---
> 
>   drivers/nvmem/qfprom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index c500d6235bf6b..1840d400fb53c 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -22,7 +22,7 @@
>   
>   /* Amount of time required to hold charge to blow fuse in micro-seconds */
>   #define QFPROM_FUSE_BLOW_POLL_US	100
> -#define QFPROM_FUSE_BLOW_TIMEOUT_US	1000
> +#define QFPROM_FUSE_BLOW_TIMEOUT_US	10000
>   
>   #define QFPROM_BLOW_STATUS_OFFSET	0x048
>   #define QFPROM_BLOW_STATUS_BUSY		0x1
