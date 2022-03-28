Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4744EA12C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbiC1UO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiC1UO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:14:26 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F757B30
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:12:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a127so16946968vsa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=6Fsq4HZZEwfE/kIoiE5yOQ4OuDPMRHRBrpIlJ+kZFSM=;
        b=NNUI9xeuM+TpUmLinvHyzdI0xFA3EmdV+4EzyU1jCi3hTMXpTObUVRnM5rwoZKJW5k
         CvmsE8sHgmGFUJoa0sWvZeDKJ3qu+EZYvCCa51mz5d9OlavYEysxlN9mj2eVEF9J8aOF
         wDgy5YxqOE/ulJUROsQkEG7w5CNTFOTMvNRGOY598XcdZFcKf+zuAjJW/yLo59zamlaN
         J7jUpHACs7/ulD+HdGGAeyLJ3rX+3vKwX6vVisKpKAe86mSUG62ysgSH1U0kYPWOAhV0
         Yi5Lu6weY6WtHNzP/nZ0vKlXLIK6ve6kqyD1tofD9w8KEQXxgh4yNBplR6slTZiRmsct
         CKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=6Fsq4HZZEwfE/kIoiE5yOQ4OuDPMRHRBrpIlJ+kZFSM=;
        b=z+o7RwyQ6Eq+bsCmOCRHrVS1TdtsD9xdDcNKpy1p+5F2cUkMRm7ZEkHTG5Vwx+fa65
         qLDJrjRAJAPBzpTQfljTnEirwXTSlcRLD4PJzU2ZAl5If8ptzp1Bvp3Eb4z6vMl0Z/ie
         BwJYVPALJRP86nboGeqQvuCQ9TYohDcdq5/nG+WHWL/ueKaXoa7FvCrG2Z+xagoj0LS4
         RrMUeOi6NGinSwsK2Ff7kJ4SZcO/d90+PZbzNSIiLzEeBv9WiG5mVNXwzI5/YK6zjJL4
         23bY2E3//mQLYattVhktH135ikA7CY3arUGVHQdg2i5IHmQYJ2xJ28z98jqCABXC42L1
         cpLg==
X-Gm-Message-State: AOAM533wGqXjovfhgu6bOrjYkP6SOCgYxcOEy2d3n6piWLGE3ZdCqz6N
        cK1VXNof4xLjGkWo6xE664lSgWa5WmPAMbK+CCI2diwaHFA=
X-Google-Smtp-Source: ABdhPJxGjy1e3cHJsK8SJYTghcaoPCJYM2ykImsaK4dT0rsK3wrWeu4BbTyZryGIc6CjOboaTX8NQJGDqgphrlTgrNs=
X-Received: by 2002:a05:6102:38d1:b0:325:aff9:358 with SMTP id
 k17-20020a05610238d100b00325aff90358mr3925158vst.8.1648498364485; Mon, 28 Mar
 2022 13:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:270a:b0:29e:f7e3:2452 with HTTP; Mon, 28 Mar 2022
 13:12:44 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <anantonioma@gmail.com>
Date:   Tue, 29 Mar 2022 04:12:44 +0800
Message-ID: <CAHx=juSTVQOSO8e2nh8yT6m4ypn-dsW4XTNOu2GA1cDS+zu_xA@mail.gmail.com>
Subject: Greetings from Netherlands
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anantonioma[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands

Greetings from Netherlands

RGI Genealogical Investigators particularize in probate research to reveal
missing capital, inherited estate around the globe. We can also help you
find wills, retrieve/secure copies of certificates.

Recently a woman from the Rothschild family, one of the famous families
contacted our firm that we should contact a business minded person who is
capable of establishing her capital in a lucrative sector.

Our professional co-operation is 2% of the capital and we will be settled
after you receive the capital. The capital transfer process should take
just a matter of days as we have the mechanism and expertise to get this
done quickly.

Please if you find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J T. Wood,
RGI Genealogical. Co
