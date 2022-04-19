Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF8506362
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347870AbiDSEo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239095AbiDSEo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:44:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8B2CE0F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:42:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so30455082ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=NDSVam5jdGtdzGAJ7b660r3vHFIeAkRc0YWQi94C+mPGDahhxAdj/Zwlq9AJOowfPf
         hzJOzI2qjvyumPNvSK8KXAz7gzkrhxw/3uscT/rqc6jk/5B3jQ87gZJuSRpAAuhxgAp8
         O7vLSBaSYwrf511y96rSRYKDQsT3pvmOe/+VoPd7Q1iBq1LcI0xiC5SPxs6whK8ThApe
         sanI8jlBcS2pe8wnGazgC6txfn/nJZJyRtm5sWftyv5ysOVc1OOl9NZZTXxYNnquxGt9
         58nvCA/zc9GPjuy7JyQ8wTzAScrvdbXTGjoEdRLo02blQPHSjexDTa+LsmMmDiO1YCeh
         L7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=3RyInx5avAfrJtvUJKrH2u5x1kTxGgRKgqeYvgNkQ8+GyycVYiB5hM3f9u3RSl/z8N
         afPoDVrVZ9TzK3fHVbO1eR1e+toq+peDTxl1eUry9ebHIkIMqZhMAFUdCs4tG/eTDPXY
         vn98b5A+zfQ1bEw6HytLRR4j/G+0o81x3yrx/V8FimpU+TfJlSCnA+o7C1QpQrUMYGdA
         C5s2fjJG92jew2COLa9QOe2jiJqKmDiLN3/USPjlUETu6ushdJZVxy6FBsaipqCG/9xT
         gSS7nLKmGWtcDB0YXgp67tm+0280cuFYyKGuq7jnljVhmjziCHoe4WimTuke6pEyFf4L
         AwBw==
X-Gm-Message-State: AOAM530IKVN+QUETt+HnrUxk1dmmXjhNKiJPukqpMRlWys3Hum/KTL5j
        ked7mH369NZZH8jfF2EdMWvL4Oe7XhLeHnmHEGM=
X-Google-Smtp-Source: ABdhPJwzOyvo6TxtqoX6tWfIsoLTm+2qOY8+3hMcxrdZx0FQOQydtMSBOxIMexPDvaARTCvIUGkNzT3WwlnLHlOFocM=
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id
 nd23-20020a170907629700b006da6388dc58mr12079893ejc.472.1650343333333; Mon, 18
 Apr 2022 21:42:13 -0700 (PDT)
MIME-Version: 1.0
Sender: elemiassieric@gmail.com
Received: by 2002:a54:3406:0:0:0:0:0 with HTTP; Mon, 18 Apr 2022 21:42:12
 -0700 (PDT)
From:   "Capt.Sherri" <sherrigallagher409@gmail.com>
Date:   Tue, 19 Apr 2022 04:42:12 +0000
X-Google-Sender-Auth: A3VImfc1zQF_lwftU3G3gVQaTlw
Message-ID: <CAAf5by8eOxOy6FdY=RGQ+xZFWQnd9w211yzff8Zju45r3=36JQ@mail.gmail.com>
Subject: =?UTF-8?B?5Zue5aSN77ya5L2g5aW95Lqy54ix55qE?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
