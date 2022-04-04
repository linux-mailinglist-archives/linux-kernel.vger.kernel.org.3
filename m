Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C144F106B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbiDDIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbiDDIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:03:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AC3B2B3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:01:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so7201711wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMlxUg9R4XMvayD2D6tTORqQnMzt34ahkr+1IIPpZrk=;
        b=xugZeTvVg5ASBCvLguGnDYkmRLxgPUfEhleySeiR9uFXVQxx+Hr8V1YFRV2BUDwXuI
         msyLtkIgyC7A9wWhZKlYg1anDc7Iju+x8iRBqTwy1j04UnbSuIirNEPkFu/6wO3m9p+8
         f9FNRYu3HOXNXKLbfoHYTVT8BjqQSPtatuRKgSDo1ThJlVmi2Cf6K0R+mHxPQDeVQiO1
         5Q9uZ5ZqJIlBr+OZp1InjMQUi4L0ZN4pffk5D9B3CuQWx8vFmdgArsfM1r28PSbPAdSQ
         0AZ8PH4SLfYjtyoicGP5lMaqZakfDhZxLmz8PVAO4yltGyK4EexIuhCNYPgYcRtX9540
         XzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMlxUg9R4XMvayD2D6tTORqQnMzt34ahkr+1IIPpZrk=;
        b=pvGDLcTBtMZm9NOL298gDGStEXKkVVRfvo//pTM4RsCazdnRPOTCjxqgUlX03UGpAf
         56jCU6LqzQMv4ZfY2cfpykqznyQ0YX76xqOpdnYyi7h8qrorl6FXrY3ITFEN9TUUtCX4
         CQ76t/bXtRBfywjfTtiEsi4PnBdZ92e4EhEcong/iuoOh48L8D6RFudG0rWxzXPclk+O
         JdnEZyJnN5l0KhfAWf91FznTbdgyl5IivD4VB8+6FhSgGsrAwUMPeD237AoUWJXenBO4
         VWP5Y7Ycwpk+NVGofpiRkfE+f5Bdw4bpRRxy89hN8drBD/gZY2ZrviessJ9Z+f1/NvQN
         GpcA==
X-Gm-Message-State: AOAM533qvEym1ULuIAZpf+Gckkun+yzoiR2h20YDNI2v74K8qMYn1q8S
        yZ8uQ2gYHfJ+EaJrgW4cU0nnVQ2XMKS+OseS
X-Google-Smtp-Source: ABdhPJwnvBXWc2QrklzwJsBhpREtyKwtTZ8QEHMMLvvJRy0/5hd+0G+oXty5theGkKG3n7Y3e+KiFw==
X-Received: by 2002:a05:600c:1d8e:b0:389:d079:cc0 with SMTP id p14-20020a05600c1d8e00b00389d0790cc0mr18377684wms.98.1649059314426;
        Mon, 04 Apr 2022 01:01:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm8586159wmq.46.2022.04.04.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:01:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Vyacheslav Bocharov <adeep@lexina.in>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/4] arm64: meson: update dts for JetHub devices
Date:   Mon,  4 Apr 2022 10:01:52 +0200
Message-Id: <164905930207.1797085.9678466232916244683.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220326075110.1462301-1-adeep@lexina.in>
References: <20220326075110.1462301-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 26 Mar 2022 10:51:06 +0300, Vyacheslav Bocharov wrote:
> Update dts for JetHub H1:
> - add bluetooth node for RTL8822CS uart port
> 
> Update dts for JetHub D1:
> - add ZigBee serial alias (ttyAML2) for backward compatibility
> - update voltage regulators and SDIO config to match board's reference design
> - update max freq for WiFi SDIO
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/4] arm64: meson: add dts bluetooth node for JetHub H1
      https://git.kernel.org/amlogic/c/2bda08dfc501967a7a7bd6f77f04afef14dc7271
[2/4] arm64: meson: dts: update serial alias in dts for JetHub D1
      https://git.kernel.org/amlogic/c/cf94e26508ad411c2a618b00dfaae515affd0ca7
[3/4] arm64: meson: update SDIO voltage in dts for JetHub D1
      https://git.kernel.org/amlogic/c/81bbd2bd24a9ebac3871b293060df50445458c79
[4/4] arm64: meson: update WiFi SDIO in dts for JetHub D1
      https://git.kernel.org/amlogic/c/87a87657249316616138c103c2bdb7525c34d987

-- 
Neil
