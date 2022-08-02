Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98155878B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiHBIGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiHBIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:06:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A019283
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:06:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so8033038lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ziFYm8rk88alkwyI6DGKeiYYXv8dOfZWiNNEBAzbbUs=;
        b=Q8FM7seRKFOLqDs9pbGjh7O9ypmYDNdS02O44fr0uDaD+Ekvix2C28Eu0YTnz4un9E
         zjZb0kmjzXhhxF2hA2MeGBEhZUMa2/QJ7merfkAYx+/6MBHNZg1vx8bdYF97YjDHoVTq
         LgeRNFA3ZxvbVMGhNzLcWi3AowWv9gQfOIN9VEPdRqbavEwLcWYz2pkHXeG3wsK20CUp
         tpChIa1AGzm/UKVSMhOsfVWVx+62gtQHTdGyf6F4anBWut49KD7kwKERKPGjulXz/zwU
         Zcu1mgRS0QCNWOsHRL3PcYpZM4sPoC0AwrgM3PyBQNCoCpSrp8xPLrt98yJI5L5agObH
         Tsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ziFYm8rk88alkwyI6DGKeiYYXv8dOfZWiNNEBAzbbUs=;
        b=TLoWKg+hUo5RzYtfNvGHzWdpQzgYLCs1l4RdUy1fQdwZeaEbEbkM1VPRLoN3w9lZq4
         ZbrHYF/IdeJ6kdlibWnSHOazJ38z5nhSnCN7OFRVcTedbxLwXKXDr3DhWGo1tpI9m21J
         dwrHVP9RDqDeWFo2nbf4I6yMZRzQOfC/9lCgSQkXOjclYBz7mxiPOZX7aeFABnC403SF
         stxLF+bYVF2RzBQRKo1H9R3KurCPfCNp85dCtu8Cdj5csH1UjQf9s5L4IgsLCfCLuOO8
         8d0AcIxL08OlK/OQuqScWpgplxHXyEN2uHxmWQR1dB65iPUkyYma2YTwmZOk/QsYrC+D
         u+tw==
X-Gm-Message-State: ACgBeo3S7WzF8cuaT3BC1EaetmFb3HygCTPJQ4An7AYNZyEglxu2oplM
        PU7EKCucE9W9IWqYRYtDdWDHMg==
X-Google-Smtp-Source: AA6agR6XdqW2PkasC+a1MlQwwoq1vcDKjruY6HOg87UsjC6E5gXtnZmjIUf2X1MMpMjvcyj6YFh0jw==
X-Received: by 2002:ac2:4e07:0:b0:48a:f6f2:8555 with SMTP id e7-20020ac24e07000000b0048af6f28555mr3101742lfr.200.1659427597773;
        Tue, 02 Aug 2022 01:06:37 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b0025e2cb58c6esm1842316ljj.37.2022.08.02.01.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:06:37 -0700 (PDT)
Message-ID: <341b4627-d729-0941-2c35-08c16ac68f3c@linaro.org>
Date:   Tue, 2 Aug 2022 10:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: add definition for mt8188
Content-Language: en-US
To:     Elvis Wang <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729084319.6880-1-Elvis.Wang@mediatek.com>
 <20220729084319.6880-2-Elvis.Wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729084319.6880-2-Elvis.Wang@mediatek.com>
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

On 29/07/2022 10:43, Elvis Wang wrote:
> Add dt-binding header for mt8188.
> 

Use subject prefix matching the device.


Best regards,
Krzysztof
