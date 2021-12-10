Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9735B470AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhLJTzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:55:09 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41670 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhLJTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:55:08 -0500
Received: by mail-ot1-f43.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10686488otl.8;
        Fri, 10 Dec 2021 11:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cy8xqEajHKVTrrDEEHj37zl/xSZfr+ukXq8qSQmWZy4=;
        b=k099Ej33haKlAPvOiOgJrWknwQrNitFaJ6qyix/8+iuy7arq2YXGTLLkCwuF5c4CBO
         VnL10twVi9okX6uRRYHpcYFb51CjzNYZlJkadiJmR7Gcw1HzKFakW5wlRDBgAdmY/Y4x
         aNxJ59y5RPhOYdd+o7r3T061kgcSrGOTTtogZBZzjrEjUF0rlEwTz/aSEb5Z7AycQ5Sp
         XAaAOXPWsUmoqqNhg6XfvH+46N924rDrMDSh/CKfakMEyw97f9MLG+1w3xlFbJug5bxU
         M78aGm1dpx32AFZLrtTBiCknUVwirz8V6z8Rne2kjmv8gitjCapcmApvyr24MclrTs5P
         p7TA==
X-Gm-Message-State: AOAM531BZgiZ9ciwP0hcNRKOSoka6MbT1+MHFfMaWkjcieoS3kRdiaat
        zEhSEQCFGBAOOiMZwFADdQU6b/3nRwjSlRJOE4r68rwEVoE=
X-Google-Smtp-Source: ABdhPJwWCTQxyhrfh4okbPpLv+QjqanHA+H+CS8qQOCWhzElNZlaNRYY3eowXHHopYyxmR0B43TOHQomaG07RYa5uKQ=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr12927095otu.254.1639165892996;
 Fri, 10 Dec 2021 11:51:32 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 20:51:22 +0100
Message-ID: <CAJZ5v0j+7Kz6n_WfjJuVaxt+MNVo77KikSPKQDB-4iT8ozGfww@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.16-rc5
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
 pm-5.16-rc5

with top-most commit 444dd878e85fb33fcfb2682cfdab4c236f33ea3e

 PM: runtime: Fix pm_runtime_active() kerneldoc comment

on top of commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1

 Linux 5.16-rc4

to receive a power management fix for 5.16-rc5.

This fixes a kernedoc comment that doesn't match the behavior of the
function documented by it.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: runtime: Fix pm_runtime_active() kerneldoc comment

---------------

 include/linux/pm_runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
