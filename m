Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A222598675
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiHROwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbiHROwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:52:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ACEBCC10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:52:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w3so2212520edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=PAGV2Q8tueB9u6nAu32uT5tMQP/9mkBrRApmZJ0yLwI=;
        b=c5pQod2KXFRdhkJv6DOOCuDxRyGUkNGisT/jpTH+Ff7dJj4wsxYDh11/pwJfqgWMaz
         8rAQTO9qapyZIuDMdPdymRsKymjNGMnUMVCH3CWzHM+bE6ZJw/4pnTMCASH+3BnusTSK
         4pdkzY+4ofYNx/ti3agI9K5Maooo+Xo6MUrNPvqn1/XAI5/KXPnFflq+pRChrR6Szxgr
         /lw9JSVgZ3j3EwFHySU6LRCuEnWLw/u1Q0OXd334YQdufgJslHNhyujxW+HAc0lOviJg
         SZXYkjimhlJr8Mpeo0NY5+P/9ZT6WaxbvXEKnME3dAxWVyjcMuvjJbs5bigFRsdCfEG6
         xM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=PAGV2Q8tueB9u6nAu32uT5tMQP/9mkBrRApmZJ0yLwI=;
        b=cGYkGumRUdKscqbWR/GbvDL7n716hQfoSXndhrKf7cN5nC43CN9WbEA/Z/q7fHuBjV
         7rNLsjgUFmeiv7lypRmGDFPfP2FJQxwahBgFlGUuGDpvH/FrgQrBXwHr+aLjCzkSSSRS
         sLEC628TU5yEcfOycZKFzLcnK76N+rPSutX5PCGRnUBucNoMRtEkA8KA74Q/20zZ78Lz
         5YT7Qo5runYzyPRRkj3K2xXsVMBfUHSErjN35u+VtgVU6JF6oJ8byRYAja5yt/xnnBAo
         py62uj9YjuDMXkZ121vc//taBj7YOx8bccdSXTGdwMsXwhGdia40bdMKCrCkoVxKs+Ze
         rpkw==
X-Gm-Message-State: ACgBeo2dfl7eMBgFay1Z80X7fdTuX+8dIWtb8W/eYea4/w2R6K3cCJjk
        jMiqx4RCet5rRMaAP8OT2QrNgSN8k4GNNL5/nn8=
X-Google-Smtp-Source: AA6agR7VVsdt7bshfA5+ZJ94Sf3u0Oy7jIOLpA4JqJI7xE377FxTNKZtFQhE5ZHkEZx37Yq/SJ2ufzekH+FvP9+jkgo=
X-Received: by 2002:a05:6402:716:b0:446:2a40:9138 with SMTP id
 w22-20020a056402071600b004462a409138mr357979edx.82.1660834326920; Thu, 18 Aug
 2022 07:52:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:b303:b0:730:af22:4244 with HTTP; Thu, 18 Aug 2022
 07:52:06 -0700 (PDT)
Reply-To: felixdouglas212@gmail.com
From:   "Mr. Douglas Felix" <kekererukayatoux@gmail.com>
Date:   Thu, 18 Aug 2022 14:52:06 +0000
Message-ID: <CAN5qXwHoHVyeYXa1qVaF_KHiRzHyJkyTt_DBt8crNijR-qAohA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Barrister. Douglas Felix.
