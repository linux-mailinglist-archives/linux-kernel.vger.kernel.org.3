Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA95268E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383216AbiEMR7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiEMR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:59:34 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3152610A;
        Fri, 13 May 2022 10:59:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so15801241lfa.6;
        Fri, 13 May 2022 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F9nVmxbxhPUjXlAFgxWdPottc/POpyAnJKeZJvdJb3Q=;
        b=nDJ5l8PJQN6ErdgB5BQL9UoNqthpJEj8Ph+b6M5H6gCD5YJQOQLn9uVZW0TCxjV5d3
         xWk/gd9SFSNISUuInNDzkEePTpVfVBA82xTxYgz5IIksYKh91DVz57K7Ikjnqx0K5gC5
         5sKzwXwNFBue6IdUNQxncSJksQy+MYHAg25vbmbX80bMyfKEjLGNPP7es0kWv/bEIXKR
         Hw2wsGYZbmfkXrLAalGWqMQX32xsODTl1Ushj8HBKuAr5avV2/t2JEnXWEirtKL+Sar9
         4Sv0KYKsLnXHqFGPaKEcjshoSESRb+QNIW0Nieq1iie2dzne+s2KLGhMaZVnk6JSujr3
         SLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F9nVmxbxhPUjXlAFgxWdPottc/POpyAnJKeZJvdJb3Q=;
        b=QemadDMPwANQifbO4+RxC3dlgF4fdEU9f36FLZhfXzRU00Zttk24YcmArwB8EVGnbg
         7j3wLEHzDXrkcXyzkow7AQrQVOfFQABTxNurNXWWDFHeKG+TLrcAjcsbI+/LA+zzzP+w
         UHsbETeHkz0zJeuFJLaYnQrDPYQOqdRnvViDrCpIaO7oOj3HNroiVLMzZ25EhYF1Ar5S
         pGTOBIdieLVk+gfnkr1UgmCY/amcuQ9haDfGIZsXBT0LNjeju9sRK4h+/s88elQ8uvl7
         E3r8CcmXW6mKq2G8YPrXSOiiX/uTp7NWhFPjsQACKoQFfhsHhebGQNqanC4EUMTgxmHi
         9Yfw==
X-Gm-Message-State: AOAM533u0lQv0RFSNQeCp02s24wIt7k5jivUSwSh/8ZlA2NgIH2C2skz
        endCmYkkVGgNvNqSO7bU4k6gFJzL8mc=
X-Google-Smtp-Source: ABdhPJzROlR9JfnWELD1llXgexuPYrFMoAc1dOTyPtjP64jGm4kWCWLf8hy56AAM4zb4yA/N6eu63g==
X-Received: by 2002:a05:6512:b11:b0:474:2b91:99c4 with SMTP id w17-20020a0565120b1100b004742b9199c4mr4252868lfu.347.1652464770749;
        Fri, 13 May 2022 10:59:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id b20-20020a05651c099400b0024f3d1dae82sm527639ljq.10.2022.05.13.10.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:59:30 -0700 (PDT)
Message-ID: <a3fa2e6d-55bc-2da0-9796-fc936583d78a@gmail.com>
Date:   Fri, 13 May 2022 20:59:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
 <a5929558-d09a-cb67-cba9-1dcfb5e43525@gmail.com>
 <88b33ada-e997-05e9-f555-b9c1ed369fb7@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <88b33ada-e997-05e9-f555-b9c1ed369fb7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.05.2022 16:40, Shreeya Patel пишет:
> Also, why would we want to do a SW reset here?
> 
> In the datasheet, I could see the following steps to enable the sensor
> Supply VDD to Sensor (Sensor in Standby Mode) ---> Wait 100 ms (min) -
> initial startup time
> ---> I2C Command (Write) To enable sensor to Active Mode

For example, if you'll do kexec from other kernel, say downstream
kernel, then the h/w state is undetermined for us. It's a common problem
with downstream drivers that they rely on a specific state left from
bootloader, which is often unacceptable for upstream.

If we'll do the SW reset on probe, then we'll bring h/w into the
predictable state and won't depend on state left from bootloader or
anything else that touched h/w before us.
