Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55C4875BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbiAGKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiAGKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8219C0611FD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090b050e00b001b3548a4250so3150900pjz.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUHot36Td8cDg3pJLYKw4P/pk/V4dAoQaKwkomqmQSU=;
        b=ZNopCICcNCT3iDv8ljgfUUyWG9dYT4uwzYwLW993ZojUVlhFE5wGliKGih0mRSyt62
         612P8I2461IZMWL80m16wQ6ULcNWfKPucE5X6Q1HdzaoG+VOJy+tyhTLPL1q8rOL41xH
         2uGdXpMOZNchAhQs1jLjofGuMI87nNOm/3f+aGnCCIdk6wenJ0ZJJZpyugyqNa5toYyM
         5OfbSanEp0X9kgVMTQt6sdfZ2hQ4adpgxPdd9wZDqq4JVy7ITZuTt/a/MEIlt+UieqYa
         laYdqu/T+3JK5dfQF4wukF+2FoW7M2jAiE/KqQe02oIMiHKvJahPD5XhgznYxvjkNpQ3
         SNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUHot36Td8cDg3pJLYKw4P/pk/V4dAoQaKwkomqmQSU=;
        b=jdtF/jJxT9xVul45mqflSVE9gCM8RUJVcOBYdB0HGyxEvEYgDMUkZgMsaRXszE5Y85
         3TK/auf3gzjS6pCFgLxMvapubkYAweh6PDy012ZNHjaGd5yfVWJ0XCVrhJocnhTl3SLd
         cfkFlrTYeFORuul1DZl98Mi3kxlNIJAkK8hkBGL4fnc65xdCv5zthZL1LGEEzbxjoP9v
         ZnuRiEklP6Te/pqwky9bfmDhpy4dd07TDL926oTkQuBrX85rg//vHofe25t3sFx4yu2O
         RjDuBgKCvs0hCzsWSxiXfRHy5iVDzL8r0CEjHlvFYll3jDF3AUDF++p7Jjevbs74DViZ
         fG1g==
X-Gm-Message-State: AOAM532qtrff6LHarVJW1GlDHgn2pOSSwk0TO4Msi0oA6qPJqtyGDPjJ
        B2tfw50AVfuW3n3vsan+970=
X-Google-Smtp-Source: ABdhPJxOYh4MYVRZeXclKlukMvF7rVvfCEjEl7csRKdZTnf/8FJglPuLr4dzu6RYEJhNFbuuhIjU6g==
X-Received: by 2002:a17:903:244e:b0:149:21a5:6033 with SMTP id l14-20020a170903244e00b0014921a56033mr62400622pls.37.1641551816417;
        Fri, 07 Jan 2022 02:36:56 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id i1sm4464156pgk.89.2022.01.07.02.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:55 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] staging: r8188eu: remove unneeded ret variables
Date:   Fri,  7 Jan 2022 16:05:39 +0530
Message-Id: <cover.1641551261.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes unneeded return variables in ioctl_linux.c,
and also converts functions that always return 0 to return void.

v2 -> v3:
- Remove returns at the end of void functions to conform to coding style

v1 -> v2:
- As suggested by Greg, change functions that always return 0
  and whose return value is not used, to return void instead.
- Not removing return variables in rtw_p2p_get2 and rtw_p2p_set
  as they may need to be used.
  These functions call other functions that do return error codes
  (mostly -EFAULT) but are not propagated back.
  I'll send a different patch to fix this.

Abdun Nihaal (2):
  staging: r8188eu: remove unneeded ret variables
  staging: r8188eu: change functions to return void

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 145 +++++++------------
 1 file changed, 54 insertions(+), 91 deletions(-)

-- 
2.34.1

