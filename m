Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A5E47D3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhLVOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhLVOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:40:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7BAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:40:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so2813614pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=/+nOXG61f5LspoL9MEmto8EIAo80dJkOEBFTCBQdirA=;
        b=Rk+1OnLjQDF6+5jwZYyYZUjYnCd5ui31TlJrz27pyF51uE5ptIzKgXe1pG/4z9B7VT
         T610JP4gb2gou28H1esAeIVmzb21MbD3NDvL05ExFHtr6tdKF/V9To6Q+8U/7gz1nq1k
         RU7Oe/hs92uMvMj8h0+PWCqS0IhzZLWfUlMvNw/cbh7v306YR3dvy/1LqrQZXl2OJ7Lt
         6N2laCFR86MVdwqO2WNrWMoGlPpfGX2/ZDSaduVvL5vtL/KOcA1SI7tJhHz7wL2RqEHI
         12rq5pSJDDD9BIGpRcVAO6G9666C4/QRpFV39acQ6vytRAl1aQlEi84ZV90COoIva9mk
         eGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=/+nOXG61f5LspoL9MEmto8EIAo80dJkOEBFTCBQdirA=;
        b=BUt25cW8cvaGCXYnTUbaWThZUq0GyfJo3c1cLDacNxosvgioZr51QpJnSvhvfOSHb9
         JZRu29HE5g66NySnEgTmMDrbncMLkBafaU1pv17jbjWFVnKA9AX9sAzulQyEvR+u627t
         9iFtxDPy3YXdEwNo7ouSPnlHe9BUxAZZPZxN3kF4NGpoRg53fwp6vAQ7/cYFgzDSGoVF
         l/HpFTRUcgj/7no5sJRHiTC1xw+t/M3tbaM9opjHO0ktHXRdDp22xGDR+iwZV53hAUPi
         F8rYsiJ+8lTRhIFPoFnvR9NAe7YEGRaYIlEHbN12ofluwOlCS3bH2AMiSjP1JrF03o1G
         kFfA==
X-Gm-Message-State: AOAM531b15rNEK+XxpfX8uX+YmMqSMf8KCFPTaBEe67dJM1GKvSoMoxd
        dlxvMpoYEzDx26CeQoOqCoJbdaJ+EFz3vw==
X-Google-Smtp-Source: ABdhPJxSYDWB5vcKdycku7QbuH8eDSW46JzO/gNjexcdqxw58FSu5CmKcrdPzqoTGXBe2F6cu7zv1w==
X-Received: by 2002:a17:902:8482:b0:148:a2e8:2c48 with SMTP id c2-20020a170902848200b00148a2e82c48mr2967599plo.151.1640184009349;
        Wed, 22 Dec 2021 06:40:09 -0800 (PST)
Received: from ?IPv6:::1? ([2405:201:d001:4dea:f193:aa3e:a737:6471])
        by smtp.gmail.com with ESMTPSA id l13sm3380591pfc.1.2021.12.22.06.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:40:09 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Wine List
From:   Rachel Samuel <rachels@dynamicaims.com>
Message-ID: <cc12e57b-c0b8-9958-40c9-12937199545b@dynamicaims.com>
Date:   Wed, 22 Dec 2021 09:17:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 211222-2, 12/22/2021), Outbound message
X-Antivirus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Would you be interested in acquiring an email list of "Wine Lovers List" from USA?

We also have data for Beer Enthusiasts List, Liquor Enthusiasts List, Beverage Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

All the contacts are opt-in verified, 100% permission based and can be used for unlimited multi-channel marketing.

Please let me know your thoughts towards procuring the Wine Lovers List.

Best Regards,
Rachel Samuel
Research Analyst

We respect your privacy, if you do not wish to receive any further emails from our end, please reply with a subject "Remove".

