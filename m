Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D751525F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379722AbiD2RjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiD2RjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:39:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF9BC07
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:35:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s27so11364034ljd.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=LFvrwou245TpTYriqjTNad0o4zj5Ew3VYU4QHzMDyfn7knjDwJM6PWdeYrEBQACdWT
         OryKA6S1W3enB018VvPCdQZWShbkr8zRCtyNnNOdSU1alowmmK/ngywcFA6SkqiSRauo
         AT0S3Iv3z7gEoFhL3bWBMcu1z9R9uAMwB2L+D2W7v9dZxPHUpZcoMgIbN/ocs58b0DQI
         Jy20Y2hgtNmVHHxLI7t065jIUZ0i7SrrGrPTSRqdu/e+C+CObYOUlkZdRGaMSO8dOOTh
         g52nGzgC2fzqHfNPMtI7T/Dp2zfwTxCTdWpgDMG6y6yPN7MpBHvWmgfmPqVSSkV26OCH
         3IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=BkkuNzG0NMgB8kAMr3GVOV4v0uHOFktnTldlxzxQEZh+IbjemloCc0aelMMGc0sXNO
         a3nf6irbOac2QkgsNmWF+rACYTUfPFPIN1dvhqwsy3f+fY7+I0MBQguMFMyNssP9pK+7
         liesHuw5IXtBID5zJnJ08RD3UYLPPtxBjBAliIILuvCs5aLx4X7uMaIdi8NufaIwtVcI
         +f8o5tTCaqW74BqAY5R9oj9gLk/b4BkPlD2ktKz07V3xYY9pR00WmZU51ux+XDEWv89T
         9/ulmOmt6qYSFjBtMJQskdRomAlVSw+ccljeKy3D2eoUp0CWtxYfq+I0mnbVwqOQ48eQ
         8JUg==
X-Gm-Message-State: AOAM532qGG9VmzWJzJ+mfPidTn0NP8+f12ctKj8A/3zxRYUFZdfJDU69
        NXbyLNF8QjwLaoa3fUPdXivbCLSvLwbX6csXzviRN5hR/o8=
X-Google-Smtp-Source: ABdhPJxuF9QVs8dYdQLeFTiJrIKVmBO+hnhPmqbLW6D+CwbG0fkkvRYxFMZy0JjDAee24XCt1FRuCOoDsyHIFyXH+B8=
X-Received: by 2002:a05:651c:b8c:b0:24f:139e:ddde with SMTP id
 bg12-20020a05651c0b8c00b0024f139edddemr199669ljb.62.1651253752295; Fri, 29
 Apr 2022 10:35:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c113:0:b0:1b9:b4ce:3858 with HTTP; Fri, 29 Apr 2022
 10:35:50 -0700 (PDT)
Reply-To: gb528796@gmail.com
From:   george brown <moordavis0003@gmail.com>
Date:   Fri, 29 Apr 2022 19:35:50 +0200
Message-ID: <CAH26tOHTjSON=j69_PQgNON=SOMtoXLf=bmo-mKMtkh5PKZ4Vg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.0 REPTO_419_FRAUD_GM Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moordavis0003[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [moordavis0003[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gb528796[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:gb528796@gmail.com

P=C5=99edem d=C4=9Bkuji,
pane George Brown,
