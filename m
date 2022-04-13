Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DB4FF60A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiDMLu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiDMLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:50:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0725BD18
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:48:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y65so1553852iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=y9bwjSVMYIsphCIRLLHfnHb4HwDDujX6DYWaEZJSQLM=;
        b=VY3gDXVzmrbp5M4q3IMlC2IOQuHTKU/clcjxYxnRRGiKmPKHswBgyMcZRZadDqLzxd
         hAhvVL7h48Se3qzYoYK5/RHiSxg/Ox37NnlZ8uYFALTRqFSWBhPPsHRQgCVKYUO8k4As
         PE9TZda1U5uGSlo/4o7BsagPEtqTwpYBrUhchLwW14Jy5MdeFD8toSHNpyhq7frSkkH/
         s1sYWTrsOKOct2F9k3/YJMNlatWAcfDfgrpNX263+YJ9F73lZOwaZ4LsTzYjJryITaXV
         nUMmftB8+thLWyDI/o9atTsEBmto63Mrp8G0nTbpjmjLFJtf9v6bd1wxlFF4em2avXba
         4y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=y9bwjSVMYIsphCIRLLHfnHb4HwDDujX6DYWaEZJSQLM=;
        b=myAgdsJZi2qT1Yv8UnptS+sfGdEiPbrJbdVPUi1BjHRz1NIt53JmgERzsPZuteAg3B
         2xJbUGbe+8lWX+mmB1976cS9zMldu8qiUjmAUmqmuKxMYHJkvHC83gMBWecjYz2YcVQ/
         1mLlHoMzp16zCzXlM1UC7C3Rrn+GqgGXfYOoW1GG4Rp4i1f5ynKP8xsR+CfiqFG71kuQ
         miohNPHcNwSfLKH23hgVx3Y23hxFpqcm/WUFQ7t25KhY5RLbpekQMsozqvkLpir0b6wr
         zRlbbVJWY3YE14GgfeCVvL/jJSZb4YWHoZbUk9YHTJwf+aboy9QGMIBTKBjlqqFo+MjF
         /HEw==
X-Gm-Message-State: AOAM531y7ATs42IBbRSFpkolBED0SZfc6UCqrmcUWVb8Yjd50EJL2cW3
        tk9yVLlwgHVY6++YHIThTUjT9axSEr06JYfxAo8=
X-Google-Smtp-Source: ABdhPJwQ+83Po/ii11LySo/HRstyb9v/+Gb2/JppQI48MjPt0Zv1bKpYElhufrbwe/Npg+TvAKtOuvfEOQ09/JV5VkY=
X-Received: by 2002:a6b:1495:0:b0:645:b115:611c with SMTP id
 143-20020a6b1495000000b00645b115611cmr17524721iou.199.1649850482015; Wed, 13
 Apr 2022 04:48:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f32b:0:0:0:0:0 with HTTP; Wed, 13 Apr 2022 04:48:01
 -0700 (PDT)
Reply-To: rkeenj7@gmail.com
From:   "keen J. Richardson" <laurajrichard84@gmail.com>
Date:   Wed, 13 Apr 2022 11:48:01 +0000
Message-ID: <CA+jvcxQH1gWX7rNT36OAyWMiVgCFfH_FVUhdCx+C7qG03pggaw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4864]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [laurajrichard84[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [laurajrichard84[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rkeenj7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a retune mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
keen J. Richardson
