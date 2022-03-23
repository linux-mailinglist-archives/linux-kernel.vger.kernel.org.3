Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25354E5175
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiCWLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbiCWLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:43:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746A793AF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:41:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g20so1484910edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=Tw4Imm4p9kucX1EsrOwipg0GcR3mAB7dsZIHemL6FlNYjkqkNEM786BBJvwdO6JAR4
         fKHSxGlUZVo8N98wGNYeKcbWMn7gxdD5dlN00xhiOlS78+VNDFMlfSFn8mBIk7cqkvI3
         gCVI9cjF192L2pYVgZeI8m1ed6ycSPJSpudG4gwwHsHG/ea7xSCqfTL17CSXjdsg2Ve7
         dVYCf0/eHr5fzOpdX8rCg2CoWRpo4CN3x3/xq881XgPffYYASy/vKjuoAkkyagKICzFp
         Is3TJQY9jONE242Ve4PIq3BAJyWr8wfD4q1Z7gWCQk8avixwTIcCEDcoerZYwICccxCX
         22Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HjeihxJTxzkbTZ2MqJZoma1iPJVLD30cD4qsp7lAs6w=;
        b=Vu6xm9PWEnPMU2suQ+cjgWWyywAe5Bg0X6icu6vMIVvw/nUsZqcz35DdAHQYpXwM/m
         hhp7HKcxwZxcgMgIaWalTmgdYnnWH8WSORA9tFyZDB7QAJM7pnEGDlmWQs0VmK7gO0Ka
         ISOMs4oF5cqROpEx1Y40KJkoxAlNTHvXr1ZroJXGYav6R0wZWLTNHlNk0NbsUFxblhJl
         S2Kw7iAYYHLRmUBWSnEUpe2qf936qgUcByIIeN12UGCWUIuRnBuiX5WtWZeRvPZF3F8/
         aZX3nHwcRJ9MEf8Thnat/MdpPipEi2y9swb0T3yc3/WBma8HnwLj7jd/u8vZcqu6t9p8
         Da+w==
X-Gm-Message-State: AOAM532WxxCECo+NQ/KEc74I7k4RlAhtGvjp/2VSc2Fz3tyNEl8fNGkA
        1XXOECZT/Ixol20kga4uDaADdDdMFMGudrmfdOs=
X-Google-Smtp-Source: ABdhPJycynGTHAqQeQFS1KifpE4r87504lkmzF5eANpXf4qJJtlpfVygzobdHWHLLErV97cBpAoy0/IEjXk3feL3PiI=
X-Received: by 2002:a05:6402:909:b0:416:6f3c:5c1d with SMTP id
 g9-20020a056402090900b004166f3c5c1dmr34517386edz.108.1648035697358; Wed, 23
 Mar 2022 04:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:340f:0:0:0:0:0 with HTTP; Wed, 23 Mar 2022 04:41:35
 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan09@gmail.com>
Date:   Wed, 23 Mar 2022 11:41:35 +0000
Message-ID: <CAMz+VjTmWu+boWkckOnJL4emFrBtBiiM2Hg6yQWynicg5BBpbw@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:529 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan09[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Schatz, bitte hoffe du hast meine Nachricht bekommen
Ich brauche dringend eine Antwort
Danke
Michelle
