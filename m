Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB58590CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiHLHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiHLHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:53:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3AA721D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:53:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a9so272441lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ip78SsBx57ju3DRdHsIt5n1DmT2pQVDaLo3LS2FuFCg=;
        b=H/PTzsPEaYJyQoh5RXzNFAqF+MM/cYZVjHLghf26kZOV/T5L9auYLNSZx4kNMg3748
         2painSyq9r/zDvFicwaScAS2EMc9/cA1ePa2YUXS5ChHzoVOL0g66EnQgQEbyjwNiCZm
         PhtYAU7XarKCB2DUmhwR+sIY7860CxDmnnrCerFEPnAdO/JmPLAvudYGYeaBQnVMbZIZ
         EAV+3hgMotEEqUxljVwBK43jhHg1AeWeJc7flAPWgBW9eVYt25PLKtNPtHT/+YpU6YZN
         l3yD97jviITaRGEhvqKwg4OONqHAoQ9/OGp11JSPhkROBLws4UPQxbELjETaAFRZnKX3
         5DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ip78SsBx57ju3DRdHsIt5n1DmT2pQVDaLo3LS2FuFCg=;
        b=AQ7SLnwUH846Tw0anDlckGuGzHIZxX9V70oJD8+hkQB3GN0PkNdWL2u+kcr3TwZ/7b
         h2Xp0s6OjocAuur6tPrnx1TPxVojtewkCeO9L8TxOA3u3VHPdZXXjp2nvlAV4xVt0YNa
         vPtHBZqB7Z18ec9mPbGVTsZbPAT9Kg0AlOx0Sn4XD9Bt/42o/oqnI/zCIL732D03LqkF
         VYhUyvuZUDnjS4PZzHjpUwx1QWvyTILC2cpym3Wo31LaBXcmEBuakpwB3UBXy5bD0+c1
         gqk741MIH8CVL6cPItwHCEifupIGSG8P6H9fQ7FPkFDbMDyvssJLyPuJfU0Pz66JWMd8
         eczQ==
X-Gm-Message-State: ACgBeo1IFz9CEFkLk3iehyqLZmx+wR7zI4OgoVPHrqEBJGQucvkn/JC+
        eqTsrJRcbQ+n5IEg3lGaOijI2w==
X-Google-Smtp-Source: AA6agR6xx5G8Pl2PcS76eyLfa+iZnFOmptumXiFgLxGagYIFUe7zQOfe7bzKBthYs4SSTW/nzYarTQ==
X-Received: by 2002:ac2:4f03:0:b0:481:5092:ec8f with SMTP id k3-20020ac24f03000000b004815092ec8fmr955302lfr.35.1660290798913;
        Fri, 12 Aug 2022 00:53:18 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id x25-20020a056512131900b0048a83ab2d32sm131704lfu.0.2022.08.12.00.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:53:18 -0700 (PDT)
Message-ID: <90b2dd81-e037-5109-3b31-0efd8e65c1d6@linaro.org>
Date:   Fri, 12 Aug 2022 10:53:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: lpspi: add dmas property
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20220812073452.45763-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812073452.45763-1-peng.fan@oss.nxp.com>
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

On 12/08/2022 10:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The LPSPI has dma capability, so add dma property.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
