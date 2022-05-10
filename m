Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6603521C66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbiEJOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343654AbiEJOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:11:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080306BFEC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:45:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so2049738pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ax42sJsqbttuOzGtxG9fAYrepKefZkhLYZ59j7bBIPM=;
        b=msugZbKe42jvOm4igUuAxLp7PgfJo87XpODa/U4e7KX5WR1sUu13uZdHGm1WoHoIBP
         /RN/fIcgMjFFIwhmgUsH5mi8h5Ss5W9bgNFWWzgqvC7aTVEoJrPLP5UUB7FQ3cM56y+W
         zFBGA8m9KYvpfCPqBh8HlnEuWLoNrEO0JUCu5gtyNUMi691T5+CZ5RDTsgVzAChO7amy
         8IlAu1vFMqTAxaRU7rTCoWBAbpPYU92m+Ez1DoJzQPfojttd9Zg3zoxcL9mLBqcZVSsO
         zgIwSEGA0hbnV4Ex2GsJkwDczS/89Ui/VzkwrNATwvpxHKQccvUj/1otwcf7e2Hte74s
         u5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ax42sJsqbttuOzGtxG9fAYrepKefZkhLYZ59j7bBIPM=;
        b=ejG+Gc/R8c1Zed0iPemH24o17KqWeUF5Um/F8EXblNfEzHIEphabJZKMsfpCPAN4Hx
         rfBCKFUJfH2kOIHqTcdCqxpf+7/TJlzlZnDHo5bj9k28zPRTEhRt7urZBY9zPjEBqNfn
         xp0jMsBBamOq5cpyEVXediaY6JMSX37iTlmiQx8SE60zYbQyMhHXOj07z667IkdYZQT4
         T/FBQE3sSORxvcZSccpVZWfNTyJTCIOXPhI/QA6zsIT8E2uyRsjb1kH68LyDfF4+ipFc
         WAO6bhwKDjacRs49RoCb2GDQHrK+MsIU/kr2ENy7NYlFsuCoNuKj26GVg5Ok3RaVJJuy
         rjVQ==
X-Gm-Message-State: AOAM530nGh5OIUbAW4chXlUioIjuCUWij+ReDkOpR5b6fKEUjT0084u6
        XROPEfd8TvzUlkEFohP4VSAHLZuGqc36rTjdsfY=
X-Google-Smtp-Source: ABdhPJw9TaI8LG6mI6+8KB/rKOTEEdZ0qlV+CZUVgnObpX+TFZEoz05KvOPtAUmdezgXV8c6zoi0b6HiRirp6QG8JTM=
X-Received: by 2002:a17:90a:8c04:b0:1de:5177:37e5 with SMTP id
 a4-20020a17090a8c0400b001de517737e5mr128405pjo.26.1652190314129; Tue, 10 May
 2022 06:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:640d:b0:60:61b7:54df with HTTP; Tue, 10 May 2022
 06:45:13 -0700 (PDT)
From:   LUGAED JOE <lugaedjoe2@gmail.com>
Date:   Tue, 10 May 2022 14:45:13 +0100
Message-ID: <CAHtk-n_+rqK1-TYLWoCq=jpKZtMh5Oi2m9NOG6xDK7qLpxBrmw@mail.gmail.com>
Subject: HI DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello to the people of good conscience!!

This message is from orphanage home and children from Refugio camp,,,

We are calling or pleading to good people with conscience who can
willingly wanted to

help the children who are in need at this hard time,,

IF not for anything just look into the children,,

they are suffering from huge hunger and pains and sickness!

You can save one or two even more as you can be able to afford!!

Please help the homeless children,,they need you support ,,

Support them with any amount!! Big or small,,please,,,,,,,,,

Contact us with this  Email ,,,,,orhpanage@gmail.com

IF you can help ,,,,,sign by secretary SEMANY  JOE,,thank you ,

Be bless as you support ,,,,,,,,,,,,,,,,,,,,

 Hello to the people of good conscience!!

This message is from orphanage home and children from Refugio camp,,,

We are calling or pleading to good people with conscience who can
willingly wanted to

help the children who are in need at this hard time,,

IF not for anything just look into the children,,

they are suffering from huge hunger and pains and sickness!

You can save one or two even more as you can be able to afford!!

Please help the homeless children,,they need you support ,,

Support them with any amount!! Big or small,,please,,,,,,,,,

Contact us with this  Email ,,,,,orhpanage@gmail.com

IF you can help ,,,,,sign by secretary SEMANY  JOE,,thank you ,

Be bless as you support ,,,,,,,,,,,,,,,,,,,,
