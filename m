Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045EF496F40
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiAWA2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 19:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiAWA2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 19:28:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008EC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 16:28:12 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n8so1422779lfq.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 16:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=613ViBpRb3EQpTDngNVxaspPzE7CuPWpTntczPjI7aE=;
        b=Rbu9qxrwXZOrJaXSffZ+wECxyeK5XzVksBsgtAjMDinfwLu/isoqXgJN3fus0RGJmg
         BXW3jffZ+1gjrUgWuthg7cameQ8wt/dhf4SY5PPmUKK3YqiRF6zbJ0UmKVq3fSmxY4p6
         ZoqsTNqdbg3ukeDOgYSHn41XIoFiNv8xAY6IZoA/Lrhx6Bm5vJuVi3KNaZwnsbNIeY0H
         z8Ema1lfhKiSs+Scbs23G2N22y3jSN3o0EJ32Ve4uelyRcPSVtbYhDJYtiqmrIAQq3f0
         zlGocaPgLv1LceRkor9wdzSF+UDO3xlk33+3IhCVTjAC/YU0/oBpjxEVrEK++d3hULty
         f2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=613ViBpRb3EQpTDngNVxaspPzE7CuPWpTntczPjI7aE=;
        b=HuCvqQz8ZC6I5rMCICp8L5182eQMB9vafYgWMQaswuNJtK2Y9re0X9NwbAXdUZzSfE
         2KDklZA14Mg8jXDVyfFgdKE5UjD/g/r3RGKOGPl2O40x1YsWR3aB1kuBP2+n0MwxkDnS
         BnGuiPcpFPyEAM/chwzUnttPEJxG/DOajoIVhu9MMdGOY3GTuWrMhatcRySZkekdBb6i
         BxusZHCXXlr1Uq+wc+RbmlNFleUB0+Cn0pSVLscQXMakQXj4SnEJS7BIT2Ff3HBt/ZZj
         MgdlYQqlj8IrmIoejdOHKvgJI67E2sB6mqL4M+Kfd7GQHFk9Ea92gO8EHBc6T5dGUfdb
         7YWA==
X-Gm-Message-State: AOAM533J+K9B9bAA+F8p1exTAy5qi6efvlcAJyzHID1qC1FJRjZQoB1S
        1oylhUhN/9pZxazH1pimJUsfID1APw8qFbzA5Vw=
X-Google-Smtp-Source: ABdhPJyYSCOVU+7bfc+S0h92VhPr9gbRPFTRcty3OTt6d9o3PM2RYTU9ItBuaV652e5CVwWcwllV9dekmlP8iYkV7Mk=
X-Received: by 2002:a05:6512:12c5:: with SMTP id p5mr8333698lfg.103.1642897690541;
 Sat, 22 Jan 2022 16:28:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:47ea:0:0:0:0:0 with HTTP; Sat, 22 Jan 2022 16:28:09
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <lorijrobinson589@gmail.com>
Date:   Sat, 22 Jan 2022 16:28:09 -0800
Message-ID: <CAKXTXJyABu20tokaqv-QCj1Vj=Zr4696CPTNnNStJiM9De_bXQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi did you see my message?
