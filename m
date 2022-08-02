Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBE05878D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiHBIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiHBIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:16:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30E19285
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:16:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so12435939ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=BlgVUzLcNk6nPCzP4HZtzqs1YrqAnjzgG6xgPn5nG6L7Ma+k+2NRBZ0m7DGn35OYjf
         Kf7m8KpeFBB7FuNfLm1xMkNgkY8mV4MsFczpHcETDV3eDmrr6xPCJvvQGKGa/R17VxML
         f13El9Xpo3RxTOH6oh/k0uJm7KW60GNCN59ESlcRi52hatYAI1CdbUhCqogDZW+mxMh3
         /N1bgiCxXA9JDDZBlh0S6LU/j7xouNXmQkfGjmUNiw3Yjez1a0JajrVWPAQ455avnmlM
         pi7X50kzwXrYWx+d9kZRhhkv76gUcJ+NLgIXJAZiGeUqnqxs5AQdO6oGmhM+SwfS1PmS
         AU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=t+pQa5dRvfaXNuusnmsa3SIVfyR2GaEPDHqht+u9DDE=;
        b=7+ySAvSD/iNKN9H4iFglGCzzyRucmnMTa9IVOqFwIK9OvF9YjRTXAqMqOtXCc6lVxy
         3qD+lzcWo8KvPt2qQeW7jlYUYboDzRZPNo52PBB1uaEp5TBd/+ANKpUKZOY4B15zG+4o
         ngJt1vDjCFBwXWxnAttFOJZg5Ve4FfccUrQFsKHVdUgPP6gIuVTB9X0u5zrq5fBq7lLE
         WzmztCyzgahEN3hIfm8BnQvrv0l4uXo5+Ifx4rdh9bVelCSGBA+g5mb5XOT5B9LyLs3P
         E9Nuu1+zDfivuHNj+IZKBJ4tqotMVNWHGJDvYqYd4J6UWlw5bN6r8n0mhF18an0hWip+
         dtkw==
X-Gm-Message-State: AJIora9fozIE8zp64gsIoJT4dEtJ5h+J2SEsgHiLRdmfxZ0uNwgNoNWE
        oLzg4sV1ZwRvuaaqmwPlnbdNB44gugoUQt2wNLw=
X-Google-Smtp-Source: AGRyM1viZMGF966+RJGbbHArBOM3BIYnlrSbbERjHDRObZ3SUnNc6sQaiL1gsgjq755QoEpM/eWbZ0B/36S7CPx+8O0=
X-Received: by 2002:a17:907:75e3:b0:72b:198a:b598 with SMTP id
 jz3-20020a17090775e300b0072b198ab598mr15623092ejc.401.1659428179782; Tue, 02
 Aug 2022 01:16:19 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsabibatuhafiza1@gmail.com
Received: by 2002:a17:906:2dd3:b0:730:8417:5f39 with HTTP; Tue, 2 Aug 2022
 01:16:16 -0700 (PDT)
From:   Mimi Hassan <mimihassan971@gmail.com>
Date:   Tue, 2 Aug 2022 09:16:16 +0100
X-Google-Sender-Auth: NHvzQnh-oKMl5O4r-BtJGn5lSQE
Message-ID: <CABzhNW0GCc+t5Bt8N6QwqJAJwZkuvSu0sTzdPE7BxU_xW4WR8A@mail.gmail.com>
Subject: I WILL TELL YOU HOW TO GO ABOUT IT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad and i was diagnosed with cancer
about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
