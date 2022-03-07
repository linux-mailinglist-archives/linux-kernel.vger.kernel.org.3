Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B04D013E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbiCGOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243193AbiCGOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:30:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A578929;
        Mon,  7 Mar 2022 06:29:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id x15so23565894wru.13;
        Mon, 07 Mar 2022 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=/TXRHh9thNzMbXH1B0crHzkh5AlR+CozJDtm1yFjNvk=;
        b=WbKiUsFtPKRxG1odhq97KLE8Do3BrsuC9dB1k1mqBvfgmS2gYIh/PYJv+PaH/y6hCw
         CZSIl84GNrGeoFlY4lqrcGJBbvCCL60LdA1JtwO/IMQGmA+Xn07lip+4uTPrjgWrUAEs
         iOP/ATvg/Xtyyf+rdOcWI2kmVhWDsV3s+FJpMXq3HoYOuqC14tVouEsJw/wmMeKJfr1a
         la3hwVXiNAccnRGE3uHWgQKaxPa9VytROTtpyshNFa1Mv6eH0i7eFC7BycIv33INQZHB
         pv2L0hooySVgMvMDd3+chWOgQxEmXl9W6VawPCbW99wLXQ6GYxkUq9RbbBFkeFYylSbE
         /l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=/TXRHh9thNzMbXH1B0crHzkh5AlR+CozJDtm1yFjNvk=;
        b=Zzpa9dUytK/VNccnL9ZUK6CDPto5Onsc4vD0T6jsgiLvqjkWs4q0uH2h9XCIV9K1eq
         zYUl06WHR7gTP2mgU2QRx78j6P3iBGo6SL4YDy69d2bukMgf56j25ICrQwHns2NFYrYO
         ACkxfK3lxb4Jji/p6h8AL6Y9/ZoyVhzpl1XfVN8sPxKL9bs2b3aSQ66PPDYIGK7YxH9n
         Ek7fsqcYAjC36AwRG9caM2LTdeM0s4dWnmyPcQwmTPbstpnTUdTOq8k9a4e2sqvhxV3p
         i1jCYBWAozh6I1GpiqdmEavx9Ovw1JK06CMz890Be+19NSRfXZCOg7U+PWVw5PN6jUGd
         ro/w==
X-Gm-Message-State: AOAM5320xjDuiuUYsrvsCyosWuhQeVZ5nYuZC0xNluH/dH2ULBlP4Kj5
        7wfv0/G7ViGh1WIOgvRUVMs=
X-Google-Smtp-Source: ABdhPJy3+xTfGDxFBg5hIBTiFsZG/2EuzVeZVyJp2dCcLfl9UNbVvX/2OGEj2PVJqN6dqPrYX1htXg==
X-Received: by 2002:a05:6000:1683:b0:1f1:eb7c:be70 with SMTP id y3-20020a056000168300b001f1eb7cbe70mr5142898wrd.129.1646663397366;
        Mon, 07 Mar 2022 06:29:57 -0800 (PST)
Received: from [192.168.0.101] ([196.28.249.26])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d698c000000b001f1d8bb4618sm12984175wru.36.2022.03.07.06.29.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Mar 2022 06:29:56 -0800 (PST)
Message-ID: <622616e4.1c69fb81.5f507.21b5@mx.google.com>
Sender: Elena Tudorie <coca1colaaward01@gmail.com>
From:   Elena Tudorie <elenatudorie987@gmail.com>
X-Google-Original-From: "Elena Tudorie" <sa2020bah1@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Dear Belove,
To:     Recipients <sa2020bah1@gmail.com>
Date:   Mon, 07 Mar 2022 06:29:51 -0800
Reply-To: elenatudorie987@gmail.com
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply this =
message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
