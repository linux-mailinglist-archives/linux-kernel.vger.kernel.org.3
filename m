Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3E4EA697
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiC2Ebt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiC2Ebo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:31:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7727326D9;
        Mon, 28 Mar 2022 21:30:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so14008857plg.2;
        Mon, 28 Mar 2022 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33VyKW7pU2vJes/nt4T4RlOrxbfe6Pv3wVbPF5ZvFrY=;
        b=UKAiIZ38d8lZ+gHBxvL8z70mMrPg9GsupwvrfvtKN7N2KjzwGxGQLUDmuDYSRZ4YCf
         5eSbvYPFXmI3reRY4WQ+sK0yvfMzUJzbvHf+iyVrwWtCqQ0RgPKw9bGgjI2wqjudVpTO
         fDWhX0JAJqGI9wS8lIddspWcTm5vUXPjO/GqHNTg0Tv8YySJvlJUqfxjQcZhARA8s37V
         s2HbYSAMuS3aW6viDCr7GTYO7AqYi/gTJICwBoBpngTVPIlxMv/l7MM03Ah2YVCMvUX2
         Rl8xHIEtmseO/LbOX+O2rpWOMIis87Ho93AGEukpt1bQBDIznx9y7Mpib1OmZNJ9WI96
         01ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33VyKW7pU2vJes/nt4T4RlOrxbfe6Pv3wVbPF5ZvFrY=;
        b=VAJxhApsPAXbvGBcwR8GmBjeYTkCgekcnodI/Z48mbGZdY/mnZrv2ICvBR48670bYE
         QQJyiIUEZQqQ8C1EYHf69THk7d+5vn964/9Q6GiVThDmP6iYIkiiKR0Rz9LxkLHKG2a3
         PStuJk/ZClqyhZDM4rkqkM2P0veDWPWeN+ISqgUvQVWPji/BtY4qqtUcHzBlRzmjpFQh
         51JJtnw3N6ouJw9wLx3iCvbHEoGFP5br97kRr+cTTzy0PYB44Xn87wE5K/ZI93T2y3l3
         HZL022Q9pmyec+tQns1fr+Y7ETC3m1W2G4PJyazYHrlaqzUOyihFyA9ANwZv26d0A2hr
         QXhg==
X-Gm-Message-State: AOAM533X5qKj8REb9Nc5w98DTK+Ab/BsXMUd5M19mVyRz+WMuqI3voOM
        eRKhxdYjYkThWjlQsUKGQEYxJ+oID1GL16dz
X-Google-Smtp-Source: ABdhPJy0Co0aUdUfWkKUzbXORaiwjXBK6Ys+uEAItYtRJgyBaFdunNz2w1KfWckB7XAilRJsUGFd5A==
X-Received: by 2002:a17:90b:224f:b0:1c9:949e:2202 with SMTP id hk15-20020a17090b224f00b001c9949e2202mr2573849pjb.56.1648528200803;
        Mon, 28 Mar 2022 21:30:00 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090a468d00b001c7db8e6ac7sm1055075pjf.40.2022.03.28.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:29:59 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Documentation: siphash: formatting fixes
Date:   Tue, 29 Mar 2022 11:29:50 +0700
Message-Id: <20220329042952.10100-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting fixes for Documentation/security/siphash.rst. The shortlog
should be self-explanatory.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org

Bagas Sanjaya (2):
  Documentation: siphash: convert danger note to warning for HalfSipHash
  Documentation: siphash: enclose HalfSipHash usage example in the
    literal block

 Documentation/security/siphash.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
An old man doll... just what I always wanted! - Clara

