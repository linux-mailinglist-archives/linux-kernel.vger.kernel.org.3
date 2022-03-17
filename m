Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE54DC9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiCQP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiCQP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:29:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15C163E05
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:28:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id t11so10869675ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:mime-version:date:message-id:subject:to;
        bh=9YV+XxfN9qvqRlfP0nyAbGHXEabT3Ft7uOsdiJpOEbM=;
        b=lGuslnfBaWMbbTMGXl0suTb8KZvmlrDwASdirV6i7OVpwShU2qRoiyPp28W4jw8i6+
         sIolQqUXb+oxjJknfx6ZW3L8YzRcsS7Ncpsbd5hkiudTFhuFPt2Rtu5XPHWGN0j/wSTU
         WkRK4afrSelXiVXZUA1UwAmi0D/tBK7dxdVterVaiJn4t+hsvQAhifvT4f0p6+E/0acj
         wHYeowkERpl9w4LDmflA+oR+UbsrNzJHhYMNq72Z+N7ZBhGXYoopgpNuLHuz2+B4YGxk
         USpQwVvfwnptyrXw0Th+mWgasxZU4J3WWpjy0CbqoyZU6XADd4Uc7kEdKPIkCYbgd4cR
         OtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to;
        bh=9YV+XxfN9qvqRlfP0nyAbGHXEabT3Ft7uOsdiJpOEbM=;
        b=aF1MmHJX/i4qimVuxew2ozWgdkEWvHwohVxHiw3aTlZnHEelrdxQDDv7vBEOY7f6M2
         z4Eghu6YfCS7WODYPXHSlrzd/K2qj+YfemGBnr/e9VKtMJMW2pixZA7uvF3UZljS2Pe/
         nG51t6lPdhy/F+MvifWbGGc0mDpoSJOHK0qtgaN9fQVNSZTkqyfdcj+FDhmX4iIibZdZ
         cpHrenGhf+N2ukBO4og183/sqJ1JhOxD3XT0TkHkAiafKTfK1y3uAnmwJ+5DfX1kezen
         x+7owarX8DEbXTMs3XhW2xtixCFswKAcvbBMddAf+VUGD+6IuLBYJQaZ41ppXihkQbKw
         BZQA==
X-Gm-Message-State: AOAM532P/cc3j0eFIEviFD9grUSxzzxQWblK1MSWvoLPh+n0R2uoTZvm
        5sSTaeTdNAqMw6McKju1B0syD3/UselOArZv5mNj+YiaRF4=
X-Google-Smtp-Source: ABdhPJwzN+qhuY6d1e8nPNKMtQ9MzYuQcyUBpOvfUX9WKFVHc8aIN5GsdYsQImC70dCMd/R5wf/87fMKAeIL9Ob6lug=
X-Received: by 2002:a25:6c03:0:b0:62c:2c43:cd29 with SMTP id
 h3-20020a256c03000000b0062c2c43cd29mr5518882ybc.478.1647530900946; Thu, 17
 Mar 2022 08:28:20 -0700 (PDT)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 08:28:20 -0700
From:   Scott Anderson <karban002@gmail.com>
Mime-Version: 1.0
Date:   Thu, 17 Mar 2022 08:28:20 -0700
Message-ID: <CAGcbcMABWeNFFTr4rLs1CqhhrNuKV8bVB9L2qcqCFuJAO2b4pA@mail.gmail.com>
Subject: Banners Order
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Good Day,
     My name is Scott Anderson and i am sending this email to your
business in regards to the order for some Banners and the sizes that i
am looking for are :

1. Measures 30 x 60 inches
2. One sided on Vinyl
3. Full copies Black Ink on White vinyl
4. I want you to write on the Banner ( DON'T MISS YOUR SHOT TO STOP
COVID-19 ) For the Artwork.
5. Hemmed With 4 grommet for outdoor use

I would like you to email me back with the total pick up price plus
tax on the quantity of 150 copies , excluding shipping. Is there a
surcharge on the use of Visa or MasterCard for payment ?Kindly respond
to me as soon as possible for us to proceed further with the order..

Urgently Waiting to hear from you soon.
Scott
