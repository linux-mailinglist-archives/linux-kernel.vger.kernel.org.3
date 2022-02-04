Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D14A9508
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbiBDIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353606AbiBDIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:23:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2DC061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:23:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so9775369wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf8akufeGhb+PPmP1SAbnaUbaBMJcqn9Z0xu1czGwCg=;
        b=AXj9j3dMMLt36X8aezSoIjs4fCy31D4QAFyxiNWb1N5hGx5LZtrttD5fHlnh46XWvA
         lJOYTG6wlZ63LK6qZTpj0EBTkYM70azohqkXi2CcAytWWV534Nv019b5tVc2qUbWRE7Z
         ulJPFz82hCyLdYUvh3lgGJT1fnxEKf7jC7IdV0yxBypM0AwYeExkbdDIM4QiRajYGsOD
         wr873VB9clThGIThv0Js/0h6PgQ9U2WZwhmZuoLLlPmw7+a8IT9qeReHKkviiEIb6whf
         iNHYBoAaVJx39cGlvM/VuHKvjOFqsliSRUkThbeqtGdkTmTO7dEyqlB/J4br/e5wx703
         WEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf8akufeGhb+PPmP1SAbnaUbaBMJcqn9Z0xu1czGwCg=;
        b=iQSDpJV6/AE15sxObNI5Z1uZuKVcdJS9TrpWPm2uJvo0K6Kh+3NexExUsb97ib2SeG
         69y7qY7FhiDCvelCX6LVc97zv5AhUWKYgbMw+aOdVdz5D2u9g3L3ppWRpEyPhbXFzZxq
         q+XspDlCWmyIFM3XamhA3/PYev0Mp1AzDdG9BZ1afIesaDNiJVYFWzVyy4qmMYBUO2HA
         GfXMZbuWdwzLchVivdkNaSNSqhT7rAaUAa5jJziYfC6oozMXe4OJ6ZeMyHWQI5/L7X8l
         0AzcJdCiYOIMGgxhN4kIVoHNP6h5XH7qTf3QErUIh6jF1oPJ4cBd4BFL+QybUwE/Oy77
         p2gQ==
X-Gm-Message-State: AOAM5323E7zKgyqaU6fuwGb6GcWhIrkhwUFzJEgf76ASf6wO4SorV36U
        gUx49naJhrlD8XLi/v/d6tmyYw==
X-Google-Smtp-Source: ABdhPJwgyM90qtmbsuXHi4DPp4XSzDTrhOZrcaVGWGmQn2thSj0asC/9RiSxtEgsaB+nyDIeoU1Rpg==
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr1491699wrg.199.1643963005941;
        Fri, 04 Feb 2022 00:23:25 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id s22sm8914078wmj.38.2022.02.04.00.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:23:25 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Dongjin Kim <tobetter@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
Date:   Fri,  4 Feb 2022 09:23:17 +0100
Message-Id: <164396299209.31118.14013385169843675577.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YfKQJejh0bfGYvof@anyang>
References: <YfKQJejh0bfGYvof@anyang>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jan 2022 21:29:25 +0900, Dongjin Kim wrote:
> Typo in audio amplifier node, dioo2133 -> dio2133
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/fixes)

[1/1] arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
      https://git.kernel.org/amlogic/c/bc41099f060ea74ac8d02c51bd0f5f46d969bedf

-- 
Neil
