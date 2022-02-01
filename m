Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F534A568B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiBAFVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBAFUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:43 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03ADC0613EB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:42 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso7027936otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxUIbjg3SvCLBVXCrv9jIsGx71GsTQ6qIWnsAt6VTbY=;
        b=BiSXSMEsNtBTkDinyXlJ67kpwdj31ar6lPoZA/5iikJbtUTbyv+x8iSa7vv7ZCPYq6
         R7Nv0ANSJk6YgAKMwKENalGwcFVeYxJ7V2bekO9F5h1eAxArRCkEJ+lG56yEr9XWpOxd
         j2UrqPc78k5N69ULMd+CcgKOfYHmCINMvzaZAjVplmKnLYhCFakcrm4CQledQ5fmW064
         2J0OepZDuPZHszaOu2m/zgWix3+PDZZGPT2LMzNHLZVSXKE7Jp/jdpgT+cVMmsIampR7
         hre70NoxFVAjnX75mUVPc1J863wP7tru5EaM0vZP9LKpUoOAE8n6/QQyI2vekIi4LFOB
         I8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AxUIbjg3SvCLBVXCrv9jIsGx71GsTQ6qIWnsAt6VTbY=;
        b=h6j1qpZsxgOUvCzV956NYqRPdRqHYmKyXt0EbvVK3kXQLd40kz51a1EdzFoDYl/gGf
         LJ5gN5amZcTebwtptACMRIPSuVE55S5yEl9HANbvHi6He9u116noI9Cq0UuResBVw+lG
         Kt2/30TDU7EEGDlbQ0gFQefm7BpUUYenmYSWRBc64bVaZ4CwgoBG8uZ6zFMVbPQRLVaL
         Eu4wmSKKEmEwVEyI7zp7GjKcrPL0g/4TAalqBl2jm/re16p/XfYsrjfSj63C7KnZIqN3
         KNMtSYGF7pMAsJ9xDAqX6lD5F4BSz1vNYrgVabzmuOhYIglD2eSwZ1NstdJcj2BES4Or
         KXpw==
X-Gm-Message-State: AOAM5300KP1vURsRbOG7DIjH+Q+U83CmBGBaq0KvuT2we5LmCt1aX7Nj
        GLAExgNpwsExkAWgFgxcIMnPGw==
X-Google-Smtp-Source: ABdhPJz7xSZzfdlELJEKFP+8VoUH7pamHFIqMvwPRNtJNI8E/x0hnVAHOllmRicnrMtz2Q1gMZswNw==
X-Received: by 2002:a05:6830:1084:: with SMTP id y4mr9564994oto.42.1643692842301;
        Mon, 31 Jan 2022 21:20:42 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:41 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: Re: (subset) [PATCH 0/4] Enable display backlight on Fairphone 4
Date:   Mon, 31 Jan 2022 23:19:51 -0600
Message-Id: <164369277344.3095904.11289204126111973872.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229170358.2457006-1-luca.weiss@fairphone.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 18:03:54 +0100, Luca Weiss wrote:
> Add and enable PM6150L wled which is used for controlling the display
> backlight on Fairphone 4.
> 
> This series depends on the recent wled series by Marijn Suijten,
> currently applied in the for-backlight-next branch of
> kernel/git/lee/backlight.git (or linux-next).
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: pm6150l: Add wled node
      commit: fe508ced49dd51a700c0f9ec7826d523cfe621b2
[4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Configure WLED
      commit: 7a52967d9050f3e430373bc51c56865b49a38573

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
