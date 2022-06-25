Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E855AB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiFYPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiFYPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:39:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5D15A2F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:39:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c2so9456618lfk.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bI751YOuP98wHh1q4rHO/ASQoCAvLeM/hP1e2c0DqAE=;
        b=CPqUZeounEV6GZdClDoQOxYCKV+MxoBOghOdCEQB+PXk07nMF2SVt/YoAUphvZAX8i
         FtVZeC8UEQbZzPAOS2JWIThFnP87/86boTB8OC5kmcsmU8yM4DT3SKFHgZ2vd/xWKHA0
         pv9f1F6RHDmbt4rbHxcfstcipzDhDmlI7HkDH2OMrAiv0gnB0hWcf9b64ALYNp4wp5TX
         3eAYfTdmnuoJWarzEzbBVrdYnOZqDSsOSnSBDUKy8Md2+PpZwhmj2TGS6vuXzafB7nqr
         xh35/8PcVrb+YC6IHP1inJynCcQMkHTiAwONvXfgXpPCce6M9SYejsugpaBrzQraAvAX
         V3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=bI751YOuP98wHh1q4rHO/ASQoCAvLeM/hP1e2c0DqAE=;
        b=Sfnf2fJuzf/96115Ec+BL33jqqEwTY2FDufMWqLgvNeTQrK4yx1FO9aDzPjILqrVu+
         F42cfnQl4odZ4lwjxSkK1cp4JyxKYyxyKUoTTDXyOimcqCOy61hiYSf3+uA9n2bwTFlj
         95l2dRrNm3X0e58COyDU3eQtqlgAkbgSUP6CIZHwTSqsTHkzOgxBAO4WmS69oc2qSWmd
         ZIssZefLUvHwo0rq0oTvXbqeodLKsX7aNDjIpd5+q7pUR3Bj2oTJzybxPk3Z0DV8KNcI
         yQr8SIO6m8ANkN8BL5SPXjpIhaShilXHZEjmPn7AwDZUisMu9FS7zaWH7I34PUEBhNC3
         PctQ==
X-Gm-Message-State: AJIora9WCHv3f5DUtaSZA3qaIhnxDud792b6icdndnBIM60d1IvwIAAs
        OIYU7mlmWKjINVouFz4KFbQV0AZSYSRjpFuYFzA=
X-Google-Smtp-Source: AGRyM1uuLG/AC0iYRXmYuqMF3fH0xRJLorT8kFvlrMtWikut1nTKsdpQS0DzrjJ82xT/oPoAZkS7hC3nhka9J/aj1Z8=
X-Received: by 2002:a05:6512:318a:b0:47f:bdb5:a4e8 with SMTP id
 i10-20020a056512318a00b0047fbdb5a4e8mr2802627lfe.539.1656171570173; Sat, 25
 Jun 2022 08:39:30 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsaliceragnvar@gmail.com
Received: by 2002:a05:6512:169e:0:0:0:0 with HTTP; Sat, 25 Jun 2022 08:39:29
 -0700 (PDT)
From:   Dina Mckenna <dinamckenna1894@gmail.com>
Date:   Sat, 25 Jun 2022 15:39:29 +0000
X-Google-Sender-Auth: EdRctZwakLpEb4BliBLXXfZ25vU
Message-ID: <CAGHGhXBWXCT2WP2QieW_gAn2GapMR84iXMJ0+EwofEENkAav4g@mail.gmail.com>
Subject: Please need your urgent assistance,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12c listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8074]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaliceragnvar[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear.,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina. mckenna howley, a widow. I am
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
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars
).  Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for..

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina. Mckenna Howley.
