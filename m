Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C52463AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhK3P56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhK3P54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:57:56 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1FC061574;
        Tue, 30 Nov 2021 07:54:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l22so54937952lfg.7;
        Tue, 30 Nov 2021 07:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5qik7JkxsV5L1nyIiJAzLGGqdU8Lv8lfNJJdZtpwB0=;
        b=RylwZe89Gypz3GfzQSBHd0yTJdUBDZytxEh0mEKj30BcarBB4LEdiIcNBm+4gc2f7l
         6lhx7QrVSHrj3DhV7qmkd8tGWUmyM8xsXbocB6Z+O9SVijMvhXlnAVxD8CwuZTCXCDgV
         HP81x3lmR8wGcfB3cd/sQYSjmGp/Xf3WrdKqFn4XEuN/KMnCjrnnSdclgF7AL81C6wWA
         U1ssQsizpD3vG2qtB1jbdA2tLh+79Z8NWh53EhmDBdL6vWrQz1/FKKY7REB/ckXWLN5d
         yIBhDKP5SSC2QUxiovsBjVhKbpimlyiEKhoFpIH+46pR8ZI6VuAaB50DCxAjtSlytoJU
         t8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5qik7JkxsV5L1nyIiJAzLGGqdU8Lv8lfNJJdZtpwB0=;
        b=rc6ReoR/WDYe5OJVi8/7//nScR0dvO1knpvdJQs5EwtaA3WIfv2XxZmgXGdvAwRjDH
         ANth6O+cvf/oZ0auOVbT91uufHBILyzGyTJZW1A6KADwjQevtUKwZf3JH/PUIEI4MIXV
         fmeLKzWczSQRl26ZQmCDbnYtDQBCNZAylSFObIaoFqghxXMxO7jF6aclZ6zYK18+WdXz
         9P9hCw2fGWLhfZnWSEwNh1gTpfRpMjfZTcYjLvD2sO/jxvC68THlDucQnSNlf6h0mymG
         rzS2Qcks6HPXGLBuP+8qXrXIB8GIUCr+zLC2b2bqZZ9duPy6q7t1HGFKzUTkrvO8FJ84
         z0mA==
X-Gm-Message-State: AOAM532oGxr8ape2Yoq3JqL4ozXhGz5JYjZUQa+CeaSmWPYt4E3BArL6
        wALdnZ934dVeB+rvf4Q+E1Yt46LyjD4=
X-Google-Smtp-Source: ABdhPJy7QhmKwfLB5R6+JEk12Qsc2zj/1kqkJEqaJM8bGr5pAdx1OFEqLSkVbe3uceco1zRz+Cg/Gg==
X-Received: by 2002:a05:6512:39c7:: with SMTP id k7mr10824lfu.571.1638287675500;
        Tue, 30 Nov 2021 07:54:35 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id b13sm1985266lfv.200.2021.11.30.07.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 07:54:35 -0800 (PST)
Subject: Re: [PATCH v1 1/2] dt-bindings: sharp,lq101r1sx01: Add compatible for
 LQ101R1SX03
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anton Bambura <jenneron@protonmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211114200717.28986-1-digetx@gmail.com>
 <20211114200717.28986-2-digetx@gmail.com>
 <YaVG93LCF6MQYiSi@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a8f05850-1c18-1a7d-e529-08d9a6bd9923@gmail.com>
Date:   Tue, 30 Nov 2021 18:54:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaVG93LCF6MQYiSi@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.11.2021 00:32, Rob Herring пишет:
> On Sun, Nov 14, 2021 at 11:07:16PM +0300, Dmitry Osipenko wrote:
>> From: Anton Bambura <jenneron@protonmail.com>
>>
>> LQ101R1SX03 is compatible with LQ101R1SX01, document it.
> 
> Then sounds like '"sharp,lq101r1sx03", "sharp,lq101r1sx01"' would be the 
> appropriate compatible value. Do that, and you don't need a driver 
> change.

Apparently you're right. The "sharp,lq101r1sx03" should be a slightly
improved revision of "sharp,lq101r1sx01". I see now that LQ101R1SX03 is
sold as a spare part panel for ASUS TF701T, hence these panels should be
entirely compatible with each other.
