Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7646315B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhK3Kqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhK3Kq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:46:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so43316556wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTHuYMzNLIH+1EREfrK23LGcaA/r+2HAUHMYWHTbK0E=;
        b=8AU4j1dXGyXQzi/uOV/ptlQLu7n5vNfIJWecdLQT8PxPK+4CrdkZuL0dYAlvoQAo6H
         FAJwmS6/QbMdGcwjzTy9aqSwkf2ZDQsf/JySYiSf960T/oGHLCNcUOL6zDmk7Nz5pT39
         KwjTdt3e0FqwJvf+OrfwS6Ox5WH8KASJeRlVXV+T+Rtf3p5BN+gHeBtVD16fAd+driri
         p+cZlg5qaXkJDH4Z3cKkm5HiuWLS1iNG6N3XBGI3IZwq9XDmzfxykAo9+Uj4Ax867M1L
         UNyRBr18fT66sHHaZ4HHCmnH4uCwVNIwpDzHIGnQwfpdZg1Ks99CF7xNbARs/Qz/ERGT
         uSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTHuYMzNLIH+1EREfrK23LGcaA/r+2HAUHMYWHTbK0E=;
        b=givEkBAf7f3n/a9paLqcHDRJGwDmD5nBSAnrlZo6VmJnE90Oy0Z2hRjfTDvMJ7CxGN
         YtmrzDQ5/F742gs5dsEnvKpwcnOigQTHOrchuQikcUzZjhRXqM/TCwTW7orQSahJfgiA
         wCJHWB+2hZloNPFsFu/8Dm7BOtatnXpxC3x94ELnwc8+zCNV+lZ4fzhnvs61WeP+BIyo
         cZLKz4Yr0o90fpOcAFWakKzAV7GH7rkDIOdSXWYdjBpmXiYQXQT5pqb4HYemESHvv/d0
         SJhrA9xbiam8/EAoAJBh5y1RcSZ2Jp+7qEqSRdvNt78kf87ojK92E8J38zECV3IqwzgD
         g7jg==
X-Gm-Message-State: AOAM533LBBMGuow6Y2pMhFQsgSmBUuLDR3iFDwzPqniXXIBJ1/Ld8+/p
        S1ImOQ+uhssPHtzDugsnMZsgug==
X-Google-Smtp-Source: ABdhPJxoxwtLa58DHcN5BX/aqFazIPZzvKQDcbKnJ8TD0G5IhqcDtB/Vhcs6l1jpvcR/iGcYKHg8XA==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr40916159wrp.29.1638268986722;
        Tue, 30 Nov 2021 02:43:06 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a])
        by smtp.gmail.com with ESMTPSA id g13sm21775686wrd.57.2021.11.30.02.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 02:43:06 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Vyacheslav Bocharov <adeep@lexina.in>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: meson: fix dts for JetHub D1
Date:   Tue, 30 Nov 2021 11:43:04 +0100
Message-Id: <163826896367.1309037.1000352899984422910.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125130246.1086627-1-adeep@lexina.in>
References: <20211125130246.1086627-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Nov 2021 16:02:47 +0300, Vyacheslav Bocharov wrote:
> Fix misplace of cpu_cooling_maps for JetHub D1, move it to right place.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/dt64)

[1/1] arm64: meson: fix dts for JetHub D1
      https://git.kernel.org/amlogic/c/03caf87822220b4e22c349d170881d122df0b349

-- 
Neil
