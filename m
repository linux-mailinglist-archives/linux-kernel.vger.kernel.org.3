Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D54B4D04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349502AbiBNKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:53:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348585AbiBNKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:53:50 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364157B578
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:18:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk11so15959914ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=szaTyk4N3ZGBl+eDqnGM2/1UfoGyA83I4bUagC+y4MQ=;
        b=K9zYjJGILqKsjU2M3Ix/x/2HfHVQY0S/MiLfoQYxHChxZZMP8FTTlKWQLJ9zLpqt+g
         +/dJV0N4H6o5TyEAOnR18YXaSIBxrktOBnHQuwCAfXybeXYJ8J3a0QstjuvHjmyG4ABo
         R4ssVk0QM1zqA4ysLbU63uj0WJ39+kmSHk/TtFUbOdfETlx/zPKcViC+TDjAKosnsm6q
         psAqLWW7Pbyoo+Iz9fQI8diwiCory7dp+/SJsyKYosL+639X4Ol72YvABbp7y9faBy3h
         CTnb+e5cHa8vE4y6KpQkSBJZA8O3eiogwc7lVsyE0YHQsc+8kltyrE7Mte0lJboZYf4w
         RL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=szaTyk4N3ZGBl+eDqnGM2/1UfoGyA83I4bUagC+y4MQ=;
        b=0A9ZQn5lfnf9r15qrTjr5PsOxG3BNSu7BR8c3dVRcp86SjjvHV3sIwfUJjnpgtFIgq
         XqMfzcIsyrPECgpVmzNX0YVTBrE9gZWV0WqHllgN1N5WDbpwT6CFGMDb+dZYBq9qNoXM
         DCs8IhvH+KWiAy0kiCkD70K1FGxZImHJZizl+lky+cNH7v8nJMCx6kKKZxS3JPgDtT7K
         OinNtUncQPvaDTCEgA+j5RgeOzO+fDRqrZekh5LvMiP4MbgXB3JKfEdvpwYm5s51yoFt
         zgb2erNcvJDLxr7K+wHa7uzmshQnGJ8vtYVk/hbPnGv3YQ983RcJArWH1aDYqde7U0bw
         IyHg==
X-Gm-Message-State: AOAM532BB0QQx2gb6xHKvTBkuWwifCHVmULCzOwDZBS614ifY4DTNg9J
        GfKc1DxKEqn1NNZNPSojLe9UkqpgOOLZWDaODFQ=
X-Google-Smtp-Source: ABdhPJylxe1azdKRs8syTDOdmJgRx77dkRc0+P5NRGI8WVs9BxbJk6hFL1ST31R8EHpfUjwN06WTOo4OxycFRqw0aow=
X-Received: by 2002:a17:906:794c:: with SMTP id l12mr2534443ejo.304.1644833909793;
 Mon, 14 Feb 2022 02:18:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:2708:0:0:0:0 with HTTP; Mon, 14 Feb 2022 02:18:29
 -0800 (PST)
Reply-To: ew206500@gmail.com
From:   Edward Wilson <laurencekpoti@gmail.com>
Date:   Mon, 14 Feb 2022 02:18:29 -0800
Message-ID: <CAFE8Qnss4Of0_dS7kbWx26p6EExA1cbeRxhw_dDSvs7uC7F_=w@mail.gmail.com>
Subject: =?UTF-8?B?R3LDvMOfZSE=?=
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
        *      [2a00:1450:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ew206500[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [laurencekpoti[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

Gr=C3=BC=C3=9Fe!

Ich habe etwas, das ich mit dir teilen m=C3=B6chte. Bei Interesse bitte Ant=
wort.

Vielen Dank!!

Edward Wilson
