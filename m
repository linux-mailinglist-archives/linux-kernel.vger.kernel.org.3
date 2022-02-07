Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24064ABEFA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448203AbiBGNKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442611AbiBGMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:21:21 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2927C1DC412
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:10:15 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 124so38580094ybw.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=806FJbDP/S2NVXq8uQXDKdguPxE5bdTnhJek5kYqWRM=;
        b=FD5SorW3R0vOATRkMZvF33typQtD3JHLRfxlSFjBbXrFlTu/0dpjvVr5ZT3R9dNiVr
         1qFy3Nt6fQd9utC+TqSf+Enefpzf8C/J6SUR4VwOPMSM0LRIPq3qD0fBzekupI15vb8R
         w3Q+rNGBeNXHlMF6SSCNrESxOp0km/hS/n365vE0My2DtzEcwu4cdAfr555WIf01AsGj
         KFZyRK+u1i40NeBEmHQl2D67XiXV6+pTgWl0Ndbi3inXh4+Q6+3/g+md1Ys/4lEhK7+Z
         xPvDdeamRZBMg7prS8M/fXliBWNe/ITJo6GCCnIbtzJhOGdgcwFQPCv9Z0Q4ausy1cT/
         lgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=806FJbDP/S2NVXq8uQXDKdguPxE5bdTnhJek5kYqWRM=;
        b=lebiTDnkwrZixij6VM4c6421wWQLRTiE0F2MsCyq7mTTnZxy76dY8nAS86cdkbCpnL
         I8yj1YYWkjMZpTFMeccFNkijSgOptXebXPgaIHvIIFJ/a5QUNkyKmTW3N03yfkhBit37
         J4p9gwaHirUF5aRXmqad6mAZrh5wd5a/3z0Jd/L4pARg17pBzWlqjT9ki1MkVMDfqN8D
         wN3TxPM/BZ4qnjiPgphhXo3F5vWq4ps2oSI/j7eBSoB1tIM1sdxbcRiBXgVmUYF9ZM1o
         RhqRVJJMrk4T6zVCCfjXy0hvbTW+xvBkw0xk3jw7XRFu46D4llv54sk5y75+JuJanEXk
         TL9w==
X-Gm-Message-State: AOAM530UknOEYIX2hEzahfqD0nwupwOlpGpH15ljNVjfgigHmsTQcGec
        77D8Jtj13qW6oT2WDw8ZfiivLXpHVEJ8IUHJ9QY=
X-Google-Smtp-Source: ABdhPJzpuqlAykv/viS0p1a4liEVmliaqg6XJUfNWH/N7fw+OZNoXDrTLjMvuPW50tWEHsIrqoerxv32OLL6H5/SmCA=
X-Received: by 2002:a81:8d0c:: with SMTP id d12mr11340153ywg.33.1644235815088;
 Mon, 07 Feb 2022 04:10:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:148b:0:0:0:0 with HTTP; Mon, 7 Feb 2022 04:10:14
 -0800 (PST)
Reply-To: worldbankinternational002@aol.com
In-Reply-To: <CA+s_q3xdNOA3U28EoAKUnQbasNvu=gUwaSQ7ZEik2Z5CxM6FPA@mail.gmail.com>
References: <CA+s_q3zAastVhqGaQRfJX+yResHB+tD044OoOCZhYCEZwhLdkg@mail.gmail.com>
 <CA+s_q3xkjy982GLujfsRTdpEBY4J6R28wdPsSmasxXkuqMEFCA@mail.gmail.com> <CA+s_q3xdNOA3U28EoAKUnQbasNvu=gUwaSQ7ZEik2Z5CxM6FPA@mail.gmail.com>
From:   Bci bank <oilmakerter2@gmail.com>
Date:   Mon, 7 Feb 2022 12:10:14 +0000
Message-ID: <CA+s_q3x7Ycr34R=2CoRJWhj5vw=pdA32KtA7kUuoCXh__1Hiyw@mail.gmail.com>
Subject: 2022
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4516]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oilmakerter2[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oilmakerter2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [worldbankinternational002[at]aol.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vai sa=C5=86=C4=93m=C4=81t v=C4=93stuli par savu uzvaru, kas pal=C4=ABdz=C4=
=93s jums izmantot j=C5=ABsu
e-pasta adresi 6,500 USD?
1) P=C4=81rskait=C4=ABjums no bankas uz banku.
2) ATM Express pieg=C4=81de.
