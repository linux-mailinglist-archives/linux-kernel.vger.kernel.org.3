Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83645836ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiG1Cch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiG1Ccd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:32:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0881C901
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:32:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so886107lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=JaYppaBYvyfdmz1MNr/HK3KvWm9Sz+t/YuEOuPFu2OqjCyYQemk8TTaIhD7w0V+Qwh
         mpEk5a71C+P6aWgpwNqPV3GYnDJsUqXoMekAAXm0HABUDlt4Y5lsaKG/JCQB9QPfU+4x
         XICxS8dO5M7eAtAnktXGKksLDJ68WPet/1Qgy4G3qjtDgbtdo6QSdRC01xUCd2GQfuFa
         21JyIa7jI6+MYXsMaijiqQt4zpNMnduA7cYi+x4mwH2pF3JdD9Q32HBy4XLt3nsrNIJy
         kOYmtCwMFtJtCZqpCOSX8jHQbkQ78YHf+7b/zVc3Zjc4E1JqmbDqU/FMD+bdzLJL5DBR
         xG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=1MKMbjaHUM8H/5pgGlfXBnkY+64RFR0sa0198s1T1zw7suSOvzgTbBDzFYTjTL+cOF
         pkGcwvEHTuW69MiinMGp+qzGwjZITpi3MMB7L7R3yz4/jO8NYH4IfOyRsx63VkLQpPRG
         10NwSLU5VhrF7dXT9ypw9zS6WKXp/k+iBp1D8A02Tvm06YsiwfAu6bRkxjPlorrjaKSV
         w/6OxgQN0juZMgbhX6za3mGl8tVz8ZLBRDlGkoAH6KeuJfK3Zy3219ymUhhj9M0KsLEV
         kkYWAcGHgP4m4FQJYxYb7G74BmikwT+5NROUJKNyE40fzUmDAnbQnXVOQTmI1oo7wB0d
         g4BQ==
X-Gm-Message-State: AJIora+zUTegOVaKzCdunomDlZYXm8xkAc2X3CKUrShX2E2ZESDdTW+o
        jVGQvWZOalCp4i52XMyGj+SuD9DR2vvojCZTdRQ=
X-Google-Smtp-Source: AGRyM1vtAZkIDHO+C1Mp4SQzIV9nIO1IXCu/+FniG9e/EuX/gIsuq9pdAB8I+Ja8/rwQGvj/fHwM07zwvYp7QuPCQtY=
X-Received: by 2002:ac2:5f6f:0:b0:48a:be19:8be8 with SMTP id
 c15-20020ac25f6f000000b0048abe198be8mr1709533lfc.595.1658975550594; Wed, 27
 Jul 2022 19:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:9ce:b0:1d7:f59e:4751 with HTTP; Wed, 27 Jul 2022
 19:32:30 -0700 (PDT)
Reply-To: drlisa985@gmail.com
From:   Lisa <hwaldean@gmail.com>
Date:   Thu, 28 Jul 2022 04:32:30 +0200
Message-ID: <CAGpHGUFzWiTrMcvdDV+OZy0C0i8SEH5aayChcUbAbpFNVrYXDA@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa
