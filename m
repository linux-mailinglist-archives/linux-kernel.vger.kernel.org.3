Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD01565D73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiGDSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGDSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:20:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CB397
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:20:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eq6so12610175edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=4MMCQKAkP9OzX6adQ0p/a0Wa+SgAAbruvXMtvQEiDa0=;
        b=WDNY4mipdCHuIKSqrW7k//Gmz44kBP96nRWz74YD6sQuVxXJXIiRsHsZ7yY7oIHi2b
         9BWx74fMeRHLL8p5aPqxiivpXOUg/caNjpYYII3q7UNKVGH4ZtjFvh7HQKuB/IquNweV
         pzBISmK5J6vlz0wEvB+V7Uvb0QwJ1nLHSWER0tCYpCp3WUvwv8e04GKTIYX7qnY3+Thr
         XX5EivNmuMCkQSgQCGU6gHSdoV0O9b55XsCmrV1DqiXxUqmJTtDzIC/P8PO2U0k8Rd2c
         P3MzuQ34+pM26D6N1vWewjucAc27vGeZyblYtkmLrQmIwUEtRRPJPmczjbtk8fgCXM4b
         Ew4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=4MMCQKAkP9OzX6adQ0p/a0Wa+SgAAbruvXMtvQEiDa0=;
        b=aCZxaRHaAHtSJmIBi2wseAwafFM46LCM6KQ9GI1VOQ24Z0ae0blhau7ELiPUPy2qJH
         wqBO8zdQvDzpnOLKiObJLeVk7s8uTsDEWHpY+vMnRIlHYN8PuDj47HNv+2YxQ8GN+N/u
         PDvUtdiDRSjdgfWGM1eVOxu7b26g62jsVuhdlCpAACMIUffpPLGfrXYKEZGtQXkbXkdQ
         QBDgYnSAXQxM0YTjby3DijuNhGgQ9VZP1AiL+jQqEoH0UqjzSwpBW5UhnYT9H3fwv8xo
         3z0CfG7Ie5/WxBzwAD7L9IFGDAK6ZsraaO4w57jFO8ZG34U8/W8d9QfW6ZGIPulDi6gg
         1Dew==
X-Gm-Message-State: AJIora8TTJwqYWUUlBO/DX2Bccta0wkjgwnetd2zYDxQogJ+s1sIn4U9
        YCvfBvHHs8MY9K1lqGOybcmvEcjpWfA=
X-Google-Smtp-Source: AGRyM1vMxjw01hglbhbR866dQ+jFCoID2DOkZQvkg8r5GxB7q4TTz4TZc/3ON4jBo23IINibN2AQQg==
X-Received: by 2002:a05:6402:228f:b0:43a:896:e4f0 with SMTP id cw15-20020a056402228f00b0043a0896e4f0mr15851008edb.81.1656958821565;
        Mon, 04 Jul 2022 11:20:21 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id t23-20020a170906609700b006fed062c68esm14501758ejj.182.2022.07.04.11.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 11:20:21 -0700 (PDT)
Date:   Mon, 4 Jul 2022 20:20:19 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: vt6655: Convert two macros to static functions
Message-ID: <cover.1656835310.git.philipp.g.hortmann@gmail.com>
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

Convert two multiline macros used only once to static functions.
checkpatch.pl does not accept multiline macros. 

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (6):
  staging: vt6655: Rename pbyEtherAddr to mac_addr
  staging: vt6655: Rename MACvWriteBSSIDAddress
  staging: vt6655: Rename MACvReadEtherAddress
  staging: vt6655: Move two macros to file where those are used
  staging: vt6655: Convert macro vt6655_mac_write_bssid_addr to function
  staging: vt6655: Convert macro vt6655_mac_read_ether_addr to function

 drivers/staging/vt6655/device_main.c | 31 ++++++++++++++++++++++++++--
 drivers/staging/vt6655/mac.h         | 24 ---------------------
 2 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.36.1

