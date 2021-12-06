Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210A46A8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbhLFVBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhLFVBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE64C061746;
        Mon,  6 Dec 2021 12:57:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so752621wmd.1;
        Mon, 06 Dec 2021 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XqvFWwjigRYg/qDFlCbBpyfLDh6E1UzrKYM9j3gZVCQ=;
        b=Ftn5O0PU35wFEBXLBVckAjE27WQTY4606alcTMJFw3R6Vqf/E2xVyLz9SW3QS+uFLt
         lMz1uKf3x8dEnG6ez+3zfNwb4Yqim+B+rpAE9KxmrLHxzlyz70gAB5dcHR4vZ4GHX1zz
         uGtAzitVp4YfLTMOZ9heQs4sIwotW/A/kZDeFCl9ao0S+36882dFXcS1epO+5rSAoTI4
         tuD43xtEdk0XAmqAoXxIvA5we40SCHpm/+d2jj53MtxP7Y0z9KEst6zHGSd6mSAYUMOX
         P9ZW3n4m27UibC8C9keBnE6aUY4pyyBlCMQl7g8r8PDghYnwON4MQyZpMgPpY4kjgqF3
         PjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XqvFWwjigRYg/qDFlCbBpyfLDh6E1UzrKYM9j3gZVCQ=;
        b=DoMQ3bY+oiHnktB5W1LNSMG98ehu8zWHfvQm0hRcFf9boq9Gxq41bSwFTNINKolPz3
         rRvVCTEeQoXH0I4RBlpfAU0AqgfD69SUY0UVmEui6R8CGG3zasKKwLdvwMy07CTozBpp
         FUuj1Un1wVrdfON5Za4g6sAiLdnYUn9SqGV5weeCXOpSITSyNR8shgwkKOtqFzrR2wM/
         zdlyPt+zad/S9ZcDAMwnf5xgKMX1tbpN+48Lsn9dpNA+R63slrGA3SgB8V9g2cpng3CI
         NYQ3sWLjXbsQaByVFKqnNudrc2ZVbkWyS3necEeCBGWpYoGNSmrZAmR834Mk0zhkLVtg
         z47A==
X-Gm-Message-State: AOAM530r6Q8IikvQkBaZ0SWgb4UziHIyahx3C2+mw00FU6qU6jZXVRVt
        Bdywo85bk8wFYXDmrENvAcM=
X-Google-Smtp-Source: ABdhPJwTKNdFslxk89avHLfOJP4PsaFEJtAuBbfAqlcBTpeq/8UaSuhpyxREzNwU+lFpuFPTsPg1BA==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr1293915wmq.24.1638824268224;
        Mon, 06 Dec 2021 12:57:48 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id e3sm12696754wrp.8.2021.12.06.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:57:47 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:57:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 0/5] Docs: usb: Code and text updates from usb-skeleton
Message-ID: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explanation and example code updates from usb-skeleton

v2: update patch #1 to #4
    - corrected format of function names like the following example:
      "`usb_bulk_msg` function" to "usb_bulk_msg()"
v3: update patch #1 to #4 and created patch #5
    - moved correction of format of function names to own patch #5
    - reverted change of variable from retval to rv in patch #1

Philipp Hortmann (5):
  Docs: usb: update usb_bulk_msg receiving example
  Docs: usb: update comment and code near decrement our usage count for
    the device
  Docs: usb: update comment and code of function skel_delete
  Docs: usb: update explanation for device_present to disconnected
  Docs: usb: correct format of function names in the explanations

 .../driver-api/usb/writing_usb_driver.rst     | 69 +++++++++----------
 1 file changed, 33 insertions(+), 36 deletions(-)

-- 
2.25.1

