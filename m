Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19164507C78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiDSWYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDSWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:24:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA222B3B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:21:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so22257639ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5Dq6xFmjoDhCAFWh7f6P8JZuUY07YxNxqLZEbbotfUs=;
        b=bnG8at8bVk0EKo/HPydqvv8x39hOuUXMWDPQ2OHMG46B6Cfytcc6PqhAvemrDn0kJ+
         pzDX1JGQxEpU3XFZhBG9Cs+S2Fx2OPOVIS+NuLiWXqfpoHrlQgwoz58+v/saT6hahPH8
         DsnwdlnRYfTbjh7qKevjs5SO1zSrZ2Ty42mFJZMaBCJEimfjXcYRU9k45rl5WyYLBWAq
         qGMLEfdoMieJvVG27TukwdQw+1VXrmW/HJdhnOrIFQeosbn12d5Kgj8/dw5fTdQGB4ho
         DxEFhP+pyHQOamhCnM2WAFHQvtUiZnd5/XPGFRlHyDrZ+inbuYdmhWrFPE46noBvCfw7
         AD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5Dq6xFmjoDhCAFWh7f6P8JZuUY07YxNxqLZEbbotfUs=;
        b=PYd1qlEvbKTbqR4NmYOnP3mJ3mZaJYo741hJTZ0ae0B5R66f1B308hlxZIoCIbt+x1
         JE+OQ45QNC9Z1PZeR1teZPZBbzqMXzujFhVlzoqyDtEiyIoHTuPL+Ur0OKa44qq7lkXA
         y0XhX/kt02fQCUdmIND1rdxFdNBdXeFNUQtPBeU5fkCCKD9o7hRhd52Djjh95qYrJeFs
         07iec8D07IF/Vi1hBXm8yIYvpHMg9UcXROphD303E8venMNqTthcGp+4Iqjde1zuL91m
         IIrCIpcITjrqbttkqFiwn8UmVY87Uv1IsUkwZxIYDOxtyMtNLFuShnkw3A2Iq16VpcSG
         EODg==
X-Gm-Message-State: AOAM533a2Vi+v8SbuZ2pP7mDUK7aO0KAaZIgAeKXrU4KVwalve3QFUaO
        1lxRqkc+qrmzXR42rYH25fdX5MG5dZP5jOMaVFA=
X-Google-Smtp-Source: ABdhPJyjLWuZEWeve9+SN5nfG5uq7Udx/AYNAISBoHA2GtBQgSQSQSdXnokMAe7RemmnInm39JATTcVrnVGbmS7+mKQ=
X-Received: by 2002:a05:651c:19a4:b0:24d:c2bd:ca9d with SMTP id
 bx36-20020a05651c19a400b0024dc2bdca9dmr5391689ljb.465.1650406893423; Tue, 19
 Apr 2022 15:21:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:8081:0:0:0:0:0 with HTTP; Tue, 19 Apr 2022 15:21:32
 -0700 (PDT)
Reply-To: ritterhousesarah12022@gmail.com
From:   sarah <loversloveme239@gmail.com>
Date:   Tue, 19 Apr 2022 15:21:32 -0700
Message-ID: <CA+M9X+tU=1umnfrwoZA=CiOMGW_w3FJeTX3mJTH-1j_D_QoeoQ@mail.gmail.com>
Subject: HELLO DEAR,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3995]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ritterhousesarah12022[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [loversloveme239[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [loversloveme239[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to talk to you about something very important, please
reply very urgently, thank you
