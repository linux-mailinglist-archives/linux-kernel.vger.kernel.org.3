Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236E522E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiEKIWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243574AbiEKIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:22:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7B35DE0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:22:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so2580288ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IIOcJgbS1/hMQQvn2DCFX+BHhbtb4xhB0glTejG9nd0=;
        b=nN+tvnytLjTaJLXUpNkGlrL31C7UW1pB6NFTtmXaTXEc/E6YrG1OIKgpwVMC8S+kVK
         D0zGHuOSWn6VMDT5RVsCrOPzqDPn+ynX+2xgsLJ+esu5HFhKI1L1FfojyWFbLtSNbXuS
         1qXyVZ1jTq1c48DPsEHHWi1ElZ8UTZzr57W1iPjRSdUmmWlSe8Hm8Pc0jYi+i4kpwRAW
         hH+yxI/z9Cc1NoWL0nAk+IMz8mhUv1TWwTqWJaA1lqsWAnJvZ/pbzRI35MVvlcqiK0bh
         yq9FIOhP2dWozNqsyasJ2s6B/nnu1uuSBahdmKMJDmas8sdvCmBeg2zvG6YZlvRLOBiP
         0WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IIOcJgbS1/hMQQvn2DCFX+BHhbtb4xhB0glTejG9nd0=;
        b=BEEUc4ryW373BqSOCD7Ap20Xscd5HOszqgbvDq9iZ6uBrSbj2kPiuChXYBaQ44Fs/W
         anQx0O4FfNE9ZWpn0yWoLNSqamGLnWwt4hBJX/bayzdSsowFEIazhkPhYZLufTbl4sQE
         AsJuYUuD3mdSUekByUdhZCZYe314WpwzyyhBCCHj8nMqIPi7jcXPqpvFW33zUvhRkFPR
         0sioZdc8oAFOy6/JKqyuZ8Z5PAZ/+XLToi3tn9lZiNSShVmCLbNr7jXvdl6i2Efr9Fv0
         GG7HfsBY8CYViqQ6JbUL2LAK5uQ+ZHKmx3UoLOL4nUn16o4FsHR/MNSQxhqae7FwLARP
         C58w==
X-Gm-Message-State: AOAM531BXW23vPNkcD73DKhzrZvKGWclmuSmMYdEv9w+RgKzi0efLVmi
        g+MVwRwbr3b/2B+eftR+VexraA==
X-Google-Smtp-Source: ABdhPJyQl+2i2St5QQZxqWfls/5xIarQ0xgPypRKf/p7aX8oprL7xHpOkr9jt2CVt3KlxWwPkWf+7Q==
X-Received: by 2002:a17:907:16a2:b0:6f4:eeb1:f7de with SMTP id hc34-20020a17090716a200b006f4eeb1f7demr23680710ejc.446.1652257345815;
        Wed, 11 May 2022 01:22:25 -0700 (PDT)
Received: from [192.168.0.254] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090676d400b006f3ef214dddsm686150ejn.67.2022.05.11.01.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 01:22:25 -0700 (PDT)
Message-ID: <7783d64c-e48c-5e3d-9560-51197234051a@linaro.org>
Date:   Wed, 11 May 2022 10:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] dt-bindings: display: Add bindings for EBBG FT8719
Content-Language: en-US
To:     Joel Selvaraj <jo@jsfamily.in>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <cover.1652245767.git.jo@jsfamily.in>
 <BY5PR02MB7009F6D4CC6CA1C433912C56D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR02MB7009F6D4CC6CA1C433912C56D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 07:28, Joel Selvaraj wrote:
> Add bindings for the EBBG FT8719 6.18" 2246x1080 DSI video mode panel,
> which can be found on some Xiaomi Poco F1 phones. The backlight is
> managed through the QCOM WLED driver.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
