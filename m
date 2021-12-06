Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE5469551
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhLFL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhLFL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:57:25 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04250C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 03:53:57 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g19so9929002pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FN8gmeeFosyEMCwP+9T5Qcxe++S6hreeBk1oxhzKQmg=;
        b=AvoidPfda8OfEDUPPec8E/gMS6BVPagUxoB4DQ30MK2GZ0PUA5o5gI/zhfcKViQuMX
         6br1HttQJxgl4eu8mU/G/5aFKHJLVcxJbVB05iRqZY90+SHTpAEdsADLqgqFIT/jbnOH
         9QyCu1dNLYVltXszFpb4yq5fXJ1yAvEGIOMZv95VigtobB/5nGY8nM8z+sfhS2iGrFh3
         jRly8SkktWNL9oeDZZqjwt5yW+W3Vm9VDcb4bsv89Nw3UhbDXmoPZyE5VSfyrqqgWLat
         hjhp1ScaNcMn/10sqYwmGBUwJkVeKw9oSCQdsiylvmaOv7wIRzl+bYY6liaw/c9W07x3
         PMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FN8gmeeFosyEMCwP+9T5Qcxe++S6hreeBk1oxhzKQmg=;
        b=K1dVkDYxNflysdmU4EbGd6i53ZGKRVfpnu7qfF6CGzUZ0fVKuh8b2VNkfxgyfAQ8Yl
         bLMkGqMXbPhJjxnN9zXr/Ky+kZcekynonwgk7oJdqVnAxJrvgTUhLc/5t56gaxqjtWMo
         e528NwN01yyQVhdTjxTCQqTI4u0UWJStDoBbYLOKU8GSO47r95A1+Lx3/AIZkwZW4tRl
         mabKwS7orF8P7kTEmpZh59QV4B7WescMZ8hL+D1i5Em0T3ZfGw9njbu26IpgpWaTqQB1
         BJkZ+p65zAVNn1b7Drl4fK2AXrkjlcbhm8x9idi+R5cmYI12C8vn49STbJAVmg464C6m
         9JiQ==
X-Gm-Message-State: AOAM532kDxRNGYT3VzdwG3I68xdKGKn+hNnEAb+A/3WoT0ACmOswhhxg
        eWhFZhBqn4BbcUwkTaP12X0/Q8DcKhg1ZARONT8=
X-Google-Smtp-Source: ABdhPJwZOBPk0clZH4TnqwmDjugpATaQUL+/Y7m4+W6u1GbCFdZ4NuqQEpCkM4Ks5SQcQdDOi2n0K5kmrX3MzJEjh4o=
X-Received: by 2002:a05:6a00:1c65:b0:49f:d8d0:c5d9 with SMTP id
 s37-20020a056a001c6500b0049fd8d0c5d9mr35534574pfw.72.1638791636303; Mon, 06
 Dec 2021 03:53:56 -0800 (PST)
MIME-Version: 1.0
Reply-To: oliviaeorge@hotmail.com
Sender: kkalynes@gmail.com
Received: by 2002:a17:90a:7021:0:0:0:0 with HTTP; Mon, 6 Dec 2021 03:53:55
 -0800 (PST)
From:   Ingram Olivia <oliviaeorge@gmail.com>
Date:   Mon, 6 Dec 2021 11:53:55 +0000
X-Google-Sender-Auth: MXoiQhKmoBXlurBS8_jvhXCW6F4
Message-ID: <CADS1LaDTY2bPxO=7QSPkneB80xboGVcyM1hnmtLdnQSQZB5ASA@mail.gmail.com>
Subject: I wish you read my mail in a good heart
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

I am Mrs. Ingram Olivia, I have decided to donate what I have to
Motherless babies/ Less privileged/ Widows' because I am dying and
diagnosed for cancer for about 10 years ago. I have been touched by
God Almighty to donate from what I have inherited from my late husband
to you for good work of God Almighty. I have asked Almighty God to
forgive me and believe he has, because he is a Merciful God, I'm
presently suffering from Leukemia.

My health condition has gotten worse and just two weeks ago my doctor
informed me that my condition has reach a critical stage, that I have
just 5 months left. This confirmation from my doctor was and still is
devastating news; it is hard to know that you have just a little time
left to live here.

After the doctor=E2=80=99s medical pronunciation that I have just few month=
s
to live, I decided to divide my wealth to contribute to your country.
I want to assist you with the funds to do great charity works in your
country, this is my last wish. I selected you after searching few
websites; I prayed and was led to you. I am willing to donate the sum
of ($8.1million ) to the less privileged through you.

Please I want to transfer this money to you, If you can handle this
fund and very sure to do charity works on my behalf and from there I
will travel to meet a specialist as I want to be buried alongside my
late husband when I passed on.

Note that this fund is in the financial institution and upon my
instruction; I will file in an application for the transfer of the
money into your account for the said purpose.

Lastly, I honestly pray that this money when transferred will be used
for the said purpose even though I might be late then. I have come to
find out that wealth is vanity and I made a promise to God that my
wealth will be used to support the poor and the assist the sick. Do
let me know

if you will be able to handle this fund and use it for the said
purpose so that I will inform my bank on my decision, If you are
interested in carrying out this task, get back to me for more details
on this noble project of mine.
1: Full name:
2: Country:
3:Occupation/position:
4:Phone/s:
5: Age:
6: Sex:
7: Address:
God bless you
Mrs.Ingram Olivia
