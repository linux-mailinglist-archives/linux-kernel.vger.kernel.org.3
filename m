Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3624A58F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiBAJJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiBAJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:09:35 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E76C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 01:09:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b15so14869193plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sZWGihYuBSIBpF/UUxqTCvTiC/Dkr6jyPhYvam1O90k=;
        b=Mqlva6cmYpQtx1YJKviDmMS+a+3q8B4J+0EvIvJeZRtIO3AKBM7belBhna2swcSnXg
         8T5UlqET+HZNnxB1OZVnj2hELA1LOZSZO0sQPZTY/q80CbBYQGbD4b/vfgv/SGIKBXYk
         6jrSrKzG2BZtNWLuSG6Pjmv3Q0WsQnB/YFCiPKmW9B1YEFXpg3++XYqgsysjwLi4yMGl
         GQTW9dMUda4u4ZYpO4bZtJPbOYG18PFKuHW0bZ8ccjDXasrhlwIJAr0O9sN0X+Bzgwya
         LbHPWCFYeplsp3B2N8ix3Pi+yfUEgX47/cdIJJUFLQYGWm1z6BqRxVKktLFRYtfcCjdU
         8Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sZWGihYuBSIBpF/UUxqTCvTiC/Dkr6jyPhYvam1O90k=;
        b=g11NmUKjFkcVc9XGjPfIvQ8NyWWiUfD6K5wiJjJ4V9qfHRhM0lcN7sAZnDVsUB6p1J
         d58P6DpXWSXofJhFC9zaBxkt3bejyAZMoI4mZfIOl7mqYT001xRI4x/H/GqSJIK2BiQU
         TBVmS0nGt6AkC87oF6AuM+bSyLMuAfYJof8kyi5khShxQ94gCqGAT+q0I1ggS1t6EJlc
         EPLnU4NFDYthOg4RBsVGoCq5JNLCBilrz9hXfiGxO8H/wYjCp1cxg/YOOuymhv84aw3G
         Bcj0LaWTBy2XvlSCnf680C4V4x9ABxx4wiP+DdXCcgGV1hZ7f5kncVKbiufOZ83zuCUB
         aeJw==
X-Gm-Message-State: AOAM531WbDIXRq61PGyPyuTlKC+eKKVoLeK5Q5NX73hewDfDPw8BzFne
        CXXaoM5k1cLe2ox0f/jp5LqoI8oi5hUvT9yN7QY=
X-Google-Smtp-Source: ABdhPJzWF6lggy6ZjS9W679GnSz3nbp5HQVgmRLVQPYB4e0xbFIlWzErdfWGD1FtBLIOaYWtbPQI6pz6bYlOOajqhig=
X-Received: by 2002:a17:903:2301:: with SMTP id d1mr25102611plh.26.1643706574466;
 Tue, 01 Feb 2022 01:09:34 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrselodieantonie778@yahoo.com
Sender: marianmichel236@gmail.com
Received: by 2002:a05:6a20:448b:b0:70:f80a:8033 with HTTP; Tue, 1 Feb 2022
 01:09:33 -0800 (PST)
From:   Mrs Elodie Antoine <mrselodieantoinea@gmail.com>
Date:   Tue, 1 Feb 2022 01:09:33 -0800
X-Google-Sender-Auth: 7iN3l7ODNLN5cfbFbnkGR-Vn3oU
Message-ID: <CAOJar2KvCLJoR-jNJotLt6_1-g2Q03wkq7a-txS3igT5jg9P1Q@mail.gmail.com>
Subject: Happy New Month
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello To Whom It May Concern,

Dear Friend,

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, as my
pastor advised me to reject earthly reward and thanks by handing the
project to someone I have never seen or met for a greater reward in
heaven waits for whoever can give such a costly donation. I came
across your E-mail from my personal search, and I decided to email you
directly believing that you will be honest to fulfill my final wish
before or after my death.


 Meanwhile, I am Madam Elodie Antoine, 69 years, am from Israel, still
childless. I am suffering from Adenocarcinoma Cancer of the lungs for
the past 8 years and from all indication my condition is really
deteriorating as my doctors have confirmed and courageously advised me
that I may not live beyond 5 weeks from now for the reason that my
tumor has reached a critical stage which has defiled all forms of
medical treatment.


Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time vow to donate to the underprivileged the sum of (US$4.5
Million Dollars) I deposited in my bank over 8 years now because I
have tried to handle this project
by myself but I have seen that my health could not allow me to do so
anymore. My promise for the poor includes building of well-equipped
charity foundation hospital and a technical school for their survival.


If you will be honest, kind and willing to assist me handle this
charity project as I=E2=80=99ve mentioned here, I will like you to Contact =
me
through this email address.

Best Regards!
Mrs. Elodie Antoine
