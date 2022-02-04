Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94F4A950A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354927AbiBDIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352148AbiBDIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:23:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36247C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:23:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso4896811wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoPvGGzXerErReeFppgzdtNkqWy9wD5WssaNJIiZPAw=;
        b=qAz5EkaTZsfsTLh1I6QgmoLeMggzHNVtoruhvmek+PN5S03il39jVkDg9XSuFL/15H
         BMeUWIOxFtE6gKfREYC5rGLvh/G+sr5I3fkqsfxz3KKDRantZ2aYm2oJDo5MVtInsPpF
         Vg84QUlgZAZC1hlGL8rxzsdE8QtolELENIa3m45ocuQsfJqr6Zx7c7/pZhonPfyA0wex
         TZgKDlm1lEjT6m6AUESdCXTVAeN6unUckrfKFO5vQVeW6akFRVw9r9WogICoWfgsZaGy
         Syw6MtoTCthoBy+S19it+H4A275Y33s7KDS1TG+7ulAsTPmz/cuh+lNT8NLiMqcNf4od
         Cdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoPvGGzXerErReeFppgzdtNkqWy9wD5WssaNJIiZPAw=;
        b=O5YgjQaRx+e/Vy5cyXnDGiqbvYfUTzpKuyARC5YZUu7bu6Ifohgwyg/6K7Ekw1ipCy
         0WRJV+0FaDdc8Yj5c+NX6a0fyR9JvSYWO8HyHxYp3QbqENVTyz2qKpX0oVaTZEZeoAZ5
         x9MbfGnHgkRqVZ+8mbW+G47GgjvZ2uiewKDm9r7PDtWMAlxjJIh5Fjj7lQuZdrduQf5C
         OkiktlH2fMLJ6ED6FQbDxkAcKmQi+pVOpv7mSGjEZ0foOGaYaZYVpPYewbz13k/5j6mf
         cWZ9XyORF6BjmZF01hCYXtP/o47O87+0YZE8cpuFyBHuhE6GcsOIMbhD0MVSRLGT0KtN
         jY8A==
X-Gm-Message-State: AOAM533zElnBY+sgLBn7pfD9bFd9YZOp2cYyP8/x/cwZ/MFGOmyG4snH
        1/J2+JJhaDkMrTIMjPlZSXe5Pg==
X-Google-Smtp-Source: ABdhPJw1Bomabprev4G5Jse3YWUeThRqx2iBXXS6w/R8YqCmRa+dipbHD0p+G10Qc6MuisMWmLc45Q==
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr1205575wmi.161.1643963004720;
        Fri, 04 Feb 2022 00:23:24 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id s22sm8914078wmj.38.2022.02.04.00.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 00:23:24 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lutz Koschorreck <theleks@ko-hh.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: meson-sm1-odroid: use correct enable-gpio pin for tf-io regulator
Date:   Fri,  4 Feb 2022 09:23:16 +0100
Message-Id: <164396299209.31118.6606096108779211673.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127130537.GA187347@odroid-VirtualBox>
References: <20220127130537.GA187347@odroid-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Jan 2022 14:05:37 +0100, Lutz Koschorreck wrote:
> The interrupt pin of the external ethernet phy is used, instead of the
> enable-gpio pin of the tf-io regulator. The GPIOE_2 pin is located in
> the gpio_ao bank.
> 
> This causes phy interrupt problems at system startup.
> [   76.645190] irq 36: nobody cared (try booting with the "irqpoll" option)
> [   76.649617] CPU: 0 PID: 1416 Comm: irq/36-0.0:00 Not tainted 5.16.0 #2
> [   76.649629] Hardware name: Hardkernel ODROID-HC4 (DT)
> [   76.649635] Call trace:
> [   76.649638]  dump_backtrace+0x0/0x1c8
> [   76.649658]  show_stack+0x14/0x60
> [   76.649667]  dump_stack_lvl+0x64/0x7c
> [   76.649676]  dump_stack+0x14/0x2c
> [   76.649683]  __report_bad_irq+0x38/0xe8
> [   76.649695]  note_interrupt+0x220/0x3a0
> [   76.649704]  handle_irq_event_percpu+0x58/0x88
> [   76.649713]  handle_irq_event+0x44/0xd8
> [   76.649721]  handle_fasteoi_irq+0xa8/0x130
> [   76.649730]  generic_handle_domain_irq+0x38/0x58
> [   76.649738]  gic_handle_irq+0x9c/0xb8
> [   76.649747]  call_on_irq_stack+0x28/0x38
> [   76.649755]  do_interrupt_handler+0x7c/0x80
> [   76.649763]  el1_interrupt+0x34/0x80
> [   76.649772]  el1h_64_irq_handler+0x14/0x20
> [   76.649781]  el1h_64_irq+0x74/0x78
> [   76.649788]  irq_finalize_oneshot.part.56+0x68/0xf8
> [   76.649796]  irq_thread_fn+0x5c/0x98
> [   76.649804]  irq_thread+0x13c/0x260
> [   76.649812]  kthread+0x144/0x178
> [   76.649822]  ret_from_fork+0x10/0x20
> [   76.649830] handlers:
> [   76.653170] [<0000000025a6cd31>] irq_default_primary_handler threaded [<0000000093580eb7>] phy_interrupt
> [   76.661256] Disabling IRQ #36
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.17/fixes)

[1/1] arm64: dts: meson-sm1-odroid: use correct enable-gpio pin for tf-io regulator
      https://git.kernel.org/amlogic/c/323ca765bfe9d637fa774373baec0bc41e51fcfa

-- 
Neil
