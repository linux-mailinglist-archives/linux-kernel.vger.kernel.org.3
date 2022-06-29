Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD65600AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiF2NB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiF2NBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:01:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD91739153;
        Wed, 29 Jun 2022 06:01:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g7so10587693pjj.2;
        Wed, 29 Jun 2022 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=HqNKV4bR45GvOqHjeBJQ3k55axq+VCZJ2whW1fAz/0M=;
        b=Cmqk7U/Lx1CxmE+wKYCOQwkJGXpDJajm76ZxpXqESFNmz1ExgInYIhnpQ57v74j1Qw
         cD6ju4aIsv/pcyIJu2qkK7+je4LU3DLEaJCeV4WwjXRa3equp/JCpMh+OCU2tj4LWSBg
         XLGos3i5BPRzvj2/2LYH0d/kOIznBthdIlSapY8knNhDs4rM27qQNTJSVx+YmF5RqoWh
         F9ZiFDn1lKonjn14cA/3FPywH1H6+asUp3rfoX97HOCODuix3kHUMVrV7TewyPi+zNjL
         6Z2JhBglIkNMFfxWqGN5bedh9SvQlvyQM9v/N+EiKefhPkvpy3ZtJqKc/APx1A/ygYnM
         r8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=HqNKV4bR45GvOqHjeBJQ3k55axq+VCZJ2whW1fAz/0M=;
        b=aTI13BOAvOrwP7hQW/P5XIVF2FE/Ds+RIRaE/4I/67HZwLm2puotdu+4GFZsPr8StF
         BNwIEj8ZqdEdT8Va7DIO1telwC9Elnil4HKKHrAmf9lvqBK4lyQPqTXpIJwivblvvn4L
         dp37YhEhUvR3ScBoIzSLwqngOIJhKm/C1MHv+KxxTz3e9BXJc6QOzAaXd2cql22p1ZmL
         +bGjrDjYzXeZs3/ORAbXb3LhKqFcPUPhf0fIZoBtQyz9deivhMXRCMXStskLjKnPIBTS
         0sVb0wTccNwtNMQUkMTo2GObo7zD/I8BbyFcywzsHWVZLShcZkugNtEVFSFvgcVlEArA
         EANg==
X-Gm-Message-State: AJIora+lhCNErjzIEGzP5vidrN4jDPdH+COog4uc58irhzNtxehzAcia
        YtAZmbW2T2HV3OpzGjFRVQI=
X-Google-Smtp-Source: AGRyM1ukLgzdPJmGd07DUSErX6n7geF03OhJc3b0yiu4cyfrWF0xZMcLfe41o0VtkMakIlFvQc3FRg==
X-Received: by 2002:a17:90b:341:b0:1e0:cf43:df4f with SMTP id fh1-20020a17090b034100b001e0cf43df4fmr3860023pjb.126.1656507681308;
        Wed, 29 Jun 2022 06:01:21 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a6-20020a056a000c8600b0051c49fb62b7sm11735880pfv.165.2022.06.29.06.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:01:20 -0700 (PDT)
Message-ID: <c3254669-cd71-48e5-665c-430b76f77baa@gmail.com>
Date:   Wed, 29 Jun 2022 22:01:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] media: docs: Remove extraneous \endgroup from P010 table
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The \endgroup command at the bottom of a table added in commit
5374d8fb75f3 ("media: Add P010 video format") doesn't have a
corresponding \begingroup command preceding it.

This imbalance causes an build error in "make pdfdocs".

Fix the issue by removing it.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 5374d8fb75f3 ("media: Add P010 video format")
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Hi Mauro,

In my (bi-weekly) test of "make pdfdocs" against next-20220629,
I encountered a build error of userspace-api.tex.

This patch fixes it.

This is relative to 'master' of git://linuxtv.org/media_tree.git
as merged by Stephen.

        Thanks, Akira
--
 Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index a900ff66911a..997ce2d094fc 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -570,9 +570,6 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
-.. raw:: latex
-
-    \endgroup
 
 Fully Planar YUV Formats
 ========================

base-commit: 945a9a8e448b65bec055d37eba58f711b39f66f0
-- 
2.25.1

