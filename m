Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED957EC47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiGWGVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWGV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 02:21:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88E1054C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 23:21:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a10so7605143ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=aGoDJrYv/23a7xlVt3keHbO9Kwx3iNZ53WhEz8TdkfQ=;
        b=WUyGaf/xC7V9q35DuikG4Kdt/JjnMLBbO+0gvLZYS9qvth4ajRny1t4vu0t4sKPdhw
         H0letsAkPqVCSo9p82iEnUlRFvnlzh+XmclV/tg8mwV7pWOrk4/yOc1fXgUWAt0F5pkq
         VOsV1wpEWJFf8EeIpmFWiDHJiw8n4Va/bvbqFm7vKfi995VWDGm+MjgCeIh0Czt/qx98
         PxgJueZFjm0K0xCOkDx8czeyFXGQDMLxQ28NIvcASap4T6Wer2zAkx+kkG/6FDYbxXKM
         zIyrCkHYlgGXmAWEAl/4PEOAJquRIeCb8g/oQGfv88C0ZQSQkRNZi5HP6mw/4Z9ad9Nb
         dT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=aGoDJrYv/23a7xlVt3keHbO9Kwx3iNZ53WhEz8TdkfQ=;
        b=bJNGHFOqJXHKYMyaf+xxwV3hLsSM4SDIB159ZDx4KqIbClL1pNV91KrMhoZ+o8yJSM
         W9UHC4sZbeFK7x4exflMvEqgtlCl4egvbt5DeYlXU3LpODJVQhHufdVPv3U6/ccxLGQA
         674A1qZmyV/baY3pJ8U2wmQ065jno7u7PTG9ov8g5hz6jS1qX+uqZF68d1mAkFNfZuUI
         OUINVTyerKTF80mB6ZaX+WAJPyE9hDSM2dnj0rD8gDOgumLWtNJzubfMzkDk+i08w2Kb
         cUwcKjMPMpFgEbGRss0WeslpSzXoeWNFo9H3SWcEoVDlJwUMwU0b5jPQ2ZlLBBe4qkzm
         stug==
X-Gm-Message-State: AJIora9NrtM59sIV9rJDlhs7KkWO/lC1F3XJLOnomfLziHMvvO2hz4H8
        ryTLPNkkeaQ+nydA9M3ripBs/Sq3WztNVqN+Ojc=
X-Google-Smtp-Source: AGRyM1voAqdIMIkVXY7KLAF4FWry6fKaeV5BXUCWiMjZ9S4Xrs3LwoWP/Eh7UsQBZEAiVHZJiyTW5WAPjsY9AySxtXA=
X-Received: by 2002:a2e:7d14:0:b0:25d:d787:ab9b with SMTP id
 y20-20020a2e7d14000000b0025dd787ab9bmr1120372ljc.164.1658557284881; Fri, 22
 Jul 2022 23:21:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6bfa:0:b0:1d7:b50d:ebdf with HTTP; Fri, 22 Jul 2022
 23:21:23 -0700 (PDT)
Reply-To: sophiaernest566@gmail.com
From:   Sophia Ernest <simondornoo690@gmail.com>
Date:   Fri, 22 Jul 2022 22:21:23 -0800
Message-ID: <CAOSTSM4JSgPro8aouVzfr8w86oPn6gwQ64Ows4XTSJ-bZKTJaA@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:229 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5176]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [simondornoo690[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [simondornoo690[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sophiaernest566[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
Sophia
