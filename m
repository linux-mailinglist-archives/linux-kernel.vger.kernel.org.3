Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017F465903
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbhLAWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353542AbhLAWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:21:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5FC061757;
        Wed,  1 Dec 2021 14:18:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso906057pji.0;
        Wed, 01 Dec 2021 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GHGfbVb+zpYK3Me5+9au4jIqY/+rfyjn1Fy67PyxmM=;
        b=jBvpHn8/Akn/Ir/RWScbDdUxaYS0kuEUQPE1gXMlI7jsjpb75nbYC7axau0ts0iMjf
         1/vSH/w22TLb//arII2/ce7p7eCzG1CQGmlGST09jr3rL/kEG+CePeAOKIDH+4T0TMfN
         qSmkTYidcuLgk0+XNOq/Bdqrpkm2aupeZ+SE1RCgsWA2IxaTGLm7B8jzoFlP2VnE1Bbo
         AB50TZR/bo9tWoAlv0n+w7daYwH7ceUvNkEp/PZ1iWmqljXH1aOktRIccekekd9tI04g
         QbDVa9l4SsiW8tFVUAl1xhnvIqXLu2DCdv6IaM1L1e5sGPkOR94BjjmdbcxCHl7EjEsN
         6mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GHGfbVb+zpYK3Me5+9au4jIqY/+rfyjn1Fy67PyxmM=;
        b=g3j6F4LgTfefb9aCitAg/AljlopbAKNrZGExv5IkgwhW3g9I/gtl2FccPzGu+2Ylv1
         /0jU/HBXksurSCLmGZ2Ez/FQtpAwcA8aGMlS0S6fehQ5O6MChBs0F4WhDujgIC6/OyUa
         WoK/iEs74kTyy88mHyhjZTqhY64kS25ptB5YtUQmT4diRiNPCgQIOc1bTxsiYQaHPdRr
         debo4BYqnDYwu4mcuwZOEUYxjtXMgy6UIzawN3drq2PfxXp+/Um4vaUXI2mPQyTJSatb
         4z7JrQgd1PXzWD1FeAqxST4XncRWVEw9+jvRBLzBFjTyXfTsDg4MwacFDsroN+sQjm2K
         fQuw==
X-Gm-Message-State: AOAM530UJfsIwY+B0VuzI+Pq8Pg+/jYx9yF11y1+8fh3m27acFw74Yzz
        tW5uk5ku9aoxKRyvU8iNR8o=
X-Google-Smtp-Source: ABdhPJycufUPwH+Aburdlol0VWSDH6OER9iK5cmsjopZZ0d04CdDJYgumiued6cBwez/K1RqS0SVFQ==
X-Received: by 2002:a17:90b:1d0e:: with SMTP id on14mr1236497pjb.3.1638397080890;
        Wed, 01 Dec 2021 14:18:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t38sm787561pfg.218.2021.12.01.14.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:18:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] MAINTAINERS: Add Florian as BCM5301X and BCM53573 maintainer
Date:   Wed,  1 Dec 2021 14:17:59 -0800
Message-Id: <20211201221759.48731-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201211939.13087-1-zajec5@gmail.com>
References: <20211201211939.13087-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 22:19:39 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM5301X and BCM53573 commits go through Florian's stblinux.git so add
> him as maintainer to make sure people e-mail him when sending patches.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
