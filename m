Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA64E80A9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiCZLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiCZLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 07:51:35 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE231C5907
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:49:58 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o67so10965862vsc.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uc-cl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WkL+4HqaqGPobhai7qUB51B8QkT2s6IVHuPU1bTF3is=;
        b=PeLZj/3WP/KGOke2zHx/uQFbr7qOFnDqtWFRki+Y9noewWmRTGYOARtMkQk3EmAFCn
         OQDA0vhUhr+sUGn5M0o13DO7cs5tjQ7UvQsqA696XVcua2z9R9saF3EElpbH9rGKlLVS
         Q+9dUdTnv6romO0MslLMIsEGPC8agvbvXXMSvH2EQ8XoRfaQuahCZiIbIcNOrRYZGYmq
         4j1AaW7KqQZbE9YzPjc1YxcYM0BS4ZRPC1jaGLjPcGQVgiJZLkwLYBBGnV2up+vuR11D
         nd83u/5/YpKWsPri+5mmVfMjLigRRsk5vWNgZZSM+mYEfkW/9GourrOKNPEgESduH60T
         bYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=WkL+4HqaqGPobhai7qUB51B8QkT2s6IVHuPU1bTF3is=;
        b=ZpPmxeeuuoamX4fsWQMeoQpGIw0ta8zhSwfhfkGVd/wsTcV4fydwLU46bv5tMs02o2
         PbjXL3getuOUWjJHMN7eSP8HMdRJU85ZRTtaXMFjioBGTweU2QYqgrupFXI8uJtabNTl
         Mwk8D9MTmLfy0HlOHwN2gkKTiZi1qRNR6SeIjidVwqAc681diWbYlD/bQXoEuhwzxBU+
         oRbu1rE0VFgu1d21+mkvLbz+jBd0dTjzLGFB3GGnXN2guvZ+wTollUR5tEz/8itEJBdV
         R8eOV3DqxNsHkLU/hqm9lOmVtUwRC6Ia5POBrpOK62Wo96/hW3St98hausqaU8UhnC/D
         4O/g==
X-Gm-Message-State: AOAM533c1QabAnVoNwYBvRDglOFpbvt8nSK3zmQfGpxJfWt1KH8Ppwhu
        9CANEsqO3FWvUWxA96pObo3QFBKYquwYe4yh10fQzeiaTGiyeYbNF7MCh6kjrAv9VDQsm9D9OR1
        2PNAtH7lNDnOUUSHTm3Q9ce0sXYTQX39I
X-Google-Smtp-Source: ABdhPJxt9dHO9a0CbyMp4g29emyQ+BXd+efs5FFvFU63uDA+f1VYLVm9vgIBA0wuZUhwENI2Fz46+BI8/n48jQIoPFo=
X-Received: by 2002:a05:6102:c10:b0:325:7dee:c911 with SMTP id
 x16-20020a0561020c1000b003257deec911mr1869344vss.49.1648295396836; Sat, 26
 Mar 2022 04:49:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b809:0:b0:2a0:100b:1dbe with HTTP; Sat, 26 Mar 2022
 04:49:56 -0700 (PDT)
Reply-To: chrtyfndtlisa@gmail.com
From:   Lisa Robinson <rrondane@uc.cl>
Date:   Sat, 26 Mar 2022 04:49:56 -0700
Message-ID: <CACK-=15w8Evf5o=ETa8J+R6o1gZSMmK_EbsKFm9rUJditg6adA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,HK_RANDOM_REPLYTO,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 T_US_DOLLARS_3 BODY: Mentions millions of $ ($NN,NNN,NNN.NN)
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hello, I am Lisa Robinson, you have a donation of $1,200,000.00 USD. I
won a fortune in the Power-ball lottery and i am donating part of it
to ten lucky people and Ten Charity organization. Your email came out
victorious so contact me urgently for claims: chrtyfndtlisa@gmail.com

--=20
No sienta la obligaci=C3=B3n de contestar este mail fuera de horario labora=
l.
Direcci=C3=B3n de Personas UC

