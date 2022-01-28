Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9849EFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiA1AiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiA1AiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:38:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D98C061714;
        Thu, 27 Jan 2022 16:38:15 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z1so2823746qto.3;
        Thu, 27 Jan 2022 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NEtqARvV8XL726RAo68zVygz3uajpfAwMjDNLByJDQ=;
        b=fBNtTWhfh0e2aupYsSMkm0mnr2auxfUY4KzigBbUxuOVVU4IqIa7omg+3VRdYc0AKg
         QWvZrIl6JvCBPX4ownFqt6FIKka0D5MIdAX+lUDU+KvrkbX4KmRiuKYpAxtsWSKBmzWM
         Y2IjRCK74mxaaxb5LdY0aJ7G2+Rfy7yHndEGXWj3IznuEqesufw+qdi6eNL+uQfS4ocw
         C38/pBtqSr0W0ULk74ustaxL5xRjNHA8tt36FfTRMm20pIn8R6ww1EV10aAm/trnoLko
         G7XGtvHgI4kIL8UZyt5CvLo9iuvCvaOv6/Y8vXEYebTCbyxS0R6Z3JPs+MWv/9BUbjnj
         /8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NEtqARvV8XL726RAo68zVygz3uajpfAwMjDNLByJDQ=;
        b=qDPYGLoxVCjoZQ4Q8CAJ91xc4gW9v8MC3RJ/nmGu28TBWyXEaElhfvx4U1kl67/lVB
         70x+m8NoXraqHJehvolIZ0sWXluNCYZqVmyGDmsQWUvxOOkX3dGU0TfjZTcgCUmyDLjD
         5B+QXwPqLGDsy2FjBktBD9CvdmYAt8cFUYkSKDw+WAxDJ2BQdkBfiWgQZPWfEx8extCX
         ba/1BH+6FAKPAbJO0Q2eKnFmxoburalYhhfDHy6piv9p+2rKbnffYMDI7J+yc8RKwOPj
         NmcKMEnOIgLPRn0c6uJAItBsbkJYGkRPR6h2RA76jhuf07KRSusCMOMf/OKxBRZuCm1o
         hHNg==
X-Gm-Message-State: AOAM530lkYgHvW0JnGNHSig9nc2OzNM02HOSVQ/rcfDExLh63xhB4LEf
        lhyLogovIe3OanuTRj5LvOBBqprb002aiQ==
X-Google-Smtp-Source: ABdhPJwPHM2kqUrjC52kNZQDFaRBJEfsKeyyunuAJ0urBsruwsOfWYejieqgaQCjSHcLQUyEbAgTsA==
X-Received: by 2002:a05:622a:164e:: with SMTP id y14mr4503923qtj.471.1643330294894;
        Thu, 27 Jan 2022 16:38:14 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t1sm2142883qtc.48.2022.01.27.16.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:38:14 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Quartz64-A fixes and enablement from 5.17-rc1
Date:   Thu, 27 Jan 2022 19:38:04 -0500
Message-Id: <20220128003809.3291407-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good Evening,

This is the first of several patch series for further expanding
Quartz64-A support.

This series has the following patches:
Fix the ddr regulator voltage.
Add pmu_io_domains to permit sdio and high speed emmc support.
Add sdmmc1 node for wifi support.
Annotate con40 functions and enable i2c3.

Please review and apply.

Very Respectfully,
Peter Geis

Changelog:
v2:
- drop status = "okay" from sdio_pwrseq
- drop disable-wp from sdmmc1
- move reset-gpios to be alphabetical in sdio_pwrseq
- add con40 annotation patch

Peter Geis (4):
  arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage
  arm64: dts: rockchip: add Quartz64-A pmu_io_domains
  arm64: dts: rockchip: add Quartz64-A sdmmc1 node
  arm64: dts: rockchip: add Quartz64-A con40 hardware

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 81 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

-- 
2.25.1

