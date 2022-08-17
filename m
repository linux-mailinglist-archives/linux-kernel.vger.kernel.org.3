Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6B596725
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiHQCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiHQCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:03:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7219804A5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:03:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w15so12288812ljw.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=zwISn8wdVLRMx4eihcM5TNekfJsbrZ4Xl+DqPJtSy8k=;
        b=Vd3kZ5LQY/tHUqKhqhU7/fREASLyr52RwxpGX337OriC6pyeobuTc26YajBPzaXrQ0
         O637ft9b4CZW/CPcB8eEKyEoo+3Xb1cJuDiZM22fgR9G0LDoYr0i788azWghtaGQ2RFM
         oqZrxuMt8kWFKedPsQHPZBYLPGOsV8/6GJFZiZIuGr0Knh3IhLRncL8rCTyLg2MeEzAj
         L4H2IWwWIXvhCA8BUDE5hbMmPiRL8vXl7Yf9pbz6nKgrV0ZA9yOTgYw02agGUD9IAqpm
         4bqnXub5r4LABufcHI1njfSo1cfOubj47Em38VgikRS8dZAHMspB3tt04vRpV8Ji6JKV
         448A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zwISn8wdVLRMx4eihcM5TNekfJsbrZ4Xl+DqPJtSy8k=;
        b=h77mykV3fcCCBQEt/O0gHFLC3xSKK7ooAXf/zyp5HntKYcI+XfaSxhD/TvW7Vb5wW0
         VQk1oc3AQvt6WDTkKVE9SKt8Jel4H7yz4C03sSKXUeYOdER+7Skhj6N7wLi6ZBRcJA1w
         aRi/qImU7rfG7kUXob4nDga5mlswP5IHUG1ddfhwxAZJ4jdumMIqYp1ymjhIwyecUqci
         /E92wbyf1U04iWVKf3RxbgPe2vEZQjC/xzRtQIkjApwKXBk57uIHE5XzjQI8lXvhKgQi
         1ZIM2Y7r9ndv5nlCTUtoW2GG+sDdK8hjsKra1QnEl5rbis6b0cb5dflxPTMxWU7bEYFD
         pBBA==
X-Gm-Message-State: ACgBeo1lxX1yKov81eedmqpzVTFYlqec8x20Usq5xf++ER40Z3qjqgWo
        U0Yu6CbSBa4FhJy4USJyMlirGcB4sVmCvCnwGl8=
X-Google-Smtp-Source: AA6agR6zFzmCrxnEqD2w+UWVrITUVzOYS4hi3aH6ioV6AgSO4c9wfd/k77DCkH61CXXYcVPpl/s5ZQ0XTDiIEu07ZIg=
X-Received: by 2002:a2e:8090:0:b0:25e:5916:ddf4 with SMTP id
 i16-20020a2e8090000000b0025e5916ddf4mr6831295ljg.11.1660701781053; Tue, 16
 Aug 2022 19:03:01 -0700 (PDT)
MIME-Version: 1.0
Sender: sgtkaylmanthey612@gmail.com
Received: by 2002:aa6:da8c:0:b0:1fa:b1fc:86c4 with HTTP; Tue, 16 Aug 2022
 19:03:00 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Wed, 17 Aug 2022 02:03:00 +0000
X-Google-Sender-Auth: HH_PSQbVSO0tz_Ij7Rfifs0s0U4
Message-ID: <CALwsdYFG7Hmnb2w8o9G8_bt=QdNxWxK8Mt=Xm+jUzaDdEKohJw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
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

Hi, how are you? I hope you're OK. I'm still looking forward to
hearing from you in regards to my previous emails, please check and
reply me.
