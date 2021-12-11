Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C272471473
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhLKP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLKP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:28:54 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1BC061714;
        Sat, 11 Dec 2021 07:28:53 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id t26so23192051lfk.9;
        Sat, 11 Dec 2021 07:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W+78tT7DvCusUKi3cge1x8a7J0QAvGLFsCIq9fOA3Jg=;
        b=Sude1OT0MoUDKhSge1VsW272aWD8foR6kHOpmaKMbMBCZQUdAsS6scox7f7o5IXR+T
         IMmPBAkAq/FpwQ+lMHlC3Q5gkf6vjm5cVEOihn4QXJY5gNzvFpYY+1DHFbMaDO15Sik2
         17eRm7Q1qL3xVcHzN8g3w9Hkrqy/jzaDwVUupEiA78Vto/JKBvAnGdmmLsKOV1DcvNzp
         4L14bPdPfzCd1hc/RFrKuOiJWcQObtq9vBbdJUVr7/w1ruoTMny7Y1jRER8enzlMhynY
         PGtmifZp1cmIGl0oGqympohgatR9RVDcEqpZdR7PBSwoU4yDpfngR0cWfVSVd2EEBa7f
         Z1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W+78tT7DvCusUKi3cge1x8a7J0QAvGLFsCIq9fOA3Jg=;
        b=ca8NAPzSruo0I32d1wQWTAsZDaLOu1u2cF0lOLi4mL/BSyVaDxNHMjzhA0F/MwBGWo
         WyBaSPb6woR/mQA/XHkT8JOMi23r5KRFV96FRvcXrOPQ7egsG7fqhmjwiI5WQj1mlO1F
         qgh0w1cZfvD6qMW65636Cdh8tdCWfkEggcMUbOkbcZQE5SzyT9aYX8+vdlnIX3saOV9m
         m0hCVt08QCtvfvp1YoVNdD6kbljok0QqEWUN2ZMyYXQ8wkngvdEd85Jin+azxTBXDr8e
         s9tHoIVMkIX9znzwZGUANw7IAOCU3oY7LiuAZgWmcnJ0KtOLaFJKPNl6xI+LsnKcZXmj
         LaDQ==
X-Gm-Message-State: AOAM532qW50/oaQqdopeQ1vkNMO+cBD0yOtYZmNwaJDDDlvbKRjMMowW
        WiLy/fUjOb048sAFTRQcbdly2LFfwNY=
X-Google-Smtp-Source: ABdhPJxv4TmikjxD/+ijVr0Ajj6JZ0fjBKhtPlbI7Zdod50NnI3w0fRp49A6Ele6jDbhVL82+SUhxA==
X-Received: by 2002:ac2:5e89:: with SMTP id b9mr9969602lfq.616.1639236531938;
        Sat, 11 Dec 2021 07:28:51 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id d24sm666372lfb.139.2021.12.11.07.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 07:28:51 -0800 (PST)
Subject: Re: [PATCH v5 05/24] ARM: tegra: Add device-tree for ASUS Transformer
 EeePad TF101
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
 <20211208173609.4064-6-digetx@gmail.com> <YbN2T5guOfIRLXg1@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6c33db23-dfb9-bea2-f10f-02b9ed1558eb@gmail.com>
Date:   Sat, 11 Dec 2021 18:28:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbN2T5guOfIRLXg1@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2021 18:46, Thierry Reding пишет:
> Again, the memory-controller node needs to be sorted differently. There
> are other occurrences of this throughout the file.

Memory-controller node is placed on purpose in the end of DT to keep it
readable. Those huge timings make it unreadable. I don't want to change
it. Alternatively, we can factor out timings into separate DTSI, but
it's unnecessary to me. I leave it up to you to decide what to do.

I'll reorder couple nodes alphabetically, those that don't have address
and were missed by me. The by-address nodes are all okay to me.

Please feel free to reorder nodes to yours liking by yourself while
applying if I'll miss something.
