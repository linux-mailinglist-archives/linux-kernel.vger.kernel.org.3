Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9449180D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 03:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiARCoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 21:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345435AbiARCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:35:43 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F08C061244
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:33:14 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5533980ooj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 18:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mHfKZ9Ymw/85frIIOq9CgRwcVlYoOu3SDEmNxLb08I4=;
        b=YsZ8lnTxZiqU6rGq12f/KUNboXWA4PJcLYJ3G8KfoC7KNnN6/e5vK/YSsfKUeektL3
         5pgyve5bU1vNMXFvLyLvhXY6XhGP9+Eq45Ifp43a15ZREqukNLyRmvWOxPivAnPPUJyw
         q93jJkpcxvHs8MfQq8F9Yzs+UxzksYnPX6Nm+YWHCDJqwYSNsjaBXKmqqRx6k3PTu772
         eMFTvRlSwvLXWT/wuwkoNodUOG/FleRbmBc8iA49+BxxMkE0z3NNjqvIG5e/dCM+BVla
         wPG/8oulAHiQ99EzajwnwP6mPCcNI7KvJH4gGRBebFiRgyTjzMczpgcal49nM5ZY1FZE
         ALtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mHfKZ9Ymw/85frIIOq9CgRwcVlYoOu3SDEmNxLb08I4=;
        b=EuF+w3R+1CQKkv6ouCb9C/I64f991XBn5Qz8Cwq+C8ubVvv+SOseMlvTLJSWo2a0Oe
         pNXVf4I76BPN+giJ2JjslIVwNwDXhI8fertbxeNJj4cjhC8H4+xFIwry4jOWfAp84z0L
         JCO1fsBnXkjQJqSpqQbHCTvNMwObxM2pW9WLO+py3ceF5mHEOBLKXNPdxBDHTYBPOPAd
         YSDl+frsW+6wHNaNhazGFyCHtJSJSQ74H+H5N1123DGa81hPA1wIcILlCcl99mBV4voj
         4Lw3E+aVQmS+tPiqyEs6U7k3nvAKZXwUvvD03GkdV1dtmTLjt+EB0AmTsKoFiMdjw9O2
         9Z6A==
X-Gm-Message-State: AOAM532vpivOq8SiZbJlgWZY+o+zxFIyD5CE+Dn2NVMRVWTpKc3ob3wE
        OUjaTLjfiFC7GPmqKSKTCyL5DXDOcqaS9cbxNYc=
X-Google-Smtp-Source: ABdhPJwGvpmQ+D9x0SbrIq1IPEuH8CMqft5St+NdO1bq2yReLimmWyiYU9iWNcgmFrzXCQp5iot8PHKwZxMkPiAZ7EY=
X-Received: by 2002:a4a:b546:: with SMTP id s6mr16969540ooo.45.1642473194308;
 Mon, 17 Jan 2022 18:33:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:86ca:0:0:0:0:0 with HTTP; Mon, 17 Jan 2022 18:33:14
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <ivanroberti700@gmail.com>
Date:   Mon, 17 Jan 2022 18:33:14 -0800
Message-ID: <CAKiAiLA0pG_=0JXjrmUZ9t96FW6MpQjW9K2m8qgPJ=DJRnXuKw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
 Please with honesty did you receive my message i send to you?
