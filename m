Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16475163DC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbiEAKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbiEAKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:51:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366FE3BFAD
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:47:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g20so13700552edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zZDvps19lTsjs3/du8HCOXvX5yBRInDpxD+6Q75q+Q0=;
        b=NIfHYLhx1GXMV6BN+JqI6crKL6q/qDhpxGOiHECiCuY8tYyirqtQP6PPcMKv9bXDJb
         EWS/tx1PuhjSCjPm7r3DlHWanYY+NSG6xmZxznpLj9j/0ek3zlV/HIzC/Y5bgX7IoIs/
         oZIT0XkGK4l3aJI+/w0E0BEK9Nb4WryS8IBassS3VaAoI6mf6TkrBNIYkb/n/rH4hX1B
         oCll9aDteNigR51XnkhLpdYCbDhd18/6Gc5R0rkFqU30CEzmVxGd97etPd1yPGQAM83i
         OPGr5h8iVQ+tmRMJNyIBkjq8CphbSjI2vrORtzMEdomvgz5x2pb5cS3X/TE0QtGuhxwE
         aQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zZDvps19lTsjs3/du8HCOXvX5yBRInDpxD+6Q75q+Q0=;
        b=RsRXOGpmo6Wn370jrPVc8NnZ/Uc2lQb2BSOXp/jLzuNi7+ccnzFdjLY4G5s78ghuqE
         pqrtV5It4hpSgn4e0nhg44p1t8SjSibBm7uCAj+YYFY3+kNc/DYtH89kTEoH1V1OBufH
         PHlVDXWJk/SH7OGodlUsISHX+Thyy2Suijkv56rjiDC079ydG0rhikmOYDKzT+zc5B0f
         4nBh6RWbK7Vg0SP7VL6RE2K7nCXNzogejeedAWtiwte7275DXDkAuUuImmNMGUd8LkIU
         BVYlj6lib+c1P/yH6tEx9ve5w1QYSijn/XgfqQ7zq4wBL9BLJXzSYkCYVwE/wDxPKyxU
         TBUA==
X-Gm-Message-State: AOAM530EAyMRyzQDYrn82wqR69vZ+dnJFUujFxQ3nRzHXe/QUnBFoJPk
        HUE9G8al+Hp5CVj6ZDsYPTKuYg==
X-Google-Smtp-Source: ABdhPJyMkcCOCw3l7YDl4BFMA/bMxqLZYwwd2T9wW+Vr8ZRkTY7Bp5siolxMqUw5cQCqJnl+Sp/ENw==
X-Received: by 2002:aa7:d4d4:0:b0:427:5f6:c5d0 with SMTP id t20-20020aa7d4d4000000b0042705f6c5d0mr8023105edr.207.1651402066798;
        Sun, 01 May 2022 03:47:46 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm5262256edv.49.2022.05.01.03.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 03:47:46 -0700 (PDT)
Message-ID: <74d9189a-6c15-61c0-19d2-beadb9e2cc61@linaro.org>
Date:   Sun, 1 May 2022 12:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] dt-bindings: arm: mediatek: mmsys: refine power and
 gce properties
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Cellopoint <cellopoint.kai@gmail.com>
References: <20220501090117.19557-1-jason-jh.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501090117.19557-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 11:01, Jason-JH.Lin wrote:
> Power:
>   Refine description and add item number for power-domains property.
> 
> GCE:
>   Refine description and add item number for mboxes property and
>   mediatek,gce-client-reg property.
> 
> Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power and gce properties")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
> Change in v3:
>   Add maxItems condition for mboxes property.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
