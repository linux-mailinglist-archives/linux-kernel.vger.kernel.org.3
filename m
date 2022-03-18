Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B64DDAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiCRNiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbiCRNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:38:50 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F618F225;
        Fri, 18 Mar 2022 06:37:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id p15so3414273lfk.8;
        Fri, 18 Mar 2022 06:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+V1zc7ny51rS1agIr/dQWhdEHL02UEPO78yZkxZhSns=;
        b=pdI1ag1X3Nb03pD6pBqiJ06ktHlAlRqwHuB5tb5dzQh+eOTFD5mCKZGnTcYLNZKQYI
         DGtzfzogsIIpbfZq9Oa7IhjU8+xjUE2/+hOMBWdtvSXCNwFL66M5wdxt5ZK6puXIq23D
         74QJ5EfariZIGSwfJeP85pnYHSB6p2e7VjWGkkPc4Vehd8wKb28My4aoz+1JNgYr63fi
         TB1X4EFhM9w/p6c9R5PRrgDjccNA4hRlDCVgAmXxBGCrSBSbOqrAOs/amKh0g9L1xg46
         5zJs3/R/yex0Pm7yxjaRS+x90w3hBnjEuuXDstGtrX4S9bJuomfSVIhbWi8V6xUkqT5c
         vE7A==
X-Gm-Message-State: AOAM53107OJ1poh5spcspDHCGu+1vOKdTBh4dZYEtmplJZk/+/0c3WA6
        Ty6VjEEP198CfDf+3nCWsgs=
X-Google-Smtp-Source: ABdhPJwMv16kaKZSDgr9UlfX77ncJxrsuXGQV5YPZ6e55hxp4b59R9D+vwGyGLO3VkxKIsAzUjWUVA==
X-Received: by 2002:a05:6512:400e:b0:447:5d84:c40 with SMTP id br14-20020a056512400e00b004475d840c40mr5794875lfb.591.1647610649973;
        Fri, 18 Mar 2022 06:37:29 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id w13-20020a2e998d000000b002496199495csm685972lji.55.2022.03.18.06.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:37:29 -0700 (PDT)
Message-ID: <af4f1abd-55e0-f120-f5c3-e5835325d468@kernel.org>
Date:   Fri, 18 Mar 2022 14:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: imx: add clock bindings for i.MX8MN
 GPT
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
References: <20220317223600.175894-1-alvin@pqrs.dk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317223600.175894-1-alvin@pqrs.dk>
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

On 17/03/2022 23:35, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The i.MX8MN has a General Purpose Timer (GPT) just like the i.MX8MM,
> which already has such bindings. Add the relevant bindings for the Nano
> SoC too.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
> v1->v2: no changes
> ---
>  include/dt-bindings/clock/imx8mn-clock.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
