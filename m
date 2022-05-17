Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322152A59B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349604AbiEQPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiEQPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:05:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DBC41F90
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:05:13 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u3so4256042qta.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MCY4uzvF5gG6SZvOkl+KeT1pZWIXsOfXp7FaroiDkt8=;
        b=BBmt88iDLABtUqG6cBNMPMBDf6xu/ZV+Zj0k+QA0Bbn2Vn5aQv8ii0r8FSFqoQ8H61
         CWYmJOhz3ET4YUzxO3Pjo/hjwZza2oPsPE8hcO0P5RYXZxyxOyUT8aTo1sFJ1foD2ZlM
         HodPO4PIDMUvaT2lvxMRNz7FDizVe4cEcZIhMaqaNmitr0tfkdcDqpKf8M5J6qNYCSuT
         f/X3YfMThdyunmW3/AgU7VqM2KpfaoM26xUh/3mmH1ZY525npJbgO7bCRlbFOd/Qa/HG
         BKTtLbINh7A8QVyaV/vji81E0kjzb6EfqlkZncQy5ZBxPSCBUPxHyeIJTiG/dX7r69K3
         JRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MCY4uzvF5gG6SZvOkl+KeT1pZWIXsOfXp7FaroiDkt8=;
        b=J8o+5x7+TydrMgh3aug5IgRAF3IcP34cc0DFifld4yh1OAvMCnHBUxVerGKOrX1bKl
         JN/SEBZ/9T4wELM4j9eq9nKiU2VQrKABM7oK58BxfmKqj5iopf0s1WXdLL0Hrr+L0mZ9
         mxjRlEBf8np8hNcXfzl8WCOLu1TscW/rSc0XK/82oPDqgbggP2OekxGfXnam927VLkdV
         Y+AcuWyt9DGhpMc2xVEJlCCY9KL7B8xLZW1O9Eb7V7V/TwC/HqSlQIoTjsd/w8dZeygd
         zBSIU82oTxSjS1W/06LABErxdzTAfWH5DUDhLhEqLND+QVB+jGIULsPOMVvH6/IcKclJ
         un8g==
X-Gm-Message-State: AOAM532YY5nSxj9yG3764OUiut7iCCKbguEO6PuIL8w6vqWYKudsxTjD
        Y+mDe81gXTysZ9tqwQmcHqYMXLl0etfYNg==
X-Google-Smtp-Source: ABdhPJwjGd5l1Uj/gnVg4lIxRIeQzw3bAE6pKJ9sZKh5xkEHxceIf9tMEOHJ+K3Ffhp2+dvs2zB8KQ==
X-Received: by 2002:ac8:5a8d:0:b0:2f3:e201:33ab with SMTP id c13-20020ac85a8d000000b002f3e20133abmr19955279qtc.470.1652799912993;
        Tue, 17 May 2022 08:05:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b35b])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a208100b0069fc13ce205sm7612845qka.54.2022.05.17.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:05:12 -0700 (PDT)
Date:   Tue, 17 May 2022 11:05:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg reviewer
Message-ID: <YoO5p6jXUd7gujuy@cmpxchg.org>
References: <20220517143320.99649-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517143320.99649-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:33:20PM +0800, Muchun Song wrote:
> I have been focusing on mm for the past two years. e.g. developing,
> fixing bugs, reviewing.  I have fixed lots of races (including memcg).
> I would like to help people working on memcg or related by reviewing
> their work.  Let me be Cc'd on patches related to memcg.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
