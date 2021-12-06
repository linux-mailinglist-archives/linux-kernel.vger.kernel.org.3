Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D92146A0C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377585AbhLFQM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445667AbhLFQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:12:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F262C061D5E;
        Mon,  6 Dec 2021 07:52:03 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n12so26477341lfe.1;
        Mon, 06 Dec 2021 07:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fEMojyByZKUtRCcQzpUJpCVqQCOhDunaiwYMZcnbsWE=;
        b=Hsb0CUqM6QRshRAXrb1ckDgRx9MUZDEvSpa/XN3Xs1buHjZHl+5RA9uDhH4bmMhWAY
         WGS1I8pWcSRkn9ZpjLhCpMU1pRjqEtc6CWgU5pDyiwJqWp7hpAezzm80UWhArsI9ri2L
         93OFkxlj4yQpUNiVqiob5dyC0uoOU/JOm5S5pFlRcntllPjfVY7dUB3+7a/2dBiJnW+Y
         1LxMFh9OOBOMP0VX5vZbtYVxcBSzxV0gcoB9AmiNVvjvtBLWykE2//FoiJHpfnzR4uKv
         uLZJm2rQtYCQCmCgykd68n1l2GY3xNouFCxBJFOfkLjprKdJcWQMf26hZe1oJ2mioAVS
         Ks8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEMojyByZKUtRCcQzpUJpCVqQCOhDunaiwYMZcnbsWE=;
        b=jCn8vxx6opxGGkr5bn7u4MjQ7hZuwayOVeM/GFQnV2hwYGDrXAm4oMxKrd9Q2PtitC
         GuWNeVEnTeACWv95xb7tqabaNuA/e4RTbr19Bkb7QtpJ+g02Fc9bGPNzMXa0rdSNXGKW
         GJQp+xqFOH/g2iPhSWwdWkvJDnI6PGAZ/qkrkk/Vf/ALi1y+IKPJtagFXD6He7I8aNlf
         X2VoDAyTVDRJSwPbvu4YxOPV1GpM9j/WXGhoWMm+eVLJyjiCYx7iGrlhPpA/Sc0mqq/9
         Oki+G3xA9mNR3GohwqLrMhkJxGAyafhZL48F2Ihh/Q0Xuj/acRyiDtm5UrnKPLEfOhjB
         LlGQ==
X-Gm-Message-State: AOAM5300utM9115H/XJyQBec8Mvbd5UNjC1jgKYZCQwCCm1qkMtwLnjO
        m89UuzXxBP//7vDSZa+REbHFDNUY3k8=
X-Google-Smtp-Source: ABdhPJxn7X8g1FUQ3Iwk9mTEpSBwHa5RQVawua6/r6PtpT48+HrVktNKa5A/dwK/CVygBRWq1HLvrw==
X-Received: by 2002:a05:6512:1324:: with SMTP id x36mr34929032lfu.495.1638805921586;
        Mon, 06 Dec 2021 07:52:01 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id x6sm1388287lfe.201.2021.12.06.07.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 07:52:01 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: regulators: Document Tegra regulator
 coupling in json-schema
To:     Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211206154032.227938-1-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c5e397e-d3c5-274e-b6d1-b44cabc06128@gmail.com>
Date:   Mon, 6 Dec 2021 18:52:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206154032.227938-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.12.2021 18:40, Thierry Reding пишет:
> +  nvidia,tegra-core-regulator:
> +    $ref: "/schemas/types.yaml#/definitions/flag"
> +    description: if present, designates the regulator as the "CORE domain" voltage regulator
> +
> +  nvidia,tegra-rtc-regulator:
> +    $ref: "/schemas/types.yaml#/definitions/flag"
> +    description: if present, designates the regulator as the "RTC domain" voltage regulator
> +
> +  nvidia,tegra-cpu-regulator:
> +    $ref: "/schemas/types.yaml#/definitions/flag"
> +    description: if present, designates the regulator as the "CPU domain" voltage regulator

What is the difference between "boolean" and
"/schemas/types.yaml#/definitions/flag"?
