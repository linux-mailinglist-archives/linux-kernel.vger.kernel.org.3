Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB248A9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiAKIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiAKIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:37:22 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D6BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:37:22 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v123so10432348wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FJS4/5T71szSxuyB4zC+w3VW/dKU2m10Yv1EUUU33j4=;
        b=Y17R7oGS88+gKElXcn7sELwRrn+O+d9lTpiRTNYB39//iiqBR5yzUYSiP8kfxNpRLm
         r4NRjmTDQ2uFidRc3S6qOdVpBTSf1mlN53gKMDPSH0s/CChgu1gY9Lzr3CNvSmg39yrT
         hNoShBCzEQ9BvKmMAsNJboIOmRPUcr46PflLeCC+j3xVALLS2xkwpjXA7vO5m2SPk20S
         4rTxuVkbO6W1xcRFp4YsoqPDVXiuqOy26ilmGZp2at9zRG/h//5R7UPZ02Bs7IO9Lb09
         ppTAWc6b/Jr7tPR/nHnSez7oxs1r5ecZ5g0Lu+9QG9b11lS3qvwnOkXklQg3XMdclwLQ
         sR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=FJS4/5T71szSxuyB4zC+w3VW/dKU2m10Yv1EUUU33j4=;
        b=PiAqMNMbn+lq1dpv2jl0XOdzvGdp4zmV5u2i5X98dCKezpwHGUsnF0nHsXOMDNAsRt
         gRGQb+cYvmdnIYW+a1JZ5O0rgVTxBNXYQiBAMTpx8zx1PMIqxj/kapS3plymU+fQ+tn6
         Z64Vfw9LdTaUVcIXHP41Jbm/w34ihOi0p5Eg+8AVuslLtDQH+1ocZQZMnLPaswusMBRV
         bXmnExRKgRY1EA1q+9dAaNgYFIpMvYlZeEf5s1sGpeW8Dxqr6vibFtk6W+IxDGqdXzK1
         fb966Mi2oY591RbScMGlX3OnGu10OMWa/ZoyJ0CBSD6qAlsWtd5yd3j2SJ7AoqQWVdRN
         dR8Q==
X-Gm-Message-State: AOAM5309cKMJixBQfaWjnn1Ubk7Gnpk4lf/tJgWmouh1OdCNw0t/xtxO
        DT/eT2y59LPWCdrr4KNpMCUE+KkYO2klt9yjmIs=
X-Google-Smtp-Source: ABdhPJwI4IF2nq+G439Y8OiGQthMOnQTswSCLWGNC6XgNOQOLvmCbN64RcyioDYuF0p08aJJxSIRagy21rmU/BcbQMA=
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr1406339wmq.15.1641890240912;
 Tue, 11 Jan 2022 00:37:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:e10b:0:0:0:0:0 with HTTP; Tue, 11 Jan 2022 00:37:20
 -0800 (PST)
Reply-To: mussaomra2017@gmail.com
From:   Mr Omra Musa <mrkabore.mustafer2015@gmail.com>
Date:   Tue, 11 Jan 2022 08:37:20 +0000
Message-ID: <CALQGsjjrKWnzgBD4_7V_k9p6kt=H-Sz9UrSt0drNNMVzEXYcwA@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,


I know this email might come to you as a surprise as first coming from
one you haven=E2=80=99t met with before.

I am Mr. Omra Musa, the bank manager with ADB bank of Burkina Faso,and
a personal banker of Dr.Mohamed Farouk Ibrahim, an Egyptian who
happened to be a medical contractor attached to the overthrown Afghan
government by the Taliban government.

Dr.Mohamed Farouk Ibrahim deposits some sum of ($15) million USD with
our bank but he was died by car accidents with his family while trying
to leave from Kandahar.

The said sum can be used for an investment if you are interested.
Details relating to the funds are in my position and will present you
as the Next-of-Kin because there was none, and I shall furnish you
with more detail once i hear your response.

Regards,
Mr. Omra Musa


you can reply to my private email address at mussaomra2017@gmail.com
