Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43230595279
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiHPGWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiHPGVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:21:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3469133891
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:14:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s9so9132471ljs.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=DJuMC9uSqOfhxPndYeVwtr9rxlpKg28GSgzlSwv/L28=;
        b=BV4tp2k8RBXcCx1l8s/tFTKmUvWsMF/hxlKkZJmau4/wgSv3cnBpJFEzAaAnlEJ9mI
         60u78fY4TWhUJiSaU1wuuda54nZJD7XGeg1IAlp+meHPw1doVWdW2basHPjaWKsz655g
         ZbRKfwNS7O9xZwG+G9/HLBa62fPBftqFj891v6dh/kT9PhyBxwrT6QEQMQo86W8InOhl
         Y4KLBokEBsuUhfs8zt3oesRsGyAmrRZ7mEppc3/8ulReClZ4TNQHBqiU8UjIA8EuKzHP
         oPjviqxJOhK8SvEKWZTefZykRl0+EQrk+hjIloqaUUkRe//EbS4I8l/3+dqSeHgbGpl8
         q3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=DJuMC9uSqOfhxPndYeVwtr9rxlpKg28GSgzlSwv/L28=;
        b=ZtnD23Ii5UYV6FiNUkBt4R46d7lOSz0L2L3IUU32G4nGqchzx65Dd0X0RRXvBoxbdX
         L2LLsdxRN3ix/bPgNO+JJQ1euQJwRebMQUGZsDFpQIbJqHu2ag4boqmh87L0kvROVv++
         iJadxJy/O/YTR+cOuhjaZuhrmS/R+kdnxvETnimR+P5edDGGXFJFnniAV7prfBsUhulf
         dpIU4uP258m12leOKFcGofeQ4uzG32r9iPCo7lpWWcUqE1MmZXi100wQn4ge/GffKC5g
         hyQZwThPtcXr0h9iDbahz4BnZnfV1bzhrFZ7wLBA9c1F6rE5EMPl55OHU9qz5YFKdMcI
         glAw==
X-Gm-Message-State: ACgBeo0dFtbJnbP9qgV2t8ZsEzexI+jL+AceXJCPo5MHDO5r61JHU4Wn
        Na3qKMNXtWQe7n6tSqL3jGg0mV/CU6jKewIRhFM=
X-Google-Smtp-Source: AA6agR6++SyMXn2wyE5DieTUPNAsFJS6y2O/a1w0bnkdCfje26h4WDLcvC+Loy4RZ1wiVV1G1yD5G7XkmdnFIIoF9II=
X-Received: by 2002:a2e:8009:0:b0:25e:9d69:7cb with SMTP id
 j9-20020a2e8009000000b0025e9d6907cbmr5625363ljg.405.1660608869779; Mon, 15
 Aug 2022 17:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:2b81:b0:1fe:ccf5:aa58 with HTTP; Mon, 15 Aug 2022
 17:14:29 -0700 (PDT)
Reply-To: zjianxin700@gmail.com
From:   Zong Jianxin <gitetumary8@gmail.com>
Date:   Mon, 15 Aug 2022 17:14:29 -0700
Message-ID: <CADiDABgariXGK-yF+b2t2AkCwRLHQMCMoaUHWNtHAoeEHvFbNw@mail.gmail.com>
Subject: Deal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4970]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [zjianxin700[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gitetumary8[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gitetumary8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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
I have a deal for you

Thanks
Zong Jianxin
