Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86F55C67C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiF0Jt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiF0Jtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:49:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB66276
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:49:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q6so17870527eji.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ql1APVfZd2Lo+GYFdN0rZXs3VSU+UTL0bs7ioEmeviY=;
        b=RgORuYQJWVOAf9jFc6YuQNX9I75pP1tWgFUCQ2jVynSlJk8qBELir3nObGyYwqCfi2
         CjiNH4Mo7GKFukpzZxdb5uM6WITxuBYc3PVm2ZeMCzhfWxL4Epei6fnJUR5w+kir5N9o
         dBcfMbTmplc/onKzMhXESLqay0d7M6Kx5i8UiphW/4V/llRhrPuAp/VerKxmOpSFcf0U
         7UrUzacWK5HvAyEAhP0629DZhVmvpZfE3Y3rXmvIygo5adnKsYv3jy/RYALNzAy97P83
         5NJSKcdOiXqP0KMYSWoX0p/Co+AoZOt/tKEDij8aSYIw55Rnwy7uggkzUVFv9A3tKTDD
         A7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ql1APVfZd2Lo+GYFdN0rZXs3VSU+UTL0bs7ioEmeviY=;
        b=j173446s77yLpPCCKqbDzJwNMuklIu1VCx2maF/lSpkv4gGQDlfo3nB1nsfWDOJ4vY
         dLCrPphJyeLBLNuHHDmf5R16I1ZK8DGUEGHHw+KpqX0cYEM+TAYcgWe046DumxTl6Ta9
         Fty5smlLyXvj6gqL64P2aPzprmwhsvvmLcvp/w7d5ljyG7b1+Ki8rTf9YGggybQbpkIS
         0L6ifVeGU5OV4h4DrgIpNrn9XSK0YAf7td+Kg9s3ltTkPVfzrSQxKP9BihbjDwu9AVpn
         pUx1KXRxgtckrCl1Ww0aku0dBlnQFpPW84sGr0ZkzVnXHpgHQkhza+YlBE6M72/X7/OQ
         ZG6w==
X-Gm-Message-State: AJIora9Z+wT9ZDThHHhWU9ebvc4D0oQDRPXYJv0mp724dc+Gk0jZ2F9N
        I3KzOCzcgjENkfENAsYylH6+eQ==
X-Google-Smtp-Source: AGRyM1sHB77PAiN8CrKv7RFaOd3YlADqGW0XSj5poP0fTywWrKfS7m3vXVhchxnG1OhVfpXG/CZQ5w==
X-Received: by 2002:a17:907:3e01:b0:722:c339:bde7 with SMTP id hp1-20020a1709073e0100b00722c339bde7mr12071901ejc.285.1656323388038;
        Mon, 27 Jun 2022 02:49:48 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b0070beb9401d9sm4860306ejf.171.2022.06.27.02.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:49:47 -0700 (PDT)
Message-ID: <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
Date:   Mon, 27 Jun 2022 11:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     s.nawrocki@samsung.com, jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
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

On 27/06/2022 11:43, Charles Keepax wrote:
> The conversion of the set_fmt callback to direct clock specification
> included a small typo, correct the affected code.
> 
> Fixes: 91c49199e6d6 ("ASoC: samsung: Update to use set_fmt_new callback")

Where is this commit from? It's not in next.

> Reported-by: kernel test robot <lkp@intel.com>

You should put such big patchsets in your own repo (e.g. on
Github/Gitlab) and feed it to linux-next or at least to LKP.

This way you would get build coverage... because it seems the build was
missing in your case.

If you prefer not to include it in LKP or linux-next, no problem, but
then you need to build it.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
