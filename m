Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C255731BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiGMI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiGMI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:57:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDFF272F;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d10so9673038pfd.9;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Cn3qMvUiEDmK/nPYV0HSMPYWM/tSk3wzAm7Cpq40Dk=;
        b=M5/0GWZgf9t/HA0Ket9kH8p8xKxM/ioUpyEk18hA4+J5bez71ILiJWSOTaD+9NSvy1
         8Pd2XAqBAuu/WmB+5YRu02HSfmGPqzVpnDrOFxCrGkphNVYPQ/PAvP+WoKh2tBue0XMN
         ZWklmPECextNKytmuGT5AyVdjT773KtdMgarxoObXnT+3VjiBsPoKvPbE3owG3gJXtro
         7kd5yMmIe26lIu6HEA8LfN+8RfOyxU/vsDCBUc3adzG1PUIHWPkvF+MqWXIeGXBI5Q2M
         Tpc2Zj9IiGANSY4Jl5ATV/fLH6tIkiAsbTMrlbM8+W8C/Qui7orOizYhPGPFYqaogDBo
         wVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Cn3qMvUiEDmK/nPYV0HSMPYWM/tSk3wzAm7Cpq40Dk=;
        b=E1+4wNBBsjRqMYoVDRSf2bL+RUZWcFHsUy3HzvHzXQXXBjr068Qd69SClzfFWk9don
         zowg5Ue2aT8z0OpPWNypo13deJzrmt6U1OpWg4uCdHtGZCED+OTOkJ6wo6sBIMOdtQAC
         +OnHrwtxq7UqklasoJ5qBRG70xHP66mFCSKuLQ44i3OcbQzFTxebRVPMCXUFMg9nqVFL
         8RTHyBMiJIbhwRNxi7owvL3BGNQElyaDuuDTIchD4vFpQbFd2NIGH+r5jWUslRCJBqXs
         39P6fDLibWQKRlyqnanWAAmNHovxzkToHObHcot0YAeyMKLPp9l6exBzGQsiybT4JOE2
         ySpQ==
X-Gm-Message-State: AJIora902Rn7bGKaBETF21ZYSZyggibMKH9LIPkLMKMEsFEguQFTb9Jq
        UZpFnyBL5D+g9OQF2Mu2FXsze5VHgGA=
X-Google-Smtp-Source: AGRyM1v3xnTGYf+B+DLE2nQQf8NEsmNfuu700MRrsqOw+5A+arnmHX1YMqBRbtKgjgEB4laGmnGNCg==
X-Received: by 2002:a63:e446:0:b0:412:937b:5a3c with SMTP id i6-20020a63e446000000b00412937b5a3cmr2119838pgk.316.1657702634930;
        Wed, 13 Jul 2022 01:57:14 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id a10-20020aa78e8a000000b005254535a2cfsm8331962pfr.136.2022.07.13.01.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:57:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 65BD010397C; Wed, 13 Jul 2022 15:57:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH RESEND v2 0/2] Documentation: qat: documentation fixes
Date:   Wed, 13 Jul 2022 15:56:26 +0700
Message-Id: <20220713085627.175604-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are documentation fixes for qat driver, as recently reported in
linux-next. This is resend of [1], due to missing v2 subject prefix.
Sorry for noise.

Changes since v1 [2]:
  - based on next-20220712
  - Drop kvms390 (already applied by respective maintainer)
  - Focused on qat driver
  - Drop "initialize" from [2/2]
  - Collect Acked-by from Giovanni Cabiddu

[1]: https://lore.kernel.org/linux-doc/20220713030332.158525-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-doc/20220712092954.142027-1-bagasdotme@gmail.com/

Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org

Bagas Sanjaya (2):
  Documentation: qat: Use code block for qat sysfs example
  Documentation: qat: rewrite description

 Documentation/ABI/testing/sysfs-driver-qat | 37 ++++++++--------------
 1 file changed, 13 insertions(+), 24 deletions(-)

-- 
An old man doll... just what I always wanted! - Clara

