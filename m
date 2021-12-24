Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8447F188
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhLYAAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 19:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLYAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 19:00:47 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D7C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:00:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id k4so8605621pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Va+3Qc5m9iXppR5P+VJ2i2dR9+eZyMwUougtx+C2x7I=;
        b=inGTUfdpcAfkC2x2+fiG3/o/aNuAx4qjYEhvziSFuXvvPcmOyoomIfF4uwIpwABbRB
         5xf8ajvblIJBybY48Xgo2eNugEW/0kMVNKWij8LcA/rNo+6PNbhX9m4ub7uNYLAzj/jU
         8clBQBOruEilqpMi5dxFwa1PhKEdiDGNf1bs/8cLNgDUd28CfzuE3Xt6A+cNArMwrt3L
         n0VCwqaKBp3SXD4s19ZqVwI+HatH/rmy3khyxufu4HYdF9wWE+kKOlQT4eMo1rtKrJq7
         l7y1XiQZ5C8/m79E9tVCbpltmYbgvA2clRdFqIndI3QxhqJeMgxDcB0RawtC3KowLNAQ
         vhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Va+3Qc5m9iXppR5P+VJ2i2dR9+eZyMwUougtx+C2x7I=;
        b=JGcLwsI0KwOP2hhhBGoy45INP03wTWQyar0Yx0FA/qTaJpYgaQwDlo4QBVQYVsvGfc
         9b3opGTVYKRivdtA7zlQ/pXPKAftYihw0XKJWsys95kZDJ0StGHUT3FZpQmqhr6XYovL
         eSSUal6yp1FRS6XQbXtLPGRZNesoBu9qHS7Pjxygvt7/ufWEPeaIwdauqfq5p87JVLvD
         6P7uWMBv0sIMZDWFR/Ruz0q+EVteR7cWQ/sMrJsH9RmXR0GVTvrEB7Tst0o8+UdgYAz6
         GVKy5BLqeaxdTDrHl0cLKAgjlsH8webc7vxRYH3UHu01JXr5wzW4XoE/OYvUizoyj51c
         bqxg==
X-Gm-Message-State: AOAM532ueen4xD4g4ow+krfyOHWKT80Y4DF8Tzkfs7lxXimzdkbHgItI
        cSackW6KYZfPk/TvAfWZ0P3vY0xEvH+eOOiVO2VUQE3wHtrOGg==
X-Google-Smtp-Source: ABdhPJxEltgIDxYYX63f8ia2tXkWIBL2u1BEfeZS8BAjDwBrKmiOrcA3ua8IhL3JZA/JKEN5IR6ycCc+yvPe3gAH3yI=
X-Received: by 2002:a62:8449:0:b0:4ad:56ba:2f1d with SMTP id
 k70-20020a628449000000b004ad56ba2f1dmr8541245pfd.37.1640390090225; Fri, 24
 Dec 2021 15:54:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:c512:b0:68:78a0:e47b with HTTP; Fri, 24 Dec 2021
 15:54:49 -0800 (PST)
Reply-To: bankdtb160@gmail.com
From:   DTB Bank of Tanzania <efffbi12@gmail.com>
Date:   Fri, 24 Dec 2021 15:54:49 -0800
Message-ID: <CANLFAeThXbgR-E9B-AFvFS45A7+Y7PY1gK87NXOZT70n2BQdog@mail.gmail.com>
Subject: DTB Bank of Tanzania,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

We write to inform you regarding your inheritance award winning cheque
of $2.8 million USD which was issued out from DTB Bank of Tanzania
last week, although the cheque has been cashed & converted to ATM Visa
card, reason, the cheue was cashed & loaded into a card is because the
cheque may get expired before it gets to your possession, therefore we have
to registered the ATM card with EMS SPEED POSTAL SERVICE company here.
So you are advise to contact DTB Bank of Tanzania through
E-mail;bankdtb160@gmail.com via their info below,
please be sure you send your current home address where to deliver the
ATM card to avoid mistake or misplacing.

Finally you advice to take this serious as we have done all the
necessary arrangement to released your ATM Visa Card on your behalf.
Thanks & happy Xmas  and prosperous new year.in advance.

Contact the Manager Mr. Abdul Samji
The Executive Governor Of DTB Bank of Tanzania
E-mail;bankdtb160@gmail.com
Telephone:+255 8983 0023

Regards,
Samuel Brida
