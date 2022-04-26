Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090A50FEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350807AbiDZNVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350836AbiDZNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:20:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F6EE1CD5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:17:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id k27so7118940edk.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=6+CtorLBJcBw4FcYALJrOP7eOH4S6+CQQohbvLBDoho=;
        b=Kv/kGnJI+LuGvE3p+VXDR+AmVcS29lMEQRMbR83w5yuX72RUfZUQfNjlHoPJyPUfPT
         8tri4gDOfFBwCXzjKDoEUxGZuxjNxqeAz8Up0j4TMJRt1eGbDPTLa+VB7mXh3SQW1yKh
         GrZUFxOP+oxGCSBP+Efy7AMPxCG9kutFVv4TQuLGbhMWC/uFsVzuCRWEVtaq73Itf3bX
         NGXsqU6HqMLACF1O8xLDK2E6HXGTdFhsaVJAsjzBN/svoX+IFt/nnqFRKZFkuOnT9R4b
         t7zPzkIvVKspVFB82IwNGoOYQ+Ad1uinmnawJZ1eqc4Bx9bIO/aKzurz1WI3DKks16Gx
         humg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=6+CtorLBJcBw4FcYALJrOP7eOH4S6+CQQohbvLBDoho=;
        b=Tbv+PlcGS5YYUZI1xCl6+b4bhT1KiPGFdG0/smKBsJzb3mkEzfTQAsCk4euBez4EYV
         +AjqOl8hJ3N2iVcqQ6WpWtSnjhP9nQNc1l2cwkofHDahTkzgrx6EJHOaXFpb2qev/wYW
         f4xrpLg/kJRFf2WbOjdf8yrJ4Dcp4Jmm3U5nujk2U2AmD8oopRSCTxy0YI6ulvDpPkmR
         qnpWjsnU9aTwXZu/i/yQOx7T/bpwPdlG06en6mXSaZTgEBBafLQl/kuZlFxePJSaR3/4
         s11ONZOY6aQKcbSiUT477UQb9yrwBjCS60yuzg0hjPYWGVMk75SwOCUQmyctnY4qa9Ov
         2pfQ==
X-Gm-Message-State: AOAM531DxoM2zGd/R9jGsroSBvL2+MwQmXNGOx81j+WWwSXfSDNmoylh
        Cv4ktQXo/jX/gY826CNcdRFtGqKTTwhlooq4FwQ=
X-Google-Smtp-Source: ABdhPJwohow9WYkrnlI1/sfWITINs49EqJoS1E0MC9z7HMJPQgr+rTLYIklUzj8JZS/ae04IrG9J+3bVN4/klnMZcsQ=
X-Received: by 2002:a05:6402:1813:b0:425:adb9:4abd with SMTP id
 g19-20020a056402181300b00425adb94abdmr24935375edy.278.1650979067622; Tue, 26
 Apr 2022 06:17:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:7b99:b0:6f3:6a35:ee4f with HTTP; Tue, 26 Apr 2022
 06:17:46 -0700 (PDT)
Reply-To: adriannurse12@yahoo.com
From:   "Barr.Adrian Nurse" <offce2022@gmail.com>
Date:   Tue, 26 Apr 2022 13:17:46 +0000
Message-ID: <CAEu=3H+LWJXV+-ztgurtb0v5nbcH633+Ue-A3NJdrc-t0WSANw@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5007]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [offce2022[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [adriannurse12[at]yahoo.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [offce2022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Dear Friend,

How are you doing and how is family? i mail to know if we can make a
transact together on a mutual business that we both can benefit in it?

Please do kindly revert back to me for more and better communication regard

I'll wait to read from you upon receipt of this message

Thanks

adriannurse12@yahoo.com

Barr.Adrian Nurse
