Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE250C937
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiDWKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiDWKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:31:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDE1C048C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:28:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u15so20703764ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2m9kAORld4iDB2KAPLh1iCsQe8VM2IonNBmHniXB+aI=;
        b=abL3ZQ0jUA/UmIqEWJnORrPPfRhiBNtkKHGmN2VHZBZ4eLUI57QXL2YeGyD/UWdmw4
         /PvZ6PoNwnmTYaJhZq7ClQMH2dHTn/quieJqvwegOB2EjRvWzvU8Sa4LJ629A3GG8pcE
         vnwTF8Qc4+JhGtJ1LhWoHlORilVZ5qrChcfnsAlm/ddCPaRJ7tr8PATd6D8MqrnyE9P/
         nYB0KB3NpBJXZWsCop8opcKElkfJxWNFgi2bvFFptKKE5qlpMhtor6zB6I1WiVUfgah7
         451fMAWKE/vZvmly83beGV8CKvg5zZznrCim5huFff5u/7y8JeqMtuEgHz3DgynT0doo
         XdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2m9kAORld4iDB2KAPLh1iCsQe8VM2IonNBmHniXB+aI=;
        b=BCuU6GNsD+1qSlf0yLQrL6VN+BMIpvQFEVpXE3PtgYXQOsF5pj708deurLEPTsF9Cp
         GFDi07M66U188RhhTdMatCXbmmqTkbNi5UclA8EeQq/4athR8zd2UiuVKis9KnS9FJUb
         HC3VQQMpwbL8C9irjXSaAptPCIVTOwzir5LlAQvV4W6LxqhVmqIISBlgnI1qToRLn1xO
         RusidKEkj/QLfLxEmr8cN/dTvF1xSzAYoBu1CYdlhFUh/BY5A+i94lsL7qRaXRESX6GR
         9bubQ8jLadTkYsBPfAlCZGpV/yIlIytoV8WkOuyiF3LggNNEo9nbEXDumL+ma9NXYp+m
         E8PA==
X-Gm-Message-State: AOAM53214Cxxb4iT3QN4Xr3ItoLYfhEhiV3SNWu1ms5b47CkzEl/amPJ
        z8eAd0bqlccO2dVzvxoMmHPfag==
X-Google-Smtp-Source: ABdhPJzNLgOfjlkn71D3XLc+z6mdb8U6FtuDFVeolu/miVVPX/dSL5gctTkJCIyZlGTqP6JpYcLBqg==
X-Received: by 2002:a17:907:ea8:b0:6f3:72ef:2397 with SMTP id ho40-20020a1709070ea800b006f372ef2397mr2184159ejc.201.1650709737125;
        Sat, 23 Apr 2022 03:28:57 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906380a00b006a68610908asm1558632ejc.24.2022.04.23.03.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:28:56 -0700 (PDT)
Message-ID: <00448326-7bee-8cf4-5751-d967bc424aea@linaro.org>
Date:   Sat, 23 Apr 2022 12:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 13/17] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8195-sys-clock
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-14-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422060152.13534-14-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 08:01, Rex-BC Chen wrote:
> We will use the infra_ao reset which is defined in mt8195-sys-clock.
> The maximum value of reset-cells is 2. Therefore, we add this patch to
> define it.

Same comments as your other reset patch.

Best regards,
Krzysztof
