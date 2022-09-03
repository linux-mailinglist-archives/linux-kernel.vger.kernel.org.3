Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79A5ABF3C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiICOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiICOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:11:24 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DC205E8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:11:24 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b63so2247360vkh.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=R+M1YvVpdR2Y/vihfHhLq4Wuj9YhHF0H0u4Cbj7WBq8=;
        b=o9NRMPL9u4Da8MRhtDCt6JITbrQLv+e2QU9zvjpwm7kJIr0I3L71YgQca6gArSgvli
         Hqa0wFrvv41YNbIk2s46OWDyLYVvIXfOsPMdwGs8hrGFCAvVJdYRun1+U82HxGLHoC40
         C03yKrLtnAJbIMbUHhtSFiKzVatLYVJda8P6drP/UvFZFzIyIbs2EY4PZrl8PxYhURZi
         gYFzc9ZxHwiDgTO2FPPiZyyDm3ZY3m8D6BPOpK4jJE3im4f5ufi29IC+we7COVqjsuSw
         t93ZH7JI67d1yOEaEknwgrykWCkHm+saDjzDujOv7vMI8GOE3TfRzDLvW7AYHvRVxg6Z
         49TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R+M1YvVpdR2Y/vihfHhLq4Wuj9YhHF0H0u4Cbj7WBq8=;
        b=1hk11cKioZukD18/eHZ5c8F7XdAicH9bzwo7geTh2tXd+Lpm69D5F2k3Mq+haxhKeX
         TYMutfjJ3RQT6l6UBBGYG7X8YABo9nXMs9Zr2U1g6CMv2Y1Bial7KYP9C/RyZmdBdLhT
         GVP9vmA8zddOJ1ixZBOXHCvsSOAbK4YEXwqWx7ALSsO8kMydRBHQOTRb8FfmmttkNk6G
         CI3JFr0HFe3aUKPFjGi88xChm7sGRvx4/5ZU3HIsohg80hRGRYn+X0QzX5tzwgmt9Q9B
         KnxQA0gokXQxx1LpxAOyFRsjxlU1DZkuL6Dya2nsgaMbJOw9v9pUCeEib9qcdmbo0Y6O
         jQLQ==
X-Gm-Message-State: ACgBeo0zzAEk9eOrDVy+P27Yb1ptWUJFMDWi+pf/JBj2XQO69Tnd1Su3
        p3yeLdtTHE7tV3kHwWZN+/5tF6nKRJUeuO0kdRo=
X-Google-Smtp-Source: AA6agR4ZXrSj8UcycnvDSOG65EODD+X8oslAxIkfYEvu5DQRXUvk+iR033UvTxWXzy2BvJ6nHQteJKHustSbC9SCfvw=
X-Received: by 2002:a1f:ce05:0:b0:394:5ae7:5857 with SMTP id
 e5-20020a1fce05000000b003945ae75857mr10048191vkg.22.1662214283317; Sat, 03
 Sep 2022 07:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d3eb:0:b0:2d1:220c:9afa with HTTP; Sat, 3 Sep 2022
 07:11:22 -0700 (PDT)
Reply-To: keenjr73@gmail.com
From:   "keen J. Richardson" <roseibrahim1985@gmail.com>
Date:   Sat, 3 Sep 2022 14:11:22 +0000
Message-ID: <CAEJJipWbrp5pfwQONJV6Lg5A7_MPiqZED3Jbzv=ZgA=VN95c2g@mail.gmail.com>
Subject: Guten Morgen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5226]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [roseibrahim1985[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [keenjr73[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [roseibrahim1985[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Irgendwann letzte Woche wurde Ihnen eine Mail mit der Erwartung von gesende=
t
Ich habe eine Antwortmail von Ihnen erhalten, aber zu meiner
=C3=9Cberraschung haben Sie sich nie die M=C3=BChe gemacht, zu antworten.
Bitte antworten Sie f=C3=BCr weitere Erkl=C3=A4rungen.

Hochachtungsvoll,
Keen J. Richardson.
