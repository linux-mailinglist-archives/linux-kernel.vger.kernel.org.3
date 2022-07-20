Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1157AFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiGTD5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiGTD5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:57:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6F6C139
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:57:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso935310pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=j28hbdK25ARSDwXRqfGHYyzePyShGF2sBshDmBPw6AdEPqyaUBLmnC40ZP+jPnG3kx
         ynPSTEXsHER6OCU24y0wJQZtifpscuPrvUGqia0AddIKUtpgJ9o/nqc2arqrT86G5b6C
         twuOo8qelPv4xdGrvhnC63tB229Oolvlpm8XE/rP+DoqCYR4apyPMupgtZ9V1v8NfGY3
         izbAXhcHd5AMS42qYM/2+QPg9AUZRL7ZDxw3lAMbMzj0M90t7icgWS0i6ytwFpbX5WtN
         d7f/SxuUaenXzBrv3KEiEJex+RnBPKOUDEzBjEy3XHPO9hHTC7OqmTjLzkZ00+IjEF+M
         pnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=kv2DAKT6mKda4mPvmTxyWz7oGhPKBkd2Xu554o9wMoaU2X96S+A+NZphEfPUwG/ftl
         UrPVxZT9Wf7Z8dwQICvchIRd1+VpRTjjG+oEO8zBkzCEv3r+pTV7DiZK98P4F0oBRY9R
         97/XEMIsL6fyUlwpzxMdl2JvgyeHh8a/T7n80a5861xTcRG4F7KwG/xA8BK2v9yYCbnn
         ALux4z8EGpfe6MocGpPi37LWHV1g1ucojybStWy/xgzlsbjn5CWcGzwAhaaDPOcUAJgf
         5GtsoWI1x4SbQKO+mWTszUk7UEqy+naKPqpXPZ8U/9X7GtKKq6DQ7GkJaDrOOrkfIdeR
         8srw==
X-Gm-Message-State: AJIora+UtPB1F84ZccagrLP4fl1qIy3Ho1ak2FWBrRfhDmBWmf1mVy3y
        T0RkZCFgN08rXEEgZXnzIkTX6Zbnd7fpINTY3JZbygHT5bruoWwE
X-Google-Smtp-Source: AGRyM1skitw5IGzqrMsQkBAkoW6XCU9kycU12U9o0EBUUtCnTZHO8GAMBGCbbeOFQu+G0ow1kG0pX+HKfRX9griSRrw=
X-Received: by 2002:a17:902:f684:b0:16c:5811:486f with SMTP id
 l4-20020a170902f68400b0016c5811486fmr36168059plg.64.1658289424073; Tue, 19
 Jul 2022 20:57:04 -0700 (PDT)
MIME-Version: 1.0
From:   sanpe qf <sanpeqf@gmail.com>
Date:   Wed, 20 Jul 2022 11:56:53 +0800
Message-ID: <CADi8-=q=9Nbjc9A9XSeOpHOP7mk3tah6UxQdoo9K1V7SR0745A@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subscribe linux-kernel
