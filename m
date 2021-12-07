Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B146C0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhLGQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhLGQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:38:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B04C061574;
        Tue,  7 Dec 2021 08:35:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so30644672wrw.10;
        Tue, 07 Dec 2021 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nBq4z9ubkSuyUZ2LTFKYRzb3ppMDEl5CP7+PtRSNmXc=;
        b=D0IRMe2Htb9T/77xDfXkyxJINLH0czmMGkVrouVFzqVMSOZOrsylqTk/YrKWdWVVHy
         KpFhEHpGO5nf2x5Tt6dDSidZ8o3v9ZMuYv1ufOhaKFobyPmAw2IPyFV6vwY0KAOKRV7h
         Cs+Bhcy+ZA8w5EVwCP/n4+ykr3kICEtRT/mLPrXuBrBNw5IQfGcjUyUUSsDfUurZIBhk
         XvzVmUlETE3hvSdtfFFpy+7cmLXEVfsaVuYe7y90IRg3V3UNhWUJTzjzdWG5o7jy9JPm
         dVJQKr+NhKzoAGGMz8HptWrwE4MyYj9lOTebF30CyGtm4gh1MCVIwKaAYvmPTwSw3NCp
         zUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nBq4z9ubkSuyUZ2LTFKYRzb3ppMDEl5CP7+PtRSNmXc=;
        b=4I+OF+70TTjpD8CxeokEEc5h/8rkxFaP0ljDG3LFVRw78OXwdrfraycioaIRTjxo0Y
         3orPrlGbnLSCsBqcy4uE4DDmyvDH24EKV8Jc+wlIPri8smlZeRM7R72jkFw0O1Od6Wf+
         pH+9ypJ84uIFDrZF/TItyRVGNNFT46B/SjXz/1uCwdan8NbSwMx5b/4APPF/Yn6gu4hi
         KsOz9SJwGPiyZUeeglRpAY1bgLZpoxzXry+DBCw22owaFKdKTfRYzECVzZ236cY8Vxok
         jWSx3KtVQxi7nMEsDoNU7FaKv0YS7Zj2LlmxLD7xtBbcMm1oOAM1XQNTS5sxj05SZH5S
         rYHA==
X-Gm-Message-State: AOAM532q2RE5zz+YN/FvQymB8WQYn82L0b80VxeXI690tWbDoHdVs371
        WLhqMEeMDzvTdmMhMoEly+Y=
X-Google-Smtp-Source: ABdhPJyErV7Ldoev0AkP7ge08IK0PwnZRV4VTGR3iDstNcFEMnhrUQP8nEqTFb67Xngi/5irPBooBQ==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr52392964wra.440.1638894916603;
        Tue, 07 Dec 2021 08:35:16 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:eab:126a:947d:3008? ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.gmail.com with ESMTPSA id p8sm189854wrx.25.2021.12.07.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 08:35:16 -0800 (PST)
Message-ID: <d54b9767cf76e7d4cf1a1dcf8f7efae12d0f25e3.camel@gmail.com>
Subject: Re: [PATCH 0/6] Initial Samsung Galaxy A8 (2018) support
From:   David Virag <virag.david003@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Tue, 07 Dec 2021 17:34:28 +0100
In-Reply-To: <20211207082656.GA12097@duo.ucw.cz>
References: <20211205153302.76418-1-virag.david003@gmail.com>
         <20211207082656.GA12097@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, 2021-12-07 at 09:26 +0100, Pavel Machek wrote:
> Hi!
> 
> > Add basic initial support for the Samsung Galaxy A8 (2018)
> > smartphone.
> > This phone is also known as "jackpotlte" and under the model name
> > "SM-A530F". In its current state this should work on most if not
> > all
> > Exynos7885 phones/devices released.
> 
> Thank you, it is good to see support for more hardware.
> 
> Can I get you to cc phone-devel@vger.kernel.org mailing list in
> future?

Sure, I did not know about this mailing list. I will CC it in the
future!

> 
> Besst regards,
>                                                                 Pavel
>                                                                 
> 

Best regards,
David
