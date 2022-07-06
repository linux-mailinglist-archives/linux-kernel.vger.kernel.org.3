Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F056894B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiGFNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiGFNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:21:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CF167D6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:21:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so14027926pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0wycCic3IQjLfFUkhvbAA5k6Sim7nNN6yKAb7C8DaIc=;
        b=Gkowlk9kxyMQoZWdag95a2G3CObcLUndvl22zb6fP5tnkzyvBaxjA2T80fgfYmzDT7
         /kStuwFmmZomXiOhisu0B6ZcbDuhRgkJTWUmCmVHyc5D+FcohyoAypY+OtXLYsVwurqx
         FEIoOrKHtxj+jksFe/hNqB2NlQP80o/ABQBE/CQ9Oo3TfOq1riEIzGgFWiOf5I+2DsEk
         T5Hix+EKnsmTd2eMJ8BCAdiBJmLTtyjuwh0H7a2sq+PFejDNfs44m9QN9r6DTqxjgxPp
         yqaH92Pac+GcGYbiQJnNwIMnz7mXgixaqmIEBhr/DrkCeP4JGBrNetZHa1fm5ddgP9Xl
         LuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0wycCic3IQjLfFUkhvbAA5k6Sim7nNN6yKAb7C8DaIc=;
        b=qaw/iETodIb5HOIjfpKugKQoPIdI77DVP1WLmdWi6B1+3G+jIvN/QVrDsKRagYAohK
         cxWJ+M/J09TnG+6x8IMahpVT5mnAzUR4RisISqdClAYX9bn2k3nFnUjgdApXzl/8mUX9
         OuHkdsLv87zpPwtrwrD8CJikgVBuYYrQ3ygoOKwUWdcEoHjDbtamsnV9izGd7Vd3RZTP
         fQXbqlhcT55Ls3iDKkURA7Se0PuDVgu0z2Qi+SUJWXtRruHdMQRmdARbbzonT/foAQbq
         2/95jv/s/fINNiR0gPtj5pP/2MSO6u7UOmc9LTzLsqrbDH7DjYd5EQhM/rRgaik5//YY
         kvCg==
X-Gm-Message-State: AJIora/SK1ihzkTAvDiJ72L4gjM5iK3gYG68ANuFZTu4fvVuuQhvwNOQ
        kqrAMZZUaq3H3Jdj2W7O+tGyNHpqQlU=
X-Google-Smtp-Source: AGRyM1sVX23KTq7UqJA/iy6sLn9wajWmLcN6iiPJ9IW7uON2Mqa9yjpF3DACkZA8OHtjP53OEB13zQ==
X-Received: by 2002:a05:6a00:1d2a:b0:528:a318:7ed8 with SMTP id a42-20020a056a001d2a00b00528a3187ed8mr4572888pfx.55.1657113694588;
        Wed, 06 Jul 2022 06:21:34 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 142-20020a630094000000b0040d376ea100sm3046505pga.73.2022.07.06.06.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:21:34 -0700 (PDT)
Date:   Wed, 6 Jul 2022 22:21:32 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: OpenRISC fixes for 5.19-rc5
Message-ID: <YsWMXAF3ePlWuxyF@antec>
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

Hi Linus,

Please consider for pull.

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 48bddb89d59eec27c3305d179b1832d5292e285d:

  openrisc: unwinder: Fix grammar issue in comment (2022-06-28 17:31:24 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.19-rc5

Fixups for OpenRISC found during recent testing:
 - An OpenRISC irqchip fix to stop acking level interrupts which was
   causing issues on SMP platforms.
 - A comment typo fix in our unwinder code.

----------------------------------------------------------------

Note, if you do check this against being in linux-next I dropped one patch from
the linux next tree before creating this pull request.  The dropped patch was to
add wireguard selftest support, but we decided against it as there are still
some qemu bugs to workout before turning on wireguard selftests for OpenRISC.

Stafford Horne (1):
      irqchip: or1k-pic: Undefine mask_ack for level triggered hardware

Xiang wangx (1):
      openrisc: unwinder: Fix grammar issue in comment

 arch/openrisc/kernel/unwinder.c | 2 +-
 drivers/irqchip/irq-or1k-pic.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
