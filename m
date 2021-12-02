Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361C546620B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357164AbhLBLLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhLBLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:11:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70939C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:07:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4372755pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Bc78QZmKN9WTHflqjWVVHp2jtyUd58NbAc3U2ef73hI=;
        b=beRoB2W12nzKATiz7+5TZaV8IQ9HoAtnourpb7X7/ctLG7g0ZOCxvu1vrZQXA3N/9M
         OKpWQW+9fxdc0fLXA9jcBT090s6rDlWeTADa4REgZZG99OdUxWrY3vbxuX0WLHRDb6in
         CD9C57E/tklhTB9E6NGY8cKE1XX2huD1+BbDHwEJPSqClcWALwHMfK8uEmi5hfcHzGAJ
         BdGwOos0c2QXytBMmOkNrZvfBvKMW2npBCOVXD+ph3g+ZFGgxK4yFwFWqrfO3M6a+37c
         cL2vFlN8dP2n1TUH8r0nBwyI8q6wXBgTc0DAsR4te45nhoZNvK9kdt6r2PUD8nDnZWR5
         BEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Bc78QZmKN9WTHflqjWVVHp2jtyUd58NbAc3U2ef73hI=;
        b=4h9A56ZHll/os2RfdPEaVZS+IySD2Vtsv0CAHJpMpV0A3MmHqcE4hBJFg15HO4+lE9
         RCRwudqxAxpiFYBfRLHGoqr4rnr5NSr+1vGfXN8o60LgUTN5HhfIeqVYTj9bcnYn8qm9
         j1ttZAsjwYWia19RHk7NMKwbt59VOBCpFSeHXVCkFemdhUcuTiCw1L6K3ODIBVlQcBOY
         7qTuW6K+lOsWDWIt6HLxdX6PjK8MdhG7W4yXc2THDCDZ7WJQxJtMjkD1cdfSxAvGzzx8
         QCQlKdPPkucm+FJZVVyR7Y+oUcHC/2wVGKxv486Zt2jlWSamyAb1pgqvPHZHC9BjivAf
         Y2TA==
X-Gm-Message-State: AOAM533DBO2Roaj+ikItbOFJF/Iw2H5AzMiQHAKaQ+ko3BYtaGIz3Sjv
        JvWjQimrg2hVFeiZI4YtAu/4YvBBxzIwa4oird0=
X-Google-Smtp-Source: ABdhPJxgRboQ38oXAerVTFq9JJ82a8NDeZPToMORlWa4/KuBBtswDgs2A1Sv83BmbAsKHdvXCnx81zBWQzfBxzvFn0o=
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id
 m14-20020a170902db0e00b0014213e4b456mr14567530plx.43.1638443266858; Thu, 02
 Dec 2021 03:07:46 -0800 (PST)
MIME-Version: 1.0
Sender: miriamkipkalya10@gmail.com
Received: by 2002:a05:6a10:2a13:0:0:0:0 with HTTP; Thu, 2 Dec 2021 03:07:46
 -0800 (PST)
From:   "mrs.sophia.robin" <mrs.sophiar.robin424@gmail.com>
Date:   Thu, 2 Dec 2021 12:07:46 +0100
X-Google-Sender-Auth: uxyjO3WmEE9F-idRQpHxLMn_2tg
Message-ID: <CAERXgTmHPofqRM7aBLC+Qpt=3J5hcmjEOkdXD0HPAd7yyapAzg@mail.gmail.com>
Subject: Hello My Dearest
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

am Mrs.Sophia Robin,a citizen of the united state of America,I work at
HSBC Bank in Milan Italy,as Telex Manager charge of wire transfer
department,am contacting you personally for investment assistance and
a long term business relationship in your Country.am contacting you
for an important and urgent business transaction,I want the bank to
transfer the money left by Dr.Cheng Chao,a Chinese Politician who
died,March 17th 2020,without any trace of his family members,he used
our bank to launder money overseas through the help of their Political
advisers.and most of the funds which they transferred out of the
shores of China,were gold and oil money that was supposed to have been
used to develop the continent.

Can you invest this money and also help the poor? The amount value at
$15.5million Dollars($US15,500,000),left in his account still
unclaimed,if you know that you are capable to invest this fund into
any profitable business in your country kindly send me your details
information as listed below to enable me draft you an application form
of claim along with the deposit certificate which you are going to
fill with your bank account detail necessary and contact the HSBC Bank
in Italy for immediate transfer of the Amounted sum into your bank
account direct. Percentage share will be 60,for me/40,for you.

(1) Your full name.....................
(2) Your address................
(3) Your Nationality...............
(4) Your Age/Sex.....................
(5) Your  Occupation.......................
(6) Your marital status........................
(7) Your direct telephone number..................
(8) Your photo..................

Thanks with my best regards.Mrs.Sophia Robin,
Telex Manager Milan Italy,(H.S.B.C)
