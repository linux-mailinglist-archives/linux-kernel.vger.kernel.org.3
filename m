Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302845984AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbiHRNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbiHRNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:48:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74710F8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:48:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so1728481pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=HD+7cWtKNM0dXBvDhCWxrvtLlT8HapdLzulw25Ng/z8=;
        b=fOB7FulDhDA4IhXPIoMefNJDOLDcLY1SxmOPOYbFef8q9MFBBgu+GS5ucLxp1GIi3e
         /VyH+nnw3UIWJMPVmIWppf2aTSTZOIIrTbnC9Du+uSGge+i4OGqOEH6f9FSwuKFwusda
         v59sXtvLZ4FYvZAQhEqAqbZK3Q04GXxz72V27a18GbF787u41frsjvUGYj8+qYIR5nti
         L3qYpZDFLImyY10KSjcBYqiQepxRJ7d6ApZ/pPMcRa5rCqB7WQ8ZGo8jYSwy7iXWvptt
         k8i14gqLUMMxw23SSiL6yyp+jD8bks0FtmsqxHDVYb76Z6iYhMj8O2aJlHcMN5mvcXxI
         NZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=HD+7cWtKNM0dXBvDhCWxrvtLlT8HapdLzulw25Ng/z8=;
        b=rsQcylouT4z18+u7n+J/2HaFhp0XAzg33FueJv9Yp+Zw3CLrrRqgP2szo3LOWNZ25O
         ALa6t7JgD9E65t85NMTO1Apyuk+8pu8AlXnTeq+7ONI0xit18SRrkh/gNK0TVzna+DLW
         CfLe0gAppQPpJBNRcK7IJisM4q393E0LT1DkZMWFqkwb/9JN57Q2XGSL10NVVIotPgvR
         PoKeE58+ChGG5p+4UhKpIyAhq90h/YujZdF6UfuUSFKJFLWvwP+CC0rW+o3bMdBuE+lK
         PtwH9GFtcePHEm6GqzB0OYlxgD7LLrbvfSlJcpjRJh2yBAHmw1jEfgP1gwKha6650d0E
         RQwg==
X-Gm-Message-State: ACgBeo3TRY32yzfAds7qyLkvCvkf1SwvzoQc+Etj8+lKS7RFj1LEst1y
        MGJj9PjvC7j+S5meZY2NHvYBgoD4wrthC8yo//w=
X-Google-Smtp-Source: AA6agR6pYbL2LK8+WtYyYMx2q1u8N3i2j8XZeu2nf7ru2+iDO78IvS75IhoahmaHFicHRpnVtpO9bCmjDAsrMiVayoY=
X-Received: by 2002:a17:90b:4a02:b0:1fa:c277:125e with SMTP id
 kk2-20020a17090b4a0200b001fac277125emr3354847pjb.152.1660830524558; Thu, 18
 Aug 2022 06:48:44 -0700 (PDT)
MIME-Version: 1.0
Sender: issoufsawadogo381@gmail.com
Received: by 2002:a05:6a10:6d29:b0:2d4:363f:2fc6 with HTTP; Thu, 18 Aug 2022
 06:48:44 -0700 (PDT)
From:   SGT LINDA WILSON <ssgtlindawilson@gmail.com>
Date:   Thu, 18 Aug 2022 06:48:44 -0700
X-Google-Sender-Auth: 6VIqXAX-KyqbOPrk3l5rBa_4qvU
Message-ID: <CAEznJc3wvcnt+_T5sDxTi1yrx5fhkLrTTBeLUA48PUH05EThkw@mail.gmail.com>
Subject: I NEED YOUR URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HELLO DEAR ONE
AM SGT LINDA WILSON
AM CONTACTING YOU FOR AN IMPORTANT AND VERY URGENT COOPERATION WITH YOU.
PLS REPLY TO ME AS SOON AS FOR MOER DETAILS
REGARDS
SGT L WILSON
