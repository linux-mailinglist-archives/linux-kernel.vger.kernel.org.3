Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EE050E863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiDYSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiDYSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:41:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E690B237DE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:38:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so8024988ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2latj0rCBnXB64zl9c6Cd4vtnzztQbgWSngjJHYi/kM=;
        b=R1Ks/9VYznUMf2TQhtXGXR5aCkjzpdLUoWSfaisR97spPF4MehiNMwCt2AeqyIYy75
         Wryd0MHXCKTU21lUmvIGkIuIeOlWaeNBOQ0o292DP09Z1cWiXWVBkw8cj/fYovRG0B5M
         wv0OXSnZxZGMDzoB1EOuzL0Fcj1aKm9bUykaECp1yy7ehhVHEo4oUp/azHJkJhQoaCQa
         mFF0ublqOsMX91jVHalDN4LBBcPbnmDe7jYLGVrDaVZJcAyqqndzSYwPOVJtkze7Cmit
         T6pckRJUm7TQiFu+VAmnUu67olfcZyBPO5s2OpDsEdbwgtZtQAKuhrKCLH8rKt0xRRAa
         Iv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2latj0rCBnXB64zl9c6Cd4vtnzztQbgWSngjJHYi/kM=;
        b=3kv6IYITi8oK+dO4RbljR8tSqXEPw0TnKWdotdVXQZG427gx6ATtXCqNc1IXqi/CiK
         KCfhA5bRNFIAwq6f+fqiQFCZVThJysD4VAl7YLeZGeyn+lclR1bE2T4CmYlNDJv68APP
         Jd008R0ZxFGWuP/ff5Jth2GQGOfRI1zFYg3tc+sFAOVafICUACGzKr00sGSWkZIDXlXz
         78LHcEEtrJ8DY6xYJyak7M/OzfSou1TB1syrRigScWkTRFCu2Mip5QPiPvKztW7kel+2
         1GmxfPeJS4Qkj+q1k2ZYg+eLX8GW4Z1ziPmT+bjBA7Gu1nXr+zfqqlrSnWI7pbhF9xef
         +ugw==
X-Gm-Message-State: AOAM533pz8IEOCq0oI6PXLnwjchjG9MC+qELA0dHf4D3QSAeZpeJrakH
        xqmGrZbwuZAHAmMZSTUGWWVRzpgqAOhncg==
X-Google-Smtp-Source: ABdhPJwTaQxRYtmIxrzTKoSqzXvGLx5o3bPjluBri5ZQs2MVn/RNMPy0a/UiPVSixIOrD98hgW/a4g==
X-Received: by 2002:a17:906:3adb:b0:6b7:876c:d11b with SMTP id z27-20020a1709063adb00b006b7876cd11bmr17342840ejd.250.1650911916512;
        Mon, 25 Apr 2022 11:38:36 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b004227b347ee3sm5000201edv.56.2022.04.25.11.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:38:35 -0700 (PDT)
Message-ID: <5c6b1ec7-5ab7-e23a-8d89-9fd1d927a3cc@linaro.org>
Date:   Mon, 25 Apr 2022 20:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: fsl: convert fsl,layerscape-dcfg to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220425140433.33936-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425140433.33936-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 16:04, Michael Walle wrote:
> Convert the fsl,layerscape-dcfg binding to the new YAML format.
> 
> In the device trees, the device node always have a "syscon"
> compatible, which wasn't mentioned in the previous binding.
> 
> One thing added here, compared to the original binding is the clock
> controller subnode of the LS1028A SoC and its "simple-mfd" compatible as
> used in arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi as well as the
> little-endian and big-endian properties.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
