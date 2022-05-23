Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EA5311E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiEWPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEWPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:45:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90099381
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:45:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y15so8530383qtx.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=5p2yXVEaOiiIP5PreuECFUo/kZgrIrbPU/z8qM0JeBs=;
        b=obx+ho5hDRc2kXOZFH9/6aH2+glP+QsJfYkQN2DROfse0si6Zso7b/CjkG3Rw6PjoC
         T+zbjzR4qSIsYtqXt64W+6vy0S+ePD+vxinEgwiF/J1a6DUPon0zP7s8L5/GQ9Wi8Zrz
         b8IMHrrERxc94ECU66JS9Dl1Zu2iRvfqxkUwBDDH2Wu/3UTKk9hF2eJNXdcz6zMb1Lxu
         50FSPJr5Hv0n4BooDPWNDC/mPwqwBb8HcWQjDo0ZOE2RXdUrgm2sIIF+mTW83x7h9jgn
         usmDw/1eMq0hSkPr/gXykmvRyS1piDoEwSqiHU/tcGc2Pl/nboQ0ra2KNKOOcOR5kKTi
         u+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=5p2yXVEaOiiIP5PreuECFUo/kZgrIrbPU/z8qM0JeBs=;
        b=25vAgGp6xtgxg+H2X+oqDWVkJfFCH40ql3HYceMF3J8VO+3eJYUtjLx70daWCvMCZb
         C2TF/9ojPezSRmnIF90KEa2zW/D0m8CL8EoALCISCzofrYXZ6td3HAr94lK+jmkhuWTb
         l0DKzkCEK49LM4T3FdQIXvO5sIom37WQWNSPkC9QNzKbNAQU9mzZaa6QlaWxGdwlA9Ul
         MuCnPMIYAqZl05mB9FLo3hq9GV1rIG4mF3jnPnPA4oteVqjmgYXfWGk8m6ZJfAQmDv05
         UOW0QDlLRwz/PSyY1c9XbtrbmTkB7QFT4fQiiv1AXhrgeg7c9Gt5wHzqPUfan6Q+5xBg
         OI0Q==
X-Gm-Message-State: AOAM531UOXLSEJGPOPIXiJ85/+pSeLoo1kZJga0EBSJ3d7XLtQNCsDPb
        GPycYpX4JQQk8U//H60EjkR7+EUviLsjlCnRWL8=
X-Google-Smtp-Source: ABdhPJx+yXlnZgb282R1MdwjV6dCIFcZkY4b1UplKQa5gcxNfIBvd5rYdyKuUTh4gbdEJO2FgJ3kdsmli0djLW5PhWk=
X-Received: by 2002:a05:622a:50e:b0:2f9:1868:d1e with SMTP id
 l14-20020a05622a050e00b002f918680d1emr13518325qtx.510.1653320731504; Mon, 23
 May 2022 08:45:31 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.biyufungchi15@gmail.com
Received: by 2002:a05:6214:180e:0:0:0:0 with HTTP; Mon, 23 May 2022 08:45:30
 -0700 (PDT)
From:   "Mrs. Rita Hassan" <ritahassan02@gmail.com>
Date:   Mon, 23 May 2022 15:45:30 +0000
X-Google-Sender-Auth: l8h-baDX6JR_XBGV_x7EFBPqQCw
Message-ID: <CAEcaYmWfNPdK2vJ_pEYQ_SjRpRD7RpPqS_mq7zE=aC7t83iaNA@mail.gmail.com>
Subject: Very Urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please I need your help,

My name is Mrs.Rita Hassan,I am a woman and also a cancer patient who
has decided to donate what I have to you for God's works.I want to
donate $5.5 million to you so that you will use 70% of this fund to
help the poor ones,while you use the rest 30%  for your family.If you
are interested,respond now for more details on how to receive this
fund.

please contact me for more details on this email. ( ritahassan02@gmail.com )

Yours Faithfully

Mrs. Rita Hassan
