Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22284D70D5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiCLU1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCLU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:27:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9EF1D67FF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:26:17 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so16623983ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=6vzIbjKqZ45U+1eU3xnvvtAJS9airowoXo10bHb4aLk=;
        b=nNRBjWPMkjPz4KnhdWbdcmq7iF9hHcfkXj+w0MlO1XO2gjkuESb3XozdfmLR6UPsAv
         wY+tJpYDUTQ8GyZVdq8n1hY/G+wnK+vlXDOwVSSNQSgKrn8Juk0iQaChXoxxBLhMHTRq
         aKyieTLoU3DLeSPYuYLHq5n57liHkhubTYpGCPmkRRega5fBAp3fsQ6kBOllaBCrs2xn
         yvDgABS2gwpgov8YMx+lf45qmHjDjCX9DirANM9XeV/4I/escH8Ym/IxF6SKIdAe61KQ
         xS47YxogwwWvlIXTucAx0AlVfjbYqv9PYd2MGdsU+R/3a4uKRjqTQ0/d3C+WBzAFnIrT
         p7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=6vzIbjKqZ45U+1eU3xnvvtAJS9airowoXo10bHb4aLk=;
        b=a9zUTSLWmwk8mu4GPKR4LNouyuBfBGmQT7HeI1uSTdHycV15Ph7W/KP56mtElCtJVj
         zdULpHeeL9/U+2kE2DsUweWpGlv7YYnKtGmTy/3Mrpr3oZO4+JcQWFUbEj7gn3KAm4el
         CM34cCDhDdxFYDAhLtjl0IQz6GqkXmvXIPEtQK5F42KH34e77KlPIXXXIWvzZbpspjgj
         2MNdhEAWpAxYPqWF7mTex4CIJmFklTLKxR1HR34Ssui5F3xrSXvv4webNyted6+dai8H
         OnwGSyJ9KIJKyL91Awh/CJ7yKABFPBDIoi3MTKrLGds9cjrAhNkNUtGNtbWhzuxwLz7l
         x2oA==
X-Gm-Message-State: AOAM532XaTbdt8QXErdsek4Lt/3HwErvUvEuFor21feWeU3hQbcpCvzR
        9crUgkjfTD8x2jc9p7Dk9uRez/koKNylRQKpyOU=
X-Google-Smtp-Source: ABdhPJxtnxYIIwhbXT2nGaWVqUjDKTiu42T7KIFk0OXF8ONFyNz5a9IudcRY2gRi/VJ1ep9z7CYNFclksFApLLtldRI=
X-Received: by 2002:a2e:7f13:0:b0:247:ef72:9e8b with SMTP id
 a19-20020a2e7f13000000b00247ef729e8bmr9572936ljd.205.1647116775778; Sat, 12
 Mar 2022 12:26:15 -0800 (PST)
MIME-Version: 1.0
Sender: natodtoday@gmail.com
Received: by 2002:aa6:d8cb:0:b0:190:979c:eb76 with HTTP; Sat, 12 Mar 2022
 12:26:15 -0800 (PST)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Sat, 12 Mar 2022 20:26:15 +0000
X-Google-Sender-Auth: BNYrtoSEFGDLabLrtoY3zZcSdGk
Message-ID: <CANfVWTT_tLFufcy=ve4K-zGJ24mnm1t2gwhVr5JBhPPzxCrxpA@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello dear
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $9.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which  am the next of  kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor.I will want you to use the fund to build an orphanage
home in my name there in   country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.
Yours fairly friend,
Mrs Yu. Ging Yunnan
