Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49182578474
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiGRNzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiGRNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:55:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BD25EBE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:55:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by8so10073596ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i1eT6+uUackWcKA/E4yG30SX1xEVWGcn/DycM4jrjWw=;
        b=juJDKA/nI0HVRB0ZhSrCRTUougH0QUu2p/963vrn6d9474ZvGOCnvJkS8EoGbSqGiX
         HQ/m+MjDfE4Z1rFuO89arTgkHx3qD+bOVdmvDPvW2sL/evj9mLixCYlJfzqwgtQRgc+G
         2DiZqYShqcQHH1RQm8HzDPtln0R4t0Wfg3TMnhNrzkXTIY33PcvaKRFmnV/LpkG5zuPn
         UE3jH6F5LQSPDlB+HIs07vnTVcQJsnDk+8/iIy+1/JQAaqU036YJ7P6G4h2Cahp2FHrE
         1HVIDNajjGcrha9nf1mlL35Jqx43C0xOAi1nfwnt4iyDRjYSUDuSnQ4nNIGmLHCPOq4b
         Gv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i1eT6+uUackWcKA/E4yG30SX1xEVWGcn/DycM4jrjWw=;
        b=tcAaRecB9G1C2nXaP6GCGreqJ2oSlOMHGIrgLmuyvdXfhW4+vTRPq1iNyuGXkyAanF
         s4PwoOTNPtdHjaBIp/egdErF+oN2dgbQj7kIVNjYapqAzHD0rFKsm7AakFUqBFsL7vwI
         9hJqSbxeWkzAEtDXar1IVK1jeRpheIZ0zXbB/q0uXkNxVHqNNeSwMVPLCCI7G0qfh7+B
         s2a6Ge5WO6kRzVyC4ZBK5Hy0veOlf0rcAphBJtjMtq5b4T1u+0fk/5/jgnzxi+uYsbKM
         8tmbfLm2oJDvp+ESAio6sJkt7cx5PTy2y02XMQWiWPk9zzqEhotJsYUGw3WHg5y+VWUd
         A27Q==
X-Gm-Message-State: AJIora/gRu0GsV8G6kJSwn7cdStuGVVu2gMQMX1gFp7QmMQxOW9w7ttm
        QwgoYnrHBBl5BUR96NPxrsB0VA==
X-Google-Smtp-Source: AGRyM1tnokAHE/of5YUFEhL+Iv1yuOdCGAcsV3TMFP12ptjWMjuQZJzWbkbkL2xRkl/t7MGfVY+XCg==
X-Received: by 2002:a2e:aa20:0:b0:25d:a041:2d7 with SMTP id bf32-20020a2eaa20000000b0025da04102d7mr8335598ljb.3.1658152526575;
        Mon, 18 Jul 2022 06:55:26 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id n17-20020a05651203f100b00489dd161153sm2598286lfq.74.2022.07.18.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:55:25 -0700 (PDT)
Message-ID: <edc61dda-5631-aea9-20a2-514cd60d0bfc@linaro.org>
Date:   Mon, 18 Jul 2022 15:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] dt-bindings: usb: npcm7xx: Add npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        tony@atomide.com, felipe.balbi@linux.intel.com, jgross@suse.com,
        lukas.bulwahn@gmail.com, arnd@arndb.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220718122922.9396-1-tmaimon77@gmail.com>
 <20220718122922.9396-3-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718122922.9396-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 14:29, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 USB EHCI host controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 4 +++-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
