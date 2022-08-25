Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EE5A1375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHYOX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiHYOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7F6B6D2B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h24so24843075wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=3e5Lp+sPQpJEdsviEhTw3NxSeRjV4BO9S4Pa8B8xh1k=;
        b=pPYKukJHPuqWmK1OL+t07sH19l7Zgv5vdqaZtUW9xLysD/61tFOQ0WE0vS5xgH5SR8
         +jseS0iO+PDn3Dkep1G1v1e0rkvY17F1+2Chv+jwPNSs3XLf4TGBq0ar8EL1qPadvurM
         RcbBvsd3aLRPkLaGuJ+27bYT8NmCd4b5ngyB15QU9wV70ytejB9I+/m7i3KFgISUppSQ
         rB4+/wDmVUZkKk0Kq+wSxDQszty+vDSwUYLeE+belnd6EBFvsWFBatAfcmkg5e+WLrDm
         7NGByfauu8yj4kNiv5szMvFCjeNaqL8uk2JdefqMKAh2QXMSPugj/0DB8BUL/GTMmVU8
         j/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3e5Lp+sPQpJEdsviEhTw3NxSeRjV4BO9S4Pa8B8xh1k=;
        b=MHN24E7+nJ6p3uKRH8rstq0olQJ1W4v19brNvL1DiDaXi7NEOGV6mKZ6hINqONkgLY
         k0gv4trwYheY2olBYIq/NzI9QeZfU+lpS9q8rlrlw/J+UpR62cTLkhBywF6oDlSNhNxe
         eAGRRIxL0rxwuBnp2ftW9j0HNnvbgfimqi0mcVklBW15zR50xS56V4G1GEUduznKTV3x
         pAL9/F9eAzXE8h/9PLqByOaow3NVkLGYnAKm2zborL1BnsWTd3Ojq2JwXVRjdFvxAYCI
         nEJw9wQUCCw3EXhBFxj5FlIYoBsPkZD1R26/P8y+y63uOijj07gxwVKgJs6AJmB8rXI0
         ThgA==
X-Gm-Message-State: ACgBeo1XrmsWx768fkmrI26z7EG9XEi3TkA/jwRt+yJN+sF586Anj9WP
        2nBj8d4/3JQeZeXtKbvTXd3zseYCvjiUlsm6i98=
X-Google-Smtp-Source: AA6agR4gdtpFRYYhSa5iPhkDiWmJrWx6Sc6zb3I97vVMwjsjSGz2eGCpLIqD2n0wSRNVKdz+YS7LYtClEWzN3cRBnMA=
X-Received: by 2002:adf:f04c:0:b0:225:374c:d7f1 with SMTP id
 t12-20020adff04c000000b00225374cd7f1mr2383888wro.623.1661437401734; Thu, 25
 Aug 2022 07:23:21 -0700 (PDT)
MIME-Version: 1.0
From:   Betty <schafferbettyjane2@gmail.com>
Date:   Thu, 25 Aug 2022 14:23:10 +0000
Message-ID: <CAAnUbPV9wbP9xcVhEYefqqE9Si__3G183+j5LOXZ9y1eNp-wXQ@mail.gmail.com>
Subject: HELLO DEAR.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9771]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bettyjaneschaffer27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bettyjaneschaffer27[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GOOD DAY,

           I'm BETTY SCHAFFFER JANE, a business woman from  Iowa,  a
state in the Midwestern region of the United States, dealing with Gold
business  here in the United States . I was diagnosed with ovarian
cancer disease which doctors have confirmed that i have just few weeks
to live, I sleep every night without knowing if i will be alive to see
the next day and  now  that i am  ending the race like this, without
any family members and no child, I have decided to hand over the sum
of ( =C2=A3 4.5Million pounds ) from my bank account  here with Barclays
bank of London to you for the help of orphanage homes/the poor widows
in your location to fulfill my wish on earth. You may be wondering why
I chose you but I have no option but to contact someone who is ready
and willing to be honest and do my wish. I have laid all the solemn
trust on you before I decided to donate what I have to charity through
you. But before handing over my data to  you, please i want you to
kindly assure me that you will take only 20% of the total fund and
share the rest to orphanage homes, help the poor and widows.
Please respond quickly to enable me to forward you the necessary
information before it will be too late as the bank is aware of my
decision over the fund. At this point if no one applies for the money
it will transfer to the  bank treasury when I=E2=80=99m gone and they will =
not
use it to help the poor orphans, widows to fulfill my wish on earth.

                                                                    Thanks.
                                                                Betty
J. Schaffer.
