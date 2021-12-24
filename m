Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F309F47EB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhLXFAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhLXFAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:00:49 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524FC061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:00:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so12509335ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 21:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBZtx1t4O7jcjLyj3KoOrsSaHHzrz6VZtAHz9lqXNEg=;
        b=WYwC1Y0lP9iwsck2v6MxJtpICj1r+JKKI0ZiTjAp/krmob0OcIL105OtDXBUf3e6lz
         qb3wt9VNbEX3avFKZqy9umhzcdfOj5Q7QruzjICZagwtxmY2oDqoCepEXB+G+wuHtXQU
         yiXJ8lFosIU5e49pudSN+9Z+h1gNg/R3XkqEEyjwwVyAO8EOhIp3dVn5o24L9ZVe03Da
         pSz/70WrRlPSrBFiwtVS+hVwJUhkPvId568oHkuRMISOPl2GV4MQ474nJhC175vP30GL
         RR9s128KlaB+jppOf1Qk9lW5FlOjWB+hPwe81qxNyhK0LMnHmwRZ1GbCDVj1hK/t5NAh
         EQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBZtx1t4O7jcjLyj3KoOrsSaHHzrz6VZtAHz9lqXNEg=;
        b=RegOjAqJ/u0PZb09VQ8vKQT2ykRv8Eg2/e8vFDNNBZwBBuHVXUhlB3BSs7fnCfRBaP
         Srpo/iTGA9S6a6ZGUnNoVJTd/US/qxTKrcyWY0as5XfpH0xOdN2dOHRrTU20EA7jyyfL
         mu5rUqAeniYTrsCZfr7QDtbODfHR9w1qscgPvtEtxwPGuviPBqOusildA7R+5D6C34YS
         zZtZpjyjO5mMfhAg5JCyBkrhc9g5YfMmPgnFh1/bEM51Cn9d6F9QMHSKWoMrzFgnZkFQ
         DXeWYLIdnLknQrczwwP1qlZwArriTWj5Sw3/Ax8pe28Qcky3r8Cl++QbdSDCVmE8tTKE
         /dgw==
X-Gm-Message-State: AOAM531023OR9ZL9sBkrT2HOaph2RYOr6dIrGYymbiEOjmfb3vajCxHF
        u0Bi/dS6y3pc3Jvg7L/j2ZEUfMy5ZYwp+uMp
X-Google-Smtp-Source: ABdhPJwIM4jUAL4q1SIdjv85L76NJHlDTe5hACOyquxB58ef1wDzVCeH0WqytWbiEmlWA5jBXDdewA==
X-Received: by 2002:a05:651c:235:: with SMTP id z21mr3742094ljn.473.1640322046996;
        Thu, 23 Dec 2021 21:00:46 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id z24sm693895lfh.289.2021.12.23.21.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 21:00:46 -0800 (PST)
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <d4a00def-7765-e0e4-c5c7-8d648eeb8cf2@omp.ru>
 <20211214140607.1147976-1-nikita.yoush@cogentembedded.com>
 <CAMuHMdW=MytCOsghcH9p1GXOPCO3=1mSF8PKj_UAjYEqAq4-1Q@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <82b37f1e-a461-8d16-219b-2319e11e1991@cogentembedded.com>
Date:   Fri, 24 Dec 2021 08:00:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW=MytCOsghcH9p1GXOPCO3=1mSF8PKj_UAjYEqAq4-1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +               lvds0: lvds@feb90000 {
>> +                       compatible = "renesas,r8a7796-lvds";
> 
> This should be "renesas,r8a77961-lvds".
> To handle that, both the DT bindings[1] and the driver[2] should
> be updated.
> 
> [1] Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
> [2] drivers/gpu/drm/rcar-du/rcar_lvds.c

Ok, will redo that way, although I don't really understand what for to have different compatible strings 
for exactly same IP inside different chips.

Also note that arch/arm64/boot/dts/renesas/r8a77951.dtsi currently has renesas,r8a7795-lvds

Nikita
