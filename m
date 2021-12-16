Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E134776E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhLPQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhLPQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:07:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F213C061574;
        Thu, 16 Dec 2021 08:07:22 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k23so39295172lje.1;
        Thu, 16 Dec 2021 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOgP4Q0MS5pImnSQTIGont9oTNeBxvtKf955mAYz/RY=;
        b=mO/bNRXG0+RTO/ybItEyiIbpQWytEzVeRh2Q/4MI2VNIf+DrwqW48H/aDySegPjs3x
         huP3hgeW2fpFiA2AaY9q2shAY9gvbXD/u1CcL3XtxsOPeiLXBPk+TWXooQOFpDXZHciS
         edoV4uDO9Uxj1n8UJAQm+5r6HEJQEOzjVCy0VQMicthuIfae7pClMTRtWk671AJmbL6a
         JXmA+8Eev6+yLJKccJLQ49XBq8N+MgAxeu8+pp569+tseQwtJrB0vE6IiWx/NPwYowmV
         B5q7JTzoxDIHaAMF09bGdRvPHiegBScXqe5HnWvGPiZnc/Cq6G62k0Td/bxJT4fEdVQa
         p9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOgP4Q0MS5pImnSQTIGont9oTNeBxvtKf955mAYz/RY=;
        b=vGlCd9Rhk0vvdDoNlAjH45gyNL5Jqy+MavRv9RcAw1Xrb0fMPG/5u2oFsyJHVvjYyU
         yM1Yk43yfprRldoum1M012+RJnPxh5o0njSDrKXbeT/HgpmNrHB6u57VmK26St93ArSN
         0crn4HLKHkMlzfQgaiIuvTl8FjzPjbhryz6NtFeDZRc/aEUrAof0RR+cJB10l5/IaNJ5
         RBY/1g7dyk4HY7BxLeRmvVVupWkc4jz12LZrwL4nZEpWcqtOMxYbVUazT+LYQhTI0fPG
         24wF4T+soqPBZ4dywlrzw951XafoQLj8OMcoPUv36DdWKHAs1xO6jnpYKN6ycW3g2bmV
         9K6g==
X-Gm-Message-State: AOAM531H/eu+xdJqLjhpISbIs7RqTebWwS6cWPDEXmsXuYzWnxKhBtWc
        Ny4pNr/koncpCy9e3giBFqbLdi/L8So=
X-Google-Smtp-Source: ABdhPJyKZHnVDuXQoo4x5waxnM20Tpj5I+Lw2AfKI8XqZCi/GZbnt/+slbF1J3HFIj/PcvtGiqfuXQ==
X-Received: by 2002:a2e:a409:: with SMTP id p9mr15940699ljn.412.1639670840394;
        Thu, 16 Dec 2021 08:07:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id f19sm934794lfm.119.2021.12.16.08.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:07:20 -0800 (PST)
Subject: Re: [PATCH v1] dt-bindings: sound: tegra-audio-rt5677: Correct
 example
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211216160229.17049-1-digetx@gmail.com>
Message-ID: <df97dc4f-175f-738b-1670-303113dd58c7@gmail.com>
Date:   Thu, 16 Dec 2021 19:07:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216160229.17049-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2021 19:02, Dmitry Osipenko пишет:
> Remove non-existent properties from the example of the binding. These
> properties were borrower from the old txt binding, but they were never
> used in practice and aren't documented in the new binding. They aren't
> reported by the binding checker because dtschema needs extra patch that
> hasn't been upstreamed yet to make unevaluatedProperties work properly.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml   | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
> index 03ff691c26c8..a49997d6028b 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
> @@ -92,9 +92,6 @@ examples:
>          nvidia,audio-codec = <&rt5677>;
>  
>          nvidia,hp-det-gpios = <&gpio 143 0>;
> -        nvidia,mic-present-gpios = <&gpio 132 1>;
> -        nvidia,hp-en-gpios = <&rt5677 1 0>;
> -        nvidia,dmic-clk-en-gpios = <&rt5677 2 1>;
>  
>          clocks = <&clk 216>,
>                   <&clk 217>,
> 

Interestingly, I can't find any Tegra device-tree that uses this rt5677
binding. Maybe we should remove it?
