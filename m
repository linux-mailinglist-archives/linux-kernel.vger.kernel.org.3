Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4800A50CD40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiDWTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiDWTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:53:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DD3BFB6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:50:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f17so14166566edt.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6fjTjTPcfDZjkRtfhvn6NsFPWQqOM4LedF+co9scxG0=;
        b=hjd8kcCx3pivEDDrp2IDRrPDoNH+aRW8KquzJNIWY2VmN/etiAQrhLgaSVslvw1T1R
         CqyZ/787AF6zrK9I6IMSWLZ1/rYfdj6Sne30lX2gmtMgQeV6/qZCPYGeIZvvEvDyC6r+
         9tN6HjxWkkY11XjggALQ7f7EJ+jXHxulm7UADyOokXm3PwEHvLl99lAwa16b3uu6raQe
         khi6NChlxMNxkax9JJG053E/8JT/SJoKVN7ribQnXwDeeoxz0HL953m3yOaJU143UjZq
         YblIxrrhe/Jqb1nDIcmOdXsC+Te3n4QGr0Q/ATD7i7YpRcpVZrcU8sL7WIqi422tyzMt
         RjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6fjTjTPcfDZjkRtfhvn6NsFPWQqOM4LedF+co9scxG0=;
        b=izjn3HBakcD1vVZoI6knWSpyAKT/c6NZ9BG4SyjKhmP1CNXsUBE0wAy5UAcD1FjcFv
         oMGq2fp8eoPoBXF/rIk8ape5oFOsMGQKl+oHGBVKV6m66Tteda606Tt+CzSqiLeIBNdk
         Mddjj6F3yea/agvXxjc21pEbosoym0H5rC3GDf0CynwRyyE5MkkBxTt8b9q9bSD4Oyu4
         V35Z/PnQIH2iugO4ygGACg5Ofa1PtiarjR1+crjl5NkNugomS77PqdEapVNr27JXLYr7
         tVGdkv9F/WKoV50XvFWd5nKiIELt/3QB8svVEooBPOcLZA9HIp/i7QxGrXAQEs2vwG2G
         RSmg==
X-Gm-Message-State: AOAM53131Ga7ttlQUA9OqNW3CSUh+Zks0Gc+sOjjAlvsRfn0Iht+zDgT
        CO8h3KQpacDXgJ1zICmKjWBiYA==
X-Google-Smtp-Source: ABdhPJyfHhAc+3mt15wEfwhpPnCDtF/MqjY5igzzGbbebultLJxw+AxdkamvOD854af/fMAhWNJ9iA==
X-Received: by 2002:a50:9985:0:b0:425:c2dd:4cf7 with SMTP id m5-20020a509985000000b00425c2dd4cf7mr8186584edb.19.1650743438811;
        Sat, 23 Apr 2022 12:50:38 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y25-20020a170906915900b006f377b60785sm717862ejw.12.2022.04.23.12.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 12:50:38 -0700 (PDT)
Message-ID: <0c5a6c77-afc6-9314-e238-28fde7eacc85@linaro.org>
Date:   Sat, 23 Apr 2022 21:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] interconnect: qcom: Add SM6350 driver support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220422144021.232993-1-luca.weiss@fairphone.com>
 <20220422144021.232993-4-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422144021.232993-4-luca.weiss@fairphone.com>
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

On 22/04/2022 16:40, Luca Weiss wrote:
> Add a driver that handles the different NoCs found on SM6350, generated
> from the downstream dtb.
> 
> We're exluding ALC, IP0 and all _display nodes. ALC will not be voted
> from the kernel[1] and IP0 is handled by the clk-rpmh driver[2].

(...)

> +
> +static struct qcom_icc_desc sm6350_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
Apply all the changes I did in this set:
https://lore.kernel.org/all/20220412102623.227607-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof
