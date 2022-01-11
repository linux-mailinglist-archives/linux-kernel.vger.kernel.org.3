Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38348ADF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiAKMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbiAKMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:55:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA7C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:55:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d19so2275279wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=57Y0hIfgAIJ89OmSynFNgC5ocn5dJaAs87HGBZ8fZcw=;
        b=jJqOP1MveCsbkZSgYuQHcNgO0q6oPiaR+7ThlUhpU2KMIoos6D4XEcRRxhEOP/vZPh
         sUr9s9gNeJ3hbu0yb6PNdSGC5xF9DGc2Fx9dupds2L9uQbxKT9YgN4UakvVu3O9pz2KD
         ZQmtn3y60ivSQp6seh2N5cHEYgHIuk2ZUEkS5YEVUPvMmZPTjrekW0I772K8hK+YAYuh
         TbyWa7TlkDDP6sRG4bT7IAtboSFvz5Ukoe/743Cjh0eoqrhVoRcyIzy33XLfJZ4NQ2uZ
         VgLkbpZcmr12+mXWFnpPQKxQZ9I4lJc2xI3OFFFurhU2m5p1lfY7bVL8xEAnpUkvbJsI
         FRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=57Y0hIfgAIJ89OmSynFNgC5ocn5dJaAs87HGBZ8fZcw=;
        b=mUO2bngsf0IkjX87yVBuDu3C7ZDQCIsYKNgP5knFnsIZEIaPvvGE5mKWtPoythTi9i
         jaC2JYdOgV6wEFW9X4dBCjGswpIHMsqqJHrb+/JgNXPAjIQJ+49r+ElygLZ3n+fJvnpr
         9NMQn9csjolCPTRXDZ4OI8o14YOhgO5zXMDT0n0PvpefPtYHAKx0WxgJfjfm05+AV1mF
         urY+qMfURWtc0v4tpevZYfHFTIlliKhTa383NSawmhtswaCo6pFP1o0MCXUm6VUnORgj
         OjTqc+VA3IhBmSJ/V8AVHNggyd6jv3NmLczxmy7Ct1DMy8BbXCrFJOv4hbNmDsc5h4kG
         ulGw==
X-Gm-Message-State: AOAM531TT+GGYT49Yg4KPzQsDi+SjyAQhrUwTVvLBfuLggyZuEfRoHgx
        wClR4Lt/u3swlCZzPOr+t8kvPh7vZT33SA==
X-Google-Smtp-Source: ABdhPJzrCAcjmrbeyYbwcKChMCvz18TUjVmYfvNiqQHfKfZjBrQOmgdJSBnHOc1xR3mXTN2FdUz1Iw==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr2980555wrv.215.1641905730944;
        Tue, 11 Jan 2022 04:55:30 -0800 (PST)
Received: from google.com ([31.124.24.179])
        by smtp.gmail.com with ESMTPSA id e12sm9816934wrg.110.2022.01.11.04.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:55:30 -0800 (PST)
Date:   Tue, 11 Jan 2022 12:55:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Backlight for v5.17
Message-ID: <Yd1+NuCAGxhsFNR6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.17

for you to fetch changes up to ec961cf3241153e0f27d850f1bf0f172e7d27a21:

  backlight: qcom-wled: Respect enabled-strings in set_brightness (2021-12-22 11:18:46 +0000)

----------------------------------------------------------------
 - New Functionality
   - Prepare and add support for ACPI enumeration; lp855x_bl

 - Fix-ups
   - Use Regmap API to conduct endianess conversions; qcom-wled
   - Remove superfluous code; qcom-wled
   - Fix formatting issues; qcom-wled

 - Bug Fixes
   - Provide error checking/validation of DT supplied strings; qcom-wled
   - Request dynamic amount of values when reading from DT; qcom-wled
   - Fix off-by-one issue when reading from DT; qcom-wled

----------------------------------------------------------------
Hans de Goede (3):
      backlight: lp855x: Move device_config setting out of lp855x_configure()
      backlight: lp855x: Add dev helper variable to lp855x_probe()
      backlight: lp855x: Add support ACPI enumeration

Marijn Suijten (9):
      backlight: qcom-wled: Validate enabled string indices in DT
      backlight: qcom-wled: Pass number of elements to read to read_u32_array
      backlight: qcom-wled: Use cpu_to_le16 macro to perform conversion
      backlight: qcom-wled: Fix off-by-one maximum with default num_strings
      backlight: qcom-wled: Override default length with qcom,enabled-strings
      backlight: qcom-wled: Remove unnecessary 4th default string in WLED3
      backlight: qcom-wled: Provide enabled_strings default for WLED 4 and 5
      backlight: qcom-wled: Remove unnecessary double whitespace
      backlight: qcom-wled: Respect enabled-strings in set_brightness

 drivers/video/backlight/lp855x_bl.c | 134 ++++++++++++++++++++++++------------
 drivers/video/backlight/qcom-wled.c | 130 ++++++++++++++++++----------------
 2 files changed, 162 insertions(+), 102 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
