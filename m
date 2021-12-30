Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4445481CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhL3N53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhL3N52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:57:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF7C061574;
        Thu, 30 Dec 2021 05:57:28 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id m19so54935099ybf.9;
        Thu, 30 Dec 2021 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QL46HAFcIby/o1gLWnbN3+VoBbIciVe8uJTUARvDsH0=;
        b=ef0EufrCF32k/t3f+7A5Lzo7mFwUViZeEji52c2QZQduGYXf5lQIoeXR8R1uQwwv+7
         MOmcUdx7O+I7SPJzFG2V9N3OimID5qFWQHYKn5mG/RjZ7eH8HS7NmIYuxqlVFTCx/NaT
         JP4xXQv1au1OtGvyYq/VpABmjPRH4C9TJYegdsm7qSgKGPtbX4hCRM8wW5TgfNYR031L
         wXbJPBLVWory5veQhtvd8Tjn5rBJT+6rsoRQENeqZDb3TKOemYOLP1h+54tAZqBMOTLN
         E3A6ixhVBedYAzjRDz9xNQdCvhSLLSvY16+x3GLN6ue9T+eP5KyxOc4Q53xhXzqMrroE
         Mkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QL46HAFcIby/o1gLWnbN3+VoBbIciVe8uJTUARvDsH0=;
        b=kEaICfOhEBqDSpBWEqUBBYQIA+cT2MsEPPBlgj1Os1L+yx2KNfBoKHRXBt5QpnkRgu
         3C4Su7r+j0dRIUvkyteZOeGmLpx55a4vN+i0unExh2UXh6iRPOXA+vRH9Z5ArBvMNjen
         HmmoAW9LqzToU8MXOgAvk8hzAY55Nnk8Pw9iJyhde9XbUKLaA9QBxsEOUC3HsLSDCiMy
         IE1hec4K8XIs0dGJlt4Kvla3UBwVmt96rr82hz913xJbEp4y0shoFaVIhqZGxAo502z0
         nfCrQHAlioCRj0/1xefB8/bE7pUFSrIVkAoKERe7vHxwptsK9EWY80Pm9HQiPdZUjHfw
         Ek8A==
X-Gm-Message-State: AOAM533T8oDGJhh9xznyLtSajgS3ryQXfhx7o6bIrhsrFVyRZzbdqxnD
        4FUxknDBZoVtdU+6LCTWbiivxnhErsiGTDALCZYNHpvULLU=
X-Google-Smtp-Source: ABdhPJwFEhIHu0che5fkku3dBRjwodnxUCvEDnjJPXl+a7STwbDDnBSAlw+Hihml3eBTiE1VqDrMwZ5DQBakmfS10z4=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr35838815yba.767.1640872647518;
 Thu, 30 Dec 2021 05:57:27 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 30 Dec 2021 14:57:16 +0100
Message-ID: <CAKXUXMw-Tg7WcfVHaWZ-sK+WFnedL+S-jA_UnsdTR=HFwxAXSw@mail.gmail.com>
Subject: Removing the deprecated htmldocs for good?
To:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "elana.copperman@mobileye.com" <elana.copperman@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, hi Konstantin,

While scanning through the internet for kernel documentation, I
stumbled upon the old deprecated htmldocs under
https://www.kernel.org/doc/htmldocs/. I see that on
https://www.kernel.org/doc/, we already point out that 'htmldocs -
Kernel Documentation in docbook format (deprecated).' is deprecated.
If I am not mistaken, all the content from htmldocs has now been
transformed into .rst and has potentially evolved further and hence
all relevant information should also already be available somewhere in
https://www.kernel.org/doc/html/latest/.

Is it now time to delete the content under
https://www.kernel.org/doc/htmldocs/ for good?

I doubt that htmldocs serves any good purpose as of now and I fear
that newcomers might refer to that deprecated kernel documentation
from v4.12, just because it is available and can be found with Google
before one might find its copy in
https://www.kernel.org/doc/html/latest/. Some kernel newcomer actually
already proved that point to me by example...


Best regards,

Lukas
