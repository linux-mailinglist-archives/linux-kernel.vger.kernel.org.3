Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519DD5B08E0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIGPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:43:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5A79E2D5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:43:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u6so20276712eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Iv095SCL4mRr9Ct+uDl/VAW5UHdmty7AyTCUx8QERIP9/w4Pf6ZvVl6oPOQhoej0MF
         Q4RuwqpoBUEj4et2wvMFe+TxoMnB1u2kFAKj8Nuj4/hg1EJ3//xu0P2pjcksxB497GHT
         VLEgd3J7tlt09k4lFkBnXgnLsxRq6MxDOCTRFxwW+5nf06bYeHUmW7yqT2YECnjnW54Y
         ffnMbAbbI7ne9sk5iS6fIe8D0bZmqt4FokZ2ss7ElkYbCoQt5rCd6hgjvO36Ws793EMg
         gNMqJibBQVDyTX4LsfDUofBo1OPqwbTyv0LGXIZuzvlqCujaTBG3mHYg/7ZfVn+evs56
         TtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EGv/jZf6CrlWqMTenu6LofhgsZONbTLEdMZlKiIDcQRqnJ2nIgRP3kDc8kz37Okm9k
         FNFlztrlBmdPheb+Pal5VHwk+7Rd+bTOyuOtP8/miuqMuJl6RhdnFfOjw+1PSgqTbttv
         R7pIBGFoc5tRvWqc4aaVGa4D6l06KMa3EUP1sLdisUvc9qQfAqZ4BQdBpkHBTwQjjcfe
         dj8e+UDBEVRfFsMkMn2+WsFqzx5/i5c1cfl7AitS6wfBWCKyKIaNjwkHlyEXUC1yp/GC
         knesgByf4o6jNO40q2cHuPMU3ojV2zIFkWH6MfhxmTTG72lajn+Q8Xgr7whDJJv/TZcW
         RT8A==
X-Gm-Message-State: ACgBeo0rOO8Gm72znjPCWd4mruJdSrucDNYI3jISmiOR+4e6XFsmQj80
        Jh8FbJPyMtaJwgSUVqwDkeWXBH0JEh03XuQ7j0s=
X-Google-Smtp-Source: AA6agR6hYIdWAhCYx/59U+L+4R8vtGQc+GbougsrsRG20PlpBkPu8ZNkwAo6E/dluQv40QYSHBjX28/Jdcs8yBtNg94=
X-Received: by 2002:aa7:d5d0:0:b0:44e:f6cc:7107 with SMTP id
 d16-20020aa7d5d0000000b0044ef6cc7107mr3616576eds.371.1662565401603; Wed, 07
 Sep 2022 08:43:21 -0700 (PDT)
MIME-Version: 1.0
Sender: prafullpanwar9174776568@gmail.com
Received: by 2002:a05:6f02:c846:b0:23:49a2:39e3 with HTTP; Wed, 7 Sep 2022
 08:43:20 -0700 (PDT)
From:   AhilLia Lialia <mrsliaahil070@gmail.com>
Date:   Wed, 7 Sep 2022 15:43:20 +0000
X-Google-Sender-Auth: O6bLrXn3fFAFr7B8GSzfCf99-eM
Message-ID: <CAAyD0rsFq=ow_TNjZzP_h_KiGusz+NGogwNS17D+5h3NX0KM6w@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


