Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53EB46AA91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352097AbhLFVmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhLFVmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:42:23 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D56C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:38:53 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bj13so23974599oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=mSaIlNfoBW/jt2OkD5XcCr12QDK1WvUAFurbspD0PgHjQqx6OQFGqu03SnfjTCN9aO
         IRFLPSVoajjd5r0i/DMtHY2Miq/FP4PHZVyti0Ur7J0ADDv6b/hObU8OrsFLEjSUbNh6
         mL3FarxoyProtsR36Ay88HrDJgnfwZSE4O+sCy/HM57FQDYN0v+JkxS6yb+rdwFcX2Gs
         uEblW9Ef94bQEhtIElOn41KgxAMhYmLfN0yAiYQzB+g96LwvT/QpDEala1EKTkgWiWpH
         zFweAh+9T+otLbklfH7FK/hSGefdTOH4Hnc6/e4exZI8Wgckcodz4rtGSYW6goGKQ96Z
         e68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=zAfn/Nzps0RzrkgsIZwmUWn12kZ+4TNRrZRgiH8yC3fG8/pKADB2ng+vVfp4cI40KT
         vO/rJ57RBvzBQUZtpe6AdLuhk61yLx/qUlxXlaDPHF87tL+MFvfBagf2P6gFOczlfenx
         fjFW5ZQT4mBAlT6wcCAvnD2YXKXP28i2zg/yxa7ARQeZfKY/XAQju/HgL9qf0Gk5knN+
         53DO3FZGDhgnc70q1FNFM53/uWFL/g/p3VIvSM1nuJxPfujj4ATl1mROpBvos4ovO92v
         EjqUCRV2SfHH3JBlyQbk50puvWb3EXGVXTqss3wBc+Gq+Eu6eoCl1yv6W8Za+SUc3Z8g
         s3PQ==
X-Gm-Message-State: AOAM5326wCUHHA806RZw9gSXUufbcSsaiSx6c/qLsRZTBHE5fGos0LAq
        Dq9fSvt1Luos2UVM6pFegdjnq8gd4XYzNMRxj5g=
X-Google-Smtp-Source: ABdhPJyVbTE5KaDjrAscHbVJd9mo9wt4r235WrCPKElvBgj57GFJ9hQyxQmHVU+CzDijny/Pi4djzIwEjJMvNxFPGs8=
X-Received: by 2002:aca:b387:: with SMTP id c129mr1383950oif.6.1638826732923;
 Mon, 06 Dec 2021 13:38:52 -0800 (PST)
MIME-Version: 1.0
Sender: ericgloriapaul@gmail.com
Received: by 2002:a05:6830:231d:0:0:0:0 with HTTP; Mon, 6 Dec 2021 13:38:52
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Mon, 6 Dec 2021 21:38:52 +0000
X-Google-Sender-Auth: 40GR5Mg47o931llSZgVLk9eOsAE
Message-ID: <CAApFGfRw-e7mjScLGKRdMtbfv0o7qABqOXxbvrNe9TcU-K3hoA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account.. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Howley Mckenna.
