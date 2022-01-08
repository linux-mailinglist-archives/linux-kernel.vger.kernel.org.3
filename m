Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F074885DB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiAHUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiAHUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:20:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF9BC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 12:20:26 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q14so8626105plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M8nlxjsax+tZ6u93885GOWQETnXbkgAORedylCcReuk=;
        b=B7YLPMm0tPwaRcCRkC3c3O5rHpeMkKeuUwWDtLRZOCupmRem/ZNZwPxVvyt7AMKRMh
         2zmKJH7hvvDjOdvDngWh9RGFwJwphNQ4VKJvdX3Br6LgLI64TesIMe8hnXxrck2+viGk
         Dr5JRoyUqiqUlsl6eb+d96bzcoK/m3qkppCHT3YhczXLpQg7UVari/erbWnTbRsRxGOD
         qJYp6MLevdN57JiT90gtYphIeCMglCmC8zGo0PPe3/dfjWfM8Qh3NQ+6fOr5VFXRsHJW
         4CHXQg+xz7CLFddqsqt6A08umOjND6jawCni/jFJD+s85t54XuFAQpjhSeFsTFFSi9ha
         9/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M8nlxjsax+tZ6u93885GOWQETnXbkgAORedylCcReuk=;
        b=V9sFJVCMT4N5JJSk7J/CXL+wswYOAJTXWnXanlfF26LB7sDGnYbyhzptccUFga9pzR
         cyA23bs2HYDzbJV18AGbZDnJOyqokMP7wfC29W4NqYDMFXnjSlbv6T8/IU4fdjrUUlzN
         gbOEyJwCZ4YYTtAI6eJRv7lWsc0tIpP32OieOvXbA9UeuHuOqpoC3RMIHI1UHjIjbewc
         3rR37Sme06Zs7omlDhOgjOHtth4kPGqBVKC7KgboS050BEdZIpNDUH63Pk0BpDb7cU55
         59c8f8fmHSd+elXa2qyY55K+yaeJee4wm79mtMVLptjGj7bLYNqHdDMif0NuATvXbfa3
         8B2g==
X-Gm-Message-State: AOAM533Jt7LX9dIYzCs1bnraPCQRsYL0WziEYyAhfv404GqyaYzn8FEN
        NBpel63cTnwXDlK6vv9wNehjP/CTVLU8uQ==
X-Google-Smtp-Source: ABdhPJxil+u06qw/bUKv6pIt1DhMgft16Ye8bg9TyK17pH3MkElpfotxEL/Ko5m9d4NGvM2kHOEJ1w==
X-Received: by 2002:a17:902:e84d:b0:14a:2b59:7779 with SMTP id t13-20020a170902e84d00b0014a2b597779mr161221plg.38.1641673225576;
        Sat, 08 Jan 2022 12:20:25 -0800 (PST)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id j17sm2780550pfu.77.2022.01.08.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:20:24 -0800 (PST)
Date:   Sat, 8 Jan 2022 12:20:11 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SoC: Fixes for 5.16, part 4
Message-ID: <20220108202011.GA1760@lx2k>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-5.16-4

for you to fetch changes up to 8922bb6526ac4b20bd8de7f47d6e77808670f6c4:

  Merge tag 'socfpga_fix_for_v5.16_part_3' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes (2022-01-05 16:18:50 -0800)

----------------------------------------------------------------
SoC; Fixes for 5.16, part 4

A few more fixes have come in, nothing overly severe but would be good
to get in by final release:

 - More specific compatible fields on the qspi controller for socfpga,
 to enable quirks in the driver.
 - A runtime PM fix for Renesas to fix mismatched reference counts on
 errors.

----------------------------------------------------------------
Dinh Nguyen (2):
      dt-bindings: spi: cadence-quadspi: document "intel,socfpga-qspi"
      ARM: dts: socfpga: change qspi to "intel,socfpga-qspi"

Heiner Kallweit (1):
      reset: renesas: Fix Runtime PM usage

Olof Johansson (2):
      Merge tag 'reset-fixes-for-v5.16-2' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'socfpga_fix_for_v5.16_part_3' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes

 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
 arch/arm/boot/dts/socfpga.dtsi                           | 2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi                   | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi        | 2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi            | 2 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c                  | 7 ++++++-
 6 files changed, 11 insertions(+), 5 deletions(-)
