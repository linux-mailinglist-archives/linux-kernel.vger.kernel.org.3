Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C365AB203
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiIBNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiIBNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:48:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4843303
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:23:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g14so1388861qto.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=IlwaBfEqgssY+dYmDhjSg7WY0RXRSc/HZEDYE/URW0g=;
        b=Hjq9E7oKRA2wLwrDd1NNRADh+G/nTJ5zeqw50qzxvscwqQ6XVo+mXxLpjkiXWNfmC9
         jUVwRkygrYTdFJH8kOqbXUgfU7LzRAIUiTD2LY1MAT5VGepSY7TPdBO39eQ9yF6cV2dM
         kBYb1JX+0iCHq9SV8czHn/Wx/KzqUeDO7+KrpBais3THGL0ujsnWDAx52Wi/ZBpJoZ5X
         ILeQYJFa+m3JyyOogM/zVYtI3U8iIiG5gnci5sWFVpKPkg8LImxa/e2NA5+Ewe2KT5S6
         zMN8FMWgqXXeFTy1xxz/tKeR8WxwrbFrYlv8ESTLr9Je771is5SfNu/IBUODpbHr8LsM
         I+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IlwaBfEqgssY+dYmDhjSg7WY0RXRSc/HZEDYE/URW0g=;
        b=WqhuCNCh0ZLwIBqbUU5csTZgwuPOPBgiwVChC1AVdGOXTcFrYi9Nw0BFcgsXXT6A2E
         BLWJAVdCZq2YJ+9feGsjvsNa52z5OyJVWXA69y9mYKM1YdMH/C7iJ0UMxkXV+EDb8O78
         2BGDQQ4tqmdCsxFihFw2LP0JOwZstgnRaR+0XOekryhwEQyauPt3m5dTlmNnu6G5Ty/o
         xRe0bbY28rL8/psgqgbpiQiUyHLN2lpID/or/Pp2ZWVOg6kNTODBrQitYD/zpD31AV17
         mhwFUFDoCtjtc8Xgz0R7mU071FqI60Lmn+VFUPThQmIVdKrqeYRsI6LdmhaSy+7lauBG
         8Vnw==
X-Gm-Message-State: ACgBeo2Kq6GT0JD0MW84gp8cDeEFcDZO1KDDjn3QdIAEHOxEnp+p8wtc
        vNR8KOHAgQeb/dpH4uZPeHAnkv1WIpJA01VRavs=
X-Google-Smtp-Source: AA6agR6zBzGp9VBA+VAbIcfeCv2l+I6VFzuSo+jxtEvRmMlzxvDlifZpHz1DUU2Dv57Tf7exIHVG+0bFPWCiY23NeWc=
X-Received: by 2002:a05:622a:607:b0:343:4f06:fdd4 with SMTP id
 z7-20020a05622a060700b003434f06fdd4mr27522439qta.321.1662124942135; Fri, 02
 Sep 2022 06:22:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:620a:4691:0:0:0:0 with HTTP; Fri, 2 Sep 2022 06:22:21
 -0700 (PDT)
Reply-To: kreditschufadeutsch0@gmail.com
From:   Georg Johannes Proksch <abubakarharkrb@gmail.com>
Date:   Fri, 2 Sep 2022 06:22:21 -0700
Message-ID: <CA+44wy5n6Ew4wvhwUqjXUKnjYag_Hqf2ds6kCOTfdfxzmvb1mA@mail.gmail.com>
Subject: Darlehensangebot
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:843 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abubakarharkrb[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kreditschufadeutsch0[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
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
Ben=C3=B6tigen Sie finanzielle Unterst=C3=BCtzung oder ein Darlehen, um Ihr=
e
Rechnungen und Schulden? Wir bieten alle Arten von Darlehen an,
kontaktieren Sie uns noch heute =C3=BCber E-Mail:
kreditschufadeutsch0@gmail.com

Name:
Kreditbetrag:
Kreditlaufzeit:
Land:
Telefonnummer:

Gr=C3=BC=C3=9Fe
Herr Georg Johaness Proksch
