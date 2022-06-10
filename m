Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C64546FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiFJXKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbiFJXKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:10:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E4A101DA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:10:13 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-fdfe64231dso1093384fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=lhMzmUd5inDG3vMtGMelWY5RpHKo6Y4bgntRhGTPVWWbEE5hx2imi3RhhKqOE3kf8h
         ZgKxy/Y3BLOWYVnIoMdN7S07XvvBYvkKkhltpT8fjyue/bO+IbRhaQHDL65ZbuKOhK3+
         fqFMutAKldXv8UaE+CXZ2CbvTYR/T76gjwa76Fveh7dlq+KEX5/bIbMxvg1F7aYmkPEV
         XLJ3yL/pyhy9oOjYSwF7KRHHXOMncjJfOg3VxDHz+me6RxqJ6DGzbAJNAqJHKnoIO4qw
         N8s3LrvbTqosmyPPhN6H1pFWpcAeGHYkwmSrzOGZyDpIwwf9dmw4Qr13/uf3nGYsF8Ex
         2hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=qFMeBXcZtcp4UfmXxS33p2to/PiDlsXeS+J0AoWTKPw=;
        b=InD/vPY0bH79gfKcXgTeqQbzSuVpN7q4QlZLeFRrQH3dT59P7fI3GwNnF3SoyA4f6S
         XZAkOaRZMOBJgfk/mrpiWAwWA5+wR6F9YOCI6odTNO3qyU2MJvdZPZYRIYO2AgNm5z0r
         bC3Go6vXK/e8jeiHhutw/jfdSANiQZeQdDaVeR7UL7vBX7F/2PAiLT/YiStDqsa73K2P
         pGPk2UQmnuOiJTBURvu701dZnr7thTNAK3O5Dw1azGzCTtaS8qUNG1luCAGQDOJg917d
         xfmAP3T1KASsC+EG7x+FMqnQ7Ayw25D45Z2r3s8kxgM5KM2dVHpOmULoKeOETorFn4XT
         Z0/w==
X-Gm-Message-State: AOAM533IMaBXqIbcRr6EVQSEMMOxTLDa62hOwX0kHN6Btk7Z+cAIVglt
        cOwYLC+OiFIotV5013g/JxwGRuJKqyxmbyqT6Us=
X-Google-Smtp-Source: ABdhPJxH/62NLq4ga+rP5yuXf8AwddLmvwlozTLcab7P1IJUvV4QcqGFaKFsXrYSSzoH3bVZ8IrR9U3gXvLo8DwZWx4=
X-Received: by 2002:a05:6870:51cf:b0:100:eb6f:42a3 with SMTP id
 b15-20020a05687051cf00b00100eb6f42a3mr1218771oaj.208.1654902612228; Fri, 10
 Jun 2022 16:10:12 -0700 (PDT)
MIME-Version: 1.0
Sender: maritbrunel@gmail.com
Received: by 2002:a05:6358:9483:b0:a3:bae:8a23 with HTTP; Fri, 10 Jun 2022
 16:10:11 -0700 (PDT)
From:   Hannah Wilson <hannahdavid147@gmail.com>
Date:   Fri, 10 Jun 2022 23:10:11 +0000
X-Google-Sender-Auth: vMmZTiLuZYIDlmWefJXT-5cDivc
Message-ID: <CADJK9pKA5PvhgTy74rkkocpKbeDa6Z5H1+dHs7Z2Z_1N--6XLA@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
  I am glad to know you, but God knows you better and he knows why he
has directed me to you at this point in time so do not be surprised at
all. My name is Mrs.Hannah  Wilson David, a widow, i have been
suffering from ovarian cancer disease. At this moment i am about to
end the race like this because the illness has gotten to a very bad
stage, without any family members and no child. I hope that you will
not expose or betray this trust and confidence that I am about to
entrust to you for the mutual benefit of the orphans and the less
privileged ones. I have some funds I inherited from my late
husband,the sum of ($12,000.000, dollars.) deposited in the Bank.
Having known my present health status, I decided to entrust this fund
to you believing that you will utilize it the way i am going to
instruct herein.
Therefore I need you to assist me and reclaim this money and use it
for Charity works, for orphanages and giving justice and help to the
poor, needy and to promote the words of God and the effort that the
house of God will be maintained says The Lord." Jeremiah 22:15-16.=E2=80=9C
It will be my great pleasure to compensate you with 35 % percent of
the total money for your personal use, 5 % percent for any expenses
that may occur during the international transfer process while 60% of
the money will go to the charity project.
All I require from you is sincerity and the ability to complete God's
task without any failure. It will be my pleasure to see that the bank
has finally released and transferred the fund into your bank account
therein your country even before I die here in the hospital, because
of my present health status everything needs to be processed rapidly
as soon as possible. Please I am waiting for your immediate reply on
my email for further details of the transaction and execution of this
charitable project.
Best Regards.
Mrs.Hannah  Wilson David.
