Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26D5166B2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbiEARjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiEARjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:39:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67051EB4
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:36:13 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f863469afbso104576077b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3VgEodFoqdEn7TpTTCdx9i+wRJ/ovbu1piMWlMcHA30=;
        b=bSSYdl7TFPH9Kl0RJ+Gzul6wLStpL1UZ2iwO4ycmgNZFnwtrNm4g1i3FIf1BMW6GJ5
         u1WjfBDafWWBR6s3TNTQbIG/FKRH2JdsyjdI72HLZMPvXxE6pkW4c8jVoWaFhNhENaFz
         CfKhnfrsGg78elgQKjzypfb9Z+dXuYkk9KwBDxjPzQs8wS5jHdrhLzxfX8k3XL769px9
         QQFm6SzrAx1Nrfby7p8IePt07rFtNxJfUG7RVBbzC4N727oNhRjarG+U4aZ4wqJAIuEJ
         6l6FhnoK60yHqijBJlHjJXEu83JbOm8Hpmoh6hNoaXpIqpUzcEkyL5w12rwoo13y9WUv
         4L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3VgEodFoqdEn7TpTTCdx9i+wRJ/ovbu1piMWlMcHA30=;
        b=rtjYzL3bD9tOvDd5WWj8R79WTNh116ISFAwWBOedVS3f4arnTdUqWutBEuQQ2UK06n
         1IdlENRT2AnLhcHI4UIvAw0F4PthlJKZTpYSIOGLfKh+Xz35riH5Ag/7SMgXAYbH3on6
         BXwGrlRBf0/x03AtOauSbWaKKLYb0ZPOPBHCsuWsnTB1/wvNBo5+lh9rYLtB9b9ieM6s
         YBLg6w0dZXqYk/BpQiW/HJMcTkRddb3os43calgXP/6+iEPho0E6v9gRvM7jW0uf6c0T
         oOwT8Q9ZJ4/YS96o1DWF1mUueQ8rQJolpMjRNUb8PCJ/YHDy0DRR92zBsHe6+v7i/wIT
         eOXA==
X-Gm-Message-State: AOAM530cUvn4CXNL5dOXielAWkaPMp83DXP2u0oKfLr7o+d6FbXAgyPm
        ZwsgEQhyCHD74nujx9q5WDb+KSg9d4GxSliGPhQ=
X-Google-Smtp-Source: ABdhPJyx1yTzV/oc9dXLHk2L6LTKNtg0jN9B8edrxzJimq+wamM0VuWzpPMGZEP9yoqbpBYC3hTXEjWA/UrdB/WJF/I=
X-Received: by 2002:a0d:c503:0:b0:2f8:a359:637d with SMTP id
 h3-20020a0dc503000000b002f8a359637dmr8437890ywd.157.1651426572421; Sun, 01
 May 2022 10:36:12 -0700 (PDT)
MIME-Version: 1.0
Sender: ikumbani3@gmail.com
Received: by 2002:a05:7000:b50f:0:0:0:0 with HTTP; Sun, 1 May 2022 10:36:11
 -0700 (PDT)
From:   "Mrs.Linda Alexandre" <mmelindaalexandre@gmail.com>
Date:   Sun, 1 May 2022 17:36:11 +0000
X-Google-Sender-Auth: Z_Uty5g7rkUpnWXLJmCv_U2fPAQ
Message-ID: <CAOE4oCvZ23D76+J=mHoAD-7=3PVaSqYPR9S-DcezKLoaqJA+tQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Happy new month,

My name is Mrs. Linda Alexandre (Legal practitioner). I need your
assistance in retrieving my late client's funds worth ($16,500.000.00
U.S.) deposited with the bank by my American client who died on a
fatal accident together with his family.

Note that your surname is similar to my late client's family last name
and that was the reason why I have contacted you to assist me to
retrieve the funds. The bank has issued me an official mandate to
submit the beneficiary's name for claim or they will confiscate this
fund and close the account if no response from me. Get back to me so I
can furnish you with more details. There is risk involve.

kindly get b ack to me urgently.


Regards.

Barr Mrs. Linda Alexandre
Call me +22893945334
