Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF752AC47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348126AbiEQTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiEQTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:51:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125D38DAE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:51:36 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f4so20433924iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X0CjJufNCscwinSw/tM0ViQ1QozSI5Yl55fOvHEmMVA=;
        b=nurwuf/z6wzgE+KkGJY+pIiR35UpqsAIalcZqaxDSdoqsKFungaf2X/80BYAHM1pA0
         X5Jhbk/Sr+OoRO6ERIAiAY5yl7igFh5SrkyyirFDwEN/pr0NuU6XbVxrpziwVcUPJ9mi
         EmEwJaY5u9WKcnCIfSMjLC1+1o7t6oBJTz/GXc2odPomQiDR+u5nengFwDx6Q7JcvMZ1
         /c85SlkijcroS7w8fiRoE6a8sqs7JLG0rShfz3J+KRHv4o24xmxnVeVgJ03UASD49WOO
         RJUq8XUUXF+Q1bCp0ZITNmG+RFPlsHnWBsZnb4PNDWGtM5PXzuB3CFJk1RIsAtZRI9RD
         FvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X0CjJufNCscwinSw/tM0ViQ1QozSI5Yl55fOvHEmMVA=;
        b=NioB7UPaNNyRmYDwROkALQuj/My86BAZnx7reTgHtUq0iQfpNDb7A5CVVlh6CHY02K
         RSe6OlYWOaChvPu4SQ9M819GWN6BMXQt7MuQpEK9D3k4lsOGQId0ZQ/ya4PbuhqqmtXd
         BYry4tK0+zFkzYhukHiAxGo9g/T/mXqm+VLC+DtXN+Ullks9maDvDFHNp1yp1JA2v+i+
         BeC5i41jtuVnw+QI7vnj1aK0IMiXiuWRCwJ9db4IQqooOoSz1x9mjVTzfEdYu5xW6L+P
         a8/+bSBgqC0GYwcmNQ3t6f9tBuxeQnBgpNHbXoxdDEtHwqaBuwhW0wFb9pIKV1Gs0yJW
         syPA==
X-Gm-Message-State: AOAM533r/NMx9ADEozPCQbEwuIa6ToUW7ui37kj+s5Ois+Fck+1bzXgu
        hCZ9hc3WkhuUSkWTxlpTbueWVg==
X-Google-Smtp-Source: ABdhPJzzUHBSKQZGPiaHYHds7KBaAbvtYcKoQ2eHzKRIL+FeUodWy8jYJUlf9JY/NPEE3YUiTq2A6w==
X-Received: by 2002:a02:b384:0:b0:32e:3063:b340 with SMTP id p4-20020a02b384000000b0032e3063b340mr6154204jan.169.1652817096127;
        Tue, 17 May 2022 12:51:36 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y1-20020a056602048100b0065a47e16f37sm58821iov.9.2022.05.17.12.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 12:51:35 -0700 (PDT)
Message-ID: <ceb32b66-1341-d54f-a60a-5c342119c784@linaro.org>
Date:   Tue, 17 May 2022 14:51:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on
 trogdor
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20220517193307.3034602-1-swboyd@chromium.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220517193307.3034602-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 2:33 PM, Stephen Boyd wrote:
> We don't use this carveout on trogdor boards, and having it defined in
> the sc7180 SoC file causes an overlap message to be printed at boot.
> 
>   OF: reserved mem: OVERLAP DETECTED!
>   memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)
> 
> Delete the node in the trogdor dtsi file to fix the overlap problem and
> remove the error message.'

Is the mpss_mem node (which defines 0x86000000-0x8ec00000) correct?

You're right, we don't use that memory on Chrome OS, but I just
wondered whether the other node might also have a problem.

I don't actually know...  Bjorn, do you?

					-Alex

> Cc: Alex Elder <elder@linaro.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Fixes: 310b266655a3 ("arm64: dts: qcom: sc7180: define ipa_fw_mem node")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 732e1181af48..262224504921 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -42,6 +42,7 @@ charger-crit {
>    */
>   
>   /delete-node/ &hyp_mem;
> +/delete-node/ &ipa_fw_mem;
>   /delete-node/ &xbl_mem;
>   /delete-node/ &aop_mem;
>   /delete-node/ &sec_apps_mem;
> 
> base-commit: 42226c989789d8da4af1de0c31070c96726d990c

