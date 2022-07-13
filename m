Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15153572BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiGMDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiGMDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:04:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034426ADE;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1461376pjo.0;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcvxOfFen8+coWdSHokeQGruWe/pYjGO7D4rgu/+ryk=;
        b=flilKcCb9s+K4lYxxi7bsOBBDtH4sxM+3eDvd5glK+fo4HZgyrpC6TjsbLfhTcu5zh
         +gZcRwHH+P2NLrALafe/Lfe9PTpiuX5JzzntfLhRPVRHbumIRQEwi1Ait2D65fxz6yMV
         ozXmbI9R+ELQe4qsmwbfmBQLXzYIFNxp7QOGwDKXlGWjFP0T9WhVoZmeJ38Cl7KxBiqn
         yqqc2qME02RSgvBl2p5VSeh3DuOTjEwJH0MefQVVVoM/YEamSURY47QPAbzsWQx2AdIm
         4emZPsgqQHrILQcsOOxFHV4ghIdV/Qc1OMZTYsRn4NpzanYklY1mnjanDZ+aBwLJaW1N
         vVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcvxOfFen8+coWdSHokeQGruWe/pYjGO7D4rgu/+ryk=;
        b=YY8RzDMp4Q9LDiGUUsHt/wD+ZmhQ/Jh1ll8odDSZc4iBSc1npzm4dh9TvaqL7IY+6M
         toXn0mHHKPD8shljCHEWK0NCBhBon5vtar4f/ACmnR8lmkguH2L9NdbzjeaCdDup0VQu
         7xxrMN87A5xHcNID8tsQp4J4Erq+WU6nz0xXBJKKwK9g2hcuR9+u24+bPJ+u0UzQBMDP
         PV78goL1CFJpbAK+GDF5gdmAVrt1PMtHIJ/bd0MqTQgAz2uVkn6pDpSUbwJ+LOLFpTKD
         nhg3yGkfOeWMY4zl/BAPkLqEDfZnpjEKww+uNxcsMRoB+Tn87eVNsS92nzG8pV30QdJ9
         hp/A==
X-Gm-Message-State: AJIora/i5Q2mtY4jJxbfAve68dyMeQ5P6W3fZwG5mdk1c286S7pouL4e
        fq0RaSWeN6hqkzNgEdiYW9Ud914iZT8=
X-Google-Smtp-Source: AGRyM1vkCBfb64HFXNpQHm05ZrXTU1TUJ4ASQd+vMiWxfgxGGaY8iE4xWoKgET+ac3j/w+0d9aKXWQ==
X-Received: by 2002:a17:903:234e:b0:16c:2d7a:d341 with SMTP id c14-20020a170903234e00b0016c2d7ad341mr1060879plh.10.1657681433789;
        Tue, 12 Jul 2022 20:03:53 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id im9-20020a170902bb0900b0016c4fb6e0b2sm4402209plb.55.2022.07.12.20.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:03:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D047D1039BE; Wed, 13 Jul 2022 10:03:47 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 0/2] Documentation: qat: documentation fixes
Date:   Wed, 13 Jul 2022 10:03:31 +0700
Message-Id: <20220713030332.158525-1-bagasdotme@gmail.com>
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
linux-next.

Changes since v1 [1]:
  - based on next-20220712
  - Drop kvms390 (already applied by respective maintainer)
  - Focused on qat driver
  - Drop "initialize" from [2/2]
  - Collect Acked-by from Giovanni Cabiddu

[1]: https://lore.kernel.org/linux-doc/20220712092954.142027-1-bagasdotme@gmail.com/

Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org

Bagas Sanjaya (2):
  Documentation: qat: Use code block for qat sysfs example
  Documentation: qat: rewrite description

 Documentation/ABI/testing/sysfs-driver-qat | 37 ++++++++--------------
 1 file changed, 13 insertions(+), 24 deletions(-)

-- 
An old man doll... just what I always wanted! - Clara

