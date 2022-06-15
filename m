Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DA54D1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbiFOTnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347040AbiFOTnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:43:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210F3337C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:43:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2966312pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=d8fhnbfaPrU2+uiC85kAcwxMXgjbGT6e60zD5sDwnLTPVfIebFu6ujW9v9D+HIGGOX
         xflERCHkkCdL6KPdIzK3ICCUzEE16RQdKOmBPJ3R/J+eNXsLcSyoz505OO6p/QlV6GGq
         O7GdyXYdHJHTW6y4bqizczAP5tht6h9enLmvovAeH8e7S6lsohw2nwxdAgJrAEjATyrO
         39e7MHMhOFj0i5Sg+2FAilC8MCeGfop0VNkaHbxw00EJYAN38OfK5WqyIYIxmpSZJRlP
         zO3c63Nkit4qySkdilxmHbNCW7pl3DKS0cgNLR2e9VlE+UFuGHSyqDdQ9ib7JbiS0zaq
         vVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=QEOa+COcBscH8T8aQTvNEDVAH/UDejIB2Bzv5DAxV/GcgB+uuagvYCRFQSl+clbaYq
         dP67e9a45DLTSMHoe6t2vktFhltVe9tJoDtTHrA3wgeJY/0hee3H+w+AgunV7tN1Ji70
         efBKWPkVBMrNrVAoxrAW+jwxK62WU0zT92mqNVhU+nISJw4nRq8NtYOyVBMyYicfpVkj
         8i2Wu+05BQqNTzGQh0BHcUxkivo4Pw5NKqXwWafPy9bf12iHGmcQgt9FOpJv1cGmqG/Y
         YHD1DMk7WlA4ObdTDX10OKfgRuro5RRRBwB1Ovlw8ooHBKXbiw5NUBQ5xXPYIdJ/y3hz
         r0Nw==
X-Gm-Message-State: AJIora/wMegpOh9o3Z9cMsaoeF3fnZXa7kZCa7DzolUfy/dBx0mSQeDR
        yQaiJxLGLvtEdj3A72wBu7RNwB4DzEF647NCdw==
X-Google-Smtp-Source: AGRyM1shG8emlCgSYivx4aQKJnMn5syrlXGqEVVXxeJCFmVaj5cPb6f5lDMlXZ/WAUQr34McbttygOFSiSmZedGVCrU=
X-Received: by 2002:a17:902:ce88:b0:163:dbd5:9797 with SMTP id
 f8-20020a170902ce8800b00163dbd59797mr1207473plg.82.1655322199133; Wed, 15 Jun
 2022 12:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bf93:0:0:0:0 with HTTP; Wed, 15 Jun 2022 12:43:18
 -0700 (PDT)
Reply-To: peterwhite202101@gmail.com
From:   Peter White <peterwhite20211@gmail.com>
Date:   Wed, 15 Jun 2022 19:43:18 +0000
Message-ID: <CA+xfdp==zhwiG1dD-yoj0po=FytaAL_ZiPeAyxm0Y4LVUx0qaQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from here.

I want to know if this email address is still valid to write to you.
There is something important I would like to discuss with you.

Thank you

Mr. Peter White
