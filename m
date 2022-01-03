Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CC4833B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiACOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiACOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:43:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B22C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:43:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t26so70301888wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqTYoEG0fCSSuHO7RjGcCyZafDlFczC6QQaAo/YOTIQ=;
        b=eDq8+T3KD08eY4K75ef7W2e9wgz0NCwTOhUmRIZaTfZslsSQ0oaarsrfDnmQLg3LxD
         jiZxYt0sz6h3M6taVElZUCFrMgL3jgrEacd9mQg1/yhve4PmYX/s4NlU5V1SniS/iIgN
         lOge45jCILCsCnzv8g5WjcuYuJhc3/glCuB1CpFxa2+4ehcGBGA+ArNqAic1jz8ZklEI
         q2tAKGfJ/67TZ7HV0zobu0OC8eXtabpSFO38Gc0LOK6VlhxAFIg5pHK55zmt7KmjlGdH
         m3A1bv3B4kuUBrErKULmsQScbQVa5AELEYOccxz2Aq6ow5n4l0BSmIzzRqYniW2eg0MJ
         ZuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qqTYoEG0fCSSuHO7RjGcCyZafDlFczC6QQaAo/YOTIQ=;
        b=wG3+A0EODZarjvS2nSmtoq9t1Qzur8vwtWQ2psOLZ/KjAM/ZwQJ5H6FEU0fQaQaEYo
         CeYG4vn9uZhCgPWspOZMLApov2jvrsI4oRshB4oAujXzKvb60iWsx9riPsKhtRG4IWwf
         jYiyFxb3KYDZ4dQgAfJcj9khxrQjeYwiKYOC0m4hqC2ThDEFBZHQ/E9yY7mo8V04/HwG
         dyDT0ETBRsZKj36VeogLTsncPLKpoEDFPQzsI6Y7D9Rg8xdvguwZ71khHVB9STmVepU6
         SiBhohuvEHKjvLSZh6mwtxG2RnIOcfeOW4yqSwy4rBcoGvZU6vcSd4b4yrAty21rOib3
         R/XQ==
X-Gm-Message-State: AOAM532IC9OYfCAkAQxFaIvfoSL7M8/qFjICvQ8UTjj+ci1D14cHpf/O
        7O4LI1JBLIuqaesZgXdp3D8PXw==
X-Google-Smtp-Source: ABdhPJyH4/D8nNoHqFkVlu/pqPOj9rQ6tyY2S2g5s+3XjsvmJ/FAKLoC8vYVTHBCYM5DDlPLzWJgvA==
X-Received: by 2002:adf:a489:: with SMTP id g9mr37708807wrb.235.1641221019202;
        Mon, 03 Jan 2022 06:43:39 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id b1sm39204103wrd.92.2022.01.03.06.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 06:43:38 -0800 (PST)
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix UART device-tree schema
 validation
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
 <CAFBinCC7iSKjZ=U5PN5FKF9js77tvaQBdWdHMPp_y+u+asaeoA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <2c5311fd-187a-d129-4e15-e83e49c14c09@baylibre.com>
Date:   Mon, 3 Jan 2022 15:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCC7iSKjZ=U5PN5FKF9js77tvaQBdWdHMPp_y+u+asaeoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/12/2021 16:38, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Dec 27, 2021 at 7:00 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hello,
>>
>> here are three UART device-tree schema related fixes for the 32-bit
>> ARM SoCs.
>> These patches don't fix any functionality which is why linux-stable
>> is not Cc'ed on them.
> The statement above still stands.
> I would like you to apply this series to a 5.17-fixes branch because
> of a change from the tty.git tree which will be going into 5.17 to
> drop the "amlogic,meson-uart" earlycon handling: [0]
> 
> To make it clear: Backporting this series to kernels older than 5.17
> won't break or fix anything.
> Only 5.17 and newer will need this due to a change [0] in the tty.git
> tree. Without the patches from this series the 32-bit SoCs won't have
> earlycon support in 5.17.

OK, I'll submit it as fixes for for 5.17

Neil

> 
> 
> Thank you!
> Martin
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=ad234e2bac274a43c9fa540bde8cd9f0c627b71f
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

