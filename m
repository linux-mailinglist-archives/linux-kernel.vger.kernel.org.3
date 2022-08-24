Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1C5A0383
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbiHXV5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiHXV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:57:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3457E1C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:57:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u24so12104483lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=nSm5m5Ch23K0ZGueBXfURMZO18EUih8hkLVu+JRIJRA=;
        b=SKnxAGK2x8GfM2HGrYGFE82sAA+2ZT7kBtMe43D6NAqAYH8n1JtihX1yNw0Gcjce9c
         g4/+Va0EwNgoN2dSryhCuAkfw5o3k/C5y44J/P+paiNIQmX3dkx55Oe069wmg5W3uXPA
         BJgYvj+bQZLFWt/4YVrOYafJpK56ZJBycLROvtaLUzNzV3Jw4slTxsDNbDNVtUlrKP1i
         ATZ3sF41IKN0paH50qsrDiPVRbsyu4frfAIThss2lthyHd57Tkfi9Q7CYIpEKNspAM/P
         Nl9cJkJuGK3ggvxJx9UGetVO/QyrMIwfCKhzzSgeT4WIIw3WryXdpM2rw5H9Wzpl4wDT
         Juag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=nSm5m5Ch23K0ZGueBXfURMZO18EUih8hkLVu+JRIJRA=;
        b=WQrljhIgqWvGaU59w0OhO+4jE4dspRhSkzH+t2rTghhHxFbxgRy6mHwTJWmin/C5uR
         sjuFyKB2PMigDeZNes6coQhmcvNV8ykvWuyb/VKJZv/7h2tWSIt7Ia2XwbI6asn+Ujev
         f9o6kp79Qe9N9ObZxPENM0hPiochD5C7liBWFZdPkHvH5CWL5uzLFfO+sQdnEGhdK0UK
         TJzomb5lOv8jV8LPBuNABRXvd2CgjtJVIameIcrfzreX+4r5k8UTCOjsXdHbx5D5VjbW
         mPj/ris2QH+3oRTnQFLkpoaXVe3+s0jaxHq3kAu2+DR9I7ZSSVKtquZ8rknTOSrJ05ry
         phIQ==
X-Gm-Message-State: ACgBeo2wwBwe/WuBiGEgRK9MKDpmK6v3tIf5wI3uTk9vIFx3WRGNFCKB
        ZjQ6xnbyPCOyCv2eGFbb8YUF5xjk5VwL+vp9JMs=
X-Google-Smtp-Source: AA6agR6Cd2On+8LM1ZyPy9c3A0pPnv7Sc0i4Buqxav3rvp8gvu/TpU1K6gTjGExYieFj0JFbFudnCvN0D7JD1O/Y4as=
X-Received: by 2002:a2e:a5c2:0:b0:261:d23a:2009 with SMTP id
 n2-20020a2ea5c2000000b00261d23a2009mr272982ljp.303.1661378245807; Wed, 24 Aug
 2022 14:57:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:1488:b0:154:c3c2:5e94 with HTTP; Wed, 24 Aug 2022
 14:57:25 -0700 (PDT)
Reply-To: usarmy.jameston4@gmail.com
From:   Major James Walton <danieliorbee@gmail.com>
Date:   Wed, 24 Aug 2022 22:57:25 +0100
Message-ID: <CAOUWinRK4j62XjP6E99PUHcsCRTNXAk_5ex8rFNt0cwnXLeFOg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
I am Major James Walton,currently serving with the 3rd Brigade Support
Battalion in Syria.I have a proposal for you. Kindly reply for
details.Reply to: usarmy.jameston4@gmail.com


Regards,
Major James Walton.
