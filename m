Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4B48BFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351605AbiALI2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiALI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:28:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F60C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:28:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o3so2701422wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwC54M20s1dVwJYZKIeIs2e8spLyvokky9vZwJUb9ck=;
        b=x6/HKkUeityEVr4mhv//xRzAfioo36Y/WXkvvyvxwyItbtDGVAk+0yaRroBkd+Rnsm
         MPQyeEocgqk0Vv6ZSN6T0fVXM3Xi+NmccVnOLqGF293nYmL1dQvNbW42V7VRtMVYKkH4
         KJ/b4AitjIvXYrwaeTHgrMyNoMyIIjb7xVVjH0bp0aYq25Ttie+TeiWLEdDOKcO/HKzQ
         +T+pYpidUnrcsobEJTV2KAB06hfEFXIBlOjd/zRJQSIBsPGtndselWoIzQFI5P1/XOXc
         bMTPg+u1zkwOIgKtk84X+ATw/Yb2gCpIomM/L5cHLRdKq/l6DTgtN++FQ5rjeE7mgirS
         0Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwC54M20s1dVwJYZKIeIs2e8spLyvokky9vZwJUb9ck=;
        b=3ktmWMVW9WPM4iAJnOUIxZHpYy1AD5hXdUXkaeGM7jpIP1zlCrrC7Hy9X5V5X99LY3
         qQR4VWGQsvurNyWnv1f3DqEBN9KGpA3K2Qk/+sqf/hgMW71HU0vtUAUbp11y0CoRNZTp
         TBzNimeglDcfJsYO/E8bucaYvvGc8iIZjP5F9FqtqArUriZOjmZuhYJGu2Gvq07hWUgP
         cu8Miz+0KpdHkCF7g6FCC36dPgtYusHesJJ+Rfm8t5WYloxTc5m6iFAEvHpoGChaWVDQ
         pYrnN8pwkGUaUWUwnUzwhbYvn9YHx6kPPcSHnzu7y9PCheQN7w5KtRsAyGscCsyeTdRe
         d4cw==
X-Gm-Message-State: AOAM530ekIzYlNhltFicR8C9Ldol+j/Ck4WsKvR8afy2+o53WTrAO7UF
        W9gbtgOG+0JTjQ5c5CEdHT9UnA==
X-Google-Smtp-Source: ABdhPJzc4CgOuLpsEHWv104iY0/uJKOak1yF9w2ZznHxADOXpB3TT9IcUg9Tc6+20UXeADP60LdIAg==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr1151301wrq.79.1641976108000;
        Wed, 12 Jan 2022 00:28:28 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id v129sm254846wme.29.2022.01.12.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:28:27 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        christianshewitt@gmail.com, gouwa@khadas.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        art@khadas.com, nick@khadas.com
Subject: Re: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Wed, 12 Jan 2022 09:28:23 +0100
Message-Id: <164197609473.825600.7789792176979118539.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215030236.340841-1-art@khadas.com>
References: <20211215030236.340841-1-art@khadas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 15 Dec 2021 11:02:36 +0800, Artem Lapkin wrote:
> Add spdifin spdifout nodes for Amlogic SM1 SoCs.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/dt64)

[1/1] arm64: dts: meson-sm1: add spdifin spdifout nodes
      https://git.kernel.org/amlogic/c/86f2159468d55aca1793c1f0f3d95213501b32f3

-- 
Neil
