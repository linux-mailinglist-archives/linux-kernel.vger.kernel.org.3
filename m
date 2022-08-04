Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029A589CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbiHDNjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiHDNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:39:51 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880A3D5B5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:39:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 129so21113977vsq.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WlA+9YfIozAhz8c5LlPhM1dJK7wPGINaWEZjXQbmmhg=;
        b=pGlXwQSqHYX3ef+b2jrFB9ANxIxJf9EgIP2JHUgBMIt8TdzZGmo4FYXiSeL0nSHOH8
         M5l1YJWQGzU6I8bcly7Gy/VGEgFF3T8e/AngfVRey7VNjFUHbuM62fc5TkOnDaMNkrfx
         rjZbLun+dQMISWkzH91VcQLqsQe+Ug1fchRFuRc5k742l3+d/2Su2yqY1ASH+03isoz/
         lj6Y1tiYq9latVn/KbFBkGGK7d/kjixOo79OnmIkARqjdqRyFssJNad5VkslEjDZCsbA
         3cSp5FEpo7pGWXXrqPSD0JUemkaW0HNy1NV3OF0aMvVc7+jUQwZInowV7I+i2F3RKGN0
         sf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WlA+9YfIozAhz8c5LlPhM1dJK7wPGINaWEZjXQbmmhg=;
        b=21CfxxGvEnYwvqyisg8BKT5mWWiwKEUxC7mbDybXHonqHafc2JVyxBYtT2MAjE8NJO
         TnRDVvRFZVeXhfWrH11nbtMO9OjbXsZTdo+3G4OGylR9tCKXHagPy+b93j1RM8itBkiJ
         9ENDeNEjIJdd1JayuZTANLl2eKCcaMyagLEZ0bUnz8CM95pP7EzTh5t6t24EKASNpgN7
         uagxr8zTp4auLnp90PNhjVXv6hoCK27hPvX9a22J6Iwy4PwR14ca9SadueZAPUIrHc2b
         z7cAtE1tILAstiAxnFdHcg+sbRUJ8hL7FvbLWi0bgUEsYS99beZwF02De4vm/2H8Kl9I
         yadg==
X-Gm-Message-State: ACgBeo26Yb7fOsyJ0Ns33kjMvzYGUnJCbVYMHp8wa/Iybz9X0Kg1XlzN
        wK1iED6CchGQvVAGxbn5Zr+isLFZXLyhP1/OV+c=
X-Google-Smtp-Source: AA6agR5o+9qN5oqhJ+kdONhztp+V1PMKbvPF9KT+Ij7SmJhWhgH+CT8o/yIh3Vm5CTeqFuOoLFdcw4LjuDeRuooo3fY=
X-Received: by 2002:a05:6102:356:b0:375:3bbb:149 with SMTP id
 e22-20020a056102035600b003753bbb0149mr774054vsa.72.1659620389655; Thu, 04 Aug
 2022 06:39:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:11c6:b0:2d3:7e6b:5db3 with HTTP; Thu, 4 Aug 2022
 06:39:49 -0700 (PDT)
Reply-To: goltzwrite@gmail.com
From:   goltz write <agoudaviadjovi@gmail.com>
Date:   Thu, 4 Aug 2022 13:39:49 +0000
Message-ID: <CAEbGuUdHsGtNJcva52AG9aXcd_5TaQxSSNo6tnfA=o-pbwDvhg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [agoudaviadjovi[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning and how are you doing, my name is Miss Kristie Adams Goltz, i
am from the United States of America. It's a divine connection to meet you.
i am new here. Please try to reply back to my email, it's important
Thanks.goltzwrite@gmail.com
