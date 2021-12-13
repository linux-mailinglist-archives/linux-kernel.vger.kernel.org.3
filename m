Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318BF472D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhLMNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbhLMNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:22:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:22:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u74so23072423oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=Y2sKyeXEaBilgZYYZDDa6aPlYj3E1nHDvU0l13MgrTTmjcwK4NjtzSj+DeHt71aUP/
         yQYv69xxDBR0bqxxAoK3RmBZUktm4e1pmAwjEjBM0gmrQ+AUROLO86WgBQx9pir0tDF+
         h85MsGjRSW4br6jX05DkuZyPbo+x6QfDZb5a8YSP1WvSra4nZKW6ZgGCM5vwWdL3qn8r
         z5NfpZsflcoYpLF8SLQ7vxoy5OKIkweTaQSgPjIYXlYJ5I6LAgjvO27DGbCbmSoSNhMR
         lZEkrX6saWdyb2ismnZFCJx/QF5e4wLWrnoTFbEABKG4VZ4CMK3BZXSyNamrz2ZriaZl
         yGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=ZuJ88JEfpzk5Sqey/kR3b2fuxKIE/Egp7yoqJPc/Rkep2/impvYZOkSSUf39TfeAE1
         +nsIeFCM+aaQtprsHqiRD7T2fuw+S+W1MA4coagDoPgirnhSDiH9g7nLNWHAiC+I0726
         XgINHSlJcyEsmFoLOpINeGDxU7RWaVjOpj82mCQdFT/aht1/FiB8IZv4BfhMqLwhNr3X
         T9/UBsdp9pfsvJ4XbCp/U6tWY1qnm5q+VQ21S6x98VjYXTOE+fpf74U/z3Z9XlBev/GS
         QMG21e/Ftv/9SyWEy/+O8xVYJRraPTasKn18eyLigtJZ7QKA0NDZF9hrM0vBCfGgPz5c
         1tXw==
X-Gm-Message-State: AOAM533xwcdlOTo9Y2Ga45P9/G56z5x+bd8R1HqOaZ+ufItINBjeAQaY
        WLoob4+TpzIu05pWjxB1oLVtKSnUOiqaYFsLFkc=
X-Google-Smtp-Source: ABdhPJzpYOxTqsKnSiDaX/r5Hw1sceDgRXAHUy6cKxoyF27s6iWmlCzTtGMGTJjfmqZbLVY3tNxD2933WSscFyBSQ+Q=
X-Received: by 2002:a05:6808:1202:: with SMTP id a2mr27646186oil.8.1639401746308;
 Mon, 13 Dec 2021 05:22:26 -0800 (PST)
MIME-Version: 1.0
Sender: blessmegod87@gmail.com
Received: by 2002:a05:6838:9414:0:0:0:0 with HTTP; Mon, 13 Dec 2021 05:22:26
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Mon, 13 Dec 2021 13:22:26 +0000
X-Google-Sender-Auth: ArivTEpDXYPOPIjU9HGSCOoJNY4
Message-ID: <CACOw96=G12yhjuxHi5V52BsFS529KxcCUC0dVD5e-f2NYNzNtA@mail.gmail.com>
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
