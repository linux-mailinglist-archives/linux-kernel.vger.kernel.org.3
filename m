Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE44CE734
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiCEVcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiCEVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:32:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0DDF94
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:32:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so7947780wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Mi2MyRH4qz07k40jNFPsAGQE2Jp6+/W02tCyKhboX7A=;
        b=DK4Ll3hRmJ4i6QTp33kAKp/lNGJriKpnXKuoOUIqev7eXZtMjaOz724I4fBCk6ZCNi
         VesodY8gGK8uQg0gss2lkysYrIQjIOWk64LC2FAR6/0yNitwcGRcABri4Ovq4+w5Kgzd
         i7VSNfA6HMHYwWcv4iKZDpSmll80mMdVY39rzJDJLbL1djYpihUxjCkWhQB6tMtRdX5R
         ld69UwzjypiyusBLucp7AwdCrdfrYjFpO7qt1XWzwGosizGggmjzmnyfgA73pjrb+G83
         4ullV84EsM0SHcesALOp4nu2cAeqyDolJ2Xv6ncSTJRDejeLPwPH0aiNor16217gH+eh
         rnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Mi2MyRH4qz07k40jNFPsAGQE2Jp6+/W02tCyKhboX7A=;
        b=NuXVj2/j3mqw40BcadpsVOiIR58cYCqGg1Lzi+mOoGF9pszFBOiDSYzN4f86nR6LRT
         86fA5Ly7jWExDaBJVZfouJECs0Oc5WuKm8a5WFtg+qm72hQ6k48bcLAtfYho13pdbo5L
         5wOO2WpCPRkLN28nq6eHaj6NsVPGwv9OL4pisPXrWeZsHOBCTH+/BUz2f/C0dY2Anzgk
         eSvf4WoGF4G5cPOoWHhluhehf/Rxifudx7R6Z8TJM7cBZeif199TKHe9wPVaL4390c6E
         cWZ++R0GSkIx4vLxCN2PvT8KoN1N1lbMeC+S8SBi68uz4UwVmnedWyA8jSwQSxS4Cm5V
         6oCg==
X-Gm-Message-State: AOAM531WObrkd9AjBJIQ9QS0RrYGPjL3m3cWAac5n1Y3MZJOqxrco7y3
        VGOJaYGigZQVlRuOig6yr7k=
X-Google-Smtp-Source: ABdhPJwqmdBH4duclSfVpiRvnglFMJA3f68Kb3M8zVyX9ydD5ic+EGgrcktkVyWj4RF9Xrpn9fO5Fw==
X-Received: by 2002:a1c:f003:0:b0:381:17f5:21b8 with SMTP id a3-20020a1cf003000000b0038117f521b8mr3558452wmb.158.1646515919152;
        Sat, 05 Mar 2022 13:31:59 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003811fab7f3esm9925553wmq.30.2022.03.05.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:31:58 -0800 (PST)
Date:   Sat, 5 Mar 2022 22:31:56 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: vt6655: Remove unused 5GHz support
Message-ID: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
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

Hardware of vt6655 (PCI) and vt6656 (USB) do only support 2.4GHz band and not 5GHz band.
Both drivers do allow only one vendor id and device id.
So no other devices are covered by those drivers.
Because of this the following priv->byRFType cannot occure:
RF_AIROHA7230
RF_UW2452

Tested with vt6655 on mini PCI Module
Module used for testing is using byRFType: RF_AIROHA (2.4GHz only)
In order to combine vt665x infrastructure it is important
that vt6656 is also not using this code.
vt6656 on mini PCIe card (connected over USB)
is using byRFType: RF_VT3226D0 (2.4GHz only)
vt6656 as USB Plugin Module
is using byRFType: RF_AL2230S (2.4GHz only)

Transferred this patches over vt6655 on mini PCI Module

Checkpatch errors occured because indention was changed. (3x times CamelCase) 
I did not fix that in this patch series as it would make the patch more complicated.



Philipp Hortmann (4):
  staging: vt6655: Remove unused byRFType in channel.c
  staging: vt6655: Remove unused byRFType in baseband.c
  staging: vt6655: Remove unused byRFType in rf.c
  staging: vt6655: Remove unused byRFType in card.c

 drivers/staging/vt6655/baseband.c |  80 ------
 drivers/staging/vt6655/card.c     |  56 +----
 drivers/staging/vt6655/channel.c  |  85 +------
 drivers/staging/vt6655/rf.c       | 404 +-----------------------------
 4 files changed, 3 insertions(+), 622 deletions(-)

-- 
2.25.1

