Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8D47EF45
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352816AbhLXNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhLXNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:54:36 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A8C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 05:54:36 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id v138so25909992ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=UurZZuYyggXyvA+720tOXY42Y74kcB3/Evm/o8OZfYDGqzao5gEMqJopVS56CVwwju
         7fLFx1z8GeA95WJac1P57zndLfCIuWzoh3z0AGo80V+7hXtYFVbt0Wlya0nXY+mctFd7
         Z/KAUGOaMvjFHMSZMtk8W6MZe3xzg3cS4VMANT1cQlfo+H/hS7vgJbkur6YOT32yn1eK
         6rPhG2hIRMZl8yz+RvZrfbsTnnALDcf7QvsHtJt/WhVdE8qYpVxObtknFcDEyNpj/yy0
         dWINn/tBm2QBC3Nu0fFdMHon2g2LFRdg4QDDbFD7WhP8VoqF5+WplYfIydgMdRCEViI8
         dC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=24EFpZU5AMMCntdM+3YfQ+A/kKth8PZ34wiS7rq1lOE=;
        b=Pjjwkiegx1A+fJKR3VMzIVHLjffSSfSdiLqUlQ2FrYK4B040Ik5Mn2bD3ZZCq5NjpL
         GRlZdY8wJUnE8iUOwVcYhyKIIqRmgebwSGPPiCqwOS01cf1yo6W4aRMdMWedUESm1gMh
         01NphLFAS+STOYcZiAEyA/LYAJIvP6lb8mfHRGDP9QfSP4ViWGxCCbHc04Q3XKeLYo+e
         rBd/J7qlrKQdDp+vU6XQJPx1lKQyJ1SZfnFMCFn5DYQcL+iCi5wsQTps5DLxPin2CEVA
         gHZG0sDYDHSBqn2iMDRSwn9E94dHbCS98P5dqjG9DLHTuWWh24T7TRinsaJHhzMGcKdv
         Eb7w==
X-Gm-Message-State: AOAM530DiqZPuHpmOYQU0occrlHmSuZgIWH9puQGULYIY+MwUxXLKMV/
        Fe2TFd0TGpVqHbp5ZQvvQfly0zzQI8Oya2D7Guc=
X-Received: by 2002:a5b:d05:: with SMTP id y5mt8886804ybp.568.1640354074910;
 Fri, 24 Dec 2021 05:54:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:11c9:0:0:0:0:0 with HTTP; Fri, 24 Dec 2021 05:54:33
 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAH6eeoG64RM59E0-ASeBVLygjG+o+t_RJFMvvLSLk4XpUotjsA@mail.gmail.com>
References: <CAH6eeoHsCQ1=9zgTjy1YdkcjkjDQmC9q=7XtTT1LmBop=Bj-mA@mail.gmail.com>
 <CAH6eeoGZfPNTB4qrSpA-xYXviwq0hfo-SbCmuZc3fhgxeDJ2Nw@mail.gmail.com>
 <CAH6eeoHK1QEoq+1fz+gLy=J_1QP5TheXYYC0FVC6BbxP-T=d1g@mail.gmail.com> <CAH6eeoG64RM59E0-ASeBVLygjG+o+t_RJFMvvLSLk4XpUotjsA@mail.gmail.com>
From:   israel barney <griestkristen667@gmail.com>
Date:   Fri, 24 Dec 2021 14:54:33 +0100
Message-ID: <CAH6eeoESj=vF=qdc17UM++SEcX0ERYbH15S9q9MU7jS5_wmUaw@mail.gmail.com>
Subject: Greetings
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day My Good Friend.

I am deeply sorry if I have in any manner disturbed your privacy.
Please forgive this unusual manner of contacting you, there is
absolutely going to be a great doubt and distrust in your heart in
respect for this email. There is no way for me to know whether I will
be properly understood, but it is my duty to write and reach out to
you as a person of transparency, honesty and high caliber. I'll
introduce myself once again, I am Mr. Israel Barney, from Togo Republic. I
am also the Branch Bank Manager of Biatogo Bank, I was also the
Account Manager of my late client Mrs. Anna Who might or might
not be related to you.

She traveled down to china on the 28th of December 2019 on a five
weeks business trip and after the successful transaction in china, she
flew back, not knowing she has been infected with the deadly
Coronavirus (COVID-19). And she sadly passed away on March 20th 2020.
She left the sum of $3.2 Million (Three Million, Two Hundred Thousand
United States Dollars) in our financial institute (Bank), she
specifically confided in me told me that "no one else knows about her
funds in our bank" that the funds was for a project before she passed
away while she was ill. And down here in our country at this present
day, once anyone passes away, after 1 Year if no relatives of the late
the customer doesn't come to claim the funds/assets, it'll be recycled, and
reported to the Central Bank where the greedy government will then
want to have their hands on the funds.

That's where you come in, since you bear the same surnames with her, I
want you to stand as her next of kin since no one else knows about
this funds in our bank besides me, and i don't think anyone will be
coming for it. I promise you that if you agree to assist in claiming
this funds from my Bank, we'll not bridge the law in any way because
I'll be your eyes and ears here in the Bank.

After all is settled we'll share the fund $3.2 Million 50% equally or
rather invest on whatever we choose. So I would really like to know
what you have to say in regards to my proposal.

Thanks
Mr. Israel Barney.
