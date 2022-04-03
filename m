Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA04F0894
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356231AbiDCJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDCJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 05:24:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E139B99
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 02:22:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o10so14260453ejd.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OTuQUiog2XmLT6Jm2LnAcZJ4IxYwjdtxF6IgEfkS7Y8=;
        b=fZq61mlWlHyc1Y6wGvfGvXgqo6pPeCmp3tFD8va5puX7gSlcNNGG/plOoHxhkQ3kor
         UCxhAaOd3Zqe5ZTl8MjkNgpv/DWlZOzEjEChMyi5G1nrNRKWLrsNTxRr40aFw4AQaMm2
         iV5GaHQgPeT+ZKs/ihqft+Lm4HXvHaJ7686pgWBX2GDRzzQqUsF0/mj7+7dJUGFYdJqQ
         iDS5NzjX/VgRitmDZaasKFMWrNdo2lvckAhPrah27Gf2b2aDkqGl4eYkHfBUD6reUCI3
         jTDSQ363rRgK5d+3td+q58jda0Vm6zYiyz0yL1iu/Bts+TjzEl9BUYt+OJEaKAWXCM99
         eVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OTuQUiog2XmLT6Jm2LnAcZJ4IxYwjdtxF6IgEfkS7Y8=;
        b=VthUZVeuDyjApCac9D8Vi/C4eCkIDLn068LK78+NSRLufTRIGtrOulWUbTn5F+qtEU
         IMBn7MOCHs6vzjR5BFZgwoMBXK0cooe/iF49cyh2HY+5m+z8jayfvKXfMzaHwMsZ7vda
         /yH8ut8ay47cAzlq5BNJEdMuMjzFnVBDzlMoLqEiDzfo0d8f4mnh3CnA3zJYWcF6Ci+/
         0g/V6laUbhj/m5/ntWhsAUhX0k+GhRwbmFZoIRgvuPgKAmMMSr0JEi7v4PVnV0bHHRJw
         0BliqSKT7+yZaR2pZgsGulQfFbYKAccXPmxq6eudRRCWqBApYvA6FtH0RIw3k4sGLK6V
         ys/A==
X-Gm-Message-State: AOAM53097LxRh+ElsxyoOxqJGfXkictB+bKf9A3VWCxgVXRHSFsaYGvp
        Ad0kXVH0SaXeuZsJygcDI+TG4ToLteoVXEAfsDo=
X-Google-Smtp-Source: ABdhPJzLg0+erREsH0LkqvZRw0B9apCBelXQz2EGRKuZhrBT/KPSramJjcoWDVpB39OeZGvWHR/AjvJ8iSqNFn5BJys=
X-Received: by 2002:a17:907:6d1b:b0:6e6:2583:cea5 with SMTP id
 sa27-20020a1709076d1b00b006e62583cea5mr5495591ejc.188.1648977725289; Sun, 03
 Apr 2022 02:22:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:b1d4:0:0:0:0 with HTTP; Sun, 3 Apr 2022 02:22:04
 -0700 (PDT)
From:   Ikuku Ajunwa <ikukuajunwa@gmail.com>
Date:   Sun, 3 Apr 2022 02:22:04 -0700
Message-ID: <CABueqtC5yqZjA2-Nahh+2UZbiKPEH6hLa+sSvwcE85Wa-A-PYg@mail.gmail.com>
Subject: waiting transfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valued Attention Sir!
Our recent record   indicates that you are eligible to receive an
optional repayment of cash fund!! $750.000.00 which has been found in
the security vault registered in your favor under your email account
waiting to be dispatch without claims.
the account is set up under your email address  can only be obtained
by you (receiver),all  you have to do is to provide
Your full Name.....................
Direct Telephone: ..............
And delivery address........... For immediate shipment
Thanks and anticipating your urgent respond
finaccial@citromail.hu
Yours faithfully,
ikuku
Section assistance and   Verification committee
USAfro-Euro   Debit Reconciliation Office
ID 4475 UK London.
