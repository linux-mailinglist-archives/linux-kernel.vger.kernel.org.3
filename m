Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A42587DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiHBOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiHBOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:08:05 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756D29820;
        Tue,  2 Aug 2022 07:08:04 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DBE8040888;
        Tue,  2 Aug 2022 14:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:message-id:subject:subject:from:from:date:date
        :received:received:received:received; s=mta-01; t=1659449280; x=
        1661263681; bh=8KhPfch9J7h2naik4dg4WS1DAhTDrtuGEqDEDTTZIds=; b=O
        y+GdHXelDTvgQN6jYrmyahCacfCwh6k1GCvXWWfOAK0LaNPqVFD0ly9iGKcxZ7sy
        hpcY5z5lgx5Nyp2bjvfaec2z0p0tTtFjrxSisF86losphuFBRJ7u2ZTf3VmFjfWM
        xm0J1gjaJ8GNTjuFxwEjDzUPEvupPVw1xd6AUfQJ2A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ssrL5wjlEuGi; Tue,  2 Aug 2022 17:08:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7E09D41240;
        Tue,  2 Aug 2022 17:07:58 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 2 Aug 2022 17:07:58 +0300
Received: from yadro.com (10.178.118.226) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 2 Aug 2022
 17:07:57 +0300
Date:   Tue, 2 Aug 2022 17:07:56 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
Message-ID: <YukvvPOOu8uZl7+n@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-29-ojeda@kernel.org>
X-Originating-IP: [10.178.118.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +module! {
> +    type: RustSemaphore,
> +    name: b"rust_semaphore",
> +    author: b"Rust for Linux Contributors",
> +    description: b"Rust semaphore sample",
> +    license: b"GPL",
> +}

A minor neat, but ain't it possible to use &str here in order to drop
this ugly binary string prefix?
