Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9967542D03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiFHKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiFHKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:16:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A741796D4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:03:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 25so26090371edw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qbaH54iTPUvSlJswsTaQYF7iNoFv3UN0F4If8aY7DSc=;
        b=aFWzyS0kWpbLXEzlk7ET7h6AKVCHaUv0/FmThRMiSJJdJ2TwMOW4pNM4d0gA6rOPP1
         AiIqne1sHMa1t6Eevw5WqRZoUr7ZA+qcck2QkxiQgX9aKoT/FEppfgfXVfU4jCK8o/Jm
         6Yhc3L/+HTJhV9EbHEhV8Uoh7v014wP3+2ucc8p658M0707V8C9XP3LvEepB01lG64gF
         ne8ERP/D7NVdVCXno/LWhi1Q4GkurXh1jVv+oCWHmYVxfUWG/hq2KF5hmd2JAXd24W1w
         1bDD3/0Nzmik5G820CvrJodpt6W6P2n8n7iBNQ0Ep5A3Qo2edv+VS11SSD0p/33JQQ56
         x1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qbaH54iTPUvSlJswsTaQYF7iNoFv3UN0F4If8aY7DSc=;
        b=NxoL5/dS0kZi4OyaGhDlw7pXD2qkw5irBxIo/Am633Hzv8uQW81qAkt+asUSH33Ff4
         Nd7DgGyKM/UDH4tSyEiILJxhYjH8aSPbC1+lw4iFpdLGbwAwjUHKVRl6x3EcKaUsa4/g
         9ERnWVNCKLQuIJY42dcvlfDvyG76Qsinaa+EL8NeZOSAZeef+/gJFrPGWtts19/ASW7B
         lpnJmfwqxqLs23qLiTRSR6AAz9tOyFRpglaAzK/ebRGfHDbZRrBCjVBaiXjKrxomCozq
         THp4sa3P2XFglXXB+PppsLSfeFheool3b5kPPdIHktvoo9B4WamoY1+HC+AGMAPzrTu4
         u5CA==
X-Gm-Message-State: AOAM5304pNmmHnMUNf9cYRL3InhsoiWHM1OaOo+NoC1AxmdkEWdeAsJz
        QNsOOg6S10LVstVqswBrlabgQg==
X-Google-Smtp-Source: ABdhPJy1tq/L9Aur+Nt5T6ZhaLwpbN3JbYjRS93TPs2VCwukxaU6Blb7GfO2AfGNFAnsB6qJsjU4wg==
X-Received: by 2002:a50:c407:0:b0:431:39ed:1c5e with SMTP id v7-20020a50c407000000b0043139ed1c5emr22514863edf.402.1654682627998;
        Wed, 08 Jun 2022 03:03:47 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0042dcac2afc6sm11881830edq.72.2022.06.08.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:03:47 -0700 (PDT)
Message-ID: <b06eb0bd-08b8-87b8-fdd7-4cad07d1fa89@linaro.org>
Date:   Wed, 8 Jun 2022 12:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 08/20] dt-bindings: reset: modify to general NPCM name
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
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-9-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-9-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Modify nuvoton,npcm750-reset specific name to
> general NPCM file name, nuvoton,npcm-reset.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../{nuvoton,npcm750-reset.yaml => nuvoton,npcm-reset.yaml}     | 2 +-


No. Name from the first compatible should be used.

Best regards,
Krzysztof
