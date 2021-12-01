Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38758464AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348197AbhLAJeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbhLAJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:34:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:30:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l16so50695942wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lQcO8ppUE7hejt9YaL1vY0mu8mVlWjuLxDwwyoQ/Tc=;
        b=TPS/DB745w+9fVWD0DQRKtMppF7KlB0l87RE7pzidy+9/mbqUxL8vX/M1184NjUfBe
         7YKDQ/M05Q46ZnY6vkb3QRJh2vZUKNrYP3bM/2ThfnMDlyrLwZNc5P2Q9aHNk4vYTM0V
         oCIqL0dvLybIN/uvq4qAPNJ+rn8HhMviIVvKD1RD1+FXCZGLDM2UJKhK8IUjezXV2BzX
         3q9758XE5U8vE3PwAUk+SdCqO4fIKydjYpG9cuAuaAEK15bwoJdJB/+cqk8v+zQ9b925
         wfp2+YwMqEKTVv1a0yP9JUcyNSMEsEU/fiTfhvRxLvAO+5mgL9QUgvbrbq5uzgBZWF57
         4j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lQcO8ppUE7hejt9YaL1vY0mu8mVlWjuLxDwwyoQ/Tc=;
        b=2tIGc8MKYp5EXSPSwifoivqezF5FuAI4+Z5x+p9xfrS0vwEET/vsRuzjZxJp7TQ4jw
         ApbNrncqtCbRZTdo7luS3/tY/fTj4OE8VWWVtw1AAFKmL/IURhJVqWV01gn6lOyqbhFu
         fsGGjoCkpyA3xsEtsBWnT1Dw0XCmBM6A61hpwep8wHmNuwio/lmZEfKkFADJ1Aa0QqTY
         Ty2VqPLKLkvF2eNTsuEYlH5UmETaAYiNuxcNFOAj4mywR4UquNQkZgztMSB+/Hro4erw
         1Bdeu0/ZiiECoLPO82k0dIltRP+6xmqKMY42eIolRypY8zPfeMfTMMYRnoJhrJUUtx2g
         9+2Q==
X-Gm-Message-State: AOAM531O+eFmhyN9SwUH7fcmEAut0Pm/g3T/+vyz3TCgwIywn8uAsmg5
        aulrcKAPhmbcKZtdbKn/9R/fOQ==
X-Google-Smtp-Source: ABdhPJzT1IuhrS2TGDdSq4UiTp/L1srB/g3ytBrh3irQ8SUHGP9eItEtK+ItCJezZ8CSKR403NLT+g==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr5345728wrn.337.1638351040539;
        Wed, 01 Dec 2021 01:30:40 -0800 (PST)
Received: from bojack.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h16sm20066480wrm.27.2021.12.01.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 01:30:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arm64: meson: remove COMMON_CLK
Date:   Wed,  1 Dec 2021 10:30:38 +0100
Message-Id: <163835101636.1348067.15879754302967719702.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609202009.1424879-1-jbrunet@baylibre.com>
References: <20210609202009.1424879-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Jun 2021 22:20:09 +0200, Jerome Brunet wrote:
> This reverts commit aea7a80ad5effd48f44a7a08c3903168be038a43.
> Selecting COMMON_CLK is not necessary, it is already selected by
> CONFIG_ARM64
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.16/fixes)

[1/1] arm64: meson: remove COMMON_CLK
      https://git.kernel.org/amlogic/c/5ad77b1272fce36604779efe6e2036c500e6fe7a

-- 
Neil
