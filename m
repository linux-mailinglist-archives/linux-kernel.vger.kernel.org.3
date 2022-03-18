Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E534DDAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiCRNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiCRNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:38:04 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F36BF039;
        Fri, 18 Mar 2022 06:36:45 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id w27so14149756lfa.5;
        Fri, 18 Mar 2022 06:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wjDzJSGXTTcuL82lpTBp2MHk8BQh8JdFlvWu+QOgSBY=;
        b=Me9rNx/qdHcBelkyayeMLxvEbOEjDMhzL/F8ftldSps2uNe1jhrj6TM80GOV+y8gxu
         KB4LgvV9RAjsf8XgiyqlaAZPjqvHWzvo2YkmYHzR5sc+SX+L1nw9KYHnS5Pm3Dai1oqc
         n35qM5AUM+yNm8xwPDbmVT+70rtEmlt2Mg8gHMth2ouMIF/+wbtWrEG3E8Esqodf6L/j
         WTSahauCG1DI0b6r9UqJNw+kfQ5z+JsqsiU9uBbQG3ZVkpbcO9RUWDkIgPJH/vfL1yQE
         4lW3FB/wCh/IRqzXVPlpKUHwOEop3ieeNryOYjoDdhzsesK0iN7Stfz43so/Ibiwx+kK
         RUcw==
X-Gm-Message-State: AOAM532wv2kyLP335Fsv9yllG23BRe8p1F8Xz2grEpRffOhgoELObESA
        mwHzt9KgrGzrcq5i6QIF7PE=
X-Google-Smtp-Source: ABdhPJyJVU6pA74yZWso0qATSsHvY5dYqdTC/qKc+yQ0t0dvp8UOTChQx75cV51xFqSp8sqJ15i6OQ==
X-Received: by 2002:ac2:489c:0:b0:448:5d76:c11d with SMTP id x28-20020ac2489c000000b004485d76c11dmr5963618lfc.322.1647610604110;
        Fri, 18 Mar 2022 06:36:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id t25-20020ac243b9000000b0044824f72b16sm855846lfl.80.2022.03.18.06.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:36:43 -0700 (PDT)
Message-ID: <ad39344b-ca50-ef74-d418-b721af358661@kernel.org>
Date:   Fri, 18 Mar 2022 14:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: imx: add clock bindings for i.MX8MN GPT
Content-Language: en-US
To:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317222521.170762-1-alvin@pqrs.dk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317222521.170762-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 17/03/2022 23:25, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The i.MX8MN has a General Purpose Timer (GPT) just like the i.MX8MM,
> which already has such bindings. Add the relevant bindings for the Nano
> SoC too.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  include/dt-bindings/clock/imx8mn-clock.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
