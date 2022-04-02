Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E84EFFC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354009AbiDBIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353897AbiDBIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:52:55 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A72F4601
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:03 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so918996oou.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUOMhCxGGDDxH0dnq3ze5cK/Iq3zT9j9067V4Svj/w8=;
        b=hrLcCtLYrV4YeL/G377XYASUh4ynccAF3dZOX/TdMfZ0LT7DWHenqFFyLsgJ+xcmWY
         l30NBxyr80GQFqz2/yVqvr1QHMERlogfqRKw6AxdrAOikr9iths9SSGjgA6uZpq8IMXG
         +8hEFoqw969OmbP089du3ZZ6uDbQiiOAwEdtW5wH21gwR162yn+8axiyenkjardWQWEK
         oST7dqdh5VWZlBFhlphAzewFXgGGslRtGwBqwLtVOo+u2ccMieDYdKxUHVQd8EcjSsq5
         vqoFpNvvTlti4wUkJ/HqKUcglFP1uLPiuidpO6h1EVORreAvpbuuWdC0QlwvzTJw8ZRB
         o4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUOMhCxGGDDxH0dnq3ze5cK/Iq3zT9j9067V4Svj/w8=;
        b=xYHab4lGjJqrxSED6mRktEMjdhZGGgKcC8PFZ2dtRTPxoRiXpmNJ+w/4jmXc2hQN20
         rQwByVOK5gnsABpTdyErRZ2M9suyjpX0ptvViWwUMlHciGp3OMNci7hRzhF3dgr76Df4
         PIhReL7AXfq0Uv8S6BvxGg80LEDqbxKKqT+saJTc45p5VU4R4Q7pm1IoSSGuCQWzFHI3
         yFwGbaJKNzGrUZsDxyqhP9fL8Vo8/YVcrNGSQ+r2g5wntfvBkcs8XRpI62MzC8XnQ6Ic
         Q8ZXuooElzo0ojPx7myzF1reloTXtGn/5/ysH96BT2AA/+tbC8q9800EpaK1Ue2zzirb
         BBkg==
X-Gm-Message-State: AOAM5328att6hypx1IEk+xGvomanp73C0JiXSKfNksRt/AbsIinkHMrR
        sYM2YVJ/GClTOXimMhnVjWKfDE3nQDM2Xw==
X-Google-Smtp-Source: ABdhPJxrzV+xUQGXp8PKXfzymFhsePke7giMv8WhRPhF+uAjb81XNa8NFgNWfLbe2Tkz9gZNql63bw==
X-Received: by 2002:a4a:5510:0:b0:328:faf7:9ed9 with SMTP id e16-20020a4a5510000000b00328faf79ed9mr3063895oob.65.1648889462911;
        Sat, 02 Apr 2022 01:51:02 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id o17-20020a9d5c11000000b005b2611a13edsm2146162otk.61.2022.04.02.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:02 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: cleanup
Date:   Sat,  2 Apr 2022 03:50:42 -0500
Message-Id: <cover.1648888461.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address style issues found by checkpatch.

Rebecca Mckeever (6):
  staging: r8188eu: place constants on the right side of tests
  staging: r8188eu: remove else after return
  staging: r8188eu: correct misspelling in comment "conider" ->
    "consider"
  staging: r8188eu: format block comments
  staging: r8188eu: remove unnecessary braces in conditional statements
  staging: r8188eu: remove spaces before tabs

 drivers/staging/r8188eu/core/rtw_cmd.c | 70 +++++++++++++-------------
 1 file changed, 34 insertions(+), 36 deletions(-)

-- 
2.32.0

