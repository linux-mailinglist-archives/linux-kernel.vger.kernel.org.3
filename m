Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076D5968A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiHQFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiHQFfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:35:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEEE5D104
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:35:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z20so12567212ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bHBxTrGeV4uX3RKPj3kIhCR1qMWY5TMaO/ZMSAA+DpY=;
        b=iT7SRCTQuPrgh4De5yQrnxK5ozQB5tyUZ8oxMXMRatGyyF1DzgWCjWenauP92iJRBG
         0VhHh1q803RGD26U/We6NvU1sSvyIzdR9HkK2SvYdzJ0KGMKL/AvkKtO5NFrfV2l4sV1
         OuMkSFqKT6N89GKjgdPtCdoxv12/4TL4pjpPdnEL8+YjaQm0F0ucrnz0YSNnxpxnBldp
         Ogxh9K57SD/lCxm8GQwbVzSvRm5nqFC0j5ukiJ0aET3Zt5Cmkhoy+fy9eHIJm/5NiVm8
         W+d5iP5RVYUm50MTv6UD99GR9aZqi1OYuBaw0XdzdCUNYOMqCvuNWnEOqPyM+dnGtf2G
         tEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bHBxTrGeV4uX3RKPj3kIhCR1qMWY5TMaO/ZMSAA+DpY=;
        b=UcqUb0/HOt3oX1TFFUJg90NpLI2tz47hEMqZ9Vcu4h0lD88RLyncdt1a8TTVgu7qmI
         rhYZXaqhVzWAcFigH3MRzQ2/0V7nGrrZkfdfnnHKbgo6uHmBarr6XVrdqsdleaqHp5to
         gADICyy3NfAvMIzsd8y4cBbdIlvnRP9jofxdWmb2Z7W8b8UCqyvf3fs8lISpLtpD+0lw
         KL5MEIITlum3KCi0cudgYM3cpenfc51qoPAJ1niMZhU7XSJ6EHBSVjHkiSgS/RzVEl3j
         k+UFKlAJARu6QxnaBU0xh2cLN+mn/TZbJCYNFkd9O8TKm8kR9CPtvisRsT3tAA8EGZuE
         r1dg==
X-Gm-Message-State: ACgBeo0n3n1raEP9xRSkZdbESxtgRv0OqnI4UPXjXHzUmRg7uRk7NF1X
        F0ykZxH4uNiKh9V1jaUw5W8mFQ==
X-Google-Smtp-Source: AA6agR6gdlTnSi+flxS4mgsv/fvJDiQHfefYmbTiI48/+uMiUtBIk45srSbYy5of8xoABI8nx4CUdg==
X-Received: by 2002:a05:651c:c8f:b0:25e:4e3e:18c0 with SMTP id bz15-20020a05651c0c8f00b0025e4e3e18c0mr7733803ljb.115.1660714539695;
        Tue, 16 Aug 2022 22:35:39 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id v18-20020ac258f2000000b0048b26d4bb64sm1579335lfo.40.2022.08.16.22.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 22:35:39 -0700 (PDT)
Message-ID: <786f0f8e-7f7c-2015-dd78-b2961b715d66@linaro.org>
Date:   Wed, 17 Aug 2022 08:35:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for
 pinctrl nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 08:26, Allen-KH Cheng wrote:
> The mt8186 contains 8 GPIO physical address bases that correspond to
> the 'reg-names' of the pinctrl driver. The 'reg-names' entries in
> bindings are ordered incorrectly, though. The system crashes due of an
> erroneous address when the regulator initializes.
> 
> We fix the 'reg-names' for the pinctrl nodes and the pinctrl-mt8186
> example in bindings.
> 
> Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
