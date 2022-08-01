Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A0586227
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiHABL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbiHABL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:11:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C61183D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:11:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so12221245wrh.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=C19LRDKnOIvo1bRCCKl5Q5f12sVQisQtvAoqZ7Kuq4xSwdcb9obWovzWCSclTrX1yV
         0fvNv+3wqqzM6cJ6PvxT3SJfIpobh2a0WHwRr24D4pZAJVyRBYM67MFrYB73GXSoMeSz
         juqiOpqhOVPJbkY1I2gSJZ68cFk5FJqdhtgfuPJMZxmNfGm3lVzGQ7G9LcEGPXTcFL8R
         H9qXoq3b3a5z6vtkz4XlnZU7/WCYrOvSXqTwcGUh07X0yU4cfRnxg72PXRFqsKpnmMG+
         dRcp4bdC+dLJkRvEusJhnB2ID2pieZHQFW+tlAcTsBjUjc57SVxlQXjfqoOq13QtFoMb
         Fgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=tNUGtBhIVE+5ZorqmXpYgz9lDy38G/PW+I7u+CoO68vb+8c5K7+JozC2bHGj6Oie4t
         gjsFKyTiWvDDMUsYUIWgi1t4pa0MyfdcufSfDm3Gu+KBusmzDWSMheKuiiBDxL55BxSZ
         YDcFHeWo/WFxAunwhkeihsFj4oz4XdGJiL8Kc9CsDEqU+SFEVla+3zfUJktAA+FzI1+P
         m+nBqkXAvw2mEYQ7W01WkCSLV2dAm+G4fFVa/gfyntdNBtvlXqEvRhQcc1GC+QYwiT7i
         IjIS1OsE745dIrJdCJs3rxTKRW9PKPm9UN4be+Ipr0T+MZcUd1ZpV+gsrKhIXiTO4XJf
         fKsA==
X-Gm-Message-State: ACgBeo2eQpvQsBOkf7jvpQIcvdS6QiWkX4M8hg89ktmbJ/cEEwpCC3sF
        7bvX6n86Nbx2sSVKDun7jITRDcvtaW2HIVcxpZ8=
X-Google-Smtp-Source: AA6agR4wZwjJ+/xHhMAEVCMLP+HRfi3FVtp71eRRr5JHOvcSN5yy6lvaiP832svjL/0soB5v998gBD0UNzGLx0fvDgk=
X-Received: by 2002:a5d:5d10:0:b0:21b:9ec1:f4ab with SMTP id
 ch16-20020a5d5d10000000b0021b9ec1f4abmr8727395wrb.558.1659316314525; Sun, 31
 Jul 2022 18:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6021:905:b0:1f2:7126:830c with HTTP; Sun, 31 Jul 2022
 18:11:53 -0700 (PDT)
Reply-To: usdepartmenttreasury63@gmail.com
From:   "U.S. DEPARTMENT TREASURY" <milleymilley325@gmail.com>
Date:   Mon, 1 Aug 2022 01:11:53 +0000
Message-ID: <CANf+Lms_xz-3yt_Vfp-hK+tqH3+YWpV55Enf5xhxTD-Jte4YnQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [milleymilley325[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [usdepartmenttreasury63[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [milleymilley325[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

You have an important message get back to me for more information.

Mr. Marcus Hamlin
Deputy U.S. Department of the Treasury
