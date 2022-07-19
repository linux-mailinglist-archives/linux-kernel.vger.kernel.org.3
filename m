Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE45657A82E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiGSU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiGSU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:26:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DE7474CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:26:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u13so26835815lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=W/0pyW4vGZUBJNu0LDTVCRn88+Qyo3BDzqzfQ8YIAo5WlDXNNMWgRWOEsulijqHl8c
         F3/nKLCQ2gWmMRWdLEc3YrE74wn5AzsTtsRgIIq9H53Jl3KwYCCpA/iKSV49HAxljuWp
         rc0x6bBPlB4wSZ3X9Th+RcLSsA2uoMq3pLHTeMiJl8vAQWT/kzrajYJm+GdjBmJrQiPn
         YAcHqvTAoGQDc1krkfY7h1xVCfI/77PDgBqlLthU1xLqVaK5zCzLraFx+kE92X/tVZZ0
         JoKI3AhufXO6Oz+riEfBfgk9QXMCgGz9mh1A0R5sChcL0TaLNIsz3W+E2yk2ttJqI06a
         oViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=CtNn6vPspOoewaN3AjyAJrhrmAGTVUdNaa64I7oYCzu1IHeQc1BGmbIeTAUKB/DK4d
         G/bwUFKPiIrNY316i5JElcn1Scl3VE1EV7vS8L0/Fyodqc/GVBK3gHKqs1AR5qRyF6Ia
         R4qVJiZwj+gGcmohgn7GdmiV+Qm+F8zEJbpS6QiQSFrFpiovLNNay/MYxAKbqmBsxTXv
         dX8ssdbJ7auNVbH4kCv1aYesTHVL3wXwTVe8oLMBmxca8jtFx9Ox+HeK+6XWW/XlY75F
         7TXGc/nUxLoAfmV8xptBTpM5V0vPV/9E2xAZXWG1PterXVi5Slerl81vLqMXGu8f0BrX
         Ymzg==
X-Gm-Message-State: AJIora/YwyxHQZVm+IuIKEMDqP4lma05MvMpTKINmSVweG8L2Ke8rN6+
        CyWey1k19IaxKwZqE3ezVbYq8DS+38wVBqbbS6Q=
X-Google-Smtp-Source: AGRyM1vfwQA7YtBvbZ/b0S3D/draqSG9aDi64edANVdZvy5z7OVqQSAcXHdd76rscxYSlXvndRQHWmD3+hYBwcoo8uI=
X-Received: by 2002:a05:6512:1152:b0:489:fda1:1507 with SMTP id
 m18-20020a056512115200b00489fda11507mr18076544lfg.206.1658262412923; Tue, 19
 Jul 2022 13:26:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:2f49:b0:1f8:2994:4bab with HTTP; Tue, 19 Jul 2022
 13:26:52 -0700 (PDT)
Reply-To: mailfunds48@gmail.com
From:   Tom Christ <yahayabuhari92@gmail.com>
Date:   Tue, 19 Jul 2022 21:26:52 +0100
Message-ID: <CADbC8Auski5VreZF74DxwqFFZV2veAeu2NNrRhRkPc6eDfr2yw@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mailfunds48[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yahayabuhari92[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yahayabuhari92[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
