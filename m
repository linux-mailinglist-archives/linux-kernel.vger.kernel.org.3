Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C855AFEB9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIGIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:14:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE81F2FA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:14:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bj14so5827928wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WNKKGWN+WFUu1oa3BX6+NmApFTzWRBHzKK4NOWIbTqo=;
        b=SZDDwsi0AoB2G4+KibXTfTibP3Oppkq6dveQcXInabz6Lemcdu5SL2sFUspyVKzz2S
         PGL2Jxscgtr7Vv82xViWHea2t8H6H3wUKSpyIlgzVY7EuyoArMJWz+FTgI3c90iOHOFP
         cIA+5BHuphOsOuDZ88Ec9Aa7yPHIxbx0HMfWNXP4qvTLCD+/v5XH/2HbR24JdpGUGzId
         1ELkQO/iPwwljHvxRr74jhVWAtzllVPBGVoCw7ctvSZW7xaF8V3S/wN2hWNLpgzoqYsL
         6ELR54wpnI3Rf+YA321Wl6NrqRRcv/rYaVPdSaytIdiy58yvh7TPfzRdk94sWnZ7YOYk
         Kd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WNKKGWN+WFUu1oa3BX6+NmApFTzWRBHzKK4NOWIbTqo=;
        b=clB0JcYbQhDFppgeFcCoqwDSzoeomX0k+yvZyf87qew8DE1JgVGrw2SUrukq0KIpHi
         x0oP9n5RUPick94IN36eEvBTxFl/xMxUFHXZfFluRNmgaUiyfDBNg6UBTx+iyGySMIGD
         /VQT8RvgURjTBO0xt2HLdJVeql4VS9M0NVK8965lg9lLe3YNVRqUgSjmMEMcL4dqhPhA
         e6Pp5RuNaREwlRm53QeRAEyiXC3Xqi5bVoOSWQJ03ULaasrfsDPT2MTmQwgfmRY9svtC
         /grVUKW+k5uIUyZFh02J0J6AnALFH5N56DXfCSZziorayzDTnJoJ/Iw+sIH5DlObOPIW
         UEGw==
X-Gm-Message-State: ACgBeo3Zi3GaSmfW3JVZ2lE9N9R/xnvwkSR3jhIJWx/7K/oOHtTM+FSq
        YFUFOcO0F5TI3q8ayL+YeM78xg==
X-Google-Smtp-Source: AA6agR7U0b4uvQP/9XxTMhY5KOg/uOkGhISPokUyB6IpUnggVIGAc3fQEfsiDBnibuM3vwsq30Y8HA==
X-Received: by 2002:a5d:5489:0:b0:228:94fa:9caa with SMTP id h9-20020a5d5489000000b0022894fa9caamr1285103wrv.227.1662538488801;
        Wed, 07 Sep 2022 01:14:48 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t64-20020a1c4643000000b003a673055e68sm29260780wma.0.2022.09.07.01.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 01:14:48 -0700 (PDT)
Message-ID: <def4f82f-7438-b29e-dc1c-f971aeee0448@linaro.org>
Date:   Wed, 7 Sep 2022 10:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND] clocksource: sun4i: add definition of clear interrupt
Content-Language: en-US
To:     Victor Hassan <victor@allwinnertech.com>, maxime@cerno.tech,
        tglx@linutronix.de, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20220906052056.43404-1-victor@allwinnertech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220906052056.43404-1-victor@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 07:20, Victor Hassan wrote:
> To prevent misunderstanding, use TIMER_IRQ_CLEAR instead of TIMER_IRQ_EN
> in function sun4i_timer_clear_interrupt.
> 
> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
