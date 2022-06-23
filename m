Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2B557FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiFWQWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiFWQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:22:26 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A664504F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:22:26 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id d5so107424yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=HWfdSuINNohtisnS2qVOe06xpDSp3T61e4mpFZzW/k8=;
        b=HOFArQ3z+psjRhswfHFbkJ777acIBYuvDQtUJzNJAfYngjn9qBZfxj/3ZTsHtrWvk6
         TqKk5mB0oo/luDPnxhxAXY/ptMqAXqploZcvts4ivkcngTcXOa/JZWs8FjiuLDyCtw5h
         iozTmNry4cqQBFmP/U2TdVf03GlopG4433CMGGtk9lBmSt2AkxwwViJh0Dlvd9CDJUKq
         TCF0Kx2VOe/VJDCGiKP9ljXRNhjaf32bkfSfgmiWZ44hUDO46xmoToI3KAJUyyCST2cx
         5ADze3xnp/sLbHzjwJfgNseVgb78meUe1vyyiHbFgJaijlYdMYC5eFWefpNrp0WI/L4F
         oALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=HWfdSuINNohtisnS2qVOe06xpDSp3T61e4mpFZzW/k8=;
        b=DRVHM2vk7ZnbeUVEX0AhLLDeHvNY303IXfvcIzZ2kMmzDnjymoaRCbtOewbQM0nrcj
         y0gHTgNemlMqAQx6XeUiYzCzofdVoaWmqjCFzJ8T7LcIp7ufLP8xcbVpI7yL6ATdBRP/
         y4GuqBRsEcP6hrvKSHictwhYZRwEafL9SUxUfGZn+fH3mAOoWPKBR//ZAceO8SwzGeBV
         YuRK9HhPnToh4bjp1aI7Ya+ny19do2xnrPZMdg7c48dk0s3dfYwtEgYwLyTAlq10eKuB
         H7cJCHNUvxjvBU1K5QAXz8L2HrsSBjgQjuITjYihTU/KPHdVpMnZnUTUMMw3tJceRaL2
         iung==
X-Gm-Message-State: AJIora+ypqOhTukgDac0qzDV9bkDy+YQSzvxuV2cNTglgAXteMULX61e
        hdSteKVjmEg6rR9dtwoZL4rg57lUqrbQO/8URoU=
X-Google-Smtp-Source: AGRyM1uoTDv8XCXfFkIu5FvBPYoTjCSyzN2oF2NFi7o4cKP8qZtDUDucYBGS6fCFpKiSlAKhfNQucgHCtczZcYBBnqs=
X-Received: by 2002:a05:6902:13c3:b0:663:ee28:428d with SMTP id
 y3-20020a05690213c300b00663ee28428dmr10132669ybu.613.1656001345095; Thu, 23
 Jun 2022 09:22:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: miswendygeorge@protonmail.com
Sender: mrsgadafio@gmail.com
Received: by 2002:a05:7110:7108:b0:188:5d05:ae10 with HTTP; Thu, 23 Jun 2022
 09:22:24 -0700 (PDT)
From:   Miss Wendy George <misswendygeorge@gmail.com>
Date:   Thu, 23 Jun 2022 09:22:24 -0700
X-Google-Sender-Auth: WqN8VWx_hoLDY1PftSZF4FKYuOI
Message-ID: <CAAPaySPNUcODqGqAVrqMcyC1GvMzS-bLkXsBkingdOJMF4h-Ww@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MILLION_USD,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsgadafio[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am with tears and sorrow in my eyes, I know this message will come
to you as a surprised but permit me of my desire to go into business
relationship with you. My name is Miss Wendy George, 21 years old Girl
from South Sudan, My father and I escaped from our country to Burkina
Faso. At the heat of the civil war after losing my mother and two of
my senior brothers in the war.
I am here seeking for avenue to transfer my inheritance fund of
$15.5Million United State Dollar to your position,
This fund was deposited in Dubai United Arab Emirates but I am in
Africa at the moment. Where i and my father escape to because of the
heat of the war in my country I will be waiting to hear from you for
more explanation about this transfer thanks

Miss Wendy George
