Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251295114C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiD0KOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiD0KOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:14:47 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391044C50A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:07:45 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id w21so438230uan.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Q+iQw8dOuRhqWFMfk36v+bnSnga97KmjbrW5RqLIfmI=;
        b=GvYVPqx5jED1fUd/5GyEMVvZkvcEE8HbF0kbwRMiLoXjm0PO6M1Cx8CyxY5oGcp3Ls
         nWpwJ1/ZaCEWG5eRDQD1fvugWerHLVb4velzH4k7rbmWfL1kRwL83hgEO4ITyL9N6BD/
         mO7a1m+5P6+CQx7/TFZ/aRCUvDpb2lmXx10qT9h76Kj2Xl1XQwrRutQpIS81To/TMVo+
         qkCtYksfAW/IwhEVQ520pjCtxRUY0XDxvhXeF2iK9Wn9Lwfm9hhc6mQLBnS7lMakr5ZA
         OoXdiUriq5mDBRcmT4xgzKEVM9ZY9n6pCkPmua7aS+udoX0nKu6mlGx1gbqhm8W+Gfp+
         nj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Q+iQw8dOuRhqWFMfk36v+bnSnga97KmjbrW5RqLIfmI=;
        b=jwvTp9Zw/QnvSFnkFXWbDWDZrTnEHNJKffGF5ECpQ6AGvX3V3aSGUEd1hTMJ3c2z8M
         d7aReltte70U0l6ojug5g0uAMm/bQ+ciox9OW2nEv7UQEqcz36DN3uls7bhRpV1/e+dC
         ZPl1gYLmKBlHDvITNiqRVHmuQkCbGBIE2YbQj4Tt2pOUNEBtSjuyEeMI0R2sQu1JiZ0u
         aBi5LlLuBLMHV8rtB+W3jQKum3FcDShG3aVLd1jpSwALwEBcSRx4Z903jA8dT5ejwbY4
         TiUJbjCoJ1dsPEbfi5VIResqpze4iNPJUdrNvKvp3bFHz7gChQqCviVdOma9OuxPeYOS
         biVA==
X-Gm-Message-State: AOAM533oZ3czr91aXyfQPy36Q6YrFbqBTKm4uixYfl5k6T4EOAXtsr21
        rjUumxaZFIukzDVRjHT5dDlKENGHMz0e3WedSr3YgXLO7Yk=
X-Google-Smtp-Source: ABdhPJzXofcTLesXDk+xboqRZ5g0BO8Dz/xZhsGhDdelaQMpKudIfRJGZSO8vh7TW2CyE7VGRLGReghLx7UjGeKodzU=
X-Received: by 2002:a05:6130:20f:b0:364:f48c:82 with SMTP id
 s15-20020a056130020f00b00364f48c0082mr410348uac.56.1651053032949; Wed, 27 Apr
 2022 02:50:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:21a6:b0:2a3:724f:2c50 with HTTP; Wed, 27 Apr 2022
 02:50:32 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   parskin Antonio <parskinmantonio@gmail.com>
Date:   Wed, 27 Apr 2022 17:50:32 +0800
Message-ID: <CAM1PqaY3zfSzoyC+8PqkpOTKSYmz2eY9oh4gNgOUS8ePt88Hzg@mail.gmail.com>
Subject: Greetings from Netherlands
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:934 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [parskinmantonio[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
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
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands
Call:+3197005033311
27/4/2022

Atten:

RGI Genealogical Investigators specializes in probate research to locate
missing funds, inherited funds around the world. We can also help you find
wills, obtain copies of certificates.

Recently a woman from the Rothschild family, one of the famous families in
Europe contacted our company that we should contact a business minded
person who is capable of investing her funds in a lucrative business.

Our service fee is 2% of the funds and we will be paid after you receive
the funds. The funds transfer process should take just a matter of days as
we have the mechanism and expertise to get this done quickly. Please if you
find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J.T Woods, CEO
RGI Genealogical


   -
