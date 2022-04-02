Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B84F004D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiDBKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiDBKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:09:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242D15CB7E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:07:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h4so7357545wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39W2WA7bUOkMwy0BPM0nlS8ZVhAhS2zd7iYkZyMTI+A=;
        b=zXbJKei7ikyS/sIkHRTaolngqejiFymFzHFY9Q5a8gOdtTBWJG+Ifxxg8pbiAdKrQ9
         vNWNnZ1o92mf+8q2nJD9zsHkw1rCu0RTsAe//AlwlF/p6s9P2DpJ7eAHdx6QGnaBUL/G
         QfUpCdrvmsioiyNFgNxjSfrw2vmgpLaFmVElCQ8AGtPWkFLRUws5crhVFY5pF4aPii4B
         BzxC4fdPJtu5dhtOXdy1OpaPpTaZ/pNSuujdWT2IlDcZNMp/lXr4wcalnDSohBvJ+T7r
         5KUOwi3vwl3ICsmQtwvrxILQRDYj89E44Tqgt+G7CFxTRztmqmBezsKOaiJvpaIf9agq
         Dxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=39W2WA7bUOkMwy0BPM0nlS8ZVhAhS2zd7iYkZyMTI+A=;
        b=YGEh+yALj6P15h0LoSlaRnnhAR2vzDSbOgSR7UdPPSFcDCDgDbVsbuwYef+onCtko1
         6Ae/aHSVwUOZS+JmDEFXXght6ow+PoBvyL1FRdFq2kHcGLisCSO2CB+C1sALKXnksNsY
         eTs4A0EPDLS6qrsJk35hW3kRGJi8ToNN+pNUKDy37rOmM2CardofzgEp7yuy2bM1jY9v
         u7Db8ry775W9Kp6nS3pAr2axTCTWICCk6buXM/OVqraJYf6bRzkx45uCSnWpF8yYt1Oo
         3vsvEv3Ui4oPCvkEiHdTCcD9RYV0u50+J0GTy+yryJOV3O2q8RHc/vQD1A53pPEJEkIs
         xI0w==
X-Gm-Message-State: AOAM531ubj3NxiGfwf6yKpTKLSVhul4ka+ZjWQX8+s3pcYcTWVjElE/g
        /4isyvfRyPlqkP5HoTLJhgqE8g==
X-Google-Smtp-Source: ABdhPJx44Frh2pj/E+dvH2rYWUZX6RXCPE4jN10WUb1rG9+Ahq39C5cL3jlsCulMyQbspRxeeRn9AQ==
X-Received: by 2002:a05:6000:1868:b0:204:1e4f:7f9a with SMTP id d8-20020a056000186800b002041e4f7f9amr10809767wri.106.1648894033467;
        Sat, 02 Apr 2022 03:07:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm4084761wmq.6.2022.04.02.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:07:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Documentation/process: mention patch changelog in review process
Date:   Sat,  2 Apr 2022 12:07:06 +0200
Message-Id: <20220402100706.57507-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the "Respond to review comments" section of "Submitting patches"
with reference to patch changelogs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/process/submitting-patches.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index fb496b2ebfd3..9bb4e8c0f635 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -318,7 +318,10 @@ understands what is going on.
 Be sure to tell the reviewers what changes you are making and to thank them
 for their time.  Code review is a tiring and time-consuming process, and
 reviewers sometimes get grumpy.  Even in that case, though, respond
-politely and address the problems they have pointed out.
+politely and address the problems they have pointed out.  When sending a next
+version, add a ``patch changelog`` to the cover letter or to individual patches
+explaining difference aganst previous submission (see
+:ref:`the_canonical_patch_format`).
 
 See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.
-- 
2.32.0

