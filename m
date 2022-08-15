Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E999C5933B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHOQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiHOQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:58:51 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678E125E9D;
        Mon, 15 Aug 2022 09:58:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a15so5527918qko.4;
        Mon, 15 Aug 2022 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rzM3JqvnxsoWPVIXaDiU4d/LUQsOkqzo4ABIVVFOAJw=;
        b=PQdA6Z3lfdxlktddD5yp8zviHlvFY2VEPX2pdwYY4jPtop+mP8GwfdH0uIZEBhuG4l
         0dwrCKAheoDHuxWunvNF11/ge+G1iiA6PaYkJqHn6FlSEo/XkFXG2dOqoPnTQ7aRsfK2
         JI2wEd+3r2kTyXdQjlGGCeRu45awh3Ws+g+KCddX9jSnLN0y5MYIcJ0o2IObz1VUj4PF
         VIl/1cYoLIe9j6LsDj6ieBaX0IyIszz0Q3SJExJWFEI9xtJIs4xNeqrQNMDxEN2g/mvF
         RnrusReCloThAcUnjwu8eef3R8leJxmKgs0sn63IRsGuShL4bWh+RKSR72aRA6jxMkjN
         EVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rzM3JqvnxsoWPVIXaDiU4d/LUQsOkqzo4ABIVVFOAJw=;
        b=64nn/46XgnOL08PN+FDaXXYsrhqvM1Pxg8UvMrf8ce08ZmLZa96iVlfe59sYTaYnuy
         /n8rsWemwrFqFrwuoA/6sio0pHmeLXyQFH+ly5JEJNNH56JDLMdsb1P2ZsmiA0GuPw08
         tlS9iKW0/Yf9S3zdNOzCqBQEkmfkSSKYkwMnHe1Ip062IwxyJkGOr/83jmQzVcJONPM6
         b+Wu+iUZFwAH7ZVHMsj0HUs94Yl3hQtvmksmfpKW+Ex5TUiKR3QiJm+YqlaRxbZiXAxA
         QvU7YEIF5pcwGH7drMY0+QR/+KwYrcYLaxNvIRN6OP9u8HgX0eMFtdCOMtyrbJ6zkOO+
         rCWA==
X-Gm-Message-State: ACgBeo37958JCqUF3xF5G1VQNVuoUkj/0qNRT/PeI2MLhInier3KjCgm
        6rf2Xu918FaEdf38sqjHmwA=
X-Google-Smtp-Source: AA6agR6frgGoCP/h6DZqk5vMGKv36dBjLyTimu6548/3eAa9rxI+WbnfflmA5GDylppFjnlB1wCCMA==
X-Received: by 2002:a05:620a:a42:b0:6bb:2168:7517 with SMTP id j2-20020a05620a0a4200b006bb21687517mr4638436qka.562.1660582729494;
        Mon, 15 Aug 2022 09:58:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j18-20020a05620a411200b006b9ab3364ffsm10003709qko.11.2022.08.15.09.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 09:58:48 -0700 (PDT)
Message-ID: <e97bf849-ce6e-0f61-8122-0389bc285b06@gmail.com>
Date:   Mon, 15 Aug 2022 09:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/9] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        f.fainelli@gmail.com, krzysztof.kozlowski@linaro.org,
        rafal@milecki.pl, Rob Herring <robh@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220803175455.47638-1-william.zhang@broadcom.com>
 <20220803175455.47638-2-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220803175455.47638-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 10:54, William Zhang wrote:
> BCM4908 is one of the Broadcom Broadband origin WLAN Router/Access
> Pointer SoCs. It was originally added by Rafał before Broadcom
> started to upstream the support for broadband SoCs. Now that Broadcom
> Broadband SoC is supported under arch ARCH_BCMBCA, this patch moves
> BCM4908 SoC device tree descriptions into BCMBCA binding.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/devicetree/next, thanks!
-- 
Florian
