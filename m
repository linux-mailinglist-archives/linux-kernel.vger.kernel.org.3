Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E25299BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiEQGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiEQGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:47:08 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87CE366AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:47:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ec42eae76bso176761627b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dcwrPtXldcZQuaUTRubP/TsWaJ05MpxYEGzdke58B18=;
        b=R9qVwZDVZYgr/idFDWYCCs4gn13+kzMPeII1mwEb40ID9CwNMVHHJDtxSlN9gA4rNN
         Jg3KRSrDeaTopIxTwrZpUKvESYUHpu7XssuML7jncRc9myqHIK0RwCZ2YuK/tsixgVQR
         CJlariUNY8Hp/F2bewVvnG+hZbgAFGN9LaxfOYaaWE1gtnSPsUEof6AMuR/x8OWTXpVC
         IQ4hOtC+5/KnwErPJVr/uNBqQ7W1rddcxMjlRdxedh7CjCuol25dFXwMOaIyaB++eieh
         Yq7WvF11pMKTJZHR+QrAN0zRi4chAlGa2bmNo2rE21ohJE/RHZdG/2JIaAJ1sbIwZCGz
         faNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dcwrPtXldcZQuaUTRubP/TsWaJ05MpxYEGzdke58B18=;
        b=Ou9okIKEMAjPuI82NZxTLwhqfdjVyTEmxE1pTYAIUGV21RUL7+m57665eQF/6uCEZk
         aalb/PAWqDLvSsdzFfG019leywTI1P4neIZtQDlKs2NjapE3WhXkW1P8BkezyfD2QTv6
         Q6D2ETjTfz56g+uBNtDiezCyH3O4TAQ8voo4E6db3rq2thAL2yZ1JXBWuoE1dCZPeCPj
         sC6qrmEE8cK5XEm+pj1gDvdM2VUmGiPIO2W0oszvwkJJ5SFGQBLsj5QP+2bO8+/gtqAj
         nzL6WXv9oUVfvcyjbrPIxTWXqsz1Es43mIPJn/fNoGTvG+WDr5GsRgIEzYIE6jlRyYrE
         0v5w==
X-Gm-Message-State: AOAM533OhD3SG53XAGFXp/BXKR/NrfxTOzyKnbvctA4Cbwmfo2e9zkc/
        BQnp7MxkfeS5h/EEHTV0N2pIoaomTS1rohBPmvM=
X-Google-Smtp-Source: ABdhPJwGwaIOEHhvcWJ1RqyYzYrzMSYh9fY2k41W46wFVU01ppFRMr69KIDMRBrcd0jbxFjpYETwzeFx76DGz5zDrCY=
X-Received: by 2002:a81:71c2:0:b0:2fe:c534:ddcf with SMTP id
 m185-20020a8171c2000000b002fec534ddcfmr19440085ywc.252.1652770023542; Mon, 16
 May 2022 23:47:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:8191:b0:179:888e:1844 with HTTP; Mon, 16 May 2022
 23:47:03 -0700 (PDT)
Reply-To: mrscecillelettytanm@gmail.com
From:   "Mrs.cecille Letty Tan" <kabiroubagna@gmail.com>
Date:   Mon, 16 May 2022 23:47:03 -0700
Message-ID: <CAP-q6B3YJgMEUzLf66LxSMm3eKs_YpaNEOZK1ed8dF47Ec_9MA@mail.gmail.com>
Subject: Hello
To:     kabiroubagna@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you doing today, I hope you get my message urgently, please.
