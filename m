Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C732479A91
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhLRL0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhLRL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:26:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5BBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:26:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t26so9035737wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=PqeKwfGtry3Hm5mwkXDEHiRgHh6Y5S1ouypmzni3hLo=;
        b=FRpimAx7Q+Rxj9nx50MfJ7GHDgM/vnbcPLMYpPo/kBZE07mDPqIzntmOFgtokxGp9/
         rcas2TtdcXyPIIGMgejN23srTlpiEAixbyHM/gVA5ijQr+VOLlqbnPNNiL6gn2d2oOGb
         l96eEmfLJ7JGpqtDWWBN0bZxER301m8Xz2io0pU09Cdo1ml5/5VdHzp24yk6sIotsBfZ
         G44xfRjgloJ7BSy3vR9BVhwIB+ftGv4rzsjDqgSYyFyQ5o8L0ADcLyqtjF6tQOk42Ub0
         Y8/bpRUpJXNtxEuUU/X9R7p+asortXHqWckioRVGUrjRVn+iRGmqT5sK6QD6rNiWYmcU
         r3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=PqeKwfGtry3Hm5mwkXDEHiRgHh6Y5S1ouypmzni3hLo=;
        b=Jol7B/sA4AgMyb0ER4VsQwjKJ2RK8n5SXawtgf9jjutqh8RZ/kHRvabesEu8hqjYQJ
         kyirgBEaMh3zGlzgLjjuZjBWhbL1sZvLGJbyWZEyX3yjBWy3HHUbUYEYdVj3DtHsIJsw
         OClU7iRU4kGwGd1FaTboYBUui94QODXvqv4zaQQ3csK5qPV0vIYqr1sspRZNNxPjjgMV
         QztPR1rZdItIYkYNG6lDgbwDINA+xIKg+StHC+9W0we5B51Nrb+/iu6xLKHl8OHuXW1I
         xPKXiveGWOQYrZ2Bdf9/Mzz5w/0zyv1QOSpYuh9iuJ38EPv7lSCNggy9MluJQhrOsZtw
         Uiww==
X-Gm-Message-State: AOAM531g+RQjVTiz8RQ0xSejwVIBtKfa0MWEdo/m5U5i6PNzbfhRcDQD
        BKd9VIkaplh1YQmNgSJ554nZQwb4yx95VN+51uslXgGO9vEv1WlG
X-Google-Smtp-Source: ABdhPJwSZJyP+QciOy/LN5IAsDo30j2azyNnikziARstKIlueV/eyzf9riWPBBpDfhtIhea3j7wG6DF3Tesar/IggEI=
X-Received: by 2002:a17:906:f43:: with SMTP id h3mr5656202ejj.414.1639826800623;
 Sat, 18 Dec 2021 03:26:40 -0800 (PST)
MIME-Version: 1.0
Sender: alimahazem02@gmail.com
Received: by 2002:ab4:a64f:0:0:0:0:0 with HTTP; Sat, 18 Dec 2021 03:26:39
 -0800 (PST)
From:   Anderson Theresa <ndersontheresa.24@gmail.com>
Date:   Sat, 18 Dec 2021 03:26:39 -0800
X-Google-Sender-Auth: f8zxg4ww-vO0eebLp2jI42ExKa0
Message-ID: <CABBDEbjK6WLqi2-ZLNmOiM+MY81u0fcELOeQSMdorDm7YL+ZoQ@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night without knowing if I may be alive to see the next day. I am
Mrs.Theresa Anderson, a widow suffering from a long time illness. I
have some funds I inherited from my late husband, the sum of
($11,000,000.00, Eleven Million Dollars) my Doctor told me recently
that I have serious sickness which is a cancer problem. What disturbs
me most is my stroke sickness. Having known my condition, I decided to
donate this fund to a good person that will utilize it the way I am
going to instruct herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs.Theresa Anderson,
