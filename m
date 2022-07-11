Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74845570890
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiGKQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGKQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:53:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3652AE1E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:53:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 70so5272452pfx.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9fS4GuB/o/7tK1gz6r3u6pQBSQYPt6xFQaJkkm7ODCg=;
        b=L39vvqqx0/Gr+A1p8R6ue+DEMAUSln+Wo275L04X3efhDoLhsEwvUXs3VGKJDGOuzo
         xqsPFuHaH5IcFaYlDPP2KjNWNKIsb1qthUJeh3DEYTV/6w8R7ZIVCn9+7nv26rGuou7/
         4nq848cXkbfZlfeBLG/fHUSj9h6wmBuI0SaJedOAuWAlqadgwaWBI7EQicYR0ChipXGi
         WrQkeAjjT9ahxADd6kfCCUDdU63ReeRdO2w/grEX6pelqTLXTXwLcZcRDIRqL1Uw+7NV
         Qg3tkVuaKqnTHq65ulzMTrd9GIsxKueyGK/CVOHIO5rf5iToF3eQxsYUU3DLyM/6FReB
         c/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=9fS4GuB/o/7tK1gz6r3u6pQBSQYPt6xFQaJkkm7ODCg=;
        b=Y9JD3FMBgaawk9gVZuBfEWUr5Nhm+L+krobWnjld58vBFxpl5LYdJe7vRu2dkiLy/r
         rbaW7g5THF4zeDz2qnsXjJNqr4T+pB9r9UjkBBX2D4SkyJdZ6+I9KUERSsw0CSD47h96
         WZ8dhpJnwYkvCqcRfE6Z7yX4tgzk76rIr+PamniNnp4PAB3FrGc5UCX2HLGMHU8aXxZV
         +auZW5gZY9vucqL//hqrOjjaRZRBIieZRqaXOyNXv7e5Xuv9YuFK+xZfusnJq3oXE3gB
         1BoVzAefB3gc6k3sBAnmObdYLfuocmwnlzl5q5v11mhCnzSuU/Xzemae1DcneqLQaSTa
         M36g==
X-Gm-Message-State: AJIora8Z+9YVDff11xlbbORJj9Ogs6ABGwNEtbbLg5XOjLIqxF7+DcSe
        vNuoIimHj4mGlVLRLA99srq7PYApJ3bMnTwhbBQ=
X-Google-Smtp-Source: AGRyM1tLkWhQBRYlslgOJbFlmSZzcNTigxathSS+8Kvf2YYHamuMSIjkK/ajtTPdnGxTG91OdKPh9VyE5Tter7rdJCI=
X-Received: by 2002:a65:5845:0:b0:411:9797:cb21 with SMTP id
 s5-20020a655845000000b004119797cb21mr15803600pgr.503.1657558433067; Mon, 11
 Jul 2022 09:53:53 -0700 (PDT)
MIME-Version: 1.0
Sender: christyora7@gmail.com
Received: by 2002:a05:6a11:5625:b0:2b8:95e2:4904 with HTTP; Mon, 11 Jul 2022
 09:53:52 -0700 (PDT)
From:   "John N. Hendrick" <barr.johnhendrick@gmail.com>
Date:   Mon, 11 Jul 2022 04:53:52 -1200
X-Google-Sender-Auth: gEd59hcbYElbtjtP7e3VXU0u85U
Message-ID: <CA+riN51RA1TtyUeEMYWut2mcKm3cu9U_jNQ-QCRiwZ5SFwVqdg@mail.gmail.com>
Subject: Urgent Reply.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4586]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [christyora7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [christyora7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,

I'm john N. Hendrick

i have a business proposal for you

thanks for your time and attention,

From

John,
