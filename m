Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4047532472
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiEXHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiEXHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:52:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA64D9DB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:52:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so24474856wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=ZievVmUMWc6umqr7g2H0yqBs8jCp0deglZh3Bm0R8so=;
        b=pmsjgkxBZTWTO2Qvqk6mGnxvdOhUEsWtwG2ASLUXBGUOGM+hjjoCR5GrwkVsw44hez
         9cYc+CsEQN1Y/ZvBxTaRm98p9EnvWboAOSd4E36bo9U1JaALTr7sgPWhYZwVOL8lcxlU
         3eScL/J/Y3Gv0p3hpZzQb3DdhyzCEZZixBlH6raHE93SHJ9YIRhXI2jM5GPB9iIPY2NB
         jF9RPBUXQsPrtt6mXhs8yChJT7kGJjBOjI7WUPv/VxuZ+BWD2DClSPyfvcaDYaVwOfL+
         dqkiJR7SDXXBvbrzMJCb3QPT9liaG3Snun8pFhZ+7eatupVCLw6YTqnl0dO37rC+FOXX
         93Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ZievVmUMWc6umqr7g2H0yqBs8jCp0deglZh3Bm0R8so=;
        b=Agps+g6zNINQdvfdgCIZGqw+cIiDQg+ywdYGK+6Ble9/SAcKlqztjBUXHLSPDWAd4h
         tYZxkvD8lONibAM19PMOYSTfBPjXz+LRIwqSTnmo9aTyEdSdrQNcVDt38vHtev9xwCCQ
         EkZO7GafUAiOgna65wbNB1N4VIpdmlfVAEewNcr3u31rITYq5r+dJ1tfnt3r6UL+QMOR
         AuvruZ8ZG9l495tHDsWx4By8+JUPc5SM6Z+O4dChy0gzjWz/X0XkZuZQ8YDlc+VIeXYc
         wr6qfKOVReEw6V3fcL7Qck84N96VBHQlgzaP1o+gHgSrJ/pm5/tzyMcnvB0K8YDwQt0N
         JWAQ==
X-Gm-Message-State: AOAM531QZfHOrZV9UtXzQzAyNFrZHB6RuWws+QjL10ig2R42cRlycKRX
        VWSEbTMI7b3rWibipkqgB9wFRA==
X-Google-Smtp-Source: ABdhPJzafefRm9s70fbcZEESgenG3tdQpzR1qGn1FHZecrTZ3Y3KqVR+Lj3z5UBhsgDtA3BJxkPknQ==
X-Received: by 2002:adf:dc8d:0:b0:20d:bfd:2018 with SMTP id r13-20020adfdc8d000000b0020d0bfd2018mr21804447wrj.540.1653378730056;
        Tue, 24 May 2022 00:52:10 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id z1-20020adfc001000000b0020e5b2afb3bsm12180120wre.23.2022.05.24.00.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:52:09 -0700 (PDT)
Message-ID: <b5a83e54-1ee1-f910-4be4-bc3bf1015243@linaro.org>
Date:   Tue, 24 May 2022 09:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.19-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

sorry for this late PR, please consider pulling:


The following changes since commit 317f29c14d0cca09952f1022491454b23455ebcb:

   timers: Provide a better debugobjects hint for delayed works 
(2022-05-14 17:40:36 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v5.19-rc1

for you to fetch changes up to 9c04a8ff03def4df3f81219ffbe1ec9b44ff5348:

   clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return 
value (2022-05-24 09:16:29 +0200)

----------------------------------------------------------------
- Add Mediatek MT8186 DT bindings (Allen-KH Cheng)

- Remove dead code corresponding of the IXP4xx board removal (Linus
   Walleij)

- Add CLOCK_EVT_FEAT_C3STOP flag for the RISC-V SBI timer (Samuel
   Holland)

- Do not return an error if there are multiple definitions of the
   sp804 timers in the DT (Andre Przywara)

- Add the missing SPDX identifier (Thomas Gleixner)

- Remove an unncessary NULL check as it is done right before at probe
   time for the timer-ti-dm (Dan Carpenter)

- Fix the irq_of_parse_and_map() return code check on onexas-nps
   (Krzysztof Kozlowski)

----------------------------------------------------------------
Allen-KH Cheng (1):
       dt-bindings: timer: Add compatible for Mediatek MT8186

Andre Przywara (1):
       clocksource/drivers/sp804: Avoid error on multiple instances

Dan Carpenter (1):
       clocksource/drivers/timer-ti-dm: Remove unnecessary NULL check

Krzysztof Kozlowski (1):
       clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return 
value

Linus Walleij (1):
       clocksource/drivers/ixp4xx: Drop boardfile probe path

Samuel Holland (1):
       clocksource/drivers/riscv: Events are stopped during CPU suspend

Thomas Gleixner (10):
       clocksource/drivers/bcm_kona: Convert to SPDX identifier
       clocksource/drivers/jcore: Convert to SPDX identifier
       clocksource/drivers/mips-gic-timer: Convert to SPDX identifier
       clocksource/drivers/armada-370-xp: Convert to SPDX identifier
       clocksource/drivers/digicolor: Convert to SPDX identifier
       clocksource/drivers/lpc32xx: Convert to SPDX identifier
       clocksource/drivers/orion: Convert to SPDX identifier
       clocksource/drivers/pistachio: Convert to SPDX identifier
       clocksource/drivers/timer-sun4i: Convert to SPDX identifier
       clocksource/drivers/timer-sun5i: Convert to SPDX identifier

  .../bindings/timer/mediatek,mtk-timer.txt          |  1 +
  drivers/clocksource/Kconfig                        |  2 +-
  drivers/clocksource/bcm_kona_timer.c               | 14 ++----------
  drivers/clocksource/jcore-pit.c                    |  5 +----
  drivers/clocksource/mips-gic-timer.c               |  9 ++------
  drivers/clocksource/timer-armada-370-xp.c          |  5 +----
  drivers/clocksource/timer-digicolor.c              |  5 +----
  drivers/clocksource/timer-ixp4xx.c                 | 25 
----------------------
  drivers/clocksource/timer-lpc32xx.c                |  6 +-----
  drivers/clocksource/timer-orion.c                  |  5 +----
  drivers/clocksource/timer-oxnas-rps.c              |  2 +-
  drivers/clocksource/timer-pistachio.c              |  5 +----
  drivers/clocksource/timer-riscv.c                  |  2 +-
  drivers/clocksource/timer-sp804.c                  | 10 ++++-----
  drivers/clocksource/timer-sun4i.c                  |  5 +----
  drivers/clocksource/timer-sun5i.c                  |  5 +----
  drivers/clocksource/timer-ti-dm.c                  |  3 +--
  include/linux/platform_data/timer-ixp4xx.h         | 11 ----------
  18 files changed, 22 insertions(+), 98 deletions(-)
  delete mode 100644 include/linux/platform_data/timer-ixp4xx.h

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
