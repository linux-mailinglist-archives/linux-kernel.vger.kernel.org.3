Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FD4595BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiHPMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHPMWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:22:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3798357D9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:22:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu15so3919924wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K+gdbXGX7sTipYoI1hbcvxGCF62qNZJxUQfUKALJAPQ=;
        b=653mtiOz+xhTjJvQu/Z8561OQZ/7yZgXascR7WHeo+CK7dRlhjy+Pq3wT3ZBDFJ21i
         oJKNjxmxmUdqt6mrGY8kvub3ZiKfNcp/lmuGeAxR7lihOi9dguTy8jHRrzinw44OVbnc
         CMs0onKkiB1dxcEIDMPewbFr5Q/sDl/Klvh0M9AGoiosBAzQSwblc7Y+XDsGdVbw0R4+
         RyQsMOhjiajyRExT1KhuTZG4x9qG5dGUHGptj2Tapqp1Iw+LBbJuZjn//AN3cOcfvtAV
         HDvCGQqRYvG+Y/Qff57TRjaY6Rn3dntmPB6ef9s7uLxe8v+zEGAf9ibCq/TMkJW5YDte
         LYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K+gdbXGX7sTipYoI1hbcvxGCF62qNZJxUQfUKALJAPQ=;
        b=WaltuE3Ad3hhiOaTFcZ8x5GfVWhVCQo2b/7M7Qx886fLjOdRvlGjJe6NhGv5t9XnOz
         34TQV0GaR715NWOlrWtAAsAW3ZflbJRMLP6HMypi7dMAZ5HcWAPqTap1ANcT3vwMbUm9
         ZcdhGDpXxXzaebLfGWr+cUV8XYE938KsfAB3xzPXq8VPCSCzFDXFhhZdSgagsfodGyJz
         Vh3ibeZo+WrQD5ty8cZgZzaPal4IuC6QcyDTKzXximBk+rdZ8Ln5i7kRZgiShCDCxXKL
         trt5VIS0wcJU9KeSICFUBXGnWQSTzX9VHAnMTrFrJqyePBOsSLtv/QqKeKNP3bHEmiqw
         pBsQ==
X-Gm-Message-State: ACgBeo0dbx8PSlwksSdBqYikC0Loq8DmCCegRu7GJ6mtMOL0VYizKZuo
        vCTIm3J8YKqj2PJ666mznmoDOu6kk/5+NQ==
X-Google-Smtp-Source: AA6agR4mWwoCuQHHvTE6vn6N3LqhAmKu+A7J3AQ88Wt275PoY4JM7vCv03znTgErhkDwLb2BpzYjcQ==
X-Received: by 2002:a5d:6f08:0:b0:21e:cfc7:bfd1 with SMTP id ay8-20020a5d6f08000000b0021ecfc7bfd1mr11687835wrb.329.1660652556367;
        Tue, 16 Aug 2022 05:22:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:ef0b:d58b:b15c:96e6])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a5f3f5883dsm7990873wmq.17.2022.08.16.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:22:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: meson: add support for JetHome JetHub D1p (j110)
Date:   Tue, 16 Aug 2022 14:22:34 +0200
Message-Id: <166065254995.976383.683359500915068130.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811103113.3097868-1-adeep@lexina.in>
References: <20220811103113.3097868-1-adeep@lexina.in>
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

On Thu, 11 Aug 2022 13:31:11 +0300, Vyacheslav Bocharov wrote:
> - add support for JetHome JetHub D1p (https://jethome.ru/d1p) is a home
> automation controller with the following features:
>   - DIN Rail Mounting
>   - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
>   - no video out
>   - 1/2/4GB LPDDR4
>   - 8/16/32GB eMMC flash
>   - 1 x USB 2.0
>   - 1 x 10/100Mbps ethernet
>   - WiFi / Bluetooth Realtek 8822CS or similar IEEE 802.11a/b/g/n/ac
>   - TI CC2652P1 Zigbee Wireless Module with up to 20dBm output power
>     and Zigbee 3.0 support.
>   - 2 x gpio LEDS
>   - GPIO user Button
>   - 1 x 1-Wire
>   - 2 x RS-485
>   - 4 x dry contact digital GPIO inputs
>   - 3 x relay GPIO outputs
>   - DC source with a voltage of 9 to 56 V / Active POE
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.1/dt64)

[1/2] arm64: dts: meson-axg: add support for JetHub D1p (j110)
      https://git.kernel.org/amlogic/c/59ec069d50550273a83180ea6c950d382d7bf8e3
[2/2] dt-bindings: arm: amlogic: add bindings for Jethub D1p (j110)
      https://git.kernel.org/amlogic/c/a80c60359a42cf146872b9442cf847e7c2452a23

These changes has been applied on the intermediate git tree [1].

The v6.1/dt64 branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
