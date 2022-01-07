Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADFB48704B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbiAGCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiAGCWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:22:45 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:22:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z9so16489157edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YR3mYViIVeHRd2mGjIB7Zi0i9tmtApidqtk9Dz9pOM=;
        b=TDYlvt4PSEsnBELZjCsmVQwrVG3TxmHvlxQceQFr5FcsrGKH1nIA4FVQZGJMnBwIyu
         sqf+hHPaPmW3h/u49LjLjRWglow+7XH9J52xi8ucmVHPeg12k29w++nCRQ+zvgdfBwIz
         qY3lbBf8n33PQ2qzhYsaGuWBoWkyL/Dp/MAcCpsLuDGC8d6N0KGu1wCHVybm9fySZh3L
         +8Ra2T0qK7DN4rDIJ8mAHnpRLsIsCQ5ZiT2fiW3kR69mH54BI9nvSwnV4UXrNwfVjjYO
         XrbHlmrKU6XK/zty/S2vTw1y5012UvNLzaiPFaQ9GZnmbesH8iwkTuRVXlsTanEAQdTj
         /24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YR3mYViIVeHRd2mGjIB7Zi0i9tmtApidqtk9Dz9pOM=;
        b=jza1dhPRA2e8CIujtOySVxCZKaqC8qYbCqiih22c640GptHB57cPLi43Fx4AE/dFKB
         Jht1Q9c/ykR2SaG/5lujta/GSBb43LjBcthIVcdlJSJaiX3MzyfK2tsZHwq7K3oND/7O
         gEmGN/BLQuMzvoeJi33XD0XgqVwF+Sn//1kCnrLohIsLBh84LXOOaZ88eH4fpV0EhsNP
         bAfj8qZHy6uTaS2vjXOUYBvoCyAwf+YQ8b5kPnus4dB2/XUGyZTj8iDLCzRM1DMOwAkD
         mz8X+HF3y1ZmV5Q2gSWFiAcqcYGNErH12KpfLa5dBidLIRnJR9NIFvHB+ed9dtRxbvk6
         LUnQ==
X-Gm-Message-State: AOAM532VZFwEwDxdUyk5j8VGOVaZig/cH8+M+rpCN57FoS2mukJVSd6F
        Wio3sw27n1N6hxtZ6axTKgDlwsonqyQYhyClKa7Mg9uvnhA=
X-Google-Smtp-Source: ABdhPJy0zRj1/S/19FguK/ib0HHjvZRS1GyaaMOm9W/m5vh/zKiWbsRTVfZHhRJ1dvfNb2SWSvvhLDNQVo4H3Xz/OZE=
X-Received: by 2002:a17:907:7205:: with SMTP id dr5mr48290670ejc.696.1641522163351;
 Thu, 06 Jan 2022 18:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20220106175019.3116389-1-festevam@gmail.com> <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
 <YddLe8cCvj5fVBTQ@sirena.org.uk> <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
In-Reply-To: <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 23:22:32 -0300
Message-ID: <CAOMZO5DQEEHYJHv08nC=uYXbFtL9VTAatNAB8V5D_JHiQ0q=3A@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jan 6, 2022 at 6:13 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Mark,
>
> On Thu, Jan 6, 2022 at 5:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > Where exactly would you like me to call regmap_debugfs_exit()?
> >
> > Before we try to reinitialise debugfs for the new name seems like the
> > obvious place.
>
> I am afraid I am not enough familiar with regmap to fix this problem.
>
> If you could please submit a patch, I will be glad to test it.

I tried this change:

diff --git a/drivers/base/regmap/regmap-debugfs.c
b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..fa8821ecc06a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -581,6 +581,8 @@ void regmap_debugfs_init(struct regmap *map)
        if (map->dev)
                devname = dev_name(map->dev);

+       regmap_debugfs_exit(map);
+
        if (name) {
                if (!map->debugfs_name) {
                        map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",

It does avoid the 'already present' error and I see that
/sys/kernel/debug/regmap/20e0000.pinctrl-gpr
is present, but /sys/kernel/debug/regmap/20e0000.pinctrl-gpr is not.
Not sure if this is the desired behavior.

Cheers
