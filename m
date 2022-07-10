Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6A56CC79
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGJCoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJCob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:44:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06D1C12B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 19:44:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m14so1830051plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Td9R7D+qC/sMrhxG2LUChiBMYtVspYLdwWn5UPLa0rQ=;
        b=ID7O6bC5bpkfC97xVK1WmL4cK0rmIQwCVkBnnWXEw+FeZydHF/A0lUaxWiRS1ul2O6
         RqwXHNTMS5uZQHrQKh+HfwXT4o/Fyvs4VtETTTD1SFqtA6VXmvi7gDsuwYeNXsExt2Md
         NThMplvCVYO/eVSawc1VhPTK/kC28i4CX7pkUm58QKIAiEDUcGVi+yAUn5ZVUqR5cB8e
         AVureMr6Ti60j0glaY0aw8m4yMikhRRc6ft/Gc6EML1QCr5c9mizWqLz5ukxlO+vGsZO
         MlvH7lX/Ih9jrcSesucLClCq3P5fIqZyhTahcdM9c/V1e1NTMFz9et7sumFSyOrTxkOv
         SdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Td9R7D+qC/sMrhxG2LUChiBMYtVspYLdwWn5UPLa0rQ=;
        b=TdxBnnfLID0Eh2Qo/aGb7XEVRJ2rl73sIsWgNAglBUPJWruiX3xetIm5sTvc8FgAkV
         gDDC5RtklhRKbPVCm+h7Bp7W01Lb1kL+oJsxP9/e7c7OJ9lrO/CnB1vnCuH7sybYOmsM
         9NtJaHLu/qO6nx44VNEjfcnkHSWMUWC92hna8lXt2CBwp4XgBIrm4LWrvH6rI0x+/G15
         wS9Vf8KimmUeele7h72MZnHlS+6KyEHmOkYJAXmRzaY5S8rFP6gsd1JFBgExxEjTzebO
         0h+A95VKmn0TWjBpvAgQWf1HAqYV5HiGonkDeA6gxPwxl7FELNFJqTirtot3nrHcz58E
         jU2g==
X-Gm-Message-State: AJIora/vArixt8R1bACZGftzWNHvYP/DswMAcpvrbhKj7WHuwt9jqyAT
        w0Ofwr8PuzF+xAIi1UtyJlPYZHQiQK8dLopU9uI=
X-Google-Smtp-Source: AGRyM1vlCNVeriY72xOZyYmZQtWUl4CtMbaHsSTlkTxXRorYL5PSin5sJ7fk2W4waFuGuoeAxJCjpn6ITWT7Q2HlR6o=
X-Received: by 2002:a17:902:d509:b0:16c:85c:8f31 with SMTP id
 b9-20020a170902d50900b0016c085c8f31mr11404457plg.131.1657421069396; Sat, 09
 Jul 2022 19:44:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a4c6:b0:2b8:6c3c:5636 with HTTP; Sat, 9 Jul 2022
 19:44:28 -0700 (PDT)
Reply-To: rolloba75765@gmail.com
From:   Roland LOBA <lll160vin@gmail.com>
Date:   Sat, 9 Jul 2022 19:44:28 -0700
Message-ID: <CAO=sFaq0urW-1XkkgiY8cgeY1kVCMwO+xW2PuwTmApUgH5mc9A@mail.gmail.com>
Subject: NICE TO MEET YOU
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lll160vin[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolloba75765[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It=E2=80=99s nice to meet you,

I hope this Message finds you well.

My name is Mr. Roland LOBA. I need your cooperation for an investment
partnership. I will provide the FUND for the investment.

Please confirm the receipt of this Message so that I will give you more
Details of my Investment plans.

I look forward to hearing from you soon.

Thank you in advance,
Mr. Roland LOBA
