Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420358FAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiHKKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHKKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:52:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA193525
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:52:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r17so24977156lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=d7iRjX2D2keNI8slfz7qoQsCGpwSEtSMwIfU6YyWGks=;
        b=wM7xc0UlLu2qxdJx92iZEMR+Gi0HdbTzS+WEzrfl555Mbl2HEMTogGhtSMJy6Rtydv
         AzmxJAS/bA9DsBr/rMDV35nITUAs3/EIsDf+HRJexTuYpttsVIh4wAATcFPF2zJDptPw
         7g55dImwQd9A36IuU17wCQYcnM5mSDcSZHTM6mHl1BY7qvi4ddXegD6qwIWxw48ulZrA
         YEtFK8CXNDspr68xzqUBcT21jF0awZF077ZUJ7wEv6shXty/euV0Wkbkz5W/Enk9ZngZ
         tZ5qGcao76DNRWCYRXGZHhjrwUCjLyE4gX/SBtG7UdKnI9CAlR/wlYYf8qFgmQ8qAezb
         VmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=d7iRjX2D2keNI8slfz7qoQsCGpwSEtSMwIfU6YyWGks=;
        b=qitvjhM3juriEj9CleDd4Lg3cqpult8Ziy06PlDNPRKGR6ivIk8UiSfHjISnxupExM
         2WW3Uwb2bRAQkNG290svuEKvJbfuTyvm43ZQ5M4ENeC38QWyfPrebvMHDs88BWwwCJ75
         x6J1VGzYaVj6KJNYT94thuknYWkipR+gTFAcZ33o75wCHE6r6Fz74hOrlWBVfmruPpb+
         q5CNixi6LJxPfNyAwUENjW3eIjimKn3uheuY7c1tTO5oz5KeNlAgKI1noIhWukW7A73E
         +BEj5+YNAoCvUtqRFwDbMkfI0PXg9hwCdyoFKl2Y2ktC522Kh8zdc+wXdC+0bjUqrUZf
         x34A==
X-Gm-Message-State: ACgBeo2VT6jFRPE8qlC7i/qI7h3fnnsfJhYHI/G+gSCHSHytG7JlBv6X
        mbf1jUdUJaGo89RElNqkWUSWkg==
X-Google-Smtp-Source: AA6agR7dL4LIkbOwC+Z4uacUEGODwrWrQ0fm3+nLjVtBLlPmq4l/QPZ4hvKbEI/PzYUR2pBShKTjIQ==
X-Received: by 2002:a19:674a:0:b0:47f:863d:5bc2 with SMTP id e10-20020a19674a000000b0047f863d5bc2mr10519629lfj.92.1660215146230;
        Thu, 11 Aug 2022 03:52:26 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e4809000000b0025fe2049beesm745940lja.60.2022.08.11.03.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 03:52:25 -0700 (PDT)
Message-ID: <d8e512c3-2a96-0fa0-6c2a-d404a9abd8f5@linaro.org>
Date:   Thu, 11 Aug 2022 13:52:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: imx6ul-kontron: Update
 bindings
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
References: <20220810081825.19051-1-frieder@fris.de>
 <20220810081825.19051-2-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810081825.19051-2-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 11:18, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This updates the bindings in order to simplify the devicetree
> structure and to add names for the boards that follow the latest
> convention used by Kontron marketing.
> 
> It also gets rid of the N6xxx notation in the compatibles and
> file names, as they are not really used anymore and often result
> in confusion.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

This affects the ABI, so you should be sure that it is desired...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
