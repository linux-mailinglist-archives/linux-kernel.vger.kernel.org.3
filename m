Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018E158243A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiG0K0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiG0K0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:26:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E053E74F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:26:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t1so26426455lft.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z33rM/h/GlDJMPaTzwReos/+8Z/HNYbQEZfYG6DUeSU=;
        b=fgebQcKdw/6LPwbhDVieKfEk9ZXG4yQLpXIdRfYG+Z5tRiOjTWbfrCwl8KTrNr6Myx
         TZWe2LK1bwwL5Ky7WiEpPMf2yG9JlOY0yc100LEFaLna4xgFVoe+MXLkm1Twh+lviVTi
         qfXrqMTkDTX5lHGeSA1/4lRRjIWCzbMX0LD1IZnd6G4a2CAGFOreLDh8ZM5vjM25a6kB
         dH5H3J0oPpVdeB2CKxKMBdcGelcN3vtnuV7bIm7P8KJNHnvxEJp2AcO1WAMgTw1Cifmo
         CmiVNplBlXOgpzOmM+Wlsum/AMmyEVzAmPxWfBTFYv5cm24MgS4krICxRrCjcYlUFcxb
         M7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z33rM/h/GlDJMPaTzwReos/+8Z/HNYbQEZfYG6DUeSU=;
        b=kxg7Er8uPeCGCQJMARFMkrO5VFGj5V+F4LLmzwn9fnc2PE17iBcPv6h8492b+5ayt7
         eg4yyhTiIeJEwIvUvqWODB8LPmIZI2uI5tQKNng5zEgYnoUWR8IyFIhnDXYsmoJCtcEx
         giRUo49lbzYMQPdkyeX5bG/7POCOIq6Ib0909HMxAaL382DwMiu2YEh7OHOqUN34B4Rl
         j8Pi94egjxaDB5oQ08g6gwokpgY1EEV2jVB2J3yoxCohBtXIrscUfGR04/5/BVlHpEvA
         8NFdQD2+DyMBZmA7BLHcZozSELlyYpWpXIfBpNzTYxgUZaUu8/FkScIHhCFv3LG1vMVu
         kndA==
X-Gm-Message-State: AJIora9svSeEIAYlujz/+8yB6toUeMr0NiegDUhGibNZt8mUmz181LTF
        ZA3jf6RBBnjptYRMcwXp5+GpEw==
X-Google-Smtp-Source: AGRyM1uzvrmok+B71SjJ0xUan/RKfTaBGV1waMaJriK6Oe72/2/Wan5P+Xay5aCki1HX5CUSZUfxzw==
X-Received: by 2002:a05:6512:1048:b0:489:ddda:d2a3 with SMTP id c8-20020a056512104800b00489dddad2a3mr8303696lfb.57.1658917602712;
        Wed, 27 Jul 2022 03:26:42 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e9d43000000b0025d83984893sm3680646ljj.68.2022.07.27.03.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:26:42 -0700 (PDT)
Message-ID: <a7230c4d-94dc-c0fb-e39b-50de971da511@linaro.org>
Date:   Wed, 27 Jul 2022 12:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: spmi: add compatible for mt8188
Content-Language: en-US
To:     Sen Chu <sen.chu@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Hui Liu <hui.liu@mediatek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220726103729.24525-1-sen.chu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726103729.24525-1-sen.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 12:37, Sen Chu wrote:
> Add dt-binding documentation of spmi for Mediatek MT8188 SoC platform.
> 
> Signed-off-by: Sen Chu <sen.chu@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
