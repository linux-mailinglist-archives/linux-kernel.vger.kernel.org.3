Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB248882D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 07:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiAIGDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 01:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiAIGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 01:03:11 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B3C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 22:03:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c71so28406188edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 22:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KHcWV4zSsq2PqN20f8EeHPXMVayTO8KS5bdiyuIRLEE=;
        b=k0fdWqEsgCpnEmUUMA9wJ0uzf9fHE1/FsTac0eUignUdtDFImgsmqxmzlkWNRj8TtF
         2nKFNKPZvzlH2lwh30ZFxguHbecL538BJczRHNxN4dqC4DHrDPZpkofLIvHcHga9s29U
         DCR4idEgo3QyJpV0eZVhp0Tx8Nuip+MfpWlGlE9fWmqwU4B5aWWl38G8zNWLI59leXvi
         tRJw+yqYkHwT6EbiIkYyTcnTpAdL74mVtCS1Ow7zIRi9q+XnarzuXYp2BCzOjRGOuE0f
         i8+l1YM/FQ7YzvMTaRr9NnJ81BwiDp+uX4Yss7Am1qSSWKV+lg+PygjAxXV9Dam89v9I
         2Rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=KHcWV4zSsq2PqN20f8EeHPXMVayTO8KS5bdiyuIRLEE=;
        b=oRJIzh5yWwfrSNB6dsDr2sCcCqFMm23rQks9+Lr+yPP8uXcT0OYzkBg3ctiehqg6IZ
         imaPBw/K+tQTagPhVo5t4YEsb5yQahphBwv6x3SuE7IhXORxyFbepmlmB5GaVVSaTM5+
         kyfOl8epw28jisetFngzELxNbun2kjQsnsQ1s4lkqekYq+pI6YGphYmjK9cuDuzKUlqt
         qmyrReeT+VZJtDth2WAfLebbfG0q4/dk2CCMVSLQvW5xvKvwMfk24ErNtbGh2s7M5uAl
         YnwJxJWeTC6/o0YvZD4bhvMfMJCCNZnqBOf3ZsoLwTF1bs0lopsUnwb3geEtn97np74/
         0jsg==
X-Gm-Message-State: AOAM530rqf0FXBO3APrWt8VIGOgQ3DIe0BbkKOC60LXTdEpSO+xcbIDX
        q5TlVwyuv6pGUBbXy4kFyLWWKu1kEk+WpKy6GPs=
X-Google-Smtp-Source: ABdhPJxXR2mTk+bDicf93DtxBgrj0jbRJSmhoCnJUvtHO0/EGcBEpoV7M9yutlKZWZXQvXVKvRk1BWRGj1nWt97pTwE=
X-Received: by 2002:a05:6402:7c6:: with SMTP id u6mr10863540edy.160.1641708189451;
 Sat, 08 Jan 2022 22:03:09 -0800 (PST)
MIME-Version: 1.0
Sender: fedexdiliveringcompany@gmail.com
Received: by 2002:a50:248a:0:0:0:0:0 with HTTP; Sat, 8 Jan 2022 22:03:08 -0800 (PST)
From:   Jackie Fowler <jackiefowler597@gmail.com>
Date:   Sun, 9 Jan 2022 06:03:08 +0000
X-Google-Sender-Auth: W0CfFOx1XIkiwx3HvlJMp8qP8Og
Message-ID: <CAMzF8Fn0M5vRY8J_VTpuMMsc80CWcaXnnbqv4e5bhroOHmNT5A@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gooday,


 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs.Fowler Jackie.a widow and citizen of
Canada. I am suffering from a long time brain tumor, It has defiled
all forms of medical treatment, and right now I have about a few
months to leave, according to medical experts.

 The situation has gotten complicated recently with my inability to
hear proper, am communicating with you with the help of the chief
nurse herein the hospital, from all indication my conditions is really
deteriorating and it is quite obvious that, according to my doctors
they have advised me that I may not live too long, Because this
illness has gotten to a very bad stage. I plead that you will not
expose or betray this trust and confidence that I am about to repose
on you for the mutual benefit of the orphans and the less privilege. I
have some funds I inherited from my late husband, the sum of ($
12,500,000.00 Dollars).Having known my condition, I decided to donate
this fund to you believing that you will utilize it the way i am going
to instruct herein.
 I need you to assist me and reclaim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.=E2=80=9C and also build schoo=
ls
for less privilege that will be named after my late husband if
possible and to promote the word of God and the effort that the house
of God is maintained. I do not want a situation where this money will
be used in an ungodly manner. That's why I'm taking this decision. I'm
not afraid of death, so I know where I'm going.
 I accept this decision because I do not have any child who will
inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.
I'm waiting for your immediate reply.
May God Bless you,
Best Regards.
Mrs.Jackie Fowler
