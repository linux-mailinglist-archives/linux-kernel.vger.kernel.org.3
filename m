Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31C34C37E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiBXVd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiBXVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:33:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C931AAA4C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:33:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s13so1625298wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=iRz1SNlktwbO8i/K3DLoFeUMp1LybWqs1SseCpHkvV/zByQ6x6Fl82hpHDjtDE+kVX
         nxNCtkgJNxiPpcD5p7puMM3cX5vPBRP+waC7RjtgzKApdHzMzMz7DWFLDCzGbqqiFK7j
         LFdOzLxWP8TCreX4zdpDqVI4LM3n9q8ksI6nOMJgriBMCNEBbw3vhLRQQPcjPrp0Gw0k
         3L6ArBKl9C4AkzjOdilfFmmZeP1Kqm49QWVFSdTrH4T2w22jVjiaTwBDC/h38dUxYzFZ
         lP0K4h1rjKBmw7wiAUSfQuWCyc0r31qsz3bTKV3yzQ3lQ0sH4Iej0NyxLRRVV5miGOYC
         G/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=OLW5GYPFR8ur4LW0c+nW73sYlkPJmo80oOkWaPbMHCroNLi1dTj3Ag2B2YgjOe3LRS
         MWy0NOH1dBeEFBalPM2ATr1h6+HzrP4E0HgdBTw+is8sILwDz9ktxVfo7WGyrftqB+8b
         gTTh489p3gVm3YooIP1PDrEQvb/cyHdbHVcTo7Zxa0XPyliNcx3SOsK2k4YfMFgdknsY
         O26cmWQljUUzxpSjLhi0gNJOuYIrtAukL6J9GUu64ftPdV7cd8uJzONdvZSSkzfd+81/
         dWL4wLXCxYqnFRpYZTg1MQq1lUHwwzeM8mWNB5TIntKiAKK7ZiBsR/pZuGl73DaF+qKF
         zl+w==
X-Gm-Message-State: AOAM531ZY7L+PUkOEA0GzYKPN0o7JO2tGwjrZvHWea5rqAuY4OixKsVN
        BvIVsdD1tcqRwZL8+El0pug=
X-Google-Smtp-Source: ABdhPJxrLMiVSHUVrrkMKKednLTPE/rvKbiROq8oviSsQ3MOimIcjdv+iYqJccOojoxsYI/0FwQdtg==
X-Received: by 2002:adf:f2c9:0:b0:1e3:1cfa:551a with SMTP id d9-20020adff2c9000000b001e31cfa551amr3835254wrp.603.1645738403473;
        Thu, 24 Feb 2022 13:33:23 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id s189-20020a1ca9c6000000b0037ee648fbc4sm494954wme.45.2022.02.24.13.33.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 24 Feb 2022 13:33:21 -0800 (PST)
Message-ID: <6217f9a1.1c69fb81.51bd8.2299@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <ryanethan81@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Fri, 25 Feb 2022 01:33:12 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com
