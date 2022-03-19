Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A314DE87C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243169AbiCSOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiCSOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 10:35:37 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CE252B8;
        Sat, 19 Mar 2022 07:34:14 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id r23so13361917edb.0;
        Sat, 19 Mar 2022 07:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8aTmJbhMVjCM/doQKA9i3z+69Od14EUnZ7FNvA0Orbc=;
        b=wGgQO4YVSEvvlM1WJ6EyArI/jV/ZnysBHfkBwd6JstUxFGfIC08g6IwdF45/6CRuyM
         Vqnnxf2HG/tP6eUALy15fD/05KTfijinSkcOuMaBn+EMNr/xhF6q94XL6sw+RYju5uVL
         EZ68P+ioWOMQAIwp6DlEdwFOJ8V341jnooKL8Ui+20ziB4Ja7IUqFyKDUp/S1otnDi5C
         Y8WjG/mg61vsZkyStth/G+rPfGxyqFC0d2EaWCfftxrik7dSLTHpiDnKVBrEW7N1Fj7t
         mBMO6nqxV6Eg14elUj5QA1eCu/d2JqEUARDUctYzyKTaMyMye9Jm6XSxkGcVVbc/j9xY
         ZbzA==
X-Gm-Message-State: AOAM530L/byADGsemxPPGPv0UlmwTHy7ndyGhx4+bG8ae+nIW/bGzk6t
        B74OA/SOLYQO2RgfjTpa3Tg=
X-Google-Smtp-Source: ABdhPJwBZAPG01rcbsKLYeTLgYvtu8W3O5ihOYNLvu15HvPCrw8drbycgLmwepRw8OZ0c7CIt/v/IQ==
X-Received: by 2002:a05:6402:5202:b0:419:2b9f:7dd3 with SMTP id s2-20020a056402520200b004192b9f7dd3mr795910edd.224.1647700453248;
        Sat, 19 Mar 2022 07:34:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm4871746ejc.66.2022.03.19.07.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 07:34:12 -0700 (PDT)
Message-ID: <570331fb-bffa-da11-c6e4-6e059e418a93@kernel.org>
Date:   Sat, 19 Mar 2022 15:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 6/8] arm64: dts: sparx5: fix pinctrl node names
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-7-michael@walle.cc>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318202547.1650687-7-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 21:25, Michael Walle wrote:
> The pinctrl device tree binding will be converted to YAML format. All
> the pin nodes should end with "-pins". Fix them.
> 
> Fixes: ("arm64: dts: sparx5: Add i2c devices, i2c muxes")

Here and in all commits, there is no bug to be fixed. Please remove
"Fixes" and remove "fix" word from commit msg and commit subject,
because you trick stable-AUTOSEL to pick up this patch to stables. This
must not go to stables as you can break out of tree usages.

There is no bug and there is no fix.

Best regards,
Krzysztof
