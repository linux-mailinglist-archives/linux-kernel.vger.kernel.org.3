Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22825128F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiD1Bmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiD1Bmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:42:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DEE771CA;
        Wed, 27 Apr 2022 18:39:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so6378063pjb.5;
        Wed, 27 Apr 2022 18:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G1leluFramTQ110uFeMYtj0/uQ9sjIDZs18cccbWMdU=;
        b=a6dKsmOXqD4p4Bdp63U6GbgzhlEGPBzjplSyTwDcu/b6ILcdAGJTe//c8NMlehAqVN
         auLottxS0LZbusYRPQenDQltZzfezOSzlp9FizNSMntw05j6EAa+VO64/+/46V9+rL9d
         B6YMHY2JAaDGi/prqX+q5fbmvhGsL7SXQnLsy0c7Tcreq71an88hFnf8KzXOKTBPDo/s
         sKBkS83bn//6VWjetqX7473aPZOVvkgSUd62iqJ5Iy4uc13jXfIcngkzNhsVgyYAdLOt
         Mi6OJTI9xmBaZM/eZ/l9JmBERooZzgoOjn2y1G7o1l3d8L3U4bUeK8K0e093tyQV7BfZ
         nveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G1leluFramTQ110uFeMYtj0/uQ9sjIDZs18cccbWMdU=;
        b=Fa0lIRRGLc0tB5hvIX6diKHZCUQJHenTl6byVflkTcW1y2omu5wzlUeYQu2OaS8WMd
         hjPSf1j1XPqX/F3cFXhooW+3ZTurCttgqWd99OpnqQA0fchXgn80eXZ5mQ9Mvi2TVTKt
         ctRGEQCFnILQaNL5VK/FhCY/e7OStx+X3HvV/Qa3lYvpVfzYsMlql8IQxMAQQqTrBSuX
         00S+MyEgbbcJR2VhHNT8V+Wdll2+q2VUXbwZu+AnWo1tJWvqOkiC4vQaJjLOF5ry4rGb
         33rUtkWudwDKsqsWKCjjAuoxAlBvZ6M2WYXR9Sh02cuTbjzyatOMnnNqukmSrwQzixAG
         quKQ==
X-Gm-Message-State: AOAM530JDIhqpicHj7ifHpqgmqxsaQGE1boKcyFkJBwig7DEkAu2g/G7
        cRZmPvHsfzSVdSmcXxLJ+lo=
X-Google-Smtp-Source: ABdhPJzFJ8sEMv7ChDaAgf3F4q4ACfSfHkyl/MLpZBky3ODkpw75rrj5zPUIJmSGGFWeN+G2RZey5A==
X-Received: by 2002:a17:902:e5d2:b0:15d:9e66:b3f7 with SMTP id u18-20020a170902e5d200b0015d9e66b3f7mr3381627plf.141.1651109976862;
        Wed, 27 Apr 2022 18:39:36 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.52.85])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a628100b001cd4989fec6sm8089370pjj.18.2022.04.27.18.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 18:39:36 -0700 (PDT)
Date:   Thu, 28 Apr 2022 07:09:31 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ARM: dts: qcom: apq8064: Use generic node name
 for DMA
Message-ID: <20220428013931.GA72033@9a2d8922b8f1>
References: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
 <20220421171809.32722-2-singh.kuldeep87k@gmail.com>
 <YmQjW4OYe5rTBP/Q@ripper>
 <20220423180934.GA35431@9a2d8922b8f1>
 <YmhawW3wAn7HAUVC@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhawW3wAn7HAUVC@ripper>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I generally never rebase my trees, as that's causing issues for anyone
> references commits in my tree. So we'll have to live with this typo.

Sure Bjorn, this was completely unintentional and next time, will try to
fix it before it's accepted. Thanks!
