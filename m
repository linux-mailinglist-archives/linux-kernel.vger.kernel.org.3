Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2C5476C1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiFKROl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFKROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:14:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454B021E16
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 10:14:33 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-313a8a8b95aso17638517b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=faaMR93Mu4KJaiGkqy+/FkPgfqW11s1eJ+uAGLC8WaM=;
        b=oGX3VFXBCYsYguASOM6LH1Z2+Lzz64tqM5zd7Yl/ecsIhk9igbQ2OQffEpJp30BbOq
         zMhPda7QL33+YyEYzjCKjZ4k733N+XBJsDwe/qNGaiO48Ldn6JMlVz0HekI/lf3Ywj0B
         iEdqS7cj/ICz9LLrYomYoTvXZMT9Zeq+DKZeoxGCajNhl59DSN7qkU1aUtTm5Fm9HjeL
         zgjLjjqO2AUwOy2pmb6iHlv3l12B/oStruFRwcLXRqYANNdnR80+M20T60bwoWx1TFaJ
         kMj8chVlkBw5jANAHOSANzIZQHGoFjNPCMQQjjHIkLlTXqGlZ/4LrstBPb3Ws24GKsmY
         Zcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=faaMR93Mu4KJaiGkqy+/FkPgfqW11s1eJ+uAGLC8WaM=;
        b=N1Yd60pRVtW1+6T1r71OLIVpS5rBO996aPRRSly01toAWjhf2GKmWmwuFtG0yb5r9C
         cNlcHLauTXWOCSr3etuUvqs+0+9IFFy6kkgGDKlHyBAanOYJV7g77wN6Pcx3ywDNPkHW
         ld3uDIqNbkaElkGreb/vCUHvbmtkoVIHvYP2eIaUeTOQglueoUPO+tCRPGdYjL0oH35c
         i9hi28Sr9oX6J/gTz9pFAHmkYprycwIALcYRMmYiNZTapakE1MrKn1RpVfrZIJPNTJYJ
         wTIyiTNYN6w4lAfHvYwsWfXXDbxH6ChLAcxTe/xFRS9ksMguZuOLWlnQ3w2qWS6FYwVE
         j5nQ==
X-Gm-Message-State: AOAM530rpVerCBhU9HjFFVtJWehLqJwAn+TdFIsCXrnsnO034g0TxbsE
        baEJhVPQeaNIvbr+bvm9ncQ+IfSTHPI7isuB3rg=
X-Google-Smtp-Source: ABdhPJzgqdPzsfLYKlKjdfEXCHsUWgYHueiwYL1LUa41RZAX1c5RgeM7FONxSOMfVmLRcWy7i1pJ9KsHVBc3HKgn+5E=
X-Received: by 2002:a81:7243:0:b0:313:acf0:7f0c with SMTP id
 n64-20020a817243000000b00313acf07f0cmr12891521ywc.8.1654967672537; Sat, 11
 Jun 2022 10:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:1203:b0:2d5:43c5:2b6b with HTTP; Sat, 11 Jun 2022
 10:14:32 -0700 (PDT)
Reply-To: p.hanigin1@yahoo.com
From:   Pavel Hanigin <janviervingt1@gmail.com>
Date:   Sat, 11 Jun 2022 19:14:32 +0200
Message-ID: <CAMZZeqGmkNZNx-J8wTBrKw_1G1xVvtox7SQW+j-4N-Zq4UeUfg@mail.gmail.com>
Subject: Urgent Attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [janviervingt1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [janviervingt1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [p.hanigin1[at]yahoo.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your kind attention is needed.

My name is Pavel Hanigin.  I'm a Russian citizen , but now in a hideout.

I managed to escape due to the fight between my country's army against
the  innocent civilians of Ukraine.

Why I am sending this message to you  is for you to assist me in
receiving the sum of $7.6.million dollars, which i have here with me.

Confirm your position to cooperate with me.

Best regards
Pavel Hanigin
