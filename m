Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08454D5225
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiCJSzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiCJSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:55:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D918E3FD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b24so8161376edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=+JFJPMX7Uwm4Dfyx3KvGq89D/Z2lFa+BIel917v3Dr0=;
        b=VSMYRlT5qdW/04vy+bC1Ddc8L24Hafh/20WrmAxP5WKQUdsFYvhA1m0IBpysR0Y/20
         qwWhHHFWZWONxFU5+ee/WmbWBQmM+p/31L9mXtPDWCEeqkP87G7lPFEHVXdhvVUFohVf
         BxiHa3EVc1I/lA5aN+pJv/br2tp6+Ntx8+nPueyzyduS0tuHmsx1oRgs2mdM0HZqsXwa
         AbVoJHSiS6iT/RA2xWSruaNywCrOHLl6nekOYCEt1ohTpVwckUJvR8m1GTb+1hCy/E9z
         sEmegPZ6UMu1aPX/DX95l9PfHxIYOR9r44HiycSMo0c8RzGhcYV1Vg0Eh1YvxG1pWzG4
         6Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=+JFJPMX7Uwm4Dfyx3KvGq89D/Z2lFa+BIel917v3Dr0=;
        b=dbRraYbkOrNHAoIYWJaOi1eSo/ThxUc1XIOg2y6wrE0WycVMRlWOBpj6kdcKklsbIv
         VT+I5OBk64UTTVdz87wMF/rsJ1rnVc/heF/CJdpGj102Fo4X8/cj0jefUGjQ4kycDFYG
         pLnxhHPBpc8u/5knn610NX1aBTRB1/rNhPFRiEo/FwvG4fFdPtGZ+SmDSXMjil2gsEz/
         XVZVzsXgXwdVNaIdq6UHLf1Yvf2knBH7W8G+JOuzAptBp0evwThrfTVdeFN0pIfjTpEJ
         tf/VQTYTUvf5vp0/h/NsgEBx3zE9OSw1G+2+qzUJ2gBDlTkPy8pZ5botyevGYreAbYwh
         pIOg==
X-Gm-Message-State: AOAM532Tke43vw1wd4+0zBaVnbqQRI9/u/UH+MBgtgPHEosnQziekZ0b
        VnqMCOlkmP2DOiGNyg7sP+9D8E2iC/w=
X-Google-Smtp-Source: ABdhPJx9TOmMFujFnGVl8b6xHN1ndgoe2DniOY4IItI5ZmI4A+NR+uZ9Da7nqpkBConZUtEfqH+rIg==
X-Received: by 2002:a05:6402:11c6:b0:416:3751:d700 with SMTP id j6-20020a05640211c600b004163751d700mr5866245edw.97.1646938446827;
        Thu, 10 Mar 2022 10:54:06 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm2047740ejc.120.2022.03.10.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:54:06 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:54:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: vt6656: Remove unused 5GHz support
Message-ID: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
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

vt6655 (PCI) and vt6656 (USB) do only support 2.4GHz band and not 5GHz band.
Both drivers do allow only one vendor id and device id.
So no other devices are covered by those drivers.
Because of this the following priv->rf_type cannot occure:
RF_AIROHA7230
RF_VT3342A0

---
Tested with vt6656 on mini PCIe card (connected over USB)
which is using rf_type: RF_VT3226D0 (2.4GHz only)
Tested with vt6656 as USB Plugin Module
which is using rf_type: RF_AL2230S (2.4GHz only)
In order to combine vt665x infrastructure it is important
that vt6655 is also not using this code. (Patch already provided)
vt6655 on mini PCI Module is using
rf_type: RF_AIROHA (2.4GHz only)

Philipp Hortmann (5):
  staging: vt6656: Remove unused rf_type in channel.c
  staging: vt6656: Remove unused rf_type in baseband.c
  staging: vt6656: Remove unused rf_type in rf.c; top level
  staging: vt6656: Remove unused rf_type in rf.c; unused variables
  staging: vt6656: Remove unused rf_type in card.c

 drivers/staging/vt6656/baseband.c |  16 +-
 drivers/staging/vt6656/card.c     |  16 --
 drivers/staging/vt6656/channel.c  |  96 +------
 drivers/staging/vt6656/rf.c       | 413 +-----------------------------
 4 files changed, 10 insertions(+), 531 deletions(-)

-- 
2.25.1

