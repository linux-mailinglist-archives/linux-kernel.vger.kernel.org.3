Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB484FA8A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiDINpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiDINpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:45:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E456C3D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:42:53 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id u2so7159265vsl.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=LPasulMBi6RtloUPQhHeOfT4cjSndFRN84+1L6oK65iGY/Q9+3P53fmwQFslhIvMMN
         0HtJQiHC4deVflDwpTo1ilQLyCQND7Fs9jKSz/YcaShf3V2zTghrvXfOFiUT2Ngv+pes
         aDeSFrDW5b7DzO+jwY1z1LtCoWSEy9Y5SP9cWrwOPNHTxTKrBu9aRq5giImtM++ZuwUm
         DYyefSbHfv3tHZnS5ny4Kg7UonUSHwY9tqy+PyNwQIg4oGTVW9yjZq5FlKuSXOjuXq8p
         SZ1N62OTXlRKe/sAawrjibmqukppjatBkyz0ycEhfcW7ZqpQBZcT8I9O5l+V5TAhrTAL
         CVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=e9VkK1k3Pjj7JgjP9iV7IGTN0p8lichvs67mpvB7TO97DBdcCWirRXkc/RNhMrrnyN
         3Z7npzm9WhaPeePjvFXBYkRBm0IE135fO8KnfybQjxKpS5ohbz+NlrDQnLC3Tm3tqMJT
         KIBO6FHf9zSYceeyQQkmbF3Gf6dJoLSU2QbPiCZh6kkq01rSzTOOaMJW9t+psvELHGkZ
         2DyEMrm3ARlwQecAkukJzOOWLinVL51eFTksn8WSiL/QgPdrexNXuOqJSZErrYhHbFwr
         gO4gjhleEYxKFYhpZCyuZhC/l8lHbqLEkHCB6wEJoGYvbiQZKrdeHCiZ1ihqywQeWJVq
         nfUw==
X-Gm-Message-State: AOAM5318ZTfmH0bPYQfY52T2AA6QrO5qijtgZU3tAfAD8YnLHRD+KzJP
        Fp77KFlPbupb/zMm+wc2bGs+XOrAceJ0QvTojjY=
X-Google-Smtp-Source: ABdhPJyTMjFwvkBhIdLrMEkn3ZGpIU5dM1o16GKBW5U1J3LV1Qkj5ONs7ErD8qyUTEiKOtbSPgZqFmhQyHcX2L1x87s=
X-Received: by 2002:a05:6102:3234:b0:325:5b7e:cf2f with SMTP id
 x20-20020a056102323400b003255b7ecf2fmr7923279vsf.65.1649511772895; Sat, 09
 Apr 2022 06:42:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:638a:0:0:0:0:0 with HTTP; Sat, 9 Apr 2022 06:42:52 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Kayla Manthey <adossirobert@gmail.com>
Date:   Sat, 9 Apr 2022 07:42:52 -0600
Message-ID: <CAMAp8G-LWi9R2BV1S7ygB303K0kbQGy0tGyLP_TH91BwCkiZ_g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? Write me back
