Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED96849B173
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiAYKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbiAYKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:15:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F26C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso25593931ybg.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ueYsGyaLQSVR2x9Kzw6/iG5Y5nhNjYWyB1+Gonc5Ftc=;
        b=efFdlWFP67mTX8k0yBeFjiDgv0aKG2Mghid1Nf9irHMgdY8QTqF0mQCGGfhXcyiWbr
         ayMFdRdD17+i2ANJ5Wy+KSdENg18uC3/wXXx7TG+SYsMQrWyKYAnjGx/CyNPrCwhlFGS
         xh8sc44GhR4+vItWb0/1qYRXTsq0KPTqTY0Z0VldMCIsU5AcDmfY5Y1opYYpp4suuU59
         duJOuY9RkmRPqmzIAexzQxtYGy/4ud38B0wkC2wUP3ZbHmHo9URRPLDZVMvEPUM9HkmG
         AK5K2mN90b4eEQN2ZU+HjSCQtpUZv2gdI+iTIqOZD70OW6phUMGL+AMRw4IZS4V33FaD
         eumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ueYsGyaLQSVR2x9Kzw6/iG5Y5nhNjYWyB1+Gonc5Ftc=;
        b=EuA57en4gtRdTkr1uCjrZ7OHFx+ZUD2kHS8NEoOphTnq87kZBaS4hFUSmsRzyV0lSa
         9cxMgRi2C5Sbz7iA2PvZG//55nkrwKk6zMlS+WoWwaIYv/SV6gTFFUX004SdWDTQqkod
         BiE0LIDbZKf8J/1zUs5WA9kRRAS7qh4t7zr62mcU+5p2hVGEGRu30xKlLxmtShQIkgmr
         8/FximirX7wjUjiy5Uyx0bc/OFquvzxaCOHCzWhhIMD1qzVHfNqpI+GMqP9f9veERtnY
         se+JbMGwgazaxFLiCHoGQcyT4iod1TfpKFcTaqTYk4l2QRXXtMhXn1wD3UPSd4Rlk8bx
         p4Zg==
X-Gm-Message-State: AOAM531o1yAWRxnosRN6/Bx+lCLvv8umcHLC+h84HvhLUd7s4MG2L3lS
        CFR0A56R72+Ws+pgTE6WWUqUm+EDDw+A
X-Google-Smtp-Source: ABdhPJxt7HJFvzRp0YTgmr7uw8gyt8egDDhLnledf93ScEbYW2WXdwgYiaPdMGFEw8acPIp8uzyTtjizv8cw
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:69af:7f25:2010:2c85])
 (user=tzungbi job=sendgmr) by 2002:a05:6902:110d:: with SMTP id
 o13mr30910873ybu.715.1643105741817; Tue, 25 Jan 2022 02:15:41 -0800 (PST)
Date:   Tue, 25 Jan 2022 18:15:21 +0800
Message-Id: <20220125101527.1812887-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 0/6] platform/chrome: cros_ec: miscellaneous cleanups
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, tzungbi@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1st patch fixes unhandled undos in error handling path.

The rest of patches cleans drivers/platform/chrome/cros_ec.c.

Tzung-Bi Shih (6):
  platform/chrome: cros_ec: fix error handling in cros_ec_register()
  platform/chrome: cros_ec: remove unused variable `was_wake_device`
  platform/chrome: cros_ec: determine `wake_enabled` in
    cros_ec_suspend()
  platform/chrome: cros_ec: don't initialize `err` in cros_ec_register()
  platform/chrome: cros_ec: sort header inclusion alphabetically
  platform/chrome: cros_ec: append newline to all logs

 drivers/platform/chrome/cros_ec.c           | 38 ++++++++++++---------
 include/linux/platform_data/cros_ec_proto.h |  3 --
 2 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.35.0.rc0.227.g00780c9af4-goog

