Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2564C468637
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355304AbhLDQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhLDQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:38:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36416C061751;
        Sat,  4 Dec 2021 08:35:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so12652700wrw.4;
        Sat, 04 Dec 2021 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IFVu1PuPnhIt15rJ74uCpu5RJLk7jJ20O56jMrGMi24=;
        b=NnTbwLUOLeauIl/AOA9bQhINPrSZoM5h3Oh0pQGZyt7EyZWOPAhZgLv0egY7uka2ol
         xMP7kKFXtyEbcYOGZ6TdaqT+GA6m3CUqJ6+/+TdmsLD1mJEPahlsusDxCmM7RMVm7Y/A
         NQLR0kmCa8HDfDMoXAKeArhZiRvBW3X2Ddc2QLtu7fM/tlE4iNhESjwEt9MOmlcqkaTj
         KhJlj16dWfcHh9Z7OdnxMSd5rxMFli4R0IF9hjWE/iXfa2eER3Tk8Pe5gESCmtVFCHwD
         IbmE/V6Zic9tqPtAJWqmnlDFpW2nAQRWdZURo6cbqXwOj84dWvXGWpd8Qv+rYhcLfSiP
         RTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IFVu1PuPnhIt15rJ74uCpu5RJLk7jJ20O56jMrGMi24=;
        b=34BaR/ziyNlgiiMhOZLqZc7kjk20nWXqe2DdUVkNxivsFwxaKESeYYO4HcLgyiTzyr
         4rDln0dXNB8tNggj5eI1hCk50Gp3cc+8TyC6cI63Wd75b8qKn4H+SxI8Fd1yWW/g4xmj
         zFZVp7fTKn6uUDyxdVk/XT4mZWu4VOyKP1lXBJ1t9H9MkBc7Fv26/omi0xzig5jnFx8I
         fib+H/6XRrIilc70C0/mYgKPnty6kDHc90zpL1y72W+VHozPw/zDptWveoGQWRlR0KJy
         mHZuXColbL/XcuGkDJX28uS/G2t/xswg7Fky7CKQpBiGMMjbgnnDZRlxagVQat2vPpT/
         G0BQ==
X-Gm-Message-State: AOAM532QuSDIZDYd0e2RQkegjecZ4PW6x9+VpglIvEBD50jV/b7qIVM+
        56RNcyu9g+9xfxfrk08sqnn+E+VBs7mS+Q==
X-Google-Smtp-Source: ABdhPJybhJZg9DgLmgRtdfPsXwakZKlPE8uyKjdTz5vDl5CosgVARe48rXeUfLuHOZ7asdUZL7lH5w==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr30345787wrq.139.1638635705882;
        Sat, 04 Dec 2021 08:35:05 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0685b3447c22a42fc55e.dip0.t-ipconnect.de. [2003:c7:8f4e:685:b344:7c22:a42f:c55e])
        by smtp.gmail.com with ESMTPSA id n14sm2908383wrf.69.2021.12.04.08.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 08:35:05 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:35:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 0/4] Docs: usb: Code and text updates from usb-skeleton
Message-ID: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
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

Philipp Hortmann (4):
  Docs: usb: update usb_bulk_msg receiving example
  Docs: usb: update comment and code near decrement our usage count for
    the device
  Docs: usb: update comment and code of function skel_delete
  Docs: usb: update explanation for device_present to disconnected

 .../driver-api/usb/writing_usb_driver.rst     | 73 +++++++++----------
 1 file changed, 35 insertions(+), 38 deletions(-)

-- 
2.25.1

