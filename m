Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5017530C14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiEWIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiEWIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:17:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8211CFFB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r23so20179367wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JO19XUtUb4lxcpFq+kOX3360ZXpGqMHTnNEdiX4alJQ=;
        b=oVFYX1Zw5Y6P8a1FwORUPcHrW6d5k9ZpKqhKqU4NIzBfpNFluktusjdT4JLrn5GZnV
         N5YqK1qj3cjbqwTCwa+oo4VGnWDAdPy/lInZ6hWg32AQzWJsdq50oXdipbv4JdGjfhBJ
         0oYTTeA/hOcXeszwixqCAiwKmYlePtlEBr2kqd1lLf3Zo7vYji5pHjltUGpdb59dtVWo
         LAPmZgWGd2PgqCtRL2hRLiJaBcsezaqlPdp3sYHPp8J9tjsGFkNYQE9AJgJSDloy3R2c
         eHGshr7MRlwNfNMS5PRRkrJsaxyuLIcSKKXXkL543cNRXCHD8NCw43QsJ6qoQzzB3DaB
         s+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JO19XUtUb4lxcpFq+kOX3360ZXpGqMHTnNEdiX4alJQ=;
        b=uReCSAIoGxdcjZruAmokaFvF6K7GrQ1rfPyFXLXVBYvklLis5sYBALRO2sw1rroaMw
         HX/bfXsmQ9TY69QiX2Hh8YYUqx7IEFa67Up3NgSNDjLwKI/RbtprUql4H0kzrQAzqybL
         wpv8VmvcU4xFEKSUt9lk0Q4yHRXpbaR6IZmSuJTvtrlowEoS367goA/euObTMqH2yCtW
         cbnxNXCpuT+chW4JRB9JsCe/iJVhI7L8UscO7iTrLzvfMM5IRLANpH4W6bf7vdIAfwHL
         sBeKKF84WWj/6aUdRBIdyy/QdMbhOijrDGUCcl+BAAu9pA+8m0zmkvNbYMPFguB+6ZG7
         P7kw==
X-Gm-Message-State: AOAM533foyiNB/2ELA8Py8uXh9FBYtJp7WwMjfPt9Dc2X4qUD7TAX91w
        5UW9/yfIlP/tLW1eyfdL2wLLXebrBkJS7A==
X-Google-Smtp-Source: ABdhPJwdzLWac9MQ6M3zTnAx4pg+h57hxJxn9X7zy62qNB3UMo+u7fITcsiNNCZ+i9ucHRv60mdn2g==
X-Received: by 2002:a5d:48c1:0:b0:20c:52e9:6c5b with SMTP id p1-20020a5d48c1000000b0020c52e96c5bmr17193399wrs.233.1653293819239;
        Mon, 23 May 2022 01:16:59 -0700 (PDT)
Received: from krava (net-93-65-240-241.cust.vodafonedsl.it. [93.65.240.241])
        by smtp.gmail.com with ESMTPSA id e8-20020adfa448000000b0020c5253d8e5sm9483885wra.49.2022.05.23.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:16:58 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 May 2022 10:16:56 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] perf inject: Minor improvements
Message-ID: <YotC+NbrBENmqtAh@krava>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520132404.25853-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:23:59PM +0300, Adrian Hunter wrote:
> Hi
> 
> Here are patches for 2 minor improvements for perf inject:
> 1. Keep some features sections from input file
> 2. Keep a copy of kcore_dir
> 
> 
> Adrian Hunter (5):
>       perf header: Add ability to keep feature sections
>       libperf: Add preadn()
>       perf inject: Keep some features sections from input file
>       perf data: Add has_kcore_dir()
>       perf inject: Keep a copy of kcore_dir

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/lib/perf/include/internal/lib.h |   2 +
>  tools/lib/perf/lib.c                  |  20 +++++
>  tools/perf/builtin-inject.c           | 162 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.c                |  14 +++
>  tools/perf/util/data.h                |   1 +
>  tools/perf/util/header.c              |  62 +++++++++++--
>  tools/perf/util/header.h              |  15 ++++
>  7 files changed, 264 insertions(+), 12 deletions(-)
> 
> 
> Regards
> Adrian
