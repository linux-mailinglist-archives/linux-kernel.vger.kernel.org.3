Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42F5270DC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiENLp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiENLpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:45:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA51262E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:45:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r27so11364758iot.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HT4S6kvm8pe8lhVzW2dQz2/9/DgrJFAMA+qoTd7MYM0=;
        b=Xuw/42wQWh7vCMPNU311oidOzb0Us4+sgOcpddgStTKPOcaYZqIRLJOUxK5xsfGQ4Z
         +mkMBvfipDYMMqi2T9MCArZ2m/MddA0vSSzVzwUOKnQai+JxSmilUZseEklvTnTY82J4
         Nm1qIwetyFuAbyjwhx/L+wK3lx7KfTFCo5LUIvU4EaB1DKyCc+m94j4yjmtrQuFK5e5R
         HrtyvVNCmfABwILSso9Ir58Ozq2c9cCGGClmVktMZUOkDOyuEK+DIDhsf3aUyZLOU8P0
         0M//sYFhMZtNaUBuOA44n8IjvphJl7NgXPjIsdYgxUHR5iA652mdVIdcvmiFGZcXemSL
         GcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=HT4S6kvm8pe8lhVzW2dQz2/9/DgrJFAMA+qoTd7MYM0=;
        b=4Wbv0TtjtpQ95vK0YYde2K5qyVZNdLDGIjK0+p91eRQ7UufE2gEK2rLrLM9wSlTA7K
         F4JUaxJEmlmhoLny/L3kO57YVyjdCgDCOXl7RfqWu5+Z5c4yisfW3Kbo8BX2wl1OFlhg
         d6J7NAsrT8XlIbwoGtyXOfPyAnbMMXK7CPyV5hFNy3vFLyLllnA1qyLWRcsnzm3WixRX
         KdI0uMOQDv+GXLBHiJc1g+jwYJsnlMrczTc3ac3t+HAZfbYTqQ/mnp6MYitktjxhJFzh
         y2NpF5qwxkbNQggYDf5UnHfhRSqJa/pSK9Yz75W3sbLpcYd8AItEuCosEbiDCNygpyi9
         NzUg==
X-Gm-Message-State: AOAM533KwvP5Qc1nhicwxV9HGtD4J0O6MCXcfClV/RRLkLL+HvMcCimb
        MZp3+jNORmBl+nJ2SIQKCdU6lIWyGFy8s8vZJsE=
X-Google-Smtp-Source: ABdhPJxaNP1uyJEPrr9Yu/5kHsccK4HOLV71dTW7mk+wnObxtL04re2PvFXQlbJvms16HbOeqadRD+VUBhxnE9QUZNc=
X-Received: by 2002:a05:6638:2054:b0:32b:bda1:3044 with SMTP id
 t20-20020a056638205400b0032bbda13044mr4915008jaj.32.1652528751576; Sat, 14
 May 2022 04:45:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7104:0:0:0:0:0 with HTTP; Sat, 14 May 2022 04:45:51
 -0700 (PDT)
Reply-To: pomtfoundation2@gmail.com
From:   Peace Of mind Trust <florida.illuminati@gmail.com>
Date:   Fri, 13 May 2022 23:45:51 -1200
Message-ID: <CAE+pKzaWm5-Ja33zKB9tFqg9aL_diN5M1VcW92rF+E11jw0-nQ@mail.gmail.com>
Subject: =?UTF-8?Q?wohlt=C3=A4tige_Spende?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5019]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [florida.illuminati[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pomtfoundation2[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo lieber Beg=C3=BCnstigter
Sie haben eine Spende von 2.000.000,00 =E2=82=AC vom Peace of Mind Trust
Foundation (PMT) gewann PMT den MEGA Million Lottery Jackpot im Wert von 51=
6 $
Millionen und haben beschlossen, einen Teil davon an f=C3=BCnf gl=C3=BCckli=
che
Menschen zu spenden
Helfen Sie mit, das Coronavirus (COVID-19) in Ihrer Gesellschaft zu bek=C3=
=A4mpfen.
Bitte kontaktieren Sie uns unter: Pomtfoundation2@gmail.com f=C3=BCr
weitere Informationen
wie Sie diese Spendengelder beanspruchen k=C3=B6nnen

Dein
Peace of Mind Trust (PMT)
