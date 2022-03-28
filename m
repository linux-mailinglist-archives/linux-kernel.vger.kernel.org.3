Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9924E9C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiC1QZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiC1QZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:25:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F841AF13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:23:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d7so21157497wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=s54w4Y7MqVNpezxtg1f3Hira4YOla2hVpKZX90Ur3Cg=;
        b=e+PvBP5dLdbFmqn1YvouPmJU1DqB8m1VFGbRlAbMiHtQAl8RR7fWEQCMj28uAXRaq1
         6weOeNHkksrtIbCEYRssRfn5uInUToA10inttd0OC5P6xBdeKDErv1Ihrvitb4UrVgpZ
         L3Y2rPPDchmfPJfLUlnT/ZdwUUsl27TzRXRm3OuZkCVla1DGZCgkO5MTREltfdQ/ruuG
         SITgmg5AFw4ooSD9+fjRcaldgJS8P5YRSPXlY8VxtVzAnKpJxk6gtD4TaAQA7Jv2aCA/
         uuObYk5IOq39wqgeJW8fQbYM6ruws9spjAEWN169mOoBlS1LRBTIOzkjswxuuXHMrw+y
         6Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s54w4Y7MqVNpezxtg1f3Hira4YOla2hVpKZX90Ur3Cg=;
        b=3GXzLcSQlk0HPgnQJodkOAKmKFlUZ92rarVdzd8rZHdPr8NBeF7DlGsuIft8Z7J45D
         U5GM7Vs9WhLCMuABA+mrljn5se9I9eHj+qAhaxHtumYn/uYW0pitPdi1YiQ1m7TZfnbS
         9yfkI4BHnGZXxOkT3uN+BW9LuOomQ1qMjLdjU5fGV0AsY/oxASt6/K7lwFljGNQEV07C
         sn32MT2kn2iPrPuY4u0a0C0RGih35B/3OwTozFYVq2Y57EdxrcEjnC3eChgBkuf/SFKw
         CB0uVdvcwBUUEofEc9c1G4VftO0XkFd7d6yQ0a0M4pNxUmMV71I57pfDcIUjdwvI/q0Q
         hOvA==
X-Gm-Message-State: AOAM532kyK3RVl6RRP+OM2P2aG86ku3ct+b87EPxyGNl0JKoIG1N/rFg
        SZQgN1jST+zCPs/aCtUgFb3bCA==
X-Google-Smtp-Source: ABdhPJxSxzSv849VpLB71DL2nSrK2inpIshaSlkpesI6OrOp+8qiA+tmxOBnqzAc642E+3Es/k9ajQ==
X-Received: by 2002:a5d:6812:0:b0:203:f854:c380 with SMTP id w18-20020a5d6812000000b00203f854c380mr24405341wru.235.1648484615676;
        Mon, 28 Mar 2022 09:23:35 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b00205b3945fdasm6455090wro.92.2022.03.28.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:23:35 -0700 (PDT)
Date:   Mon, 28 Mar 2022 17:23:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb changes for v5.18
Message-ID: <20220328162333.4jwaiwuv5knxh67l@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.18-rc1

for you to fetch changes up to c1cb81429df462eca1b6ba615cddd21dd3103c46:

  kdb: Fix the putarea helper function (2022-03-24 16:39:47 +0000)

----------------------------------------------------------------
kgdb patches for 5.18

Only a single patch this cycle. Fix an obvious mistake with the
kdb memory accessors. It was a stupid mistake (to/from backwards)
but it has been there for a long time since many architectures
tolerated it with surprisingly good grace.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (1):
      kdb: Fix the putarea helper function

 kernel/debug/kdb/kdb_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
