Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138974A4E28
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355383AbiAaSZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355151AbiAaSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:24:42 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F1AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:42 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q8so13842881oiw.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htffx+10Rm/s5iM/WFm2qfwFtbfvW8OjkLAv9C5/6EY=;
        b=j2psX3OT4YaDv8W0bAQwHgWsmwnEnGhzT0ktqf/MosWHLpswSPDZ9+RAmKTMD94ERe
         FJ4iDI/Q2f7xa9KBPsh0Lx1Yc6JWISCPJj95xs6q34j5Yl+8s6QV/KBwD3x3WAVEV35i
         oesOj/U8GrYQfIaJdu9B7IaHjsCaWF533+wW958gvVbcgvttBAvuuJBxIS0bZp8VYI+F
         XhfD7Ah9bV6C+MS0cpSQKl9fWvPVcHqt1LcU+K4kSSQQnZSJAp1GCEhmMfpb3CA+vReA
         Wo0ueIB8ht1T40P80XgGHpDw4I8IOUoy0H+Jz6kzsuA8bWscEajSWgkB+QxBcNVzg63R
         lO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htffx+10Rm/s5iM/WFm2qfwFtbfvW8OjkLAv9C5/6EY=;
        b=Fo33XgRmH+LIssMN9/i21A8ejwkJiM1BRoE+o2rlQuzT9LSNj2DXi/gDB7veMNg6mA
         yb6jkMWuqkknXEE0+xJsDtr7qFbmfB+SiLVMBKpIBWk/9PCStn9sW+5e4DfMCGsQMArf
         WoC49a929psiw5dLJ4VNTWB8y6jfNtzf7EoIsH5hSiqv8xC3dNID1YONum9IAJbsUXiL
         h42l3fdstiTJ0kpK1NlarY7BvMwJz9QNJkSBRitdaEaXfrGeJCFrOeq3TJblZneZPCy/
         2XsvclJ+Z7CQQf1dkC+OLNc+261wB1FI2zXYahLewK3bCPCEdOy6NyjmaMtsENwNLcBz
         zP+A==
X-Gm-Message-State: AOAM532PdY7rHRlCjwB4G+EE5R8o4HLb5AOQAlAfM05Ds2jm3BIh97E+
        RNwjXpcC0vClSuaJSdLOA4FIeA==
X-Google-Smtp-Source: ABdhPJx0dUbfgMjXZCr7+k+SOkZ30iWgCphpFy4q1xdv2DB8Uot4LbJR0ii31s9fmvRpC5kD1xTWsg==
X-Received: by 2002:a54:4803:: with SMTP id j3mr19147480oij.279.1643653481769;
        Mon, 31 Jan 2022 10:24:41 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3273722oti.49.2022.01.31.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:24:41 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Taniya Das <tdas@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc7280: Add camcc clock node
Date:   Mon, 31 Jan 2022 12:24:29 -0600
Message-Id: <164365345128.3009281.9709804910453196821.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
References: <1635070162-21669-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 15:39:22 +0530, Taniya Das wrote:
> Add the camera clock controller node for SC7280 SoC. Also add the header
> file for lpass clock controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add camcc clock node
      commit: 7b1e0a87730e32aac0089182c8cfe3b5fa6434fb

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
