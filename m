Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC6B4D0739
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiCGTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiCGTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:06:18 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781856E56C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:05:22 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C7F23F60B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679921;
        bh=QWsOEJGQTvGYoXGyvS888p4a2khm68f4hn/XfD0htMc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ETWPDv5W3PyPPxol60CCa6adHNxluQSgMWtUnqyGhPnFlg0Nvi0aObrTfzUUlIuYH
         k3uSet0kduoz8d8jWhqtfE5wz1/jpixC9B+h0F0LcKSIBXfWX/AEGXWHgt78k4XQgH
         aGwA4u/7+sC205SYuz3M+XX9yaAtaJe7G9GVx0tKbmBgAkSMUu3MfeOS2PpXmOoGzw
         7up1twsmQQWGRl7gtJ7A8x1fWeJOoD1YO9YQIXPeEE/bMbq2C50IkYG1KFDQWB9DGN
         ZujSEXHI3j7ye1jWn5hkEqPo36XfQfcUKvp98NkyXMYilPRAPTLcZ/7KijON6Iz0Dw
         7cDr4jbEwFCDA==
Received: by mail-ed1-f70.google.com with SMTP id e10-20020a056402190a00b00410f20467abso9162651edz.14
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QWsOEJGQTvGYoXGyvS888p4a2khm68f4hn/XfD0htMc=;
        b=Nxu5aoPoS9HrlWPbc97li9uNEzpjlfU+ylWZYw12+8FTcB0FYxqtdfXkeq4JYSwvNd
         +8m5LA40bHMDsvZ0dS5IEts3/iLdQ3ZYzPo0MriO4VLfDUBFnkKBvKcpWqlv6jO0SBBI
         A/YskD6X2kseoB4iQvYn8Vm2VpPKdK/2F8yUEHKLRd43LADtnq87MzYa7g6d9UrHSXBN
         oJc17UwqI2esGKZIfTyhnhobjFfaZb+dOSy7cY7RvnHFMgUI/nPdZ/zuYOxlcSw9eu7A
         /SSa7F8c3/4e1pqSIww5qvZPhwuuO1b5G33+ehW/LRY5uDaGBrekBxdEoSwvMvrM4s6w
         PtBg==
X-Gm-Message-State: AOAM530N+wv9Al9JVcdCMu9WBo5YQ/b7payzl4LdvCcUzmeW20lEwYxz
        eDXwOa9dbXgSgolXQuju6rrvCPe3XDIuWKkevmu660bn+oY+oEd9sBzCGYafwWpCADDTQpPKMVV
        NUDwJZsFYCgnjAbJOFv6MrIZKrxcZ0/8fEDjXoIxLTQ==
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id nd14-20020a170907628e00b006d9c6fa6168mr10459589ejc.132.1646679920953;
        Mon, 07 Mar 2022 11:05:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyN0g0OSLGsRnPf1kRRnBUK5x+6sKF/QCqmI95yBIUFncnGeYZVE8vPiyRQJceikpOJJA+6Q==
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id nd14-20020a170907628e00b006d9c6fa6168mr10459566ejc.132.1646679920623;
        Mon, 07 Mar 2022 11:05:20 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id go18-20020a1709070d9200b006d650ff4b26sm4995906ejc.209.2022.03.07.11.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:05:20 -0800 (PST)
Message-ID: <7dedd97f-db81-4e72-861b-cf342170b65d@canonical.com>
Date:   Mon, 7 Mar 2022 20:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/6] ASoC: dt-bindings: Document Microchip's PDMC
Content-Language: en-US
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lars@metafoo.de, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, nicolas.ferre@microchip.com
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-3-codrin.ciubotariu@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122202.2251639-3-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 13:21, Codrin Ciubotariu wrote:
> Add DT bindings for the new Microchip PDMC embedded in sama7g5 SoCs.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v3:
>  - set line length to 80 characters long
>  - set 'reg' as the second property
> 
> Changes in v2:
>  - renamed patch from 'ASoC: add DT bindings for Microchip PDMC' to
>    'ASoC: dt-bindings: Document Microchip's PDMC';
>  - renamed yaml file from 'mchp,pdmc.yaml' to 'microchip,pdmc.yaml';
>  - used imperative mode in commit description;
>  - renamed mchp,pdmc.h to microchip,pdmc.h;
>  - fixed 'title' to represent HW;
>  - made 'compatible' first property;
>  - s/microhpone/microphone
>  - none name in example set to 'sound'
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
