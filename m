Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855F44A5629
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiBAFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiBAFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C5C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:12 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so15126658otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9zRd1V2ISXwphTRlIcVBuHuJWr0vd9KojjKRN36MEAI=;
        b=Eleh1fLCdYSRw4x0uDLRVg2ZmQ3jSO8KSPU7SAelvmamrvJVOry2xUd7y3ko8mjcdZ
         +oREGEaNWHqKKFR8eeWgJJLK6/VlorbNgPZIuUAyxiqOnbJ9IR2kAsnd4KGT9MwLm4zo
         JTjIW0h1eMxu3uq9AdhCB7B8mlvLpmY6SUBa1BtrIC66EonLHzeb1/lo7Bq8OgdfIfc5
         JUtFLaoB5mHWmPN/8caP8SKTl+EQF8WuOnkCL7lj7/dx738XqzxW50PdyrKZwjCOl3pc
         XT5lo9v8AX/E/JhZEv5nJatkfp7xNFcAyWaw1A0QR2giCWJkDr/vGf2hkYL/wmcNMxPV
         /S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zRd1V2ISXwphTRlIcVBuHuJWr0vd9KojjKRN36MEAI=;
        b=Mya4FJiaiszMVWw6nwCnSBeEjHehEHWRXe1+ljlDIYlBswKacTMnHuV9YScwWLfNqG
         sSAAvITsNT9ospUJXwPM5xe/COEZIe8dWtxDO/FoYXVdOIh5Yi1d5GTcnLOCdj/F+x0H
         sJfOv4qEP/gF6ydByp3+4avhm2o09c+02E8iHRm7OlYsojlvjdkWic2U1oe79oQlWxFu
         uHW2DLkvelXtCpqJb//z0Ld+2XofBV5C90mXNOJ6RRBZOm7WwnZMnNBp9WWODE8ovnWx
         551pk57X7I1Z+KDnAyUK6mVbK4se9c9nXuQD0accBZR+b2n5eizTFPgjaP11Knl03hRm
         4R2g==
X-Gm-Message-State: AOAM530MVb4kpicnOR3fQIFbqDe9v8WwTpXguWAKc2nuhhvnmr2SmwNO
        4ItTSfo+2NQ37OeDKXt/LmX8qQ==
X-Google-Smtp-Source: ABdhPJxXrkcDeP6zBtLfkOhZMTeiCTFxKhGi54ttguawdZi0hau2mMK9Pprgj9v/jB4lHvJC0neGsQ==
X-Received: by 2002:a05:6830:555:: with SMTP id l21mr13357720otb.54.1643692811788;
        Mon, 31 Jan 2022 21:20:11 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:11 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: qcom-apq8060-dragonboard: fix typo in eMMC
Date:   Mon, 31 Jan 2022 23:19:21 -0600
Message-Id: <164369277345.3095904.16020829127932162038.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127025358.2202977-1-benwolsieffer@gmail.com>
References: <20220127025358.2202977-1-benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 21:53:58 -0500, Ben Wolsieffer wrote:
> eMMC was misspelled as eMMMC.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom-apq8060-dragonboard: fix typo in eMMC
      commit: 206006cf20b3ccec65b11d2a83876cc6006b6a16

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
