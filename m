Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6227246D2E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhLHMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLHMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:09:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A407C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:05:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id m192so1755426qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWw1BTytddzLy6/XkEytIoB8BFx802HLDV4U7YTwmOk=;
        b=Kl7dPUnsk3Wdnu7OCpf1WsCJr8sFVCYfg6Cdy1B1OXGh3bc4hfXC0gBXlCQtKAEdFo
         eo9SvHo3GqDsj9usOELBj2deKZmAZqRssXjp4nSAT8bFURsxqz2AmJSr0u6qWT2xkaks
         6lKVvKc3ymt19hzldJJL3TG7k2tCk84lH2iyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWw1BTytddzLy6/XkEytIoB8BFx802HLDV4U7YTwmOk=;
        b=RV9yDCnFCmcN2Vxy8WqeujMw4H2I5nbADG1eGQlRg8CSBjhosfLPOzu8HFojlI+mK+
         CsLslgSlp218lae2Db9cRvDGo6VF4H0YhbfZI6AV5Enw+xtc+XI9o2TsZPkEEbkTAvS7
         FB8bB0fUZp2EoYf9HquBfEuhMdkLNLLOHK7LL0ZimjAb/IK8ldcFw4Egm5oYT7W1XS2B
         QyFGWT4/zhfBun6qQ+E6WWsLaDEOG8psZf5T9J1lpbaHUYwIUMvIozXxVMzoMlSmSnHA
         wlIyNDDwKhbA1K/9OwMJHgeGw7DGXdosftSUA/BI16b+NPxGnAfWSjEKg8WavKuJ8/Kn
         /Hwg==
X-Gm-Message-State: AOAM530EC/LYpikt1ccjNW0LKEMy8ACzK6pQbtV1A/Mv/V8RF/crm3cQ
        x4U9+tj4mAt+DifbYAnoqz/SXw==
X-Google-Smtp-Source: ABdhPJya/4dOTsby7BajUtkNNiFn7qz9QAjZ3c59vAzzslX4SgIHrQUjr2o26tg2nN/O8sSXTqYpvg==
X-Received: by 2002:a05:620a:123a:: with SMTP id v26mr6068834qkj.431.1638965134013;
        Wed, 08 Dec 2021 04:05:34 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b01-cbda-d56b-2860-e61c-702c.res6.spectrum.com. [2603:6081:7b01:cbda:d56b:2860:e61c:702c])
        by smtp.gmail.com with ESMTPSA id o1sm1566896qtw.1.2021.12.08.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:05:33 -0800 (PST)
Date:   Wed, 8 Dec 2021 07:05:31 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable USB, PCIe and SERDES drivers
 for TI K3 SoC
Message-ID: <20211208120531.GD2355606@bill-the-cat>
References: <20211208060856.16106-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208060856.16106-1-vigneshr@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:38:56AM +0530, Vignesh Raghavendra wrote:

> Enable Cadence PCIe, Cadence USB, TI USB and PCIe wrappers and required
> SERDES drivers to support USB and PCIe on TI K3 SoCs.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reported-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom
