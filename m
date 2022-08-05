Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE59E58A61E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiHEGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiHEGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:50:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374510FD6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:50:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c17so2174030lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=66UfauZYCfkJNNsyNRoqRfHJ1yRjlBq2lr8VN6yPnYQ=;
        b=kntF4zz2WvX9k1FPCp4lZcTZCZDqe6jfdRhVyqHBt9f2xiQk6qHu0du0OMLhk6VGZf
         hXgZ3OoxYeAki0lMtllgzijEdiK4IBthxl2bwV7OduXbL02u+k83tV6m+A4VFl9Rqkjb
         xVnZUPb4RQUAZv9xheu2DXKvFjDebfE+BGqsuVbCuMf5KP2TeSlBDmBrWXQwDVq/lY6v
         SYikb+uXPVuXpW3uhxO29op+B8RDQ2WRa5OrfwKAEd1tN+gIZR28hX58R0sN1VF3LAL0
         Rt2z89i5sV+FgfIawlOmeV57TAnmHDDRgZBGBK3Ijh1E5ByXVOvV2bb7wWn3WZ3R2BSR
         PWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=66UfauZYCfkJNNsyNRoqRfHJ1yRjlBq2lr8VN6yPnYQ=;
        b=ZNZWs9z86WcH5qve7pmvtH8t8ydf3DNOTVE+CQcENjmHtiXAe0lvwME+csFMmZpfNS
         W0ltiI8+D7OEAFVIVsKY1+Yxj9yrdI6NztM2ovvbSSuQMTPJppWHyTKkKzRQu4yLZZuX
         GlXWLnYoPpNL1pMN56ysfooZijubu18aYYeS807VRTO5j6JwTAGWrY9C1Bx4C9vFYgR4
         fjleKTX0TIsNkD1SUqoIChnf1m+Br2GhRlrRaGVmaOBjJeu0aUdjJv/NGbytLOJtOoCB
         1nDjyg4PVgFOqQC2r/rXgVFJbmRMXy31KIWhXh12DpeFfzH4DQOaEPANMh6O7Ez7ziCq
         TnMQ==
X-Gm-Message-State: ACgBeo2TaGa8dzWEApvexHKOCn2qTy5mWvES62SbcOHQMeHAWZtnY7XW
        /9PCF9SG4zR5SSPKrosJ2DK+Pw==
X-Google-Smtp-Source: AA6agR5o32/q5DQZ/NN/pcoVwzwAt81SW1QvApCnN8Vf3TwHu3tNGA4wS69wwP2FBnHu2Z68Mu8WJQ==
X-Received: by 2002:ac2:42c7:0:b0:48a:e7a6:729c with SMTP id n7-20020ac242c7000000b0048ae7a6729cmr1743264lfl.565.1659682240854;
        Thu, 04 Aug 2022 23:50:40 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id y20-20020a0565123f1400b0047f6b4f82d1sm360378lfa.250.2022.08.04.23.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:50:39 -0700 (PDT)
Message-ID: <9e3dbc0f-b04d-c67e-7f39-9cf936ec7252@linaro.org>
Date:   Fri, 5 Aug 2022 08:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-5-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805053019.996484-5-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> Add the qspi driver to existing Polarfire SoC entry.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

This should be squashed with previous patch.

Best regards,
Krzysztof
