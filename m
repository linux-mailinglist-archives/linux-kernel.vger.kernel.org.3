Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D95168E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 01:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356093AbiEAXvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 19:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEAXvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 19:51:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C632BB24;
        Sun,  1 May 2022 16:47:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p18so14933660edr.7;
        Sun, 01 May 2022 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c4ekEUJI1otjKCbC/Ch8dyPiWi8pK8+znYkkTcEytXc=;
        b=GnrU21HYat/Onr3IKg4Cet0n8I2iAOTKnwwLzSv4PwvpqLZOanORtsI7YI8PKlYMMI
         jpoXeBFKNklvE+Wg9hGlubnGpznjoJ7kJbTQR8IORKrMxot2f96/tdeoMu1rxLCdFleB
         uqivk18o1rQR0Qj40400FYt3+un07t3HnEgfXeINKhewiLm3tcF+RnyHCC7N+VeqwLmI
         fxSSFr5IYUdWU7FXB/c2xj2VR2puQFKUE4kDPJVujDpxFg2HqwPBcjLZETMQMGcoOYWa
         ei8uUo2WareTvD7ifE7T9Y/0OdZhx7Gcjq4ANsivoDopIv8oYV0LZQO1OdhBoGtIAjr+
         rJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c4ekEUJI1otjKCbC/Ch8dyPiWi8pK8+znYkkTcEytXc=;
        b=zCRkRh271P9ZFmOouYOA7JHJ0PTIIH4rBK/4mW5j0GK8W7QleTLuOm+FPS2wg6f0Qo
         HNS3P7IlZP4dvhJdvFXyhR90x2BfuzYWVvMTlMw091ytpSL2xzTlyTRXSutf2FeLX6eh
         kvgilxpfn4uhy30lE2WUfvX6Q2O1hVrcj+OnuUp2TxkyixLOndiAs1Elpt/Gbszz30Um
         61uEuHrE7HIWKjfYf78hDqtR3aXzr/ue3rn8x/j6U+nQQ40maMtTClTUskLKohEcnNCF
         hDS6x2nWcyAIXuCuX/t7OUtPB/ZW0iHFpV7Nr1QfCsPP8v4V19Nsy3MY8IxEqI8jyij4
         HU7Q==
X-Gm-Message-State: AOAM533OTbqqLBynmEjoToNmQYXLir6Ez+mrsmB2QyjX3/7vyJiqhq4L
        S3X2ea7fKfQYCyvQtij+yyRl66oiDamx3kZci3f/fFqmgYk=
X-Google-Smtp-Source: ABdhPJw51VSuqY99qvJQse1B5TCzwStKP6otBEcp3h+Ob86r4RA6AcZTLu8lw9vQBrUjWB5P29TNYH7GV4y7RHpCV5A=
X-Received: by 2002:a05:6402:354b:b0:426:1193:39ad with SMTP id
 f11-20020a056402354b00b00426119339admr10612551edd.351.1651448858385; Sun, 01
 May 2022 16:47:38 -0700 (PDT)
MIME-Version: 1.0
From:   Test Bot <zgrieee@gmail.com>
Date:   Mon, 2 May 2022 03:47:27 +0400
Message-ID: <CAOFRbGm8Qd5Pd9_ZA1a864wVAN=rkYzL9Hq5n=TopTDZPAHtfg@mail.gmail.com>
Subject: [5.18.0-rc5] report: kernel compile
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The v5.18.0-rc5 kernel was automatically tested and foun BUG.

dmesg log:

[    0.234262] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.GPP0.SWUS.SWDS], AE_NOT_FOUND (20211217/dswload2-162)
[    0.234267] ACPI Error: AE_NOT_FOUND, During name lookup/catalog
(20211217/psobject-220)

[    3.192835] tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does
not cover the entire command/response buffer. [mem
0xbd49e000-0xbd49efff flags 0x200] vs bd49e000 4000
[    3.192890] tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does
not cover the entire command/response buffer. [mem
0xbd4a2000-0xbd4a2fff flags 0x200] vs bd4a2000 4000

Hardware Information:

ASUS TUF Gaming (FX505D)

Kernel Booted?
Yes
