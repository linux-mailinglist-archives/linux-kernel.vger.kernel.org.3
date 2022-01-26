Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF30649C770
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiAZK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbiAZK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:26:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21AFC061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:26:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p27so62181079lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HEgFNH76xYMaSR7A2MkkbqWMIl28k6seEq+TKkML2sM=;
        b=dxA+Dkm3fOcJkppAUExYCXbixzx+RAlZ4Y2LD+IeBPxNVHLmtMRgUqpWEL4Ol2Wsr2
         NHYq7LqeUhJXDPbDOaSPyh4zyvZA5Qd0M9SKlH377it32Yt9QGVgOxwTMybwMztvlFs0
         kQd4FMYgI2GIBVnQSgiKTHOnRHLy4FSH3g3FQ8oVMuHln/+ZeqbgDgxCsthz+vdXwsGW
         q3tIh9ceODLSnO6rizEJjBp/ukBtZgw+ujtbIl2osJBYJtw3YnPJ7q7Tuv9dkepDJvjk
         58aeZwvmnRJVPKSFVyl/Q9nY4z8l3DfVQddse4alXZwXE62s0ds6q/GSyfKNE99FJbA/
         BErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HEgFNH76xYMaSR7A2MkkbqWMIl28k6seEq+TKkML2sM=;
        b=t049imXOlL+fl5WF9u/p6rKeFD9ZgbJ37TXRBBqnoAAQgC8YBXvMaDdCOXnYbMF5mX
         AiT5sqjuZ1Bw8RouJYy21HCbbzgAa+Ilz0R2f9ah2ILcAP3ev/od5PK7ffIEfUlZufKT
         Y/F6UzuIdwCeesK1iQmNuxZpSO3NevEWfEtdk0zQjfTH4k+/Le/h/e/l1vPyPhgheZbg
         gEV/ICLJjM+Z/CYfzyuYd6gQTEBSlZ1USc0BtUpX280Qm8545k28bTo1r7XrE4jKt8Eb
         ZJEnf3/f5BXAI6dOFoqWLwcDGwxT46d7+vkuV7xX+OKtv6xOTSQCx/8W4o41/k+tI0w3
         wj9Q==
X-Gm-Message-State: AOAM532MqV79NT088I1s6OQoPeoba+5VeTim6/x9xJFYuJ7sIZpjrMrL
        ddFyaXKd3DWTJBHnNeBqJKrjiaGyBMKAJA==
X-Google-Smtp-Source: ABdhPJyY4ILa/Qs8mLAGnK2T49f1WoeCEw5LbgiiByVoD1jJvbR2HbWoxDajXqLAOKdwqjyeziHGFQ==
X-Received: by 2002:a05:6512:a84:: with SMTP id m4mr9601532lfu.146.1643192771289;
        Wed, 26 Jan 2022 02:26:11 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id d14sm1782516lfv.253.2022.01.26.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:26:10 -0800 (PST)
Date:   Wed, 26 Jan 2022 11:26:09 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fixes for v5.17
Message-ID: <20220126102609.GA1516258@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these OP-TEE driver fixes all concerning the recent changes
regarding FF-A and asynchronous notifications.

Thanks,
Jens
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fixes-for-v5.17

for you to fetch changes up to 4064c461148ab129dfe5eaeea129b4af6cf4b9b7:

  optee: add error checks in optee_ffa_do_call_with_arg() (2022-01-24 13:00:59 +0100)

----------------------------------------------------------------
OP-TE fixes for v5.17

- Adds error checking in optee_ffa_do_call_with_arg()
- Reintroduces an accidentally lost fix for a memref size check
- Uses bitmap_free() to free memory obtained with bitmap_zalloc()

----------------------------------------------------------------
Christophe JAILLET (1):
      optee: Use bitmap_free() to free bitmap

Jens Wiklander (1):
      optee: add error checks in optee_ffa_do_call_with_arg()

Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

 drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
 drivers/tee/optee/notif.c   |  2 +-
 drivers/tee/optee/smc_abi.c | 10 ----------
 3 files changed, 13 insertions(+), 14 deletions(-)
