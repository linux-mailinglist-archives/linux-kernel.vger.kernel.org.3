Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01B515102
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379243AbiD2Qmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379206AbiD2Qmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:42:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10940DAA00
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:39:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso2381045pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=aT1mMx7G7UxfsIaMTAsj5UtIFy8ZPOjU7jyV9ILj7K0=;
        b=Z9JwwbjfKXF+J5lRLrITd3m71iTUDtPhiRqJyxIN4SSBsRMbJ1M/RCYtoTx4ZTipV+
         hkI9oDNZdbxwiDPi3OjvRbgQaimuNj43mqRPdHhXDksBTbL1G2PMU4XW3sIPl+jKWwGl
         tS/b1sZpWxYlu9T5yR4Bjz02WQ2U5tOpc4+BagKq0pX83j2bmsUGpxJJtlClU64DoAEY
         tOIjaQEsWwQpUiMN73iPhckFf4qcyU0r9ypKPRGKXlet/DYiWwsDjTm/K5GY25xR91Wb
         fFCn+nA8ZbLCz309uqJKKHsiD5ZIJdyOlGjntl94WRpNZF0gmXpiHAHwm7lyWWn5D5wr
         selw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=aT1mMx7G7UxfsIaMTAsj5UtIFy8ZPOjU7jyV9ILj7K0=;
        b=zZhkBnYlKKA4tsbMIvEvwVzOMyPp/CM4eCVnmVuhoJ10amRWYgraVq3I2W9o5cxxDd
         VP5vJON8phE91/mfQau0KET4UtZALrDSSZOayCubIjIzNSIzPhNnvv48yMU03PJJe9Cu
         Xm+1ILriMTv7Wwk1+kLL0+BT3x7PQqn1KZqtWXoEAlIDPc5qJDDbf/xPVDH1vRKHOVwX
         JGQfL4+Y+Oigw8P5U0uJ46WCCTe/wDZf97BFl0PzX/JNWYlEiOJ6a5ttoR6tNOO0D2Dt
         aL2M+nnHHjcgxnI3Ic7k4CEatvh2EgkR22OwDRRjq3TDWlG/Ej4R1w4Nh73j815C2q71
         +Q5Q==
X-Gm-Message-State: AOAM5316noSWcBS4PmdBGl6XgqxbRYH6gO/ewYnLAr6pERJTLm5NJ525
        pofCbCwylhUt5hyCXzOdZg9BFhIdxpKw+vU2vWE=
X-Google-Smtp-Source: ABdhPJyQBJfDIpqbDEF8XJMKLbiGNJ+OiovlON2byeWTXY2QcFzu3qFOYV2IgDL133I3otx9gv6yT7z8F4lIj010BrE=
X-Received: by 2002:a17:90a:784b:b0:1db:dfe6:5d54 with SMTP id
 y11-20020a17090a784b00b001dbdfe65d54mr10247pjl.112.1651250357513; Fri, 29 Apr
 2022 09:39:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4ace:0:0:0:0 with HTTP; Fri, 29 Apr 2022 09:39:17
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <nurulparskin@gmail.com>
Date:   Sat, 30 Apr 2022 00:39:17 +0800
Message-ID: <CAJAahvnPqY-P6HZh0kOVMXPjxcc3aSBsQOxJ5CA+moB8winvuw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nurulparskin[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
29/4/2022

Attention:

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
