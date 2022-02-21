Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653D4BD7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiBUIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:25:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiBUIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:25:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D3219B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:25:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i19so9010500wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtxBmeOXC9JY2medDRrYSSTNzMcetLrIdHLgGlB77Vo=;
        b=kZj0ZPJi5Rn/Ledb5Qn5+fHEFZqPJV8hDipfpQa+OlYs3IGumEzDR3Ko5IziRAYDtk
         OY0aRY/Ln+wFUiAJ350VXcf1vBGH9nMtgnxWfbtRV/78G6gxbz3kqDjSL6kOktJN8Ad3
         DvBvd/4imz+F/6NtHWFxKe8gThzidTTBkbwv1tv45cM/FFu0hdq+Nn6+sg9wayudfzd0
         S8s6e36z7F7pR1Um/NLEXHoF//puL0VwVu8O5I+pPMMwoFKQqDmKHDg//8+fnb9lctVg
         IYwaaenDBbVPV/d8Bvh+Ug28MP/okaFK/YFXRY0qm4sHteBreuGvIiA9VkTkCEqJwHic
         ATJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtxBmeOXC9JY2medDRrYSSTNzMcetLrIdHLgGlB77Vo=;
        b=dcyFoZ4iWQx/czgXKcMWL5+dI2MF/pvdGjONUMLP0QUJl20WCCGW4o4Bm+1u/qkwBQ
         dzwn82JOd7YbPjQmnZHvBosaVmtR2nDaEZ21vO8RQV+9L5FTiUA5nw0Sx4M47X+HTS52
         aWoB8Q7YVPa8zwePXZZmIKhIjDdXh1yt/jNrkZRQj6c1nUfjJNQbd52qXzN0mTgXuU5t
         7xEWutC6aGM396u5iJMEzAUYAB0miVz6hB7oJ/vYMdaEpuYVX9N9rmASPJaf5QY8fpoR
         eJ8uROVd7Ss8JUq4AmpDlF0tunLEE7mwzosyRk2sBHaxTptbTPGwQ0Q2LK6AnWQUD4iC
         Unpg==
X-Gm-Message-State: AOAM530+LhWu+9eHSJzmvwaW7qsRo0zwpPsmeaYIvXLVPtCrxy2wziAZ
        OyT60D5+vHp+CFhYbh9GtSzaIg==
X-Google-Smtp-Source: ABdhPJwfUY2Exdd7ZUJLotq3D3qwt70QY/uo/prkHK4RJ7kTBcqoqAfFpREMtYJAF62kh96pY29mPw==
X-Received: by 2002:a1c:6a03:0:b0:37b:dda6:4259 with SMTP id f3-20020a1c6a03000000b0037bdda64259mr20501670wmc.20.1645431909129;
        Mon, 21 Feb 2022 00:25:09 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:77b7:547a:df0c:28d8])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c379900b0037bbafa37easm6732025wmr.31.2022.02.21.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:25:08 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: add support for OSMC Vero 4K+
Date:   Mon, 21 Feb 2022 09:25:06 +0100
Message-Id: <164543190117.17295.2849143887503486162.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211105311.30320-1-christianshewitt@gmail.com>
References: <20220211105311.30320-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 11 Feb 2022 10:53:08 +0000, Christian Hewitt wrote:
> This series adds support for the OSMC Vero 4K+ Set-Top Box device
> based on the Amlogic GXL (S905D) chipset. The Vero 4k+ is notable
> for being an original Linux (not Android) STB device, running its
> own Debian-derived 'OSMC' distro. Big thanks to Chad Wagner for his
> help with testing and device-tree fettling.
> 
> Changes since v1:
> - Address device-tree comments from Neil
> - Add Neil's reviewed-by to patch 3
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/dt64)

[1/3] dt-bindings: vendor-prefixes: add osmc prefix
      https://git.kernel.org/amlogic/c/41654043226f517a8b37cab34f1eab5c6ef16947
[2/3] dt-bindings: arm: amlogic: add Vero 4K+ bindings
      https://git.kernel.org/amlogic/c/3f7dbd336f360a76103153b85ce616b86d85c6cd
[3/3] arm64: dts: meson: add support for OSMC Vero 4K+
      https://git.kernel.org/amlogic/c/d926a4fe25338e120ab49547de9707dc6e5e5824

-- 
Neil
