Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13653EE44
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiFFTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiFFTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:01:23 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A012ABB;
        Mon,  6 Jun 2022 12:01:22 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id a15so12569054ilq.12;
        Mon, 06 Jun 2022 12:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKZQYNrDOxXCRBlNMtzBiVV2S8AIodJot0qZ8ycf9Ok=;
        b=xMCz8rFg3RNv/j34zo4lF0rBeB0FuRISrVJPytgOOigeWBM1GnkydpRCXtP1PfqEob
         eMQrtU0rn1dXAdzcJIueuG/Mz7rO+Ea25XbvoMSScCd3+nux5U9vMErLZKkscJxYQMni
         xhH+u2O0Vc5it+FCkfQoWbeh2X0buBzkTYmoMBik76C5a8wStZkg4n6VbfrIGy9+anna
         0RApmxlau6Ds49jCwUkl3b9QajC22WmNnus2+HU2RcxwvHEamympn7nuRBeJFcmOUX1D
         v5Z5i7NuZeaRcJM0G6lHdZoQW3ZzwogutnxV4jaghCtQsu5yVaYmQWyI43J1V660Rmsg
         avgw==
X-Gm-Message-State: AOAM5331voJqZ6OSARpdNR6BP0V7omsx7zcx2SV6ih0HbK8xxQyyq2n6
        t5jUGCPHiD8zNTPr8n4XXQ==
X-Google-Smtp-Source: ABdhPJzpQz/1nOM9wT3g7ZzbcxPJegjARM+cjtT8oUV8k03IpH0rsSgzLs5/60arlMg4vsoy9b9Jwg==
X-Received: by 2002:a05:6e02:1905:b0:2d3:d327:6c7b with SMTP id w5-20020a056e02190500b002d3d3276c7bmr14518421ilu.101.1654542081325;
        Mon, 06 Jun 2022 12:01:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a5-20020a02a005000000b0032e9bf3b973sm5926757jah.5.2022.06.06.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:01:21 -0700 (PDT)
Received: (nullmailer pid 1083302 invoked by uid 1000);
        Mon, 06 Jun 2022 19:01:19 -0000
Date:   Mon, 6 Jun 2022 14:01:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 22/23] ASoC: wm8731: update wlf,wm8731.yaml reference
Message-ID: <20220606190119.GA1083268-robh@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
 <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jun 2022 16:25:44 +0100, Mauro Carvalho Chehab wrote:
> Changeset 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> renamed: Documentation/devicetree/bindings/sound/wm8731.txt
> to: Documentation/devicetree/bindings/sound/wlf,wm8731.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/
> 
>  .../devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
