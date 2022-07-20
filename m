Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF63157BB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiGTQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGTQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:24:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8B6171B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b11so33941333eju.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EpBkigZDhPdfhuuO8b2HxzOasU8CDpEiB+HyHCiHWt8=;
        b=po6uQkahdsywOnTCYjRZtZ5cGXET4QXRdc5MHCTVuF8bIYosXLvwPTjBs4D+F0koMa
         p+gBuIsV5KTiJL1YdkWt+zgO1ocpRVE1QfOKajsYeJUai6m5aSk+CO+pPnpppk4lwEFV
         syFqKpsUbCAZ0Bzev4H2WGMlgIpub1TlAK5hz9ZzFPTG41KhRd3RKuFKCe2TIjha4/Y8
         onsxE/7xTjYTCARe8PgFOQroCHe0hUswEJvZqPKWuMlB1Lnd3JV7QjHqBud0JgpWmLZ9
         X2NeIuiR2dHNXxiBflLOn4qYMFIwWy6Rbxs8wUYsHDwGVZpTor30Aw/nHHrpxvyo8YLI
         v+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EpBkigZDhPdfhuuO8b2HxzOasU8CDpEiB+HyHCiHWt8=;
        b=F8vMRoOa/+0uotsOfw9+UCKVvvkCgSyIOa7GCYhrQMwwFGDLZef3S3QvOX2VcYgxGs
         El/BD2BSN3lPoUVKtva/bQ8A/hmO5CjFX8286lTSr1oS69/18xZCac78NZ5/9epmq2Qy
         T4YYoQJNW8SpYNUridQt/cQwDMW0jr8JQEMxCEo4u9s/LgLH1Djz/WCZZPWj6WKPJnT9
         IVOFCag1dPFwI1dV+pmmnoLwIA88PSRUpkghEBMs93tCMr7ijdADjiwRrneDcE62SKDA
         nmV5Mx8JdcZ0pqytTLtEJ+YwnQShe8Lx1+R5JBedELVd1j2TS4Xf9Q7+6EurPYdWoXM1
         jRdQ==
X-Gm-Message-State: AJIora8knC8tJ5/d7IxZ7SSI6rkcmUhNcGnc8aBoaV+VkHsNzDbOXIKi
        J//bZXhTCylEEnC4DkaVQX4=
X-Google-Smtp-Source: AGRyM1uh7GzYNjbzMG3aYFISLknlIn55CGjxcIrNuxKZsOMNIm+wYGrNvOlERr/NAkXe/qaxFyEd5Q==
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id hr1-20020a1709073f8100b006ff1a3d9092mr36057925ejc.319.1658334269693;
        Wed, 20 Jul 2022 09:24:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id gj10-20020a170907740a00b00726c0e63b94sm8000447ejc.27.2022.07.20.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:24:29 -0700 (PDT)
Date:   Wed, 20 Jul 2022 18:24:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vt6655: Convert multiline macro to static
 function
Message-ID: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert multiline macro to static function.
Multiline macros are not liked by kernel community.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (3):
  staging: vt6655: Rename byOrgValue to reg_value in a macro
  staging: vt6655: Rename MACvClearStckDS
  staging: vt6655: Convert macro vt6655_mac_clear_stck_ds to function

 drivers/staging/vt6655/mac.c | 13 ++++++++++++-
 drivers/staging/vt6655/mac.h |  8 --------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.37.1

