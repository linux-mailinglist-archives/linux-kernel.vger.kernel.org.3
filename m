Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048EC4D8C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiCNTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiCNTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:32:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEA344DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h13so21378230ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=a7HRwjDEJxx5yg811uZ+El9Irh6PSqQjZkDfhBzyEJc=;
        b=IkPMoMgeiWX9euzrEh34idXsewhkiTsDMfQ4x8fRuLFJvG9pkDB+Ej6bDJHbiXiT79
         5pXld5HpJfCGZ2zHsa10iVQA1Fr3wPQOO4wXOQP6wkUhPEF3vrLUN7YwOEKWhUU3qiS9
         d3WZQZw8yJd7xZeupkYX1MQeZQT3j3Ss+NkALo1eO1H2AsZp5XAAfCyecn314RxQ+ct1
         iiGjSKDWcelHW5gdiDwfTFiYIcbwMr0VKQnrtvv24RcR5QGQNEO8cga3HfAr4x5nCQBN
         X/b9/CsLo9ES85BCdLCbc/OrpydZ1Y6Atoted9VZla7MHkrmb43BePn7DgxHpItnopa9
         10wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=a7HRwjDEJxx5yg811uZ+El9Irh6PSqQjZkDfhBzyEJc=;
        b=uHzm0Vr9OmikdVHS3/OTPTjBsDA4tW6+QlG8TvDt7zq+XVwNPWuSRjHBfAKRvxe7Ap
         Je2mjEvJbopoetUU+Xq8SHUj2ODSA/khjT482yu64Kw8WwEnucnf01Pdq3qP9gi/Tnud
         BNAg6qmViFu02FRElUbKNG3k/TsLqtqq625WtDHx1soWGVU+hB3euSenvx2KdeX+uOdv
         bd2b6Dv3wPKNmZ0TA0TFmZBDQ9q3ITdRXnKA8ugvpOyTUr53bdmzt7ED89aj3rbaZ2KI
         tYXGzaojp8KzciGbfnyCVNw37d8qi7jedyZbjbXIGvpo7tnT65+UaApBAnK0oFNeeiyT
         eKxw==
X-Gm-Message-State: AOAM532/whfBzhmP/XZksSf25rRshMxVnN8PdknSwQJJz+hTQeiFz2xY
        XF965PbopoxeJ7Fkx5iahWtqeur4kt0V4w==
X-Google-Smtp-Source: ABdhPJznxEeaNX3jPoinMgMsuNlfxcF+mxXZYgiZDGvyjfezB5HidM24ew+6yv8Vwildii8rh4dTWQ==
X-Received: by 2002:a05:6402:b78:b0:416:171e:835d with SMTP id cb24-20020a0564020b7800b00416171e835dmr21786233edb.270.1647286263620;
        Mon, 14 Mar 2022 12:31:03 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm8638437eds.21.2022.03.14.12.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 12:31:02 -0700 (PDT)
Date:   Mon, 14 Mar 2022 20:31:00 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6656: Remove unused bb_vga_0 and
 vt3342_vnt_threshold
Message-ID: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables bb_vga_0 and vt3342_vnt_threshold
missing in staging: vt6656: Remove unused 5GHz support
Reported-by: kernel test robot <lkp@intel.com>

---
Tested with vt6656 on mini PCIe card (connected over USB)
which is using rf_type: RF_VT3226D0 (2.4GHz only)

Philipp Hortmann (2):
  staging: vt6656: Removed unused variable bb_vga_0
  staging: vt6656: Removed unused variable vt3342_vnt_threshold

 drivers/staging/vt6656/baseband.c | 24 ------------------------
 drivers/staging/vt6656/card.c     |  2 --
 2 files changed, 26 deletions(-)

-- 
2.25.1

