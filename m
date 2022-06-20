Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52F5512A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbiFTIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiFTIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:23:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A3E28D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:23:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id um5so4603946ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3Ros44lxzdc9H034iRq9XjLHdkZr6Zmv5Tm2gUHzb4k=;
        b=F85Durofj7HACsatoRDfeiLEib0a64WUvlROiLKAKCR23NLMEShsxw9VNc2reTh5B6
         nEn4sUrddK9p57eJkJ26U8cXd0w5NdmweBPdoopqjZbsTVRGQiudD2dcC36iMk2tVD81
         yl8EcvBRXwKvfnhlm/ofgKE4Jm0m4c54ZNdmwlTjxrw4+VQLs8hQlBL4T4COv8K7yJ1Z
         7Y/eQmFlnxlpM3hNHnKwpldLgxG2BQH+d2eSM0EhR3Rqd2QNnuFwIuDQp5/j4LWWCiM1
         nlu3ZFcIaiHq94YrBwbOcIc1BrdBeH1N17YfmPP5oJYEiTYLn54nPBLdg+BECWfqs0Bw
         OZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Ros44lxzdc9H034iRq9XjLHdkZr6Zmv5Tm2gUHzb4k=;
        b=vOyZHCkfWMk7pg1jorD2Jb8+IsE7ByH4f8qyLwLV1OmLIVXzM5Es5ZKXCljQLKhwnz
         jb2s4UKvP6dTHzw8UP0esUcU0hu5fJ/d7HTQxgQEYXlfmK0g4vW+FNzwRt5znbucoyn8
         Fozij4FiZqs2jUCJGBsu0V9bLVebk4bb3DruVbOYi1dV7dR5xqNorJDLo27rEBqfc0XZ
         jD3/L/32H4XafDOPicBdoOgcPFYszgSyRG/OhqfgjHrBLgFFqXGigaJUwkuoQSShotFa
         50lmieTi6thATlbPO6mAzqARfk0VNXJEcRbi92K+9DnkiEifyQ2MrUrhclkkOPDnjNEc
         65aw==
X-Gm-Message-State: AJIora+DpEiQWQk5Tf3iT9krgDDP0Y92Zfs7JcTZgOpk3a67OsOF/AFF
        oruzQGC5Cj00OUMues8abQ7JEg==
X-Google-Smtp-Source: AGRyM1vAjBf1TjIa/EZdSqh6SpnZpGgdVyfpMQp7XUD/Ztd8tGugtH+zYZB5r7Hj++TdtJOvMarXZw==
X-Received: by 2002:a17:906:778b:b0:712:e477:8f33 with SMTP id s11-20020a170906778b00b00712e4778f33mr19958626ejm.42.1655713427224;
        Mon, 20 Jun 2022 01:23:47 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906840900b006fec56a80a8sm5452387ejx.115.2022.06.20.01.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:23:46 -0700 (PDT)
Message-ID: <14fe8f15-e91f-45e0-39e2-7ae0d5f2ea64@linaro.org>
Date:   Mon, 20 Jun 2022 10:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 10/18] dt-bindings: reset: npcm: Add support for
 NPCM8XX
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220619151225.209029-1-tmaimon77@gmail.com>
 <20220619151225.209029-11-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220619151225.209029-11-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2022 17:12, Tomer Maimon wrote:
> Add binding document and device tree binding constants for Nuvoton BMC
> NPCM8XX reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
