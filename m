Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB27575BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGOGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGOGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:45:15 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A35D0CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:45:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e28so6354409lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s6eG0cWFmaFgptED2TWTYg714sGFdvYDMGa+KA8yB6Q=;
        b=WrYlFULL2rrZ5fZG9trqBVtXKTCzn4hkvVsKSWIrqQvkiMQs21w76DZ+gQpAzCeJDa
         bYJJ5Ajj5d/qW653vm8ay9eIsbm2A9xdaEGqZW9aR3FYujeiXMtXFnMUs9KgMPa8gZBT
         IftuyN4ZHnl7BiNc3QrzyMsdbGDOyVkRA/mk/74wEFhVXeNl1hM5taeZuejPNVKvjIkj
         spnFys8kt1VahKFwRMm/jTiufQv1m3R6mIVK5xT/9C7lncXoEERby8LfxEzC8M4R+64J
         05spCOlX/dyuZ4eA6TcPzT89bj7ZkwGILC3DAO2A636emauUn3lwjK+6B5pUR8qLbwX5
         Z7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s6eG0cWFmaFgptED2TWTYg714sGFdvYDMGa+KA8yB6Q=;
        b=4Te/1ZykU2GhV2rnKfNuy4lfis0IZ4xd2g4KRfydnlJ7Zmedvlu+U6YZWUVA9tKKlK
         VLYQMY6sQoaXax4h2smeVvosIS1VCz4fqfOAv48MLXvWdUEi6nFIli9mWtv0pSFUlUSi
         qGhve5wdfLxtMGDjMfVGdHMtPU3jOwc8bQ+HQVaf7moYDn3eP4LQU1bVbMT3DeaKl+qh
         qn3jL5pnztC8moY+71mxPmNSRi6TKGWOyTYFDi+Rsex2NkJo5eNUU80ALa/gPZ69al93
         18xYHhn99lzE3lnsHf8t/IFOAsF8McXEZM48AlplO4QagYos4VzTGJDwf/TCusjXXVj+
         nZ1g==
X-Gm-Message-State: AJIora9/nSn4vANLNCp2WOjvrCMlFj5EqkBlwP3Dv6zEhOEODXXQHu0c
        xXXQ9HZJNi79PKbDK0N3TahClw==
X-Google-Smtp-Source: AGRyM1sxahtTvbaYmEdQrM2G7TMm3QM7tC9YNrozirTHaWcx6GFol3E84Jd5X4sFqg702kKUKzjeOw==
X-Received: by 2002:a05:6512:3e0e:b0:489:c79f:4019 with SMTP id i14-20020a0565123e0e00b00489c79f4019mr6936351lfv.68.1657867512823;
        Thu, 14 Jul 2022 23:45:12 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id d29-20020a0565123d1d00b0047255d21124sm752701lfv.83.2022.07.14.23.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 23:45:12 -0700 (PDT)
Message-ID: <9543f3ec-0c41-fc7a-e0f5-2646eee17f0b@linaro.org>
Date:   Fri, 15 Jul 2022 08:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dt-bindings: remoteproc: mediatek: Add binding for
 mt8188 scp
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715051821.30707-1-tinghan.shen@mediatek.com>
 <20220715051821.30707-2-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715051821.30707-2-tinghan.shen@mediatek.com>
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

On 15/07/2022 07:18, Tinghan Shen wrote:
> Add the compatible for mt8188 SCP to the binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
