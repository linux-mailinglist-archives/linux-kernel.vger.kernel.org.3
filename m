Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6A258C502
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiHHIle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiHHIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:41:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0638D5FAF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:41:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v7so9082610ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y5ugA8azfsfwmv08OCnDpdMfq2JRwexxKkXLI/mN+Mc=;
        b=YrGRHGjPT4L1hCaK34VoCuSuWFJHDL402Nu586D7o7trPMuxXX3XsPPhpwY/nGXZCF
         yRH6o7/krXRKmZRcsBbtZ2gbPs3AKxH6k5GFXE9ReLtMxjXS6qXySehZAqtVJqtTY+2J
         9w19BNzqSKuSi+KdjhqK0wUkV93Cn1x7nhONU6e6r9mELyeoGlPSVuf7x4nmPWfS1NIB
         Lmzh7Q8idVXXoZQs55m3owp4wCtjh/EYlwz8/Cw5RJQZu9b64NN2dQJwMRdP/fUc5kqF
         vp1xC6NdK9i4tUkNK3m06BiT9cne5zjiUOcGXRRFrTOmUHpBrRcmxEdlqrnpCiDKE8+/
         wFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y5ugA8azfsfwmv08OCnDpdMfq2JRwexxKkXLI/mN+Mc=;
        b=fzpckD/rTdJ24afPaSA8WZrOvy+eT8OucO7mglhZ9uQdGHeVPtx6JHu3rEorGBz14o
         wSLn/3XXe/2spjXd1ABVywj76gFDFKCpREGgPyy1x7x7mrtbK2QlLzP7tglnc5FaWTVG
         9ASNhKtz2A4lMl9ThTvoUyPNQZmJaBfPd2tq5dWylrRZOBpeBq3faCcy3k8szyuDmNdF
         b4SbtmqUcU89tLn3YmPq8CsH0cs9n89zhODws0UvDFtbYDvArJLUGs/2pvYqJTvNG+/d
         F6iXg70A9mQqWuAGK7LuboHdrmPsKe+bXm8g6jyx02P0GxeVBd8ThzH0n7SqUDGM04ci
         LU/g==
X-Gm-Message-State: ACgBeo1RFtBMxtdL0ZJw9mQsy1lxIblfBc2KLNdizVp4DDsFoXHq816f
        sJdh+XBIYSrJgJ/UJmuZEAOdAKmziLBbiI4Q
X-Google-Smtp-Source: AA6agR4RpVj2cNvz0i6zm9jUEsoiZSLWTdzMZLeiGA3YsGcsz8fbCNt2mWAzJZD2wDL9MV11owmiBA==
X-Received: by 2002:a2e:864a:0:b0:25e:4e27:56d4 with SMTP id i10-20020a2e864a000000b0025e4e2756d4mr5415260ljj.252.1659948089386;
        Mon, 08 Aug 2022 01:41:29 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id g33-20020a0565123ba100b0048b17caf05bsm1342762lfv.149.2022.08.08.01.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:41:27 -0700 (PDT)
Message-ID: <a233730b-6ac3-2cb9-cc5c-21ca6289fadc@linaro.org>
Date:   Mon, 8 Aug 2022 11:41:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/8] power: supply: Add driver for Qualcomm SMBCHG
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
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

On 08/08/2022 10:34, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> This series adds a driver for the switch-mode battery charger found on PMICs
> such as PMI8994, and referred to in the vendor kernel[1] as smbcharger or
> SMBCHG. More details on this block can be found in the last patch message.
> 
> This driver currently supports the charger blocks of PMI8994 and PMI8996.
> PMI8950 was also to be supported, but it was dropped due to some last minute
> issues, to be brought back at a later time once ready.
> 
> The OTG regulator remains unused on devices where the charger is enabled in
> this series due to lack of a consumer. Applying a patch[2] adding vbus-supply
> to DWC3 allows it to enable the OTG regulator making USB host without
> external power possible.
> 
> [1] https://github.com/android-linux-stable/msm-3.18/blob/kernel.lnx.3.18.r34-rel/drivers/power/qpnp-smbcharger.c
> [2] https://lore.kernel.org/linux-usb/20200805061744.20404-1-mike.looijmans@topic.nl/

How is it different from PMI8998? I expect not that much, so this should
be based on existing work:
https://lore.kernel.org/linux-arm-msm/20220706194125.1861256-1-caleb.connolly@linaro.org/

Unless they are different, but then please create common parts and
explain the differences.

Best regards,
Krzysztof
