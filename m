Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD2586F97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiHARcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiHARcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:32:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C16313
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:32:07 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f65so10267293pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Oes67+Ylc8hvEPTUUvcsJqVHsb6Ia9jyLiE8hgCVNoY=;
        b=T1jFPqf9wVODHTeJONRr9EOi7wNtPB+eoTceHo+25lPpxLhaDKmEaTE0l8nXc6XqX9
         NuUJGQV27xk9kGPp+GKQRyU0rrcggjp6JWDrhKdzDkDVTootOd88OwpFBK4hX8XkFdm3
         qvWoUKI0V2ok6SdATji0mXb8wXUniuuI3U8m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Oes67+Ylc8hvEPTUUvcsJqVHsb6Ia9jyLiE8hgCVNoY=;
        b=Iwe7kh/KgPr0YEv5eiD9hROCG2+zQ3j3qIQjatWl8jiMTCbaeNdpLB8O6k82+di7zU
         AemcvpYYuqYaWPnTuIRkUSrPpCc8sHTV9ugqZu8Bm9uCCfTJYtokoKGm1Kw7XyiRCYNd
         0VYH/fuMwSffYm7Eh2K3H98bffuTd6nIKlYmBsAVoEw/WXAjXTIlh2QoQCz7wdzRjCDn
         I6mlwu4j0zurj6rmNLEQUXaccZxyptqbG7KtOcL0DqeoX8iN13cgER7c+SngJMGLVdfG
         Yudl98M4qbw8gzvtf/qDV7zPrmNFc0Ls+I9lHmOp1ePUD1i11amcdlwIe/2iSsQQZtL4
         9w3w==
X-Gm-Message-State: ACgBeo1KW0btG+16hUNJEPWeYsy7SNmF2zFPI8rel84bhKv3pONLTDA7
        mc07CSxg1uBRdugP09bj9e0RvQ==
X-Google-Smtp-Source: AA6agR7NnPUJRs48F3s0ZZprsEavv77hy5g1o+FyMRU18b91gvKvhCbSSLcbY/yEIdJGd6An1iBiXQ==
X-Received: by 2002:a62:52c3:0:b0:52d:c062:27d2 with SMTP id g186-20020a6252c3000000b0052dc06227d2mr1945806pfb.53.1659375127034;
        Mon, 01 Aug 2022 10:32:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7-20020a63ce47000000b004114aad90ebsm7794642pgi.49.2022.08.01.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:32:02 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:32:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] pstore updates for v5.20-rc1
Message-ID: <202208011029.A1E7EE281@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.20-rc1. The base (v5.18-rc2) is
correct -- I intentionally skipped this tree last merge window.

Thanks!

-Kees

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.20-rc1

for you to fetch changes up to 2c09d1443b9b8b6e25bfb2acf51ad442cf9b314e:

  pstore/zone: cleanup "rcnt" type (2022-06-23 08:27:52 -0700)

----------------------------------------------------------------
pstore updates for v5.20-rc1

- Migrate to modern acomp crypto interface (Ard Biesheuvel)

- Use better return type for "rcnt" (Dan Carpenter)

----------------------------------------------------------------
Ard Biesheuvel (1):
      pstore: migrate to crypto acomp interface

Dan Carpenter (1):
      pstore/zone: cleanup "rcnt" type

 fs/pstore/platform.c | 63 ++++++++++++++++++++++++++++++++++++++++++----------
 fs/pstore/zone.c     | 12 +++++-----
 2 files changed, 57 insertions(+), 18 deletions(-)

-- 
Kees Cook
