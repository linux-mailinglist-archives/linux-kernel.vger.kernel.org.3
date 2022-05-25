Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFE534071
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiEYPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbiEYPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:35:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCA2B273
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:35:31 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-edeb6c3642so26464039fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Btm5bdKirAE1edCKMA0iKOdICFrFrxNR7mcM4wXq0Bs=;
        b=hSLdYyaRRlo2D3KUtOiboPbggLhQQwtRKS/zh4CeGO5oDqyEcC1RN4D5vsxeZuBJeN
         cELxOupT/Dp975P9eFwd3/uJuz+C2ldi5Hwmu7l+KQrQeJUWtJkSgRER0H8QAFycTP7H
         TSJ/vaKjSxwLMEksTpeg3DC25jDtEDEhcP6NL58FVtkWB1qYaLii1Nzr9YkgCUz15mmP
         gee0DOjTxqIL3pjsQArVvymbsmoVGa2KjeJjQIe9z10hSwcNeaIyEtm0ScSNF7TR/7ER
         YF2TYS83PPhhaaKNtc/rLFB/MLcgmzOJU+dxwUNjXB7lKzxIk18sX3mvPLSCQMisWE7j
         qxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Btm5bdKirAE1edCKMA0iKOdICFrFrxNR7mcM4wXq0Bs=;
        b=MqvSRRzjUg4nah7oEq9ouBrmJriaMuO7QNQnMaL9WL8tCo5L60IC+LcttVqMo7kVR+
         4ygCX3XG5aQFbMi/uWVBw7rn4mUkU0xnnZSMSpZDagFdLXrK0neNDeM7CPGmH98cRgdG
         LnlqhGY88ZsdA4M4hWymMykbvsHl3DLgfRfAgpd/9E4EDD8UiZZqUplMryKPlntnnWJZ
         i8FuorOYwGormbdO8dMDU1BrMvvZf0q+fcROwbSON5Orhy3if0CghPJHt6a2K56xkMGa
         sEVBDaSVtwtWDKbwlMBAkh791A2ikZUR75JC5N3O0foimUG8Tw2RPrOcpJURO1EZdlp7
         AMcQ==
X-Gm-Message-State: AOAM530RkgpVNfaj95mhMnFvT+jvLGFWXsN+dPjE033ECEJDWahcs7fA
        2n7nhwN1loLgGTs2j2K87sKZ0y4UmVteDzqS3Ec=
X-Google-Smtp-Source: ABdhPJyd9jMpGtTf2uKFnVvlk60l0JJ0ghHzTwn/xoqB63mhSFQpYgRdugyXwwF1LjUO2l1KKwd+/4Yv9A1ZWo7B0x4=
X-Received: by 2002:a05:6870:6196:b0:e1:e1a2:5c65 with SMTP id
 a22-20020a056870619600b000e1e1a25c65mr6181167oah.190.1653492930642; Wed, 25
 May 2022 08:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:3498:0:0:0:0 with HTTP; Wed, 25 May 2022 08:35:30
 -0700 (PDT)
From:   BARRISTER JOHN COOKE <barrjohncooke10@gmail.com>
Date:   Wed, 25 May 2022 16:35:30 +0100
Message-ID: <CALDdX6VqzsB1JPW-amBp_=At6k5Rs28=NnSS4Qb-cED4SrnF3w@mail.gmail.com>
Subject: ''''''WARNING YOUR LAST NOTIFICATION'''''
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probate & Executors
HRMC London,
United Kingdom.

By a proper analysis of the ESTATE of Late Eng. Richard Carlson, I
wish to let you know that Late Eng. Richard Carlson made you a
beneficiary to his WILL.


I await your prompt response.

Barrister John Cooke ESQ.
PRINCIPAL PARTNERS: Barrister Kim Howes, Barrister John Cluster,
Barrister Morgan Wilson
