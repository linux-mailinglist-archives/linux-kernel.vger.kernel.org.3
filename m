Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD952BD39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiERNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbiERNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:10:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BC1AB794
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:10:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o22so2454908ljp.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+b2kJbCQjxe7fZUbjqvLH/wJyCAU5HIJ3JzBSgXlc2g=;
        b=gDbsIUdII1wcs2EpKhTuW28O+P8cdc+sO8YSXKIAWpvpnedMSMgyr3RgkAAk/DVvht
         DsyXJ/jT8HQfq7B9CeoMrpIX8KMQgm8TUl0UqaMhmu8W8+EGj3J1+s5Rn6PN8rAGv2K0
         HNjXPq9JQev89Eko1cdiqxmefanGPoBgDjLwhn/WTXlDO6Fm3tJJvikqeUwkfUCuU85+
         /58tJF0mMQknDYAfbPtpV/KSZt72teOI9xPgRGIExddQwUpBndzoC+BLjFLfuwJvCPOT
         /xELk94+zE/s66lxdlvxt6vTrY5zW9m9ADpO7Tlw43FyHTOmwg3zvTfG0bZ5kQIHt+Od
         M4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+b2kJbCQjxe7fZUbjqvLH/wJyCAU5HIJ3JzBSgXlc2g=;
        b=CdgPye28I25BzVghUi1U26a0UgjtXeBh/WP9unpsRf2rVZWjMMzzPJx0F0YQAMXp40
         dzNxPuLA2iQSnKUg8ij3uhlR6ndEQ6yPCWuVYIq0IdRGIWVr41j64mETCrvvCg/vo9fU
         NOqBHX+spn+O71d61X5wVQmOPUs7yEixLo1Ah17DPcHC+9TN24PO0gmK0kydHAx93LrW
         H1bX1kbdb5fHSwAbWZWgU6DOyHTnnIFQbeNdZ2SwoJQBc/TpLWr+rcH/uuNM55IFd3PN
         iQrnlSXX7GbYnCQIfPgUit/X2aPAHspnocetziBiKdAX1aD0a5QOM2FKulNyoDrYKjcG
         /new==
X-Gm-Message-State: AOAM531dqkAcfNxEg5mvseu8uKLK/ymg7y28zd2WkCGuChdq6aMlbhgh
        vksa75Xpt6I/O+aIVFLmQImeuA==
X-Google-Smtp-Source: ABdhPJw3ZZEz0IO+p8W0PuSOZYSbEkgk1HzwIbid4bAjfiWrs8DO4UHAy0Em3/ZaTfECsrR9kKjSRw==
X-Received: by 2002:a2e:a80a:0:b0:24f:3010:8114 with SMTP id l10-20020a2ea80a000000b0024f30108114mr17569964ljq.95.1652879423874;
        Wed, 18 May 2022 06:10:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020a2eb4ac000000b00250749dab23sm211926ljm.99.2022.05.18.06.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 06:10:23 -0700 (PDT)
Message-ID: <511ca90b-6c82-440f-0363-03ca4a0989e9@linaro.org>
Date:   Wed, 18 May 2022 15:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/6] dt-bindings: regulator: qcom,spmi-regulator: add
 PMP8074 PMIC
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220517205341.536587-1-robimarko@gmail.com>
 <20220517205341.536587-3-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517205341.536587-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 22:53, Robert Marko wrote:
> Document the PMP8074 PMIC compatible.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v3:
> * Add supply matching


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
