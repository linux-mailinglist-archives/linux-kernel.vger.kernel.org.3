Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26959AE98
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbiHTOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHTOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 10:00:06 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C7F25C1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:00:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v128so6977619vsb.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=XUp8hHC9X/kUdXCLWd6qNpFQQBjrGrMt9ekC1xbGQ24=;
        b=IUK2eWuWXkAcs/YnLj26hkQ3BzlPys7m8gW0BkiZCq7jdIvrbBUEKM6Uba40TM0OKh
         nuH75vw1poLIhmtiTD5bNnXsfPS74+GV9Wjj4+nKbbznzEZW8vf69FsIDRmt5k/xV+ur
         PproL4TSw0Y2/V7ZX+zjCk/JHcKTSbsKpRBLQ+JyRz4QlwETKoC1ha90FkJA0dqp6CrM
         Edk54pTEIFrihy23NoPoIaiWP619Sz4wpqQ9Nmjrcv6k5cAtUrdlqIadXpfy1J++NLtq
         ElUqsWQsT0Fe3+YAezOxfRW5W3Reb9Bl0kakRXrjjbh9KF1Dd/3r56zNu5/RWqtvwLCn
         7DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=XUp8hHC9X/kUdXCLWd6qNpFQQBjrGrMt9ekC1xbGQ24=;
        b=WPJQOtTx75KSfrCIsN5wRChMj/yejXwG/3fNWTWXQXMUmgJUMlZFEVBF0oslFJtrS/
         0NKJ/pzauNlmk9b8wk3pxkE9FKR07q9jawhYp10rUBNXd0awLmu0sZ72IIZiy1BXmu+6
         fW1kq3tbgfyoUx31HRhz0SGQJiUrDN0V+np2vcSLl2bztiyGqgYW6Fw5PAOpc38nd7Tx
         KYIpAD0nfSH0fc/a3j1QLbRfl/KCFv5OADdmyQTnytSncf1AsbeQan4X9LyCcw69OXwH
         ByLE8F0x3N6pTETTXWe0NLT9R3Xaa2TM/so+tkK2gBm7veLpb+qEirbT2M3rC23pVXxS
         H1Ag==
X-Gm-Message-State: ACgBeo3jhe9E4Ymtvv5QEGk2PrLYIZiisyv/QKFDd+/UEEHbq+9GUeoH
        hl5HT1SMMGEIxt8BAE7/6q/Ex6tIKZroQEuwMvg=
X-Google-Smtp-Source: AA6agR6wlZRE1GTELp+lA7ljrPS8MO/jo9JDF5yFDREJr770Db3VIr3lxaI1q7F4waEFNc5QusoelbSrIfNAp2sEc38=
X-Received: by 2002:a05:6102:5493:b0:390:1efe:e8c9 with SMTP id
 bk19-20020a056102549300b003901efee8c9mr3487450vsb.5.1661004003454; Sat, 20
 Aug 2022 07:00:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2919:0:b0:387:43df:312a with HTTP; Sat, 20 Aug 2022
 07:00:03 -0700 (PDT)
Reply-To: oolivep60@yahoo.com
From:   Ismaila Ndao <isnd109@gmail.com>
Date:   Sat, 20 Aug 2022 15:00:03 +0100
Message-ID: <CACgiDeSz_awwV8aXk_thTJ3cAN8p_bzmUaLuXfpMgSJws7RV8w@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5022]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [isnd109[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [isnd109[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [oolivep60[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
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

am olivia, a single honest woman ,looking for a good honest man to
spend rest of my life with, if you are interested reply me back , i
will send you some of my photo when you reply, mind you age,
color,distance,religion is not barrier to relationship what most
important is love that we will build together thanks and God blesss
olivia
