Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3848071F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 08:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhL1HwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 02:52:18 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42923 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhL1HwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 02:52:15 -0500
Received: by mail-io1-f71.google.com with SMTP id k125-20020a6bba83000000b005e7a312f86dso7775159iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 23:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=mfSDVqJhErVedYfVrnJ8dEhFdGpJaXk8RWpKOtafGRE=;
        b=ASezHo3lYEwlfQ8H3lZZTvAHBNVpeooSfwFLKNIKTMFZTezStF4Bz7AMnpzytC9naI
         Svf6QWyTwFWfyCa5ZG6BqOyg1ar39ITBLLiwHuEJBvr+PQfj/j9MoLXwHJzCH9Fly02T
         Og6357Ykkr4q5QLCnXnrx93Er5LcI4qtsncOCgpGOGfNEs8InWFPWU/+FH5MDJD3AGCQ
         llqZrrQ09uXpQIITgM+RjGQN6L394bc6SIPfYelNEmAYCTcFVl1QFIw+z8ZK6q3NfmDJ
         OBVTR5TvOaqT6cFrseopmfRI1Vp3Sp/tyZZSVdRQC6xQ03DOxjF2Q9Gmhlefq2PZA5zE
         u19g==
X-Gm-Message-State: AOAM533oi7AW6/YwMn2sJLeo5qHO52INegYae641uGvl0RPLi/O8oMK3
        vhyCB3i6fKU2iiT5D1ELiZF8ABbjfIrpnVo+IKAzdqc8SlRb
X-Google-Smtp-Source: ABdhPJzM3WruGzEgkkdvoZlnjeHQawCjv311LVoKVmDQGijHVqpynMTPKWPTup+cgtOBPkzM/DBouDc0ImZMGjHlUyfc+QXQ8aNq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:: with SMTP id m7mr8941202ilh.114.1640677934458;
 Mon, 27 Dec 2021 23:52:14 -0800 (PST)
Date:   Mon, 27 Dec 2021 23:52:14 -0800
In-Reply-To: <cca3b7b4-d9cf-a275-ec0a-c99720a94049@wanadoo.fr>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000796bc905d4301953@google.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     christophe.jaillet@wanadoo.fr, glider@google.com,
        gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> (3rd try - text only format, other git repo to please syzbot - sorry for 
> the noise)
>
>
> first try (ok, 3rd...) to use syzbot. I hope I do it right.
> Discussion about the syz report can be found at 
> https://lore.kernel.org/linux-kernel/0000000000007d25ff059457342d-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org/ 
>
>
> This patch only test if alauda_get_media_status() (and its embedded 
> usb_stor_ctrl_transfer()) before using the data.
> In case of error, it returns USB_STOR_TRANSPORT_ERROR as done elsewhere.
>
> #syz test: |https://github.com/google/kmsan.git| master

"|https://github.com/google/kmsan.git|" does not look like a valid git repo address.

>
> CJ
