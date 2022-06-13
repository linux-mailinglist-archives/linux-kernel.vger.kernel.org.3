Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C086549D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiFMTRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbiFMTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:16:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7F248F7;
        Mon, 13 Jun 2022 10:13:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso9395762pjl.3;
        Mon, 13 Jun 2022 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vP2a/CCt7HshyUEbxtRkeXFVL2WuGiSYuvG6ycnh8y0=;
        b=QRxXmPyawmBy6y60a7KFnp7fUMASsoifDYKT+iEalt/zagbPhOnXVQEdBVe/Y3HHvO
         3VSogICEYC0XQaPBGttJ/Bop/xgzQlgJi0PBRXiiipHIqSRg53Q7sFzevYSnghNP1hFf
         B1HigkU/gNNt2M2B07iHIZaxcFTdj8lsgDppo3IMMk3MfudL70d5ms8/xEryb76aCYn8
         HGWckQmrIEE67rCVLdjgRTGaWGdkBPuSJAfdQMQ1DD3xvYwEEe150f/69w7TfdSWLbeF
         mj8QJDMYf/rcXX1ORbJ/lycjJCwwXWKfOjU4yfv2U4l9b6q6T6KaGGh/IsQkfhpEzL+d
         m9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vP2a/CCt7HshyUEbxtRkeXFVL2WuGiSYuvG6ycnh8y0=;
        b=TT24sP4wBTJ98b70m881SFjt76opNSk7WUCu1+oKv4zlHbBEubho6XchQUgbJGAwTE
         10pflM4kWtVTtXv2vmibyHRr9ctQ8KIO1INL57yURInos5ax4CFRgfTnsAxqSyOgP8Xa
         CLwNELuNXEAjEkD7AhkWv14IvUJnsSvNBOVWNQXphgzlNAuNZa26u0v9zQARShFcs2E/
         rwgRxlPkJixqBB84sS65lp1SdO7lbhDAXH8K6RvgmGTqcIhW06fx4IKp7tkqmVNye9Na
         oMbFp6gk5YQDEqPMupdq0p8G2eoN8VMkYBDe4Di2MSu8HOm5rIlqER0FwJi4qzTU0XZ4
         /Umw==
X-Gm-Message-State: AJIora8WQaIn4jnR+2hD/JkXh+WnE2LC1BphVvvExQF9GIxXfXqBtR6/
        xDjqvhCLLtQSDvEqLdJjuGg=
X-Google-Smtp-Source: AGRyM1vMykkDHn0jeBqj2shRkDwy+j687E8Th6EKkaFkwCaU9m48ptBa2fy8+SgYlMK9fIXkrM7OMw==
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59ac with SMTP id q6-20020a17090311c600b0016790e559acmr596604plh.143.1655140437815;
        Mon, 13 Jun 2022 10:13:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d20-20020a170902f15400b0015e8d4eb285sm5367110plb.207.2022.06.13.10.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:13:57 -0700 (PDT)
Message-ID: <5b677140-c395-f59c-e8e4-6f50cea2a529@gmail.com>
Date:   Mon, 13 Jun 2022 10:13:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] ARM: dts: add dts files for bcmbca SoC bcm6855
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        samyon.furman@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20220607172646.32369-1-william.zhang@broadcom.com>
 <20220607172646.32369-3-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220607172646.32369-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:26, William Zhang wrote:
> Add dts for ARMv7 based broadband SoC BCM6855. bcm6855.dtsi is the SoC
> description dts header and bcm96855.dts is a simple dts file for
> Broadcom BCM96855 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, 
thanks!
-- 
Florian
