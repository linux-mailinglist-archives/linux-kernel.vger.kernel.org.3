Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738534B9351
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiBPVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:41:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiBPVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:41:29 -0500
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4702A0D51
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:41:17 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-2d0ede7dd9eso13188467b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=m0TMDQXrKCMlQ/9UmN6Gtg1Bk4E+XAeQVtlmy8Kzj+o=;
        b=CSwFOyf7AyUEDF7t+o3B7ZcwWhCW7OysSPxe+OuYUe64ippTNAbgBoohv8WRkQ0up2
         HU0xc6EUCqNRRVSTeCYzb9oZLpOdGg1eCvaJMCd7fcl6X5Do7t6YbkiIVIEjPKin9Ts/
         x5fMW2XJrk3ZCBVeZe0uDKO0Sc8ANN8CUYuVz//AfkS8VYAofebQnwMmy30fC8t1Gwu6
         jzSOlHVpf1lbYMiK0CjcfEG60PXNHzBNj7rezXkPhEAifOup+70mTNXCE6nHIxx4pO6b
         JT1qn45Ik0hluIiXall0LBTatOB3q/iTNf8vFGepFZnvX9l4PUK0piQ1qqziOY/BLatM
         FB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m0TMDQXrKCMlQ/9UmN6Gtg1Bk4E+XAeQVtlmy8Kzj+o=;
        b=eGa8VqVTHREywzIqBoET+XJ6+ap3kJeHVWFICvXeYOW5H5B8dqUKllW+CzGsmLVs67
         0QV8UlXfbXzZjR5dHj4JnwmCC6x1IZd847eSdSwFSaBSiYtCfydIySuO2YRQrvqyAa8e
         vgYPcb1s82820Yij8DlXafOKLZQE2OyIWwyanpPn9MUVIH7+fQrHWRezEieW3eIdTndP
         nFJa40yUsrz9BmmnP3CtPdpqNq669PvFcI3sV6gXrpEdyKn6FNUnDTELwZ8ajPBFWjaC
         fvoldom5WStPm36G/VuNlcjNuSS872quYlr3g24Gza1Q6S3dHpoZWT7Teex6rRBxRtTJ
         Wvxg==
X-Gm-Message-State: AOAM531IxG1Cy99KPtTbvgIHbFH4kQQsFxWq0MQsx6j9obctxnVSl/yq
        SlnPSaOtGg3zo/tni/l4WP6Ea24WRBvsevx1ASA=
X-Google-Smtp-Source: ABdhPJyk3MbFBo5Q+pCCQAMxmIrQ6STz338eGJQ93JfaHr9q7pjDJ839xX0KwqsOXiiCkN4DSgYsw4bZGjiJ88IY8pA=
X-Received: by 2002:a0d:f785:0:b0:2d0:e9ac:faa0 with SMTP id
 h127-20020a0df785000000b002d0e9acfaa0mr4185700ywf.432.1645047676419; Wed, 16
 Feb 2022 13:41:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:724f:b0:20e:3c0b:2bd0 with HTTP; Wed, 16 Feb 2022
 13:41:15 -0800 (PST)
From:   Bright Gawayn <bengabrielb282@gmail.com>
Date:   Thu, 17 Feb 2022 03:11:15 +0530
Message-ID: <CAMMweGyRpWadKHeg29eTbVqZSt+psZ843x2dYKLJWhcd0=PRbw@mail.gmail.com>
Subject: Supply Of Raw Material
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day
Dear beloved.
 I am Mr Israel Ronald, we use a certain raw material in our
pharmaceutical firm for the manufacture of animal vaccines and many
more.

My intention is to give you the contact information of the local
manufacturer of this raw material in India and every details regarding
how to supply the material to my company if you're interested, my
company pays in advance for this material.

Due to some reasons, which I will explain in my next email, I cannot
procure this material and supply it to my company myself due to the
fact that i am a staff in the company.

Please get back to me as soon as possible for full detail if you are
interested.

Thanks and regards
Mr Israel.
