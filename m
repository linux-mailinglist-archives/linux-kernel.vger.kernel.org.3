Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526C75479B1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiFLKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiFLKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 06:16:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AEB50477
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:16:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s1so3788018wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k6Ypp3ZqB6KZarZC5LJWvKaJPTAf+yT+cTJ0/3rPKyk=;
        b=cpp2bXvvxq68gIC1sS892FUlU2qnq4Fx91fJxS+54meoPjgu7TIq3V054+tVzY5lS6
         t5O4gXSv1KvmhQYf0RsHWPALWcQHBR7VFc9/L7G8v/PYrI4FcnyY+DecPNc9LTHjpdEz
         y41HZJw30G3kjaSJbDMKpKqpGmLeeFLg54ZSt7TQM6raDdIIdppJMstC6hoyqXK0KPHn
         3wgv3K2tbXA1zHyb4YjeQSNzA0sWuvUVDGVEA0tUgO+FQ1dpOzQyuqbLnbnHUQJylhbX
         a1diXbo7tJmteKyjfwSTHY+uikDyZZFM7fbZkVjdk0DOPUL4/Q/NOAhak49zKNUll3cp
         wYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=k6Ypp3ZqB6KZarZC5LJWvKaJPTAf+yT+cTJ0/3rPKyk=;
        b=u7+Ph/KNcFTH7QI5m9LFfe27K5nt8QKUlsLFYhIB+Ux9JeuwlcY+9sUeZeFLdu36fL
         68bWKxqHMcTNr4NUNJr+wx8xtjgArfKtdU3espA+l1A52fePvUZscjXTtq3a4eL1lJ7Y
         jZwUYs24I6QACHTaPvkjnnJFbiQ8uA+n5ix7/L9oX9ULgOnsAP/z9Nt9UtgdRPYaAFNe
         ua3qXucVPoNu2xiG2YP8xbgWqFdwpAIMhM6lhKpIn/1rMD/QMY3yHF49jalLzZd0+58E
         Y9q64bOcJMLBIqk0WCnNNCFFd73RVbGudTbzH1DoG9+DDx71I4HhD83njhJbOT0s2Y5U
         e57w==
X-Gm-Message-State: AOAM531qvGFSZNiGncqtJq/n7sRuMY4jA+otFNWWfhPAfDxX14MIlGLh
        6i4sRisNKzXAQl6l4FSOcygPtc81QMEeuQ9gipw=
X-Google-Smtp-Source: ABdhPJxMTMwTvxQ70LnJ/ZTbq18l2Z6fUUnUDjUM+uIy4+EZJbPx3bONPwlcnQf+qGvwANqcNMG7UMeU6OVzmdWojoI=
X-Received: by 2002:a05:6000:1688:b0:218:47d6:5e46 with SMTP id
 y8-20020a056000168800b0021847d65e46mr31656319wrd.699.1655028968975; Sun, 12
 Jun 2022 03:16:08 -0700 (PDT)
MIME-Version: 1.0
Sender: kingsleygoerge@gmail.com
Received: by 2002:a05:6000:2ca:0:0:0:0 with HTTP; Sun, 12 Jun 2022 03:16:07
 -0700 (PDT)
From:   "Mrs.Girdaladze Krummenacher" <goergekingsley@gmail.com>
Date:   Sun, 12 Jun 2022 10:16:07 +0000
X-Google-Sender-Auth: YwIN3JBOf2ratfocttlei4uX7ks
Message-ID: <CAOSf3OS3H6+iD0OthrOYtQu4YJ2zqAGghOq91k0pNMc0hH2o_w@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Donation
My Dear Friend?
My name is Mrs.Girdaladze Krummenacher
,
Am a Western America but i lived in
Liechtenstein for many years and
now currently hospitalized in a private hospital here in Texas as a
result of Throat cancer?

My purpose of writing to you is because I was led by the spirit of God to
offer you the
money that Me and My late husband I have private account?

I=E2=80=99m 69 year old woman? It's an issue close incredibly to my heart, =
as
I'm one of those people: divorced, single and childless. My husband
and I were together for many years, but were unable to have children?
I=E2=80=99m offering
you the sum of money as a donation for the work of God and
charity and to take care of orphans and  help the less privileged.

May the good Lord bless you and your family?
When I hear from you with this email address
I will direct you on how to receive the money.
Contact me through my email address  ( MrsGirdaladze1@outlook.com )
Please pray for me and god bless you?
Mrs.Girdaladze Krummenacher
