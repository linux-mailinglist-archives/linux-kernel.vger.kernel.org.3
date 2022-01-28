Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296E49F1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiA1Dlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiA1Dll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:41:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39107C061714;
        Thu, 27 Jan 2022 19:41:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p125so4113362pga.2;
        Thu, 27 Jan 2022 19:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GEDrQnS2PQp0kCcJ4PzWq//Eov06fv7g6bwFtYZ+45I=;
        b=lWjDr4T3y968IJ3MRsdCHsaWaUxUbZWxjXJxunvhiLDc9KFkBchkFsiYTkY2dG8bJr
         GgZxXe5HkLsqGdwnk4bM5s5WD4KUWvj1Hz3/5mMz552LhXKzRjP/O5HPoMhROCLfsKwB
         yl6EOoLNLcTWTAwOKmNOn4GwZXfP6yzNE7PN9CctYARsoFcGgvlikMmqw5Iu6cuR8+O0
         88FSCCbKl8c7pUyDioTCxdvBYojfP0bCbvYC7eJdD54F299ID3dvU/Np8P12SOoZ5CsD
         ZglD/K80eHPZSh5CwHXDTyN/AkiqJ+O49sqgGli/48ZpeT/aq547zszhp3XEh7Rfug3T
         sahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GEDrQnS2PQp0kCcJ4PzWq//Eov06fv7g6bwFtYZ+45I=;
        b=58dH92PnxMI7b95NxovmAgcskstyOzb5B4nApwbxCankIkiQ3o7bu69PgcO4idUE0j
         o3VbUfENyaFKUyZOvgBSniwtleMeCR47E/YQHRQ27LxMYe0B463Gmp60hh3hE7h71rgD
         S5vmFRCur5miQulQHvt/TXxX12CbMGN33gQh7cgXZHMFNdfIplOgxKL9hCCjNx/vw4v9
         k5BBeEYGD8IEGNIAsSjDSjrfxbJyMdIl9kv42TgmyLGpS8vbOXgbTlwUxD2ZFjl9IObc
         zbczXC1xxw9GsLzA9djgagiyumEKd0zq4yhSpemmSAWDl6UO5fuNUpU2j6a1tyTL9zIV
         xOZA==
X-Gm-Message-State: AOAM530XN/gnpwgz8opS53fbeE0IN01vENa8dUEE991Rz6CRT61/u56L
        VuKolS7XonucPfJOF9fcsW5fGlUy0/7pj8mrCwPrPDXV
X-Google-Smtp-Source: ABdhPJwbhcwL1OBXdUvoiaYEdhlijoHI8NJzyaEK+ZFPRvfSAndEv1yF95YXXqm75fyPs6018HcEeDQuctzy1cqo5dM=
X-Received: by 2002:a65:6b90:: with SMTP id d16mr4998473pgw.129.1643341300522;
 Thu, 27 Jan 2022 19:41:40 -0800 (PST)
MIME-Version: 1.0
From:   jagath jogj <jagathjog1996@gmail.com>
Date:   Fri, 28 Jan 2022 09:11:28 +0530
Message-ID: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
Subject: IIO Device Driver for Maxim DS3502 potentiometer
To:     jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, aardelean@deviqon.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Maxim DS3502 potentiometer breakout and I have written an IIO
driver for learning purposes and tested with Raspberry pi and wanted
to send patches of the driver for the IIO sub-system.

Can I send the patches for DS3502 POT for review?

The setup used to write driver
Raspberry pi 3b
DS3502 breakout board
Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux

Regards,
Jagath
