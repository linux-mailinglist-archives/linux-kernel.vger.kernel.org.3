Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18855A96E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiIAMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIAM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:29:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE312854B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:29:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x23so16936435pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=aBsoS0QuUIR4yp4rLOJVkfypVxrX3Q3pjq4+QsYnonc=;
        b=fp+Bg01x33ywOQVFcAISjLwJXZDzRVIyAmYhnbHDBrmm0veX1QWtKRdfLoA4c5Pc2+
         rQw4uMAbpUI0MOaR9QKHhrqAzKdBjm2gVNYVcBrY53FcS7bTtGbO2HdWue5Li9Ki9lu1
         Gv/OmF/OV3hrqe/j+2QdJZ6QFyo7YPRRS5KjWVdxeTSFwu2MQmc5p8X30LgrJpOVFi8Y
         eAPKfezjI6uEtcHpPdE1lzv7GK22j33adpJ4s+i/2ilvYOpA5vLKk3L+xqPSLQdvd+29
         CUM1nNQwIf0Ej5pgQzFEIikwi9zUVeC8hSVpByHh0QyCte+lmU7PM7bUSthmoaPMOyGt
         kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aBsoS0QuUIR4yp4rLOJVkfypVxrX3Q3pjq4+QsYnonc=;
        b=uthI+q/nBHzt9Ynn5KMCUHSZFVbpDDIXRmgWIlPxBgSIhHutMcftXpWdDGszjNlqoW
         KnIYDB0UUmScdTatTFrglRKac2WK63bWJ6T8KiqbHx7jdHh6Q3100lTF3HOE3M8KWNE1
         8/cJ2hbINuHgEStocvnMfokZFppGAHvdcTQ0+0zTBRwtE6WWWO6IskZGDO2pYlfjy0jL
         WGX9GX7aezh8p0Tk57hunEGegUS1IaVy6WxxWCToih6l4uB+SEYz4NUAnFmS5xgnDspo
         Ooz8fLhhuv9n6rdSjpWkflQLk3lhOdhWLmFZrEdxicfwfzJi3FoPtSjCwid81pIr4m50
         9dWw==
X-Gm-Message-State: ACgBeo36zRH3ItkVaK8bewAkInEypQoBNjtwNacsjBAJuamCFJPSOP2n
        Sh5UV/PVfqUgfnayLdN8NuRrclBGBSbww/w1+80=
X-Google-Smtp-Source: AA6agR6bBqmKKs2nJfeCB9YXSK2+F/KGsQ3W+U1pnrVHUuk+KBX3PzmSdvLyKRGPXLyb+uowOU0fV+L7letPYYEqiT8=
X-Received: by 2002:a17:902:ebd2:b0:172:8eee:80f5 with SMTP id
 p18-20020a170902ebd200b001728eee80f5mr30754959plg.9.1662035350723; Thu, 01
 Sep 2022 05:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:4b08:b0:2d6:ebbb:dd20 with HTTP; Thu, 1 Sep 2022
 05:29:10 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Thu, 1 Sep 2022 12:29:10 +0000
Message-ID: <CAAnwc9sTj0r6wJxKNggoFGKBf6T2rxN8yDKqpJfGKbzP43YPJQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman358[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman358[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15TXmdeZLCDXp9eZ15HXnNeqINeQ16og15TXnteZ15nXnCDXlNen15XXk9edINep15zXmT8NCg0K
15TXmdeZISDXkdeV15Ag16DXm9eZ16gg15DXl9eTINeQ16og15TXqdeg15kNCteQ16DXmSDXkNeX
15vXlA0K157Xmdep15wNCg==
