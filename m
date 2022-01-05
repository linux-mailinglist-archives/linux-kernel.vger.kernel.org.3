Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE748571C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiAERMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242174AbiAERMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:12:54 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04916C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:12:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t19so35726077pfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=AgZz4Jvn4UqP9xwmH4duaA6yKjFU9WedUqxetranecg=;
        b=kUZsjJotxO8SNdldNAiiVqJRbpR4OX22LcO+VHk7Knf8Dm0kODuyoFdAnsU9DK56Xb
         CDPDtF3M7ka39ulyAFWN1eFZmN/NtAqIvFc4rnD71FgLakOclnqnB/DyA53yC0RJ88mS
         Rapkxq3c5rpb4J+6m7TfE3PW+tNJbcX5EUv1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=AgZz4Jvn4UqP9xwmH4duaA6yKjFU9WedUqxetranecg=;
        b=zOugUhZ4dYHm5xyGa4X6XIel6Bbbz+9Eee1SZYf1rJbN7qGhsTSA9u4QpHGV9hEoPH
         9qrgJYPKayfKOUghTIiuIEIuWrt2hgtxSuHQ32+XfQs+8HI51W4nW8kSt4Ak48x3io9z
         PH/HkvKKhI6b2Ok+2zzVeHZEWGDo8UWHY7f3MCbGiG/4U4oP9OaWe79eyoYTUYvEJmKZ
         jRy/Ze+hTBhkeR7kUHb0yXipbERJqfA3Bek8rLa5AGQWQylCNy9IgMko5uD3/PFLGsee
         e5TmHr86srDO18+8kne+j6XAu/Pht4GjbhmG3i5CFndmZ9ncFu23Uw8hkFnMvZCtMNtw
         2VuA==
X-Gm-Message-State: AOAM531+rzAssFm3L3jBtCpz7ZFNcJFdqZAPiEfF299wxJiXDNYT3MQl
        WZwmceSjTq8GpJtZut7E5Why/w==
X-Google-Smtp-Source: ABdhPJzFBKhs2g7ekTyWrbm7eZV/AyCOF7m5Dr6k2OdOc4HNrOSX3nlikGTn/xtAKlnkq3oGtiUZIQ==
X-Received: by 2002:a63:7c0f:: with SMTP id x15mr10075999pgc.431.1641402773545;
        Wed, 05 Jan 2022 09:12:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm20sm3152256pjb.28.2022.01.05.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:12:53 -0800 (PST)
Date:   Wed, 5 Jan 2022 09:12:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL] pstore update for v5.17-rc1
Message-ID: <202201050912.9C8AA2AD6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny pstore update for v5.17-rc1. The pstore tree has
been pretty quiet, which just a single change queued up.

Thanks!

-Kees

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.17-rc1

for you to fetch changes up to a5d05b07961a2df47d3b4aae3bdae61ac095a43c:

  pstore/ftrace: Allow immediate recording (2021-11-18 10:29:52 -0800)

----------------------------------------------------------------
pstore update for v5.17-rc1

- Add boot param for early ftrace recording in pstore (Uwe Kleine-König)

----------------------------------------------------------------
Uwe Kleine-König (1):
      pstore/ftrace: Allow immediate recording

 fs/pstore/ftrace.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

-- 
Kees Cook
