Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2D48D4DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiAMJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiAMJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:12:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09265C034001
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:12:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so2321615wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eVWPKFszyFBjxfc9/yhuv9HXCB5L9Mjwe4xyLGsHZQ=;
        b=TcpcHSYPtKCWa70bXBcRrJpkvUOGrBQCFeS9bSeicupmuRi/Wc/vjagaeNvO869dqu
         rOH2Jf9rD72ajvLdW9gQV+XsJ10ca1nQ+XwriEZ2Z5UxiUmc6drXwb7Avu0gmM2wHhsi
         FmdxqkuykXE7g4jSc4DEbrYEfR1wY5jAegI6azi/uodGqD0KImFNo2s0Cw0q7eLLfzjg
         4i1/U2TyoYIwaLFwAdRBilEml8u7OnOR9Xj6qB85WW/BbyVonlnPzhrG3oXlcvGHI76s
         FS1RpxrwHcgpSqSEwcfyhv8Sf7cGW+ltLU12nZykZj7ELt3pCDyIreFZdQuIEti60pnI
         0c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eVWPKFszyFBjxfc9/yhuv9HXCB5L9Mjwe4xyLGsHZQ=;
        b=D3K0hrP6JsoCuE9HACwnGlT/aFeGXsw7/k6yqrBXn2dO8BMjhHQqJkjMKNPpg6ZWbb
         vvindqyF6TYKPVcwbzV7kYN4YEnfXM3koUCpqGDNFgUByuFedbOzjDMA7BcxF8hnE9IA
         5Zj1E52ZrDaDur6cTLDxs3lUmxARHiARX6pxVO/+DebunHGdiu8n7cB0SZzluyWWFr4T
         y8Fel337NBNsMH17X2RiwfWZIdUmbJrmPn7KSXH27NFH/Nc9LX7crmtnHKG53v2clIuz
         1HbrbKMr9SLIq02ceL3VN+AgTO7OnASZxnvPAu/M7P5fuH/1rbudHRTD1EXVdeKqHO4q
         ZJWg==
X-Gm-Message-State: AOAM531c2LjZMOZ+JCdxY9lRWzcH1zflD6WQhUKxSvHeOz4A36f5U8wH
        r3KkMENDqKEfFcheaAMggJF9Y8N5s895og==
X-Google-Smtp-Source: ABdhPJwwuk0lJd2q9B0XQRjlxLNr4+VHWmnHeE+pxSHGCjPezBRiTpnT1tTjk942qIhQTg+waquDYw==
X-Received: by 2002:a05:600c:3d93:: with SMTP id bi19mr60037wmb.50.1642065156503;
        Thu, 13 Jan 2022 01:12:36 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:bece:ab45:7469:4195])
        by smtp.gmail.com with ESMTPSA id m15sm2135702wmq.6.2022.01.13.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:12:36 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, kuba@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Date:   Thu, 13 Jan 2022 10:12:34 +0100
Message-Id: <164206502761.1011244.11952182860924885505.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104145646.135877-1-narmstrong@baylibre.com>
References: <20220104145646.135877-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Jan 2022 15:56:43 +0100, Neil Armstrong wrote:
> This adds support for the Synopsys DWMAC controller found in the
> OX820SE SoC, by using almost the same glue code as the OX820.
> 
> Patch 1 & 2 are for net branch, patch 3 will be queued to arm-soc.
> 
> Changes since v1:
> - correctly update value read from register
> - add proper tag on patch 3 for arm-soc tree
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git (v5.18/dt)

[3/3] ARM: dts: ox810se: Add Ethernet support
      https://git.kernel.org/narmstrong/linux-oxnas/c/ae552c33f6edad1097dec7a5543314d35d413b3e

-- 
Neil
