Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0359E5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiHWP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiHWP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:27:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9075B5145
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:06:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn9so5610126ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yGKM2I7UEt0vdW0TbqK/IUc9qD27rValEiMJNQwZVjg=;
        b=ufPztWR2ngWfrbxMEAb6f3dXCo0gFdTtTmwimLCWzMYoKe7v37RMteWpmqKZpPAkAV
         1Lh0t8V9UnrpAUDwKqdvRnCVKEGY3NN7N4VjCyEP6hdzmUrsI76S+hNr31CmBbAVbXEz
         vn06k98hKekCkp9zzj9FAKkeI3VUvEwfbIOx4PKHWJXXCp6W/2Cva8qK/4WT3FJRB2tH
         PHqQpIPkhD0JrIuAf1kTUp6dZ+NpXqpEQLXk7BC97fPIxFKAD93CNaoORb6IyGYIzGkv
         2qprWXTL9R2go6TJVZrE2U1xAB1zGO5u1wR33qSfiIZ2Y39KeXuv6s4RsEtzVpwnXqZG
         xP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yGKM2I7UEt0vdW0TbqK/IUc9qD27rValEiMJNQwZVjg=;
        b=I9V0c6MlY5T6Z1j/HpCUpMaYnffx8+rnv95BjBdGopKqrZQOUyeKxMRpNwKpG8xwGr
         kRATZIsffzGzVtcv7UdM4TjbWb/jpKtkUCOhuPim5g4+tQeCATNfR9WjFzhmp2s6TSh+
         D/XjOnPJ4qJ7hRBGlJEEyQCFHELnIFG0uxQlbzcT/WeXUn4aT4VXvf0lMEe6ix0tZdkU
         Znh4iGWXyhb6DU2QkVPvKlmZeNKCkXjZEr9xpiK7RdSsRCkpjhzyTWV57Z6Xs61RgUpV
         Z2jyAx2pchNOnsImmW06JVxWEAiyRSWTJqOjSJzur66Xvk3oPSZ59BXPb1qVld67RiLv
         2UZw==
X-Gm-Message-State: ACgBeo3CWv9SZB4svoDqb00TNc5eKWQUaoeCzdApgkn9RHVF8thjLV9t
        CQRzqIdEt/iXhMy3EKQvsW31xw==
X-Google-Smtp-Source: AA6agR7LQZqic18Ny4TRgU5tXACZsr/Um9gWa1WzwzvlFs+fOfXqJ4LO1H1vqpbF9RIuGuN6WEDzYQ==
X-Received: by 2002:a05:651c:b98:b0:261:ab8f:3905 with SMTP id bg24-20020a05651c0b9800b00261ab8f3905mr6910952ljb.518.1661252751496;
        Tue, 23 Aug 2022 04:05:51 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id a17-20020a19ca11000000b00492b679d5aesm1722089lfg.81.2022.08.23.04.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:05:50 -0700 (PDT)
Message-ID: <04f61840-451f-c323-938f-ca91bc65e854@linaro.org>
Date:   Tue, 23 Aug 2022 14:05:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/8] dt-bindings: arm: fsl: Rename compatibles for
 Kontron i.MX8MM SoM/board
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh@kernel.org>
References: <20220822080357.24478-1-frieder@fris.de>
 <20220822080357.24478-2-frieder@fris.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822080357.24478-2-frieder@fris.de>
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

On 22/08/2022 11:03, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This updates the bindings in order to use names for the boards that
> follow the latest convention used by Kontron marketing.
> 
> By updating we make sure, that we can maintain this more easily in
> future and make sure that the proper devicetree can be selected for
> the hardware.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
