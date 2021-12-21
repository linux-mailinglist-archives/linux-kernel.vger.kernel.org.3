Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7647C7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhLUTmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:42:13 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40857 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhLUTmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:42:12 -0500
Received: by mail-qt1-f172.google.com with SMTP id l17so1440932qtk.7;
        Tue, 21 Dec 2021 11:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JPgPrPFVEIjf6OyDG4aeszuhlVMNt4/l0JdoVf4Nvng=;
        b=BkILyB1Imscz9LLSRC+YAu+ApmTw3YdFIgQ81gtvIHj5LjPdh7L9CfLIUhZSA9Zr59
         2jXZm9lR8fLu41bKb8qDvp2HQ2DpF113rJdHb54JizqZndfXAJwEN8Htn/bR59EX6BhA
         ygrYxEFCg1Oinr2iHAaxdXhcN3lje77dwPwT7H3dfSSIZVjv7fPTFreK1btv0epI2D8Z
         0VPOrSEKQH3duf9E74O7D/XDFgvWsBOw/Z1y5dbQT6YHro2mVzPCQSCqLr45cVUha+P7
         PiAfWMTcUSFcFmVv/Q/2z24iT3087F+EwPl64o54eiHKsSjVzP3pFGpBhGON5lMJ5i7R
         t35Q==
X-Gm-Message-State: AOAM530Ay9xf/8QHMx7aTQt+ZNAeFnzmuJQ3ATWXMIZto//YWkBTtalx
        yM6jfu0UEyreGX+fyO/D/b2PLnP/WLNzpbY0ijBCApWreHc=
X-Google-Smtp-Source: ABdhPJwFsCNFcSELY8NLAo0c1hYknUwTujNgEcq/0+Davb5kk9RkbGJeC/wrtwRXJsvyW4itJIYZJc6NQ4AHp2YnXbU=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr3624634qtv.80.1640115731864;
 Tue, 21 Dec 2021 11:42:11 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Dec 2021 20:42:00 +0100
Message-ID: <CAJZ5v0hCi7TM+WsaW+DFjwxtgvpJSFe10yCwg1yug8Sn_+4TPg@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.16-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.16-rc7

with top-most commit 544e737dea5ad1a457f25dbddf68761ff25e028b

 PM: sleep: Fix error handling in dpm_prepare()

on top of commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c

 Linux 5.16-rc5

to receive a power management fix for 5.16-rc7.

This fixes a recent regression causing the loop in dpm_prepare()
to become infinite if one of the device ->prepare() callbacks
returns an error.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: Fix error handling in dpm_prepare()

---------------

 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
