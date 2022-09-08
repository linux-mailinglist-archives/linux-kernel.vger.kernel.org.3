Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB95B2426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiIHRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:02:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68486EA434
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:02:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id cb8so13441498qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=4FKXe+Ug9h9TTK4rIUjXxMykKpWTxJo5iWfCJb/kRDQ=;
        b=FYkcSTCDFYtfmi1XTrnA8hCoxcvVEzL7y95tnDILJ/cijlT0lMpOzisaHWoL0H0iy6
         tbkW8Uxh2+Ivg/XKc1FKHtVjmehduJWpSkbbxYLHNdaL9EqRUxSoYBzVpmRN39nHip8D
         CLSNh+cGdNqeWy7SJGBxgOYt1Yvu3s3IfyA50xq3uCrXKMqL2E1QmWbrGq2KCQfll7RM
         5oOLdMOSBq3wt5urW2n/wjGVYlqxIOE16IphM9e5oojkcW5PA6AbQkReDZaMio5cNQom
         W9fPByEkhG2QZVg6vEpdxqOgD17pkfMohNuPSKkD5SWsN6vuxkg8umPTkPe0n7UV5WiE
         s3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4FKXe+Ug9h9TTK4rIUjXxMykKpWTxJo5iWfCJb/kRDQ=;
        b=SblrnSgr8Gyj1Qa9ruc291F9vTPK2+g494ahS2Zt4KZhugZ1RmAwpC+h2m03o7cupH
         qpLr2mgDs0Xd9QkCWG1AKRxRJ253rhcP4POEebWwbG6iBolBDrE9KL5OwHlUi4kp5OKx
         r8EIGHiPBuG1BTu0+05DnuPE9NkkrhLuhIM2CMxenl5J0gNLrf8Svy3xmAlIdZJkJPld
         eeCM6WOQ9Fj+lhy7CGXZHhcCW65urnRMspjSkJ9zx0V8httTNo3/9eYrvPNuS4+Y8pUS
         6ErbOJIf7LHnhtAoiX7u/NnREJn+Wmnl9L/hId4DpL2hQBGj+rCSyY69BQTXRP+yGdfe
         n2uQ==
X-Gm-Message-State: ACgBeo1I9YWAVTI8OF2Hc9ZFy8b1Fg00+pSrkVLpUmCTvo4gk1RvAbq5
        dg6tzEI6/J5gh6dw/QJ0GopxqJIcMtYqeJZmwm8=
X-Google-Smtp-Source: AA6agR5sgDlE5ML894d+PHsHU9dkGiCECAz/TWydBU5Ef/cJe+h3XbAO2Uhj/I0/gVPxm9ea/mRUG6+Rxk38ULlp1hw=
X-Received: by 2002:a05:622a:5a07:b0:343:4e03:d5a with SMTP id
 fy7-20020a05622a5a0700b003434e030d5amr8485249qtb.357.1662656548499; Thu, 08
 Sep 2022 10:02:28 -0700 (PDT)
MIME-Version: 1.0
Sender: miamichael3321@gmail.com
Received: by 2002:ad4:4343:0:0:0:0:0 with HTTP; Thu, 8 Sep 2022 10:02:28 -0700 (PDT)
From:   Anthony Kwami <kwamianthony939@gmail.com>
Date:   Thu, 8 Sep 2022 10:02:28 -0700
X-Google-Sender-Auth: ECBwSy-SfdHaUXwayO1RQiyHBTY
Message-ID: <CAO8TYoEy+e54n9BiVXghGqcu3MW1L9neiir0ZU=shJvQLeSKqw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

     Ich hoffe, dass Sie diesmal meine Nachricht sehen.

Ich habe Ihnen vor zwei Tagen eine E-Mail geschickt, aber ich habe
Ihre immer noch nicht erhalten
Antwort. Ich erwarte Ihre Antwort so schnell wie m=C3=B6glich.

B/ Gr=C3=BC=C3=9Fe,

Antonius
