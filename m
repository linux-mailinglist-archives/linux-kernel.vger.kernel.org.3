Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138914ACA3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiBGUSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiBGURI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:17:08 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99FC0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 12:17:07 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id t20so976532vsq.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=XwlVvro9A+/8MvhUA0ZFJavRqqmQFZ7m3OpPTkpipOo=;
        b=Sc7OnqOsLwjPQz0SRsees5dofMESl6cRjuYafvBoFn1DTu/7lzUqWInv2SEfYKgPoD
         ku0TrOoZerYmJjQUUImjz5j6yktaVLpQGAM0qOkdL23o/zthuv8M53XnVfyUzKtiyv1M
         zVgFe4J79IXsExq9/Wp/+f0ef9tz1lfNG4MJI6Z031fkeKM4JYHUP29GFG8hYAR6WnHB
         dZzrOg0vQ9g3a7JR1rT5A9XIdnopuVLWI4wDzzTaX1TEeulbSwGRfO17V4fRVcuQdvLz
         4S6h/975YDCttHNm3B8bv5AIcY4sjX5YOw6psChzXQpJ3/+NuiR+eKvnsJ2A0AB0tL73
         WCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XwlVvro9A+/8MvhUA0ZFJavRqqmQFZ7m3OpPTkpipOo=;
        b=j8qwS8UCQnvW+8d01IWiTOl2IHg/9HJpdUOrkivotY9UNec6gefiuEqWjVribQWAkb
         VCN1HI8hAPfcXeP6RVw+753VBAllMoPhLO2oHkEd3HP5bpv4MpeBSsbHImeBalPr6TJy
         UNymCr+hWqVWNmpkLOQmDqVVxJMNbJS9eF7dDWnqXOHYV37sADu8w5gNWJuQisnhDNhU
         W++DqImUi7zbaEhOM0GYigJiMwgFiUMfYDTpU6uz04GficJaKZm7hrukybZvcamjMqlJ
         Wu8cdUFRwo9iCR2UnFzDhSoWVaR7h0OVVonwVUzpK4GRgIN30YLyHjtyqzFEKUJjdxwh
         F0cw==
X-Gm-Message-State: AOAM531KYLxZa9SCuN5wqVtG/glX3c9hDK4wW2OhnJ5KMA3zXVf67a59
        W2XeOmtqBX1Dvo2GGn7GHY8haZi3/GUN4xBYOYdfD3xDly4=
X-Google-Smtp-Source: ABdhPJwgvk0HevyuzRXxvbNv+JztRzGuPiv70FNnx5V2ki+Km4C0BK2ndm3cA8JyowEBU/lQnF9kAevVo9UKOX0UvN0=
X-Received: by 2002:a67:f98f:: with SMTP id b15mr478710vsq.1.1644265026073;
 Mon, 07 Feb 2022 12:17:06 -0800 (PST)
MIME-Version: 1.0
From:   Blair Barnett <blair2020@gmail.com>
Date:   Mon, 7 Feb 2022 12:16:55 -0800
Message-ID: <CABZiDXLjwtEc9nwmxYDnw=_u-U=3aB1UVKF+ZPmGQ2TXStZnhQ@mail.gmail.com>
Subject: Fanotify Patch
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d358cbc008ebfe2aed50256074e97209bdf035f8 Mon Sep 17 00:00:00 2001
From: Blair Barnett <bbarnett@tachyum.com>
Date: Sun, 6 Feb 2022 21:03:31 -0800
Subject: [PATCH] Since struct fanotify_event_metadata contains an element
 "mask" that is aligned on __aligned_u64, it's best to align the structure on
 this size, rather than the current 4B.

I am not subscribed to this mailing list so please include
bbarnett@tachyum.com as
a CC in the replies.

This fix resolves an unaligned access fault in many of the
fanotify LTP tests on the Tachyum processor
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c
b/fs/notify/fanotify/fanotify_user.c
index 6facdf476255..f028332738c5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -109,7 +109,7 @@ struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
 struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;

-#define FANOTIFY_EVENT_ALIGN 4
+#define FANOTIFY_EVENT_ALIGN sizeof(__aligned_u64)
 #define FANOTIFY_FID_INFO_HDR_LEN \
        (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 #define FANOTIFY_PIDFD_INFO_HDR_LEN \
-- 
2.33.0
