Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8941E49B258
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377216AbiAYKt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356602AbiAYKq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:46:28 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D384C061753
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:46:27 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id w7so23155738ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=eYhJs8s1w7PRv4FHGORd6YbSSzXV91AqUHQKjw8JrGd5VyoA+3DS7OWNo8i2EIq4MU
         MfJve+B+1ax5Jt7+AAcVy97haXxTKkfn5pIvctXjiwC9M1injJmI5ne7g5H0X6iYmqHO
         HLRI4XwGY+d2biahF1GVKyNrBqsryD4G6nrAaX3jb9FiAnk/LJ37xKboiErsrzByPS7l
         t/G3XgpDEX/WloMEFItf6AXS5tkisVsx4sX5mWYMc0LWS+xKb63T1bpU2lfTXka/hI49
         gVhzc156a/DszQQzuLRprZwFIiNdxqIoPx5GyJV+wFzhV7SupTJMbsmIpSzJYj+kZEn/
         caQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=5so/UkofYmgQOIFiSU++vlkqhjfxr+GceE1ixejIIDe0THRCUgYL5i4Un+NhFPtqBX
         aYoLA3x/6ylPSP6d5MdXf/NqiBzIXXQngQyKbRPAx1EdSDL+T6aZ0p4ZuL64BnaND1tQ
         pgav7Y+0kMOgiebx30ByfFp69USo75vA9i0dO1nRDJkEgrsV6njSu1EgpD75OGzDwO6K
         y0A2PsfSsHMathkustQg7HDr1TebNP7V2yI6u8Gz+wH96ZPQ6dmTA3tqmp3k6U6eDwlt
         J8YN0uaUb9FHGsi72T+KPn+A6+xsREq3YV/d8A7Q0kTUOIW5/yBkM8uyVQg2bmW0wFvl
         UELQ==
X-Gm-Message-State: AOAM532Ip9eruF1D+TfIPbYcsJ/PrqkYH3GXmhtYouz61bCh/Mig+26V
        +Rj56U5DgMb7GVZP12T8O4Q3t29MrH24pT15eQ==
X-Google-Smtp-Source: ABdhPJy6DEyO0yUOOrQuJQo5O13wBi7QYdowPp5hCqkkEA4h9fn243gRnDuKXRHZ0DkfFuIvVoXjTCKljxu/lDRVnuA=
X-Received: by 2002:a05:6638:2612:: with SMTP id m18mr9006868jat.19.1643107586465;
 Tue, 25 Jan 2022 02:46:26 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: ali.wa1234ara@gmail.com
Received: by 2002:a05:6638:4112:0:0:0:0 with HTTP; Tue, 25 Jan 2022 02:46:25
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 25 Jan 2022 11:46:25 +0100
X-Google-Sender-Auth: e994NbP596L0usD7QbagcMEIgMo
Message-ID: <CA+0F4TE7LgAu0Z6M=wTeL3Ty-Uyf2fAkERxvjdPhuJJCASdf_Q@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
