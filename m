Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC14CE64F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiCERod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 12:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCERo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 12:44:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E620C2EB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 09:43:39 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 045693F61F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646502216;
        bh=WA79imcrFseqVS1ZTUJxkEP0srNHgX016w3iNaOE7Z8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ABb5C+7PUmNBvA5jrxfCGPVHWOYZ0WTMnEDnUYgGZVzgvt49rvli6km5OUPMMi1Kg
         5yyE8YbsPgTqlVYRaLwPrYYe36KDHTeSssFMNYR4y/CbEdQNY5Pi2QXgk0jcAckEZB
         smKkqissJrXsBgfRWfDkoCoXsvjVRfLlAc3nY235LlabRciJXtBk2ssxhg1slcXeFU
         K17dVlXZ7SqQRA367s0YkdrVDQg4HmXTMwUFxz8QaET1TNm9XuxiG4qI96Q+h2pCOk
         dtPeo2JCis+rvyWZHFzaiQt3QmtWjKDyx37UBBMpitfIucZMhTJwgf88T/6T9LSUyQ
         mdsK5QdCcLaeQ==
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso5930038edc.16
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 09:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WA79imcrFseqVS1ZTUJxkEP0srNHgX016w3iNaOE7Z8=;
        b=PNfQDkXzT1JBmhHUTdrPziobMSiqZQzOIpkP3a/slQze8wXpDgxyMdO7gvCi/BtVQs
         CYuvrb3HJigs6vkg1m4QGLOZzQ4RYTvdVQaVqMl2f6ytCnEKDUhlaAy7NH6QI8O3jmny
         YiLcqSBPrHnzW0Pr6t6A0EIukjVmcsskC0X801rSSX264sQVKYfAk90Cc2+pXbrmgpc9
         Au7wfVRdI3JBkADWBqZpcfEQq8Tdoul9SG9xdE18CQZglkePaJViE3gw/FE/fOt4cRzP
         +sEcDwNrc8Ya7MTfSPG0q/LnUJABlF6NGXfMSQsZIpIwaLpkhoRZBtaEQmgkqlaGgBc5
         YxVg==
X-Gm-Message-State: AOAM532aMiNmXxrM/ZTOKz8CbUrFxvpePghw+ocXj8Ym3OwVbHV5aPW9
        nu/e5de163nzur/sL2v8JI1PGoi8LzWjklSMl0zhKadtU72fqLjLkMXJsZmKI9wDt2uAHLWfrVs
        bbaf4s5aSr/ygu4UrG3Xf9MKpLx1LiMsNAlmOeJgiNw==
X-Received: by 2002:a17:906:2ad5:b0:6cf:9cca:d9db with SMTP id m21-20020a1709062ad500b006cf9ccad9dbmr3386008eje.252.1646502215376;
        Sat, 05 Mar 2022 09:43:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIoUZqNCcsdZ2Op7qGi5D5yjHkt6TIjLgpzimg5j17lHULbjvbmu/5AWjYb7Q0rRjqNiVaDQ==
X-Received: by 2002:a17:906:2ad5:b0:6cf:9cca:d9db with SMTP id m21-20020a1709062ad500b006cf9ccad9dbmr3385999eje.252.1646502215198;
        Sat, 05 Mar 2022 09:43:35 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm2441837edb.47.2022.03.05.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 09:43:34 -0800 (PST)
Message-ID: <8255610f-82a8-80f1-8f63-88c7f944303e@canonical.com>
Date:   Sat, 5 Mar 2022 18:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 4/5] dt-bindings: ata: ahci-platform: Add
 rk3568-dwc3-ahci compatible
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220305112607.257734-1-linux@fw-web.de>
 <20220305112607.257734-5-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220305112607.257734-5-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2022 12:26, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add SoC specific compatible for rk3568 ahci controller
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
