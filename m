Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8655FA87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiF2I35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiF2I34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:29:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6435DE7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:29:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ge10so31034581ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hO64UUQSBmd2pGDhWcTf3FCJdGuY3sVi+fiDX10ylYU=;
        b=G8hrSK1msK0ubzz6iOTKDNcp3A09rIBJqEs6JpvwWHnpzPXaLiJ7KCu57BBwAJv/9k
         1Je0u9KFaSauDIEgTSnIzj2H7hjOJallDjUs0yJe1dOeIx1T2ZmHurIvNbvweeogDrJ4
         snY3u9nrQW/h9ngYu4eYSmY46OhN+W7SfaqJau4iOFeQb3ZC/Xx4fyO2kS9f70lK2486
         co5MGqg/3tmcvlo4qguJlewf/Nes+1V1Hl9cJZ/wO3MjxQ//AxddvhpTBrT4z7veDw8u
         AsDBmN4Redi4A7O/nHmX3GNG8g/e6GYgf+lIda0K4FEXi25BrySIfuZ7GwDglY2GmjzF
         0nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hO64UUQSBmd2pGDhWcTf3FCJdGuY3sVi+fiDX10ylYU=;
        b=1NUQCOdJuJPTrtM0za/g6q0PWe0aZiAOC9MOlW4NVxc/ETC9x1lHl5BOnMt8bPfF9L
         XbccDra4Fd8SXV6Ws82iO7tyL0ZsYuPvzp+2aLi7CXHj7u6jDHPBhUNhrpnYQ1A70U98
         ir5pWAp2rPNJ/TVCF0nMAS7/5sTWGVZyiQsvQMHXRaUmnXInqHV/QOlVCPn+6t6I3mkh
         xHio3dXMMSxLHN6z4Ta1wQrXSCFTACuJ/x81psPWRCLEIfabGFwXsdtk42DGfd3VaF5I
         Kdgu0WjDTyZdjvlwZ0ifGrSmRY6STaImEFxnXopB4N4ikagM34LrwJXJupI5kqtvfsaH
         pP4A==
X-Gm-Message-State: AJIora/jr7ek4/S6DeN42XiyrV+FuFyup/+StQWZcvg3ALDBhfOf8c6S
        LdV0CC8zr3hwKrI+91q4Nalfhw==
X-Google-Smtp-Source: AGRyM1tLM0faLoxLu+OR0ALMIdlWxQdPJ+9mClKlcofNOKro3rqKXbHWjtrdN61k4jlPsCk+pevyOw==
X-Received: by 2002:a17:907:1de1:b0:72a:3216:96bc with SMTP id og33-20020a1709071de100b0072a321696bcmr1278028ejc.3.1656491393683;
        Wed, 29 Jun 2022 01:29:53 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7d8d9000000b004356c18b2b9sm10961144eds.44.2022.06.29.01.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:29:52 -0700 (PDT)
Message-ID: <c1c24c84-a33a-cb43-214f-0970f1948c34@linaro.org>
Date:   Wed, 29 Jun 2022 10:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 RESEND 4/7] dt-bindings: leds: is31fl319x: Document
 variants specificities
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht
References: <20220628182147.2837180-1-vincent.knecht@mailoo.org>
 <20220628182147.2837180-5-vincent.knecht@mailoo.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628182147.2837180-5-vincent.knecht@mailoo.org>
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

On 28/06/2022 20:21, Vincent Knecht wrote:
> Add conditionals depending on compatibles to document variants specs:
> - possible reg addresses
> - whether audio-gain-db is supported or not
> - maximum number of leds
> - led-max-microamp values

This should be squashed with patch #2. You document new variants with
their constraints. At least the constraints respective to these newly
added variants.


Best regards,
Krzysztof
