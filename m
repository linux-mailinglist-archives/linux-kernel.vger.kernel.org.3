Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1509F55ACBC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiFYVK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiFYVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 17:10:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147213D16
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:10:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z7so7910935edm.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=NknCGXo4HzclnQ4vdBnx52xJqUH/oYfoDOppBPbzdUE=;
        b=bVnWpIAjLtEncg3FchIky3XfYRBd/bWr0QGSHPdkvW1qJVVX1jfQ8F8W2BzP7+ab1l
         m/a8G9rm2SokfNlzV2Kte3g15gDEixIjTSFTYLolcGx2t/jsk0IVUMtO1zXqldpiTsqz
         uPF26JyeMDU85tgvK1h0XeLT0N3JxX9keYLdewFWCh9R1/xlZawIiM6GFVkbKsOCm1tG
         aRvsBC7dAm8oUIdZryGJRL7nZFy/032adgSIdoK84ligJxlHf+H4G4d3xNqZkbqyfZUj
         Ne9N7XDtzG3rXmG1er55Bq3NHFQBwxbE6GcwkALvtDRn99kjiaAsxFgygK1DHuGWAoZp
         JM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=NknCGXo4HzclnQ4vdBnx52xJqUH/oYfoDOppBPbzdUE=;
        b=sYGTKTkH7WIyi0w2i64RfHLUXw1UkLewWWndTJGdNNO8qExF/z5ChrlCn3PGy+9Xvw
         hNdZNUsgKDfI2xz8xHhgAPSji/SilbHo3RS6kJvfEmlhzgG24aGEfFtjCyjlJJaD/g8o
         r7CEFyrPA9+jKnyQzjw2+DNp4xK8fFetOSwYitvwgEDOpfntb7BLLh0fz6zRaLDCTRtU
         tquVEqea09uqZGkxlg3fINvbLdZ9VWClGUrQgsBE+Pn4VmAenJ5DIvuiQrPE204QpEWo
         Pnz0tsPXy6EeL+gO9OzvUhKFoBWUDbNSDETLngDN0OukidxO8QxM4A0kGjZkK1KEmwYS
         T54A==
X-Gm-Message-State: AJIora/zw/sXkWunfdtTSpB6revfnTQQ0uTjmqx6i9g+jTdsv+8oexgk
        eGyesKxNvrUZf9hRE0yai3aLd0IGh5B7WPsHfDM=
X-Google-Smtp-Source: AGRyM1t9jgJFds/Ntp9KmVX1nP+eyMDAbqoqlC1/gbZXQ7lo34yxsAWiUB6dqjruvFOnEdeCIXL0cJB0gElrZ6MkGM0=
X-Received: by 2002:a05:6402:492:b0:437:4b50:d616 with SMTP id
 k18-20020a056402049200b004374b50d616mr2086072edv.43.1656191453835; Sat, 25
 Jun 2022 14:10:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:5a9b:0:0:0:0 with HTTP; Sat, 25 Jun 2022 14:10:52
 -0700 (PDT)
Reply-To: williamsdrtracy@gmail.com
From:   Dr trancywilliam <opcc54d@gmail.com>
Date:   Sat, 25 Jun 2022 14:10:52 -0700
Message-ID: <CAHXkEY0pPYwciEVDYPpPo8PTBRsDVNXw0gD9d08hALQ=KM-uBg@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

how are you doing.
My name is Dr Tracy william. I am english and french national.
I hope you consider my friend request and consider me worthy to be your friend.
I will share pictures and more details when i get your response.
Thanks
Tracy
