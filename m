Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD2524AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbiELKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347401AbiELKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:54:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9F5DD07;
        Thu, 12 May 2022 03:54:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so9498187ejb.0;
        Thu, 12 May 2022 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saIXIgLCPDIyYjz9lRSB2RkGl170e531NzygSMa6KRo=;
        b=ohw4R9Eg0c2ItbfYTsoSCNIzcYvrRzOml2pKWEQaAB4ocJSt0I8jBEz2xw6tSOU2CG
         hh3DP8+mQs0TdYnI7eErVcX66oWFzSAVgPT3ekolBdecacsvIww7msvYLh2K7F4kyEE3
         vTqzPB6lX4MXk7bbBc/bz6b1YPiFKsgk+4S//6wkJBKY1GAuBesTOVDTgH2QdK0Vz25w
         ASPYe45vQr05a1VolDYvZf8IRUflA5UZ3aJRR2SiPQgUHA4hfgT8wTEDlBtZa+hjgdR3
         QxYNc5LhO4w8r2e+XKplRSfLt4Is+jWJuEd7ZpnnjpQM1a0P2COUml31sM/Guy16eFjR
         kNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saIXIgLCPDIyYjz9lRSB2RkGl170e531NzygSMa6KRo=;
        b=jDR9mqMyKe8cPzPL8PQ9EAKi66FRO7TBvHK9k58UK11kAr+odr6+WSnVP9oYy235/G
         BX0aGzXyIv5H20JDauwMBJL1S7woQ+wGvZ43Elb4hCbGFI0UvdSranpxeiTXwHjRLasW
         +uH5cpzCqEvVxAqH4n4JWtxskQs0qwIyTsTu7Kibg6mfBv+i0C8wIY+1zcSz2ggGCuXu
         D6F1W+kukkbsVxe2GYFdN5334J82fOqaJKYQgWyddn4jQy7o1bjkOShi/EhGeQYlH/tu
         4rr1E1YrlnawpROaqE/dQM/d6qnjlY/Dhz0sjUBsRzokk/m8xoKQige1QcU5BlgF3oJh
         Ri3Q==
X-Gm-Message-State: AOAM533gijoFvmj638Dv9WKcpDQVetdj2eGUl7ZT62tbSBXMwNwwIlal
        G9i0HQHk1mypaQLBqekTMcmotNIUofIkQEyYcNE=
X-Google-Smtp-Source: ABdhPJx1lLArqdjQJqGvhsRJUpI4KPvwCeQobzGn4twNX1r2i4axTm2gv4b7doAu7EwTllKGCeOASI58WuVd4uwVUgE=
X-Received: by 2002:a17:907:1b19:b0:6f0:1022:1430 with SMTP id
 mp25-20020a1709071b1900b006f010221430mr30146117ejc.13.1652352845214; Thu, 12
 May 2022 03:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220506232850.220582-1-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20220506232850.220582-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 12 May 2022 12:53:54 +0200
Message-ID: <CAFBinCDdBzHNzP2WiFke3E-ReTbNO34Tm-8kSV7QO_y8s_VjQQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-meson: Fix email address in MODULE_AUTHOR
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 1:29 AM Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
>
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>
> Ben Dooks's email address is <ben.dooks@codethink.co.uk>.
> Fix Ben Dooks's email address in MODULE_AUTHOR.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
