Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36DE554D62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358663AbiFVOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358437AbiFVOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:35:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945839B87
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:35:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so34625469ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H/cSfccrkMobuaWdmE/tdPoYRx0z9bpXg+/yToTVvnE=;
        b=EzNqat5NrSDe5C45j1gKPwkoY+xrhidH+Z3Io7mhsMwqTNnLBUaUqxRvEbatmHXAh8
         9R3VSv/sxc9Cka2XRU3PM+c1zHm/1nOsEmLooSA985j/kn3qrN4Nf6Y+KCn7AVfqwa8U
         oSUoxFP+uHkVZUNXblWZtsOPHxfd38C05M1J/W3+8xDSZanH8hUTP0xNCuvjt4qajvsK
         WPTsGa3qrNsJbMB7JVilnqYU99IMZ6Zz7HQH1j3Wi0gpZ3ZlD60gHK7iPQlvJOjq6Ljy
         yu1XE4KI2cVXyfy3y3xwGNHO7gy8kNWuEH3fveAZ6avUzs+XnGMyg2aRzXbypXDfewmG
         uc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H/cSfccrkMobuaWdmE/tdPoYRx0z9bpXg+/yToTVvnE=;
        b=iyeGOgbNCtwlCu2h0XaIQkEhTv81/v3LKdtHlYrM+vGekDcx/vkY3IKQ3jYgICwiY2
         cIAKmoS8MGU/cqR+xzhlmiH7cHHyyuYZNby1fGihVuMA9YRGrPQAM52Y9+hj4htH2WgY
         tIzMYDNcuqDV65f/bOZbBFqG/9g2fBkM1UUaVLP0Kg3DQYwWP2CHE+YEP+gWUVIGNtJP
         8fzq/hZnBOU3lO7+QTNl0VirWu0KQgSeastXuTDDbD5Cpugi9IZpCjsQu2RRR9Sl8dzg
         c2QNn4fIH6tYhuG0k4A+26qazj5bjFBEK+dHRI5NIW4mENegJ43g6aBnYPdA8t6ZAZQv
         jyDg==
X-Gm-Message-State: AJIora9bI7g18WrQuSEXCsCtxVLx9+eplowscjwKEjvKTh+hKmF7gQSX
        9zGMVqMf5Mt3gXvdyQCTVeS1D/Neg5gUOQ==
X-Google-Smtp-Source: AGRyM1vJVzIPqFGBsUHqfmMJi7WDemTnx1NnVJOZoZ49hmcATWo1tUFMa4ra8zQAsOYs2fyIGY6jyA==
X-Received: by 2002:a17:907:7b8d:b0:722:dcae:6417 with SMTP id ne13-20020a1709077b8d00b00722dcae6417mr3366157ejc.225.1655908505951;
        Wed, 22 Jun 2022 07:35:05 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g36-20020a056402322400b004357f88fcdcsm8144577eda.11.2022.06.22.07.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:35:05 -0700 (PDT)
Message-ID: <5421df1e-6e86-27a4-3da7-c15661aee190@linaro.org>
Date:   Wed, 22 Jun 2022 16:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622064758.40543-1-y.oudjana@protonmail.com>
 <20220622064758.40543-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622064758.40543-2-y.oudjana@protonmail.com>
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

On 22/06/2022 08:47, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add bindings for the DAIs available in WCD9335 to avoid
> having to use unclear number indices in device trees.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                              |  1 +
>  include/dt-bindings/sound/qcom,wcd9335.h | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 include/dt-bindings/sound/qcom,wcd9335.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b774f21828f7..2bcc3cc129c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16366,6 +16366,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>  M:	Banajit Goswami <bgoswami@quicinc.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
> +F:	include/dt-bindings/sound/qcom,wcd9335.h
>  F:	sound/soc/codecs/lpass-va-macro.c
>  F:	sound/soc/codecs/lpass-wsa-macro.*
>  F:	sound/soc/codecs/msm8916-wcd-analog.c
> diff --git a/include/dt-bindings/sound/qcom,wcd9335.h b/include/dt-bindings/sound/qcom,wcd9335.h
> new file mode 100644
> index 000000000000..709d33ca748d
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,wcd9335.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef __DT_QCOM_WCD9335_H
> +#define __DT_QCOM_WCD9335_H

Header guard should match better path, so:

__DT_SOUND_QCOM_WCD9335_H

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
