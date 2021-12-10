Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7797470580
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhLJQYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhLJQYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:24:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF72C061746;
        Fri, 10 Dec 2021 08:21:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so7190764lfu.1;
        Fri, 10 Dec 2021 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQ3hR815wxY8d2C2vTh6hx28ByOwjqQnUNIo+IqY3Jc=;
        b=TuUDXVSnZEFVgo6qAiyWR8SLp9STIAdrqdg2cGFG1SmHSBgA2OEyPCpvtnNtkROsw2
         /yZS7W8INF9eADa6GA0LXg6AaB7aBXPFtp1FgOHbu0RncUxgi/ZpgJPF6OavpwSZxUwA
         hXYiyDk18k/ZhFYXiSCVU9btCySiNQ0gP8vRvylDgMawONJ2nQc3rh6HkN1ieb+iHQIk
         5jnBZSw7GpcYQAWdUjrTnuQoLWJ90Q3R8JD0C+Xx4Q3XPco+AurDOD5iC9XHX1u0QL9S
         rxSedfNCYljvCoduUMGLo3hDXnUVuyrxr242ZRqDducKUHRgOj3J9tvPPF8Ry1PwJ6Wq
         JoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQ3hR815wxY8d2C2vTh6hx28ByOwjqQnUNIo+IqY3Jc=;
        b=nrWXJj1fDxLdiwvwWEwwfa8XfPMwHwCuvbA+zmNtMIcHrVIcrrHjzk0V1MLSvu7ISi
         QwzPgvIXFTrkl9f+kh5tVQoS1nmVvAKuKcAAyJsv48rRl9vUvZhSJYxO68if7IFsF6bx
         ic7/lyElvfOpWSQMm5YbE8ee2+cDXB1dYkhQVVhtTIIo14cyACkwT1wH1R9cC6FERwZo
         EpCXP4qscW02yYyO1UpA0OHSXsz0Q0Wdl9RNl6XNgn2Rr6VRv2uK6vJ7DoN3MimJl+dB
         sWd5xm0ZqFxviG9qlSitgPJCeoOo/qBlMEHwNGRoTheQ5AP2erOeDhdXmN4IjBKglK+E
         a7+g==
X-Gm-Message-State: AOAM530hXyFj1wayRHHDJxQWABtWBbAw3lrdSjuto/KbivrH8HgsAKw4
        oRw0kt/izjF5nGp9D/VnIcnIlaLQ18w=
X-Google-Smtp-Source: ABdhPJzm4ZQxiA0uKpXl1sGoGIifDEXXivAIck6/Cs3f0CLOZFpWrJD8KQW9LBCRGfwlIF7ikZU+iQ==
X-Received: by 2002:a05:6512:1520:: with SMTP id bq32mr13552431lfb.232.1639153257751;
        Fri, 10 Dec 2021 08:20:57 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id d11sm349867lfq.303.2021.12.10.08.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:20:57 -0800 (PST)
Subject: Re: [PATCH v5 02/24] dt-bindings: ARM: tegra: Document Pegatron
 Chagall
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-3-digetx@gmail.com> <YbNv8fBpMRTIGZQh@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5eedbd5e-6300-7c84-a7af-ace83ed8f1cc@gmail.com>
Date:   Fri, 10 Dec 2021 19:20:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbNv8fBpMRTIGZQh@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 18:19, Thierry Reding пишет:
> On Wed, Dec 08, 2021 at 08:35:47PM +0300, Dmitry Osipenko wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> Document Pegatron Chagall, which is Tegra30-based tablet device.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> This and many others in the set are missing your Signed-off-by. See
> "Developer's Certificate of Origin 1.1" in
> Documentation/process/submitting-patches.rst for a rationale why that's
> important.

I specifically checked documentation about this in the past, now I see
that it says that s-b should from people in the delivery path. Wish
checkpatch could tell about that.

Please either add my s-b by yourself while applying or let me know if I
should make v6.
