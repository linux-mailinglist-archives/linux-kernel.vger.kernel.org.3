Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C31503653
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiDPL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiDPL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:28:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E33E0DF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 04:26:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t12so8928078pll.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6vYx3JbvVsiL3zhGAbJQC+kPjCGgnDC5DdXmocu9kt0=;
        b=dH4aJFzB9ro6Cl+9XwLsCtQxoV3IQGnT0s82AN75oFdl9SN5zOB69/ZIheBuZHMEv5
         oihfoeNKTmB2QwEJZ/Q2Kos+4cLgsq6WMAA4uS/F4SKazM9iAnVYqOSnxEiI9NgdMLfN
         3yjdYDBxDUsAwhWrOa4qRsAuV/X8gLH7wcazohZgvhy7hjzcdSoxPLvaZmuUmjJqAxH3
         YmZmt1hiNULim1yBjRmaK7m7EOnxvTlnl6rVog5FJ0G3Lup4LeT+nDC+OhOZ3EwRMHs1
         dp+lUxY01BsOwj+/8x7TNYcTMTNuW9PUdX+y/2mi92acDyuqAr83XtZnaazUmEDYv227
         eBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=6vYx3JbvVsiL3zhGAbJQC+kPjCGgnDC5DdXmocu9kt0=;
        b=eliN9MUQKZ1dLn+pzDhBIH4Y2KOMzfVo0gYCYMKJiFHqVYuv9UWMhsnMM7KEVyMzV0
         C00hCIe52pzD1LVd5EAkZgDvaBd/PAWigCg9jJ77idYhgktxoaCJqqUSP0wlTNoFsuxk
         HeNu4mQn5nIHMehpGG8/vL5dghGbRsZaH6yyzbEmwM5mHgh254+ULfgdjDGLDBCwV9vh
         1nISLe3Y8MFRIWDfJ8SLK0G9pcMfenLsq9KBaSLKH7bHM4Z/Hod4wioUbpD43fzmCH0+
         drZzS85Jtrt+2ibaB0oNaaaH8FBqMSeIwF4yp/8hNbpdhf0IKDImWEkM9FeI7nS9rZXE
         j64Q==
X-Gm-Message-State: AOAM533ktaEspfqzK1QHnLFONWvz2c7J/highwaXAe2F+X+FnfUoKU3P
        Bx24mJ8DUrVDKlKepnndVQSWQp5W07kL+Jh5pjg=
X-Google-Smtp-Source: ABdhPJwYG9iEgrQ+chAVcPtD6ht7kr0qDjIBHCIa/Bq8gZXZbKTieiJnfB3Wp/yu61FpXLUxQyPtjJHgs+V2qliXzT4=
X-Received: by 2002:a17:902:f64c:b0:156:4349:7e9b with SMTP id
 m12-20020a170902f64c00b0015643497e9bmr3062845plg.139.1650108382228; Sat, 16
 Apr 2022 04:26:22 -0700 (PDT)
MIME-Version: 1.0
Sender: barrlucasnubueke2@gmail.com
Received: by 2002:a05:6a10:43d5:0:0:0:0 with HTTP; Sat, 16 Apr 2022 04:26:21
 -0700 (PDT)
From:   "MR. EDWARD" <edward.esqchambers@gmail.com>
Date:   Sat, 16 Apr 2022 12:26:21 +0100
X-Google-Sender-Auth: ZksK-Fp7LqK_0dWs1Xz5mlo2yN0
Message-ID: <CAHcyid_2Jm6-tzUFMcqhtRzEB=bD3xN701Lh3Jasy8nEicNx6g@mail.gmail.com>
Subject: =?UTF-8?B?VsOhxb5lbsO9IHDFmcOtamVtY2kh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zdrav=C3=ADm V=C3=A1s, kone=C4=8Dn=C4=9B z=C3=ADsk=C3=A1m d=C4=9Bdick=C3=BD=
 fond s pomoc=C3=AD nov=C3=A9ho partnera.
Mezit=C3=ADm nemohu zapomenout na va=C5=A1e minul=C3=A9 =C3=BAsil=C3=AD, ab=
yste mi pomohli
z=C3=ADskat fond, a=C4=8Dkoli jsme v minulosti neusp=C4=9Bli kv=C5=AFli ned=
ostatku d=C5=AFv=C4=9Bry
mezi n=C3=A1mi. Nyn=C3=AD chci, abyste nal=C3=A9hav=C4=9B kontaktoval m=C3=
=A9ho ctihodn=C3=A9ho otce
Solomona na jeho e-mailov=C3=A9 adrese ( rev.christlovesolomon@gmail.com )
Nechal jsem mu v p=C3=A9=C4=8Di o v=C3=A1s =C4=8D=C3=A1stku 800 000 $, tak=
=C5=BEe ho kontaktujte a
dejte mu pokyn, aby v=C3=A1m p=C5=99evedl celou =C4=8D=C3=A1stku.

Pane Edwarde
