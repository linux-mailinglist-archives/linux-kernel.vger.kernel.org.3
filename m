Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A006B539A6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348807AbiFAAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348811AbiFAAim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:38:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3148CB38
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:38:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so75662edf.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yVbJeLTdQjW4iyHS7w2sW/eH8EUfczFgigYOAZThv+k=;
        b=S+jsy1dztvI0Krgsi+xAQEuiWFRH68Jc4cPZJ8O02WtvgJHwxdE1eHqii33Battqln
         rGhZ//moewLN1auGlUrK7yP7lsL1iLZjKprixUi1sF/mcD/VzjO6VzjISWR+hjARZuUf
         pw6D08Wg3zyXZVdlQ+/jyhdQ9OH+MsHzykK7GXfGotS/0k93gHEil1SxU671X4FEXolE
         T77b3zCPgtE9cWUjAHwe5OdtNlpjYOXgZDTsR/EIDPhtBF6IShFDWuJxS+FKHOtaxP+Q
         EIVIbH2HmjmoLpEw7uUR9nVbvCU4dhGAPeEh6u6negdps/dsQ9xufEwisN3eb/QGjgYC
         TH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yVbJeLTdQjW4iyHS7w2sW/eH8EUfczFgigYOAZThv+k=;
        b=I7ZUBwvS+7PTk38IHjek/tVN/NhZzyZ6vGpNopWSCRjCb6gn382eCU9xCTCwzsnrOU
         ArVUs1/F3yNvlIfkHedStJ9qzrjDTKTz5DQ533CalMId/D/dvWcpKy9VjcP2Q3CZQM1d
         7txsoCmTbDMJJP+DEg7dGoeSq7vLvvbDftZsxIepuVnYH8AMDaTK8ojUAJd3ugCFc174
         oLwo8TRjHh2QTCUNfbcrB1aziDSY0PNFgpY0fmFT1DWTj5f4Anvu5lf6BRjBLd1FP+DN
         i6LbmcCpdfFrtr1ACxZiH3pzfhlWK9JowEFg1baUzBjH3XsfnyTjrNH0w4YOPBToBxsu
         QfsQ==
X-Gm-Message-State: AOAM531l2fympSQAdVPV1lBJtV0oqD1wOwI32K5CSsM4GHcy0iJh8Ia7
        d4yfNc7ce6LqMvN9CGz7bYjf4bYfmsE=
X-Google-Smtp-Source: ABdhPJwgVGDiU1n12nwvSJ1Ta7zNsbGzOnGbXBth/fn6L0IG7K4dAov+VY/URUw4YndKyOL7luMvsA==
X-Received: by 2002:aa7:d456:0:b0:42d:d7d9:34c1 with SMTP id q22-20020aa7d456000000b0042dd7d934c1mr10846247edr.21.1654043916617;
        Tue, 31 May 2022 17:38:36 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id si8-20020a170906cec800b00706ed5afdc0sm85967ejb.120.2022.05.31.17.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 17:38:36 -0700 (PDT)
Date:   Wed, 1 Jun 2022 02:38:34 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes
 address space '__rcu' of expression
Message-ID: <20220601003834.ilvx2pik672yxuxt@mail>
References: <202205222029.xpW3PM1y-lkp@intel.com>
 <87y1yspmmh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1yspmmh.fsf@toke.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:30:14PM +0200, Toke Høiland-Jørgensen wrote:
> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
> > commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu annotations to redirect map entries
> > date:   11 months ago
> > config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
> > compiler: ia64-linux-gcc (GCC) 11.3.0
> 
> Hmm, so this is ia64-only? Some kind of macro breakage? Paul, any ideas?

Hi,

It's surely IA64's cmpxchg() which contains lines like:
	_r_ = ia64_cmpxchg8_##sem((__u64 *) ptr, new, _o_); 

-- Luc 
