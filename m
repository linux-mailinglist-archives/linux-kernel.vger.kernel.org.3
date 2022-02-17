Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDA4BA9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiBQT0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:26:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBQTZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:25:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939CF94D9;
        Thu, 17 Feb 2022 11:25:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k1so10738436wrd.8;
        Thu, 17 Feb 2022 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=vpeOpUmYauWXGuEm2yDZ6mEq6Fn4zT9iz/EbJmMvRdI=;
        b=QXJ33i6XEuC+UWCK+Rz8HgvqSeXVVysv8CBBeq1C9fy8U5pzO/7Rqv1alz8Z4p3Xko
         pg5GVFce/WjS+22rcCL6uF+0E7ERhRpeXmmKgMbMQ1Efku+0KcktXet9IEVNCfiWIJHg
         kl0fV4UsYRL1s0YeAI9EM+OYpEbK6QSZBUahxQxObezZdaluZoUxrjuOnVyF1XEIg92H
         1YgsSHoJTvjL7h7tSpDJ7BzzBe5S+P8klSZWdKMcSBCYxQlCJO4z2wqs6sgMpEBnk/f3
         oS81rRveKKSPtEM4pHmgbvQ8/0/68kenU7lf13VMbKgHAuSfy9sXoXa15345IseqImaE
         nxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=vpeOpUmYauWXGuEm2yDZ6mEq6Fn4zT9iz/EbJmMvRdI=;
        b=G9sc9kqexM6U9zjEiOpECvEeVivRYHOh10Y8cgCT6eH5tH82qeul4FXHSBlEiHRU0W
         4QhntrSU5gzBVEx9ZUc6JfWffQcj1AlTACZ1dqQBOAk4oPBd2qLQ2CqJKaRg9SmDWKlT
         B1VMySCRMmAet1+ZkdSiApOA9g9pnaPniw3iacluOioG7zQSb9HJNRpt5m0cmP+sok5L
         2Hp2FW9tDRQ6Qo60MNm4WWCWUKODUG5/jWar1KXcCSkO8L90wRnzR9jZDeUHeEQD+1pQ
         XbVgsiEkuzvQkBay0InYw4wGFajiDuK3LdMTyGh62+X73XNoR8wxhttvzrXW+CFhu+p0
         /IVQ==
X-Gm-Message-State: AOAM5323J8rx5uf822FiDyGhLPQ1UVYN/6xBrH1feDK+DCxyglQraF5e
        A1Th3ZxJA6xePXgmq1CxIBE=
X-Google-Smtp-Source: ABdhPJwbqE4cx0c5KpgaTM9sSn4ZwirWZT26tUsFh8BtEaOKYlDbwMQGzGlwob7WwuiEMsSMLE29XQ==
X-Received: by 2002:adf:e705:0:b0:1e3:14aa:db8d with SMTP id c5-20020adfe705000000b001e314aadb8dmr3348545wrm.398.1645125942305;
        Thu, 17 Feb 2022 11:25:42 -0800 (PST)
Received: from [192.168.0.174] ([102.165.193.42])
        by smtp.gmail.com with ESMTPSA id u15sm46363485wrs.18.2022.02.17.11.25.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 17 Feb 2022 11:25:39 -0800 (PST)
Message-ID: <620ea133.1c69fb81.d2384.437c@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Donation / Darowizna 
To:     Recipients <trustloanhome@gmail.com>
From:   "Michael J Weirsky" <trustloanhome@gmail.com>
Date:   Thu, 17 Feb 2022 21:25:25 +0200
Reply-To: michjisky@aol.com
X-Antivirus: Avast (VPS 220217-6, 2/17/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,XFER_LOTSA_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wszystkiego najlepszego w Nowym Roku!

Nazywam sie Michael J. Weirsky, bezrobotna zlota raczka, zwyciezca jackpota=
 w wysokosci 273 milion=F3w dolar=F3w w dniu 8 marca 2019 r. Zglosilem sie =
na ochotnika, aby przekazac ci kwote 1 000 000,00 dolar=F3w, aby pom=F3c w =
tej pandemii. Skontaktuj sie ze mna przez e-mail: michjisky@aol.com w celu =
uzyskania informacji/roszczenia, jesli jestes zainteresowany.

Z powazaniem,
Michael J. Weirsky.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Happy New Year!

I am by name Michael J. Weirsky, an Unemployed Handyman, winner of a $273 M=
illion Jackpot on March 8, 2019. I have volunteered to donate the sum of $1=
,000.000.00 to you, to help with this pandemic. Contact me via Email: michj=
isky@aol.com for info/claim if Interested.

Sincerely,
Michael J Weirsky.

-- 
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

