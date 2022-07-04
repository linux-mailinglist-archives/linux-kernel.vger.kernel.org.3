Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3971B5657F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiGDNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGDNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:55:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A5BC9F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:55:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so9026224pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3BaWzCX2gs48m5o657dKNWJWxvbd6VVhJo20O9wNYbQ=;
        b=k34J9jCFQXFgd75z8EpNYtm9nt4YtS6IddVzJjvAThdloBININOsCaRGt19bk+hEjL
         DSqTC3h/vzmSHJC4P3069eoIumo2B1HK0WpkH8c/cibo8C00a9TE0sdLJcWuNkgYXpPD
         oTuXQTKP5U7HGJjQrCxVgvAtCgIH6Q7UqFkEHaL8ihg7ChqbiebtmXp58gznbBSJwOTT
         AjyLLGKjbli61c5azh7qDZLCPDBGxFUqyv8a6hyYG2rzgeeLBsjzHbOdZUX2DlcrMfgI
         +YV+OdCpFL7pqRjdCj3A0YWI/YR6ByRzscSY+FfQ0YFCm5pIA6qLb+J75xvpZyv4eRco
         fvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3BaWzCX2gs48m5o657dKNWJWxvbd6VVhJo20O9wNYbQ=;
        b=S41UF7+eX1mR+WBeidKf7qhFoce7VfTbyN6YiKUA8FI/L5atwt8Zx8iigV1NSnxWNO
         +Jq0LWAqg15i5vEGMAcOkokhBf+0G7sNFtsU3jse0DErvLozLrprMC0og6vi/L2uA4Gl
         3OGIZYc1Oztoc6OOeBt1YDz9XYDq9OT4U1QBETO7SoegamNYI3qSQ77OsqDf4RmoQJcE
         ccq9NXpqQmkVV1Vnt1jM8hToS4CxdIB1Hv1zOouTnd9JaxRlGph0KwKIQmj3p1wZbV5r
         WbjqXgemf21nPpObidZ2yd7QHciU9K29WCrpiZWMxcmh/yz1wqCcTAEKSUxXeJN75GDY
         IMTA==
X-Gm-Message-State: AJIora/UL6BI+M2FRzpQuSYHuoeG3SswmECY91ANi7JSiYAGz1+RRBLd
        Y0cOHAlRK4UWLNFnnrCRDlwSIA==
X-Google-Smtp-Source: AGRyM1vdAz3v/h9OadIpNWHBuh7HykTHQFAoZ7auI/S4hb+OgBx6vM+FYo/ta9/E1puKPzK+iXUiuQ==
X-Received: by 2002:a63:854a:0:b0:40d:1d04:769 with SMTP id u71-20020a63854a000000b0040d1d040769mr25787540pgd.151.1656942936709;
        Mon, 04 Jul 2022 06:55:36 -0700 (PDT)
Received: from localhost ([2408:8207:18d5:ce0:b44a:d6ac:cbc5:89fd])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b0016bdabdf64fsm3600847plg.46.2022.07.04.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:55:36 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:55:33 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] mm/huge_memory: fix comment of
 page_deferred_list
Message-ID: <YsLxVek1w194qGJt@FVFYT0MHHV2J.googleapis.com>
References: <20220704132201.14611-1-linmiaohe@huawei.com>
 <20220704132201.14611-14-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704132201.14611-14-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:21:58PM +0800, Miaohe Lin wrote:
> The current comment is confusing because if global or memcg deferred list
> in the second tail page is occupied by compound_head, why we still use
> page[2].deferred_list here? I think it wants to say that Global or memcg
> deferred list in the first tail page is occupied by compound_mapcount and
> compound_pincount so we use the second tail page's deferred_list instead.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
