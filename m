Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E030646513E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbhLAPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbhLAPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:16:40 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB87C061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:13:19 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t19so49153990oij.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjl+aFuxemE8t+fGKbflN9jyWAelRj5lTHUhnZWsQwI=;
        b=PWw2ihsYlYMikBEYgbWMHsRyTHEK8Px6PPDic53KkCccfk2gGQMld88QF5hCscCkpj
         2vJnQhOQT9C36SC9VNS8QM92rg3dmxywz4Nx8Hl9YypUY9vF9qh2XDcDKWyZrbN98oOb
         XuqTlHzNNLwcuwbSPXq3DrWLJ4Wx0V8fn0owG7m1/stHoxnx9NLFHG7S7V1S65cLINW/
         hK2NCFTcNUfowvF3saZ6gO9PDqqUneeTKmWmoAxV9hbYSJj6j6d8s5x8IHE7Bg1DQl3v
         ix6k3oyVkqEw5RSQL2Jb3xFy0QWHccTLzICe9Ru1vAIPeTy+Faas+DcYWjQsS0AzA/89
         kXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjl+aFuxemE8t+fGKbflN9jyWAelRj5lTHUhnZWsQwI=;
        b=asyo5DuHlRroZPG8+2ZvLY1aa8P+rxPYik3zkBNtH1AS4szKuYArr4PT+ISRcl3BxV
         FHAD5Sr14fUkmDpCW6So3ASMBFLF77GWhTe803NQIzubqOH4n4JQpp/inKAQimNH4h7g
         CLcKSxIajxlafzLyh9wJVE5HIEBy2MyiGUc9NVJ0HA+nUbGCuiTJAsrNq29uxtWdC02V
         CTj6wNwm9P/JA1Ve2LMiEOT2cbVlbsCaaB4PY32CAeTlHUJUtQxH0VvLaF/utv3bx2q+
         cRxnqYEGKSv9RBkaUYXthL08xmcNMZOVWjdcm97wQjkWC1BPDLPFR5nBuU5UP19mRIEV
         6FXg==
X-Gm-Message-State: AOAM533ezPky0WsVbS3zoEe1AS8/wTqrLmoI+4eYQc/foMwMVuazl6QA
        8ZkuyMG/FTo5Ggl3sk8mMvE03w==
X-Google-Smtp-Source: ABdhPJx7vOcxuYeSwnXI7Ky4+w5hZajXsMENse1kcsyJZgKeLu1PRC5OOjEWtW96FP7KPlJ8YfiY6g==
X-Received: by 2002:a05:6808:1448:: with SMTP id x8mr6833509oiv.91.1638371598890;
        Wed, 01 Dec 2021 07:13:18 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id be12sm33933oib.50.2021.12.01.07.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:13:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     robh+dt@kernel.org, agross@kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sm8250: Add CPU opp tables
Date:   Wed,  1 Dec 2021 09:13:05 -0600
Message-Id: <163837153032.1905338.5963582907244511145.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211110215330.74257-1-thara.gopinath@linaro.org>
References: <20211110215330.74257-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 16:53:30 -0500, Thara Gopinath wrote:
> Add OPP tables to scale DDR and L3 with CPUs for SM8250 SoCs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Add CPU opp tables
      commit: 8e0e8016cb797c38eea8641e8b77a5780c4614ac

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
