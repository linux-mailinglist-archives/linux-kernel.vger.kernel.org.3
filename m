Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AB4C865B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiCAIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiCAIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:21:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72826C935;
        Tue,  1 Mar 2022 00:20:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so7054328wma.4;
        Tue, 01 Mar 2022 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WRV1hdzmbVPmI+jsxWeBooUP3dqnp9gF+cD+vHx37cg=;
        b=lEGyrOVqShVwDCrP9OwQ1wqH3cNhSwBY/RA3nyTHSWosd9CKRn65WtXZkGQIxXOoV2
         3tKXfWL+tYQeBRGzTUeyTWlNqgQsYWUO5hM/p15NNlT7RHT5fJEZfw1k0R7squ4rzMLq
         oLGc7DkzAZ9e1MGlYGb5lkZMcrBTF3ggW7O4mMeZk2FoLk8CVkGWPQ8e8bgUFghAfwYc
         x0LucXz0ANCrW27dz0uKocFaL8UAd0CMQ78/kutKJz9cRPz6Xvq+9XHA2WWiOfYNh0v1
         58rCuFQmNC6WpBqMFTXBPXKPnow9bFSGJ6lRb465rGuqL5lS3Jqd++IYHGNeOQ3t3Bw3
         fELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WRV1hdzmbVPmI+jsxWeBooUP3dqnp9gF+cD+vHx37cg=;
        b=EYHV4ykJAlhjiJt5wN1PYFsupZYom+9wTdYfg8lEgxn+zPU5swHflYrmQnQyyareeo
         r3RVgNxYGoW+fMgytwlk41sLdOsY9qu0jSEIlAkH3uNaIUgF/qCd5fe4tKAhg+V+JC3b
         6FIK5DWwW0236G4RvJhpUSx+BJwkewDKJ0RkU0jk+g8UK/gOEOpb4tpWsloQUL4zd+IQ
         ShiUrTgBL2pB9axdzZ8sE1UyjWPwIrkvMbIaQLJ4+CWo7uoz2jbQpXvZjao8YsimBI+2
         C8nkmZZjeFMIQ5qJo+OmC2ZRaiKau9REEMqxk2WBWrXJcVGKlhXTyDxUQ/NN5SlQf4bZ
         D9yg==
X-Gm-Message-State: AOAM5300m01LF0lxwQyEA9svuLCgjr6YzIdLi3DwyWkw+wX1coHdJbcc
        nx0g/ernP3kjA7uLNfGRqGE=
X-Google-Smtp-Source: ABdhPJyCpmc78vN+pezWK67t1FYNLGkgoN6qM29kWj+87E3PvpdqVAibBMsy8mhmLh6JcdkxKJsYfA==
X-Received: by 2002:a05:600c:1c1c:b0:381:45b4:3f69 with SMTP id j28-20020a05600c1c1c00b0038145b43f69mr11293245wms.86.1646122858205;
        Tue, 01 Mar 2022 00:20:58 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a8-20020a056000100800b001e30ef6f9basm18395498wrx.18.2022.03.01.00.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:20:57 -0800 (PST)
Message-ID: <ea9ce41d-df1e-bec9-1c1d-e132698684ec@gmail.com>
Date:   Tue, 1 Mar 2022 09:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 1/6] dt-bindings: arm: mediatek: mmsys: add support for
 MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220301080105.31323-1-rex-bc.chen@mediatek.com>
 <20220301080105.31323-2-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220301080105.31323-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2022 09:01, Rex-BC Chen wrote:
> Add "mediatek,mt8186-mmsys" to binding document.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!

> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 763c62323a74..b31d90dc9eb4 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -29,6 +29,7 @@ properties:
>                 - mediatek,mt8167-mmsys
>                 - mediatek,mt8173-mmsys
>                 - mediatek,mt8183-mmsys
> +              - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
>                 - mediatek,mt8365-mmsys
>             - const: syscon
