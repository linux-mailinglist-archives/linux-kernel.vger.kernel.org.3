Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E04BDFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbiBULlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:41:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356540AbiBULlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:41:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B11ADA8;
        Mon, 21 Feb 2022 03:40:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id om7so14915366pjb.5;
        Mon, 21 Feb 2022 03:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=4wQBSPvi7N25ODHOjZLWf5KVQ01MEhO2kZORDI74c8A=;
        b=fXrLtAtRyb9F2Nxz5iK+QRHUbz4vUyeJy8Ha0L/o9FQBMnOFFskfwibPQOfOCIUikG
         ORnoBzJ5BzRbP2GAepXT372d8HvwxmbWDTYy3dt5JBHIK+W0592TFjMtPHNUT0qRY0BQ
         dytkclGbW9sQ/GJAkqID+MYspeEvkvBawx8qYGeXYu4dCu/h1H8N/sh6GNofP/hQzg24
         ogB7RBjO41KNNxaCUSDS91UJc1eIYJG3oKyarNZRgxz7ptHqzuqmcqCVpDeD2qPXbj8I
         PgwjlELaMX/p9OgpAaZPEjVzSZZ7pVaGkhuwuthoaxx653co1NCn4uv4PjPezkYEutF3
         5OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=4wQBSPvi7N25ODHOjZLWf5KVQ01MEhO2kZORDI74c8A=;
        b=0ZDqoa2882mAqTSKMEg9YRE9tXXVEAKyy8wJqPDUZWlp/WDCngbe0TZlppf08kYR0m
         zwIdjOKdkfdOSwiko5x2V3/OvZIAYYEg6cFmymEMd7Q2Hk6akPUK/I29+yfE8DPWuPTG
         SPliJGV6OE897RuKQh2W6lE9W1bTigAvh/59Z1DeettdOMY1Vnqya3NO0N59Tm7DxhcP
         S7qHXztjZthgHBek+SraFn+dCZxxEJUXoT2/v47iVO7Tc7maimvjMkogwH23rgPdEtgx
         CbzyNyal/HOIqckCBl60gdepneJbMAVEA3iy6ZSQiCKP/DSl5NfDooSUKAD0EzJUsUgI
         U/dA==
X-Gm-Message-State: AOAM530X6GqDfdauD474WKQEIz5PhWHm3vYNZz0bSd1Yjn1F1Ueg5oxg
        4ScyITFP/1A6zywONbV6eQ==
X-Google-Smtp-Source: ABdhPJzIRl0FmzK0rb3FW3wG0los/N0fHHBx+aYbvrw2oak9PfH6GK+jYM9i701SCrwBombMRsjkPA==
X-Received: by 2002:a17:90b:390d:b0:1b9:c042:3b30 with SMTP id ob13-20020a17090b390d00b001b9c0423b30mr25466288pjb.195.1645443655236;
        Mon, 21 Feb 2022 03:40:55 -0800 (PST)
Received: from moneymaker.zsa2gmznryouldwsfy1zyhbdib.lx.internal.cloudapp.net ([20.210.88.162])
        by smtp.gmail.com with ESMTPSA id b6sm13145380pfv.5.2022.02.21.03.40.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Feb 2022 03:40:54 -0800 (PST)
Message-ID: <62137a46.1c69fb81.1667d.4b85@mx.google.com>
From:   "Mr.Thomas Cook" <keenanhagberg1245@gmail.com>
X-Google-Original-From: "Mr.Thomas Cook" <info@ex-wifi.jp>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: INQUIRY
To:     Recipients <info@ex-wifi.jp>
Date:   Mon, 21 Feb 2022 11:40:50 +0000
Reply-To: thomascook2780@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello =


We are all relocating to your city from Newark  on 2nd March 2022.  expecti=
ng a baby on the way, My husband will be coming there in your city  to work=
 on contract basis work Well we believe you can do the cleaning for us anyw=
ay.we just rented  a 2 bedroom apartment in your city please send me your a=
ddress to see if you office is close to the apartment. Can you reply with c=
ost deep cleaning of the 2 bed apartment.

We just want everywhere before we get to the apartment
=09
