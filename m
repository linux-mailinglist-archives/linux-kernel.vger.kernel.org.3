Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6D505A22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiDROkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbiDROim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:38:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4857176
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:24:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ck12so5295449ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Zxho+exJKKOKB65wNhmIfElbVOfiLStLlJhCjJN3tgU=;
        b=i2Xxq2kKTqhF+ZuRmpzKZeiWNPvsnKiswZgWoiKK0SoedqjJwj/7TEbbDBeQWJDDEt
         gUvoL6JJRT/0JLGPxJOp1VbQB+jZMjpL+YJ3+GusiJVDcOxAJQKEouEn+myWgK0HVQIh
         rJ+zeF7Huu4bAPrh9fJNDgeGd96sRjEj7pjK/5Sw3Cf/CeJsRZJoZlYB9q51wr1bNAN3
         tSCBEGg0BpTM4PCdmKnExgioS7Y5FBKkwFD/GKoiegRNYcrYwJYphFQQtQXEHyF5PnHT
         FuND+3ieFEI5L/w4Uek35CRP+6fJi8qRyimOmkjc87Mm1zFtvRFDOK2g2HfpmB5T59X2
         CHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Zxho+exJKKOKB65wNhmIfElbVOfiLStLlJhCjJN3tgU=;
        b=zSTYZRE7DRVZKibdN5NVLJA6rcspHPRnRpUQmF2siRfGurWgTMmcFvI/JzSJon6oqV
         EmHgCKO2iWufzCs1sQdZSdiEpfrSKHAgn33w84GTzFUL9mPSxVh53AJFnxOxWyejQwt1
         aYFgINKWh9OWe3XYQ/DTlybFEkCVY0vB5Dd/8+olhGw/bca7cWotmANQd86+xtg8Uy6V
         y6x20OV1Y+4RgyoNJ/C4bWpMSULiuMqhLZ62NL27I6oFwAJolIf8dczlPrjBOfUZcRPR
         kp6cTqu6EKQUvkrewljl86U+0qP75oaiNTeDDHUL5UNv8jcmMQpuUOPBM258Bbj9nTSn
         9rXQ==
X-Gm-Message-State: AOAM531oDZ4uOvpTiZhPk2coOKr+fYrYCm7n990c9YLhk366rUiVRKJv
        IzngkmFOkwq0XFf9lYUIMbt1nPD8pgQkd+y0lLw=
X-Google-Smtp-Source: ABdhPJyfFLYQ1nNwUCtzPRKUDabieLr1JWzM39/Su02t9YXBpuIcrDnuAJGuaxAZ7Z+SiRKJGbuiELx6vbe2cQIWhK0=
X-Received: by 2002:a17:907:dab:b0:6df:e51a:b990 with SMTP id
 go43-20020a1709070dab00b006dfe51ab990mr8756832ejc.573.1650288255102; Mon, 18
 Apr 2022 06:24:15 -0700 (PDT)
MIME-Version: 1.0
Sender: lila.lucass112@gmail.com
Received: by 2002:a17:907:6d96:0:0:0:0 with HTTP; Mon, 18 Apr 2022 06:24:13
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Mon, 18 Apr 2022 15:24:13 +0200
X-Google-Sender-Auth: wUsgmFtuqxDgPaZwhFTbp5J2Lsg
Message-ID: <CAPvtrUeAnepKjptjT-H8G8nXpFJe=cW4zDaTnOp5m8GYdO9VQg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of(Eleven
Million Dollars) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
