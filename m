Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9C479C25
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhLRSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhLRSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:48:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235ACC061574;
        Sat, 18 Dec 2021 10:48:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d38so12027474lfv.0;
        Sat, 18 Dec 2021 10:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8ZuRLchSjCjtxD7Je0HJYPmmo0B43cEQtP95CkNaPA=;
        b=IuS5LRbV61GyBBM+xZqDfsfW9vrQ0lQrBSLifptXWV/JQt8EwQ7eyAFQo/t9/OQqRG
         4cqz3xSRPgZS48G7Va7rbDoIFWhECbpWtuZ0k/G1QAeeK+vTVqFx6mo8/gyx8FYCZU78
         +4JYVJA4867ZS5MqLX5NsMszfyddk2qEW1jX1VHcDlCi1wV4pgxAUO2HS0tNjYYgnhQc
         v2ul42q+DFkTALNywEF/GaXkmUZXMV073rNVjcC6CXcrzbD+CsxgAGdcGndtBRD/3h+j
         bqdx4j13PqgtMBpz9sPTZNL/QRnJjrPrdG6ndagst95WIba7PFCZMG156Vs1OH1IhbE6
         6f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8ZuRLchSjCjtxD7Je0HJYPmmo0B43cEQtP95CkNaPA=;
        b=15aWtxysDSxp1DARmUYP84XBRu5mIskz5YjjmM4eb2MiFsAGCmU8l9WMx/hCgyVXgb
         zh1oSdqII38aDctzWUCyE6HgWBaQ8/6WzH5kUuauam9sMdQ4QEPCUIw8IYIn6VNRfhlF
         Ue3G7E/lhwYCxtYyOcYFA0rOpsQspNgdCF75FeMMOgcuD1vFaqSL0N08ioIPtnkCMgQ+
         TvV+sfESF9c78S0obuWIKqiTONTOQalZ1mMJro24NDehZ1B8xovif/2L4YyayoP6xpHP
         fGbykCy1Cmpz4yovilUC8pmOM3nSP+dEadppM6nD9/CgzYQfg6PQeIsIoDmROznBeSiY
         YpKg==
X-Gm-Message-State: AOAM530pp7eno3g9t4QfgZgqHDaFTbpVr5myvN5Cq3seZLAVZwfIk6id
        +43a+mmcoG32Sc0LmWE4Gqo=
X-Google-Smtp-Source: ABdhPJzDrWPEcfKQVE72MJH6QotZdCZY8m4TenSI7c83i7pxMSv6D3RXNeLX+FODRerFA6s1RdRVyA==
X-Received: by 2002:ac2:4557:: with SMTP id j23mr8455350lfm.382.1639853324248;
        Sat, 18 Dec 2021 10:48:44 -0800 (PST)
Received: from netbook-debian ([94.179.28.1])
        by smtp.gmail.com with ESMTPSA id m19sm10169lfu.267.2021.12.18.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 10:48:44 -0800 (PST)
Date:   Sat, 18 Dec 2021 20:48:39 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Message-ID: <20211218204839.609bf329@netbook-debian>
In-Reply-To: <CAB95QAQs5=t37UTv2r=ewj1QaaD5LQckGXG1zL+wWYxYTgBdtA@mail.gmail.com>
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
        <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
        <20211217000424.41da446e@netbook-debian>
        <CAB95QAQs5=t37UTv2r=ewj1QaaD5LQckGXG1zL+wWYxYTgBdtA@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

I see. Thank you.

On Thu, 16 Dec 2021 23:58:40 +0100
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> Hi Denis,
> 
> On Thu, 16 Dec 2021 at 23:04, Denis Pauk <pauk.denis@gmail.com> wrote:
> >
> > Hi Eugene,
> >
> > Have you found some issues with idea of usage ACPI WMI methods as
> > failback solution, like in case when ASUS will release some BIOS
> > with different mutex path or different motherboard where will be
> > same WMI methods but fully different internal logic?  
> 
> Not direct ones, but yes. First of all, I still don't understand what
> causes the big slowdown in ec_read() calls. I learned that Fedora and
> Arch kernel configs result in the slowdown, while my custom minimal
> kernel does not (well, it is still slow but nevertheless). I tried to
> unload all the modules I do not have in my custom kernel, I tried to
> disable every option which is related to ACPI in the Fedora config,
> but the slowdown did not disappear. Then it is not that simple to
> gather information from other users, because one needs the ec_sys
> module to measure ec_read() performance, but it is not available in
> many distribution kernels it seems.
> 
> Instead of that I've changed data structures for board description to
> include the mutex path there, so that we can handle various paths or
> version dependent paths for each motherboard. I can add code to select
> the mutex path based on the BIOS version for the next iteration. Also
> considering adding a module parameter to override that path. I think
> that will be maintainable and give users a way for a local fix while
> waiting for kernel update. Would you agree?
> 
> That way, I believe, the WMI fallback is rendered barely useful and I
> decided to drop it.
> 
> Best regards,
> Eugene



Best regards,
             Denis.
