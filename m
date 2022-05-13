Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B4525DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350833AbiEMIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378277AbiEMIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:31:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34432A7C36
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:31:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gh6so14905784ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TNsY3qFCwXQblJPsVdG0LCyrHmw8JZ3ev2jxwT+LE+k=;
        b=UmoVPN2ActdAg0q/sV9x+QJ52g/PRzhZYttsOVqZVE9TDTLQCLgWe93efuunDeoxjT
         JKwn69yqazKwiIaopRnbqE/8GHCsx9Kv3ntH8qnhKygS8mJ14jDjtAMFSBOuwvQoa9Ct
         YaPjpGSl6DdFPek+/OyRhTvuFBMcBwG4+Yk2cQpAKzZkUcphG0Vf2zGx0nVsw0faKeTK
         +BbguEHyFGfTnEpGH1atu8e3E0LvKRJDWkjkwgUEPXC1VGmuX+j9/BJpwEneLkcWH5D/
         wgq8A4ncwnOA/+xOuHfLxxt9VhVLX9oUdfWFMKIV0b8g1C4gBIBClbHFabaBUYNMiIvg
         7C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNsY3qFCwXQblJPsVdG0LCyrHmw8JZ3ev2jxwT+LE+k=;
        b=RxUbHASqY7Sdnq/yFBUoIugtle2druF+sZHY8hMhQtGzCocqIN4Gbv7VhCWI5hcaav
         v3Fa+EcYO3P485BlIIxFP5BQOH33vdd/luWVn33Myr+9J3Bq8n688Fw/XFJE4DffdYPs
         NqwhRMdomOECsK2pKKP5eYaSeXcqh8QmYtRqm7LIKnY7YGFS5qv4yYlFKBG5FHoXa5St
         N7xgBrdqRct3U+siRyTb1xIrfH1fl+n5wZC4okUrJiIpQZnbWoCHIquA/zHcR/CpDra8
         n6yTJypqvpbSKwsQYlSk4s3+UoHEYjVY1op74X8oG5ushPYV2AA53aDz+QgqQO5xlVEe
         CA5Q==
X-Gm-Message-State: AOAM5304lN7Nizo5ZkFWQKUgQASSK72ymeW7ECzsQF7maqHZPAvjvOcJ
        gIKkAorcw1vWfTZPc4Jm25mg8Q==
X-Google-Smtp-Source: ABdhPJxqCWpvbuwp3Q2VpbEQTmfvZ/vEwaSon3Dgg8K2eunwuY85dxL2dgA71OmAhW/k9YjTGKOZCA==
X-Received: by 2002:a17:907:3e94:b0:6f4:64ad:1e2 with SMTP id hs20-20020a1709073e9400b006f464ad01e2mr3241417ejc.464.1652430700338;
        Fri, 13 May 2022 01:31:40 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eb22-20020a170907281600b006f3ef214e51sm511129ejc.183.2022.05.13.01.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:31:39 -0700 (PDT)
Message-ID: <cded90e2-b060-d144-b20c-cb8fdfcd4a7d@linaro.org>
Date:   Fri, 13 May 2022 10:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nancy.lin@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220512080523.25082-1-rex-bc.chen@mediatek.com>
 <20220512080523.25082-4-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512080523.25082-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 10:05, Rex-BC Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
