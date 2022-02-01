Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868D4A540A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiBAA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiBAA3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:29:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43025C061714;
        Mon, 31 Jan 2022 16:29:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e6so14339286pfc.7;
        Mon, 31 Jan 2022 16:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rvRd7oIw8uY3irSSv4pcS4/9DZWXv6yY++BV6uJpALw=;
        b=pGJnBjGcdVY7r9B3MigsahaaypDxK6v8v1c3MEIOeMNcDU6IZ16yNcMmPjhUBTisvy
         PsCwVein3lJE1H17Pn96naM/FdfcJstIscblsZszs59nmnUo5m+EpTHwsvqlO082lclA
         C+PuHICFkguWVk7B9OBFF8BiRmVsd2yfdvaFIo14os41v6zEJzg1Qrc3zziFrEFAWiRe
         U3cBE7CMZ6l+hCu6AvNCyh2PwEPCYCBqoVSC/AAsnQo+JD5hAYn929/KMEur+wTsP0E/
         XPtNx/x0ZHUjesEh8Cfy7v8JT4uRsD/NhpKVSqvdqjthXfHnkzvu/iTtQrn5aOxUOi7l
         UOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvRd7oIw8uY3irSSv4pcS4/9DZWXv6yY++BV6uJpALw=;
        b=X05nk6EuyzbWYdarywk8MrnB9ZNT9Ripf18NmCoo/N3wOTVYckhu0iM0N5+RpKmuaa
         7UHRDX+wpwdUlWe1SYWOlqj+uC1LxQLfnG8jQ0P35K+oFnoya7eIcDavY4YqFTC5nwpT
         57JIrMO2qXU7WUN5e2NzTFRq9O8eRJvrL2QmWet/UE8YJK7qyElwDDB9551OKSqaa1nZ
         xJe2S3l/LvCRQkzuXBUuk/VH+WUQyFV9PN7xVZLClzk6+0KctP5o7Cp9cCyONj3E7KbP
         f4uo7mEXxg+mVSj1ufR9RTlxeVdmjjKG1rLf8siaBSqEIaY+ssZVZVKduaZFAXBq5new
         YmDQ==
X-Gm-Message-State: AOAM532E0IZjZn0bDVG53qiZa7UtFcoEVzy7mYThOQzRnWXayAUDp9RH
        /T8xgsHQUdcnpPaFEUMtIR4=
X-Google-Smtp-Source: ABdhPJy9bRkpyuO7osTSD/aDf0Amnu33vTqClXfnxiYD8JPtaUo14ZBOLZ3jQbzgVniwt4yulBTTiQ==
X-Received: by 2002:aa7:9486:: with SMTP id z6mr22743965pfk.76.1643675349729;
        Mon, 31 Jan 2022 16:29:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 10sm19331693pfm.56.2022.01.31.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:29:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: align pl330 node name with dtschema
Date:   Mon, 31 Jan 2022 16:29:07 -0800
Message-Id: <20220201002907.427996-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129175557.299166-1-krzysztof.kozlowski@canonical.com>
References: <20220129175557.299166-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 18:55:57 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> Fixes dtbs_check warnings like:
> 
>   dma@310000: $nodename:0: 'dma@310000' does not match '^dma-controller(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
