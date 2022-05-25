Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214B5339C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiEYJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbiEYJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:14:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BB994F5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:12:35 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y8so964091iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=64pmXwiis7BVgQfeqcIj+59xKI2avQ4yIdqAYbjPDyA=;
        b=gG7Um0HgY3E/eJECa7s9nKtSAJKd5fExUjJ7i+MgP+Dua0Nli+vNSdlYsyeX8VXxY/
         iuh3wEX9Nh8u3RgvRR7nQQX6C+SB7C/R74r67UPptp/PQ9E9KXU+dqUzENXc+T5a5uDq
         Dd828WR9IHcST1R2+nU37LRh2ie5Am+clfMkFrKjeprkKK5o2z1KPN4enqT77dx/75PL
         gzriWGxDhGHmGps4qYaDe96YRDLpe7lHDUYDYz3bVjaf5Dswy97/byv0eOIyevxl2Xlf
         bJrlsnH6CVoRKvNuNnnb9Fdm5g9beW/3yO6YvyYg68o4cuLxGHlj/G9OakejOQsihSqM
         gH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=64pmXwiis7BVgQfeqcIj+59xKI2avQ4yIdqAYbjPDyA=;
        b=68VtUGmBDtY0x26Yobwh5xuNTVb8lnmPwS9INjQ0QULUZen76hZSi5dY0KVNO4/MlF
         DX8UHOCFMGISdhy+azWZDfXjndnJbSCTVc31zLaAPOse3qYKIDVFjAYaInG7Cb5DxzTk
         yEeX8sRqOAFCC0CS1KHUrdOu+/lO1zzrZ+xo+G+N4aC+WDM485b1amEVz2de42CgbLpu
         Q7p+tYEDZDMpIbthqfWfXoljU4Ywh1YArvPzXo6OHJRE9ByCKb1dmWkxDujORaM2eZty
         PRXEG2aVlkErTcgIQ5jaIa/iXVNWa5XC4OJzN3b5+hlQv5nGadwMLobLMb9CC4/99fyA
         t74w==
X-Gm-Message-State: AOAM532QpF0wFb7dzVybqjoL2ree965mlm9x4zWMqjVf3pC6t9ZcGoWZ
        IMf1h8M7PS+DW7lqS7JgI3eA6QCYm8ap5iG8wOo=
X-Google-Smtp-Source: ABdhPJzAUyLiZpkD6E1tvBMADff2kMnU0+QVlPoTTRfSbNQrWTYgyGfmRYRNFRfuenbQI74yCB/nLLVmu73dUGL+jgU=
X-Received: by 2002:a05:6638:240d:b0:32e:80af:6a25 with SMTP id
 z13-20020a056638240d00b0032e80af6a25mr17192469jat.233.1653469955381; Wed, 25
 May 2022 02:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2e91:0:0:0:0 with HTTP; Wed, 25 May 2022 02:12:32
 -0700 (PDT)
Reply-To: amissaashi@gmail.com
From:   MISS AASHI ABU <hannahmaya944@gmail.com>
Date:   Wed, 25 May 2022 17:12:32 +0800
Message-ID: <CAO5kVvB-BS+JhrqF2Q1nWD8xP0wKmR+GJz2Rt=zKdjkQx_vkOA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hannahmaya944[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hannahmaya944[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
How are you doing today. I am Miss Aashi Abu, Please reply to me
through my private email at (amissaashi@gmail.com)  for more details.
Regards
Miss Aashi Abu
