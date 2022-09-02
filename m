Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F235AB6C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiIBQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiIBQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:45:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8E257894
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:45:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so2555824pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6Bn341OZdaO1Ajjvul1ciSQkpdi2HXa6yajc+wV7KF0=;
        b=UuOUdc1lrwse1WuqW0nbs5Enufm53BNTljAMITm/SOp3cTseM4drqiEWGUT6Ap+4uR
         3qoM7aCRNpmGXnc02t3bwILRhmyfwOz4tZthXvlUeXpx1ECGr7OS3RKfaXjxReHvx5ZU
         CbZcAdAYjrk8beZYak1peIWRdGKdhQ5f/gpNcf0T04O6TYbQNESS1hJXVpEziNmH+8sn
         f1CnQKS/uz74k2uwRzDegUpDTSVvk+VUOZFRieJRYwXh1OlJ67ptHxr0G7plbS8S394q
         twQiPkYadduhLtmHaN5p4FcQUssaqPT9ngxmx5gfOMh4cVKyF+PJmQOAtWmgt5YTQvCw
         2kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6Bn341OZdaO1Ajjvul1ciSQkpdi2HXa6yajc+wV7KF0=;
        b=5g0w59QTxBJyQeY3Cv8ef+bIN0Dj3ZvRfy/5tZLkNbcfUrTME9vtx3TxIzpJ8CmTME
         BGOpW9t5h+CdVc8rMRSxayjIgkJYWmXTvq/WEzPTmoXYMVeajDZkNm8r754vQYX1e//i
         ZBycIGNw6qGf3i3ybo3+BwWt78Wg3KLQQULbXtx1w/ZsB57svdKWMaYvuYPcFsY+F90D
         3ujRnVfwhL1UxiYUnWq1tsRCJ/l8JMf9UiTbcAtJiyki7ubqzDPpi8vP3y0PcuuP50+m
         ugSo1HK8En78+gNpIjPfXnO2R0YlwklUvYxl8TF+w7ioogX178w4QzGSuTMbfALq75oh
         wQMQ==
X-Gm-Message-State: ACgBeo18ySqEe5upv0VTxZka8Dr0DNhdH3svV6nXlhFgE6LCp+PQd95u
        89autetUDxgmo2Y6/gmKakKbzdydgaOzK7oc1m8=
X-Google-Smtp-Source: AA6agR5ea0NY94qclq1WPIQgFvItSSRmJdBaFn/nLRmCSHqulCNh3s89fQEtSSzn6RIIyJbg1AXa/rTbDVrcRwMBDBA=
X-Received: by 2002:a17:90b:4a4c:b0:1fe:24ac:2bb3 with SMTP id
 lb12-20020a17090b4a4c00b001fe24ac2bb3mr5772326pjb.79.1662137158046; Fri, 02
 Sep 2022 09:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831052734.3423079-1-song@kernel.org> <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
 <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
 <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com> <YxF69izHufARLKqA@MiWiFi-R3L-srv>
In-Reply-To: <YxF69izHufARLKqA@MiWiFi-R3L-srv>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Fri, 2 Sep 2022 18:45:47 +0200
Message-ID: <CA+KHdyWijMSuNaT4vQ-tqyrJC_GxL++rDj-s1WZMkDi=8m3p1A@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
To:     Baoquan He <bhe@redhat.com>
Cc:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Even without this patch, the debug path would work correctly. The
> > difference is just only in
> > whether roots are hardcoded or passed over function paramter.
>
> Calling find_vmap_lowest_match() inside find_vmap_lowest_match_check()
> will fail compilation because the function interface has been changed.
>
Ah. That makes sense, though the commit message has to reflect it.
So it is only about compilation error if debug is ON.

-- 
Uladzislau Rezki
