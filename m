Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076E5AFD12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIGHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIGHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:06:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1E86FCD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:06:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v6so1472711ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=o/Rzx2on4JtIuoMDlQWT2mKwPJ8sUwps3j3czfLOhaE=;
        b=QJDKCO4FLiYWCytmEleluCQaQCqZGokx7yAGPdDHOhDT4RgPM20hx/Lc0T7WrqtZPM
         MHxaawbxfEATsY94c5r5dUyXiLh7RLyFAMfBdRsSLcJq7fc9O4/mJU1wOtN5no+HkSj6
         aLsZpMhI+iSH/TYwjrROO/9t4vRHffqrS16iYlM5iZN96Y0dOw/oHrr4hV0kwuBVTYet
         agOH7zBSfVSv4V5ZbkER5E91E4nxfUuZ10ym3kPJwjzCT2OiWUj/uGfrRrs0GdM9hFeo
         yQ5I1YoSQIUVeJhqhC9YFUNMjImObjMmLPt1HQ+Pz4xYFkI7LFn9ZMt2hBTYdzohQzDN
         Nkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o/Rzx2on4JtIuoMDlQWT2mKwPJ8sUwps3j3czfLOhaE=;
        b=QxQ1qlF3Q+k0w3wJfgiR2eSZvT8z/B7kJOg0R0Y4Vz9U29X1Qb+wHyL5ahFZfZ12FZ
         U0MP1BWieuW5T3V9dKcq3U2sE4dAqJvvptRnHAA/yGodDrXl8jlIDjz0CL49Mzxaygyy
         953NBDtf2fBi1svBbNo5aCzMZoSCBZbKpR8yPlUeHeNC6xwu1WbuAM0IzRs7o28GLPvJ
         CRHQfMZFDfAt1CCR/Fknp6iPz03fGjwlXv3dECkDVJiuCiuiO9pQEMK5yAf1/bxcIMH7
         wiSEuoBjsV13u1/ydqCKLsGAcLwUxeuRbS5yVivY2CHEw11hn/FeBCxET2PErCVcFnAT
         8O2Q==
X-Gm-Message-State: ACgBeo1jdeG1wY31x9DPUAurktYSMcVM5qHhekz+63BkFAwk8He3Rjka
        cpo/C1/MG5hXYGQP66WQK7ici+/dbtdOvk6K6xo=
X-Google-Smtp-Source: AA6agR5eHF/YCqft4mq6ajW1wN1RuvZ5TfN5vjJvBirc6gDTYvRqrhjY5jqvbkrBbx+rcVkPvjnlujOccIV+u0C+Mkg=
X-Received: by 2002:a2e:b5b5:0:b0:26a:c76d:145a with SMTP id
 f21-20020a2eb5b5000000b0026ac76d145amr583311ljn.119.1662534403968; Wed, 07
 Sep 2022 00:06:43 -0700 (PDT)
MIME-Version: 1.0
Sender: jessicadaniel7834@gmail.com
Received: by 2002:ab3:6455:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 00:06:43 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Wed, 7 Sep 2022 07:06:43 +0000
X-Google-Sender-Auth: vyVHYCc1uZT3scIKjDFSnPIcjqY
Message-ID: <CAK8-hm+NfR2eaUbVSOaQ2KrJ01s7uNQ+gJ-XzSsBwxF3cv6w_Q@mail.gmail.com>
Subject: Hi
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

-- 
Hello Dear
