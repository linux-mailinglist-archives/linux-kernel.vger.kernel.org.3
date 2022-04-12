Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751D94FDB11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387079AbiDLJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359853AbiDLHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:43:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE644A29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:26:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu29so30769163lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u42xwBuQyxkr9jacbbhifq/K2L4KORPqcfPJ5nkjvxE=;
        b=PBIF1Z1Fgguqn9IrsGHYAspjFRoZ6tdW0s9CRH/QZqUmQcRYwasNYQ3EQoD+W2oFmH
         dJYeCTt7hvv76mVtg31SWhfYh7So8xPkGO/wADN2BJXGeXVXAgYDvo6fStDbOb0fGh0c
         7vss3xm3w8qPmV4Kc/fvaaoJjjufNYjpKVq/nvSQGcRY+BqKf2CtEzk7jonXSDjfMFRY
         J9ZggLtOQPLEIGeh529LHtVhYJjFj5sDEinWAKL6C8uiY2xWyp6mpLuY40SVQghAqYDh
         CQBiy7xy+26D2Ch2xvsnF3HzoZEO8OKiMPrGBJDi3JvHG2n5OnCrRmeR33vJthuKMIL7
         ihDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u42xwBuQyxkr9jacbbhifq/K2L4KORPqcfPJ5nkjvxE=;
        b=pbI1D4EJhF9mswnZRz9gQs6zkcqOSBbftrMNy+4vLdyUm96rByQIXDujBnjcMYoqEB
         0MKjg1X5dk0mwhzEsIlpYLrwqByE5UB8jXoVv4T21Xg0Gl07Ntu5f+sbFpwv/vepuQSa
         7n5va2kr90TLuHTJTjfYXIiEkKXBMrtzWt3mloLFEwFq1oYIhaiC8iMm1Gz14k0/rLhN
         GnJNwg+g6EWizDiBEDFoTEBuOEoqNkLRLm6gs7oa7wE2XlruFPw+ORKLiN/cELy7YOn5
         zG41k+i4ZvpYnUslVJYNjb54OfifOF6VKztpQrPyFaBgv+xpjWQj2Nz75YQU1Tu1x21A
         SG+Q==
X-Gm-Message-State: AOAM53087OrE8Ax7Spsk0htWHvl5/tLjt8d8JZDqCwrEerhnQKwEWE9T
        ihBG8sIxA8RkVJ1wat4Kr99QunQZDwtQyxXQbGg=
X-Google-Smtp-Source: ABdhPJzxbboTNx+Fym0iGP07EDKXEa3Qj6xSNNf37TmIm1AGUzfT3vjPhVxBcN2kp2sfsVJTq5Zt15hmXD4ns88BFHI=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr24221124lfv.257.1649748386628; Tue, 12
 Apr 2022 00:26:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:1548:0:0:0:0 with HTTP; Tue, 12 Apr 2022 00:26:25
 -0700 (PDT)
From:   Anders Pedersen <widgagnangaya76@gmail.com>
Date:   Tue, 12 Apr 2022 07:26:25 +0000
Message-ID: <CAP2_pShw2nJcJw9UDB0ZPdm=Ut5wf8ZyhiND7vvwj11sBz=d_w@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting, I want to know if this email is working?

Anders Pedersen
