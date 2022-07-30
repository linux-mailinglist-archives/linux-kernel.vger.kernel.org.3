Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198875858CD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 07:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiG3Ftd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 01:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiG3Ftc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:49:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4B66AED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:49:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r186so5512240pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=D9adEwgWRa3F2f0wMc/dFN7FpwTjaqXiOJ+aPiD/WHv+ljvX+GjalmDndk5HBuGeCu
         78qcQ466w8RU/gspe1gscjG95JwoezKAgIhqiSVBVk7oRY6EMm+20tgWtbMc5E8rr/QV
         lVQhtuPE7rFwMzYPAwhGmfFfotzPiOwliT74XEgJtwW+ny82E80EITH0QyyjMqKABNnM
         v3CXEgJJ/Y/X60PR3qo3ePMMohRqNVCzPBPlB0Ki1B/z5pA9eysCxvamYwHVdzDbIUTW
         jgwlrwv7M9xOexYrUANNZxblNexoXbBOj7aUZ4YBbGuw/75adI9hIeuMASKPjv3aPrNt
         ODIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=azzKIEc0Tt/TT6+RtHogFpZSFXkRHr1SBPcOaLKas6txAYgFo+kHCMmBC0y8PvgRqF
         NXSrf1BtnwZYM4v+arY/X+gaAWNP3O49RycqnstBpiWn21L9t6T2+UnT+yzLdJqLfVY3
         7wpxNcDrjxcJZEedQtzCTuq5aoGYRZkLZEXtkdgzkIUKr9Yv8oP6E7RxLuCpHPR2gELR
         XJxzy3ZvyXbqlrIcwsW6sd7wgL3kwatmMR789yZRHYsJXBX4fPDtHJHnf22XlfFVw33K
         31Zi5WYwHRh7WOWPtqTSDU5y2yTNVUtmGL4AUc3wQnaZCrHEzz5UjZnFWO/kHLfAh0KH
         5K6w==
X-Gm-Message-State: AJIora+WSiKRKKP5dT3v/WonBPV0PgqpYYBmlS7Yl93HAJ8RMGpmBvHE
        V6y+D0dbqSggPvpdgJUMUjzgsZhWFAfsmV0MNDg=
X-Google-Smtp-Source: AGRyM1s0luykm7ZD5nFvU5vtjpMOs1GMqm+TJ67CEBTifk4EEciNtVXzCOicINWuHGptyT4tpnpwZHnE/84b4q5eIzg=
X-Received: by 2002:a05:6a00:4481:b0:52a:c7b2:4fe with SMTP id
 cu1-20020a056a00448100b0052ac7b204femr6695343pfb.10.1659160170709; Fri, 29
 Jul 2022 22:49:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: tw390032@gmail.com
Received: by 2002:a17:90b:1a89:0:0:0:0 with HTTP; Fri, 29 Jul 2022 22:49:30
 -0700 (PDT)
From:   "Dr. Tracy Williams." <drtracywilliams12@gmail.com>
Date:   Fri, 29 Jul 2022 22:49:30 -0700
X-Google-Sender-Auth: iM-ye9yaIu6rJeavANTMLt4R9aA
Message-ID: <CAH-phot_c4qa7Js8=ZTraJxCZ2LYBmHGHvvx07fEYPBQjTTgVQ@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:544 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tw390032[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tw390032[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drtracywilliams89[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great. It is my great pleasure
to contact you,I want to make a new and special friend,I hope you
don't mind. My name is Tracy Williams

from the United States, Am a french and English nationality. I will
give you pictures and more details about my self as soon as i hear
from you in my email account bellow,
Here is my email address; drtracywilliams89@gmail.com


Please send your reply to my PRIVATE  mail box.
Thanks,

Tracy Williams.
