Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92354D0518
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbiCGRTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiCGRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:19:22 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0492E091
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:18:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u7so21417450ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fungible.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PytMAvERvamFaZa2mj5LMYSOqi/GBoG5kLYBTiktqF4=;
        b=T+dSeMWfcde2IMq2WUbaYuLqzEIakHQTrdFu/RiI3mChnzXdpRv+55gHKXnNrQ7OTQ
         h9aCbBjLij3fFFlTaUgAPBZ+hfgXAUSpJGn8ZEcHmsG7BrWcjhUyAgSAbr71oFbd7ihM
         ezjO8fkfFFAJOqGQZOIsPnGT7/ZRa9s3eGn4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PytMAvERvamFaZa2mj5LMYSOqi/GBoG5kLYBTiktqF4=;
        b=0XrRzsyAxIW31kMYEL7HIAAzlypU7kfE+xxrfmuKjEQjx1s0K/4VoYQtaGRqiFHXGn
         qliI/lSvAAk0Ku6vbgdukCEGUitx4yvp58fTAPSnDlS9FS9brJZMizg3UUZBXAn5BXVF
         fWZaSWQMTGyIpDmEqXldJcMSsVqllcaGayVp7IZi5PH+OwXaxJPaxq2pLdZtWr15CqLg
         XHYPimkB4e2tYk/4MCpTdV7D4J66ys/WG1PqYlql7hzTnYj+eiyF2ORJvB63dxp3P9e/
         fId97Win7vykpHg3T/oALYaTxDqQ4iRtZXZf/cgMCOcWoUpWlY3EAb3DQs/X3z+8vgrb
         0J/g==
X-Gm-Message-State: AOAM531SiMZ5sHi+SDyjApLe/suNIKXhXStm9ZNi420yLdsm+oThXCQM
        TOEgUobE4GNb84bEJ5Tqt4adn4eHh0cRMUJJUPoyTNqz+wM=
X-Google-Smtp-Source: ABdhPJzeDulbdEBe1aXrA3wisAoL7vLDU4NWEToPGu7WCSEho7enCbGd/lemy+S0Y+Yp1jhMoep5A9rr8ih9oTxIJKg=
X-Received: by 2002:a2e:90cb:0:b0:22e:5363:95f0 with SMTP id
 o11-20020a2e90cb000000b0022e536395f0mr8195637ljg.210.1646673502736; Mon, 07
 Mar 2022 09:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20220307214539.473d7563@canb.auug.org.au>
In-Reply-To: <20220307214539.473d7563@canb.auug.org.au>
From:   Dimitris Michailidis <d.michailidis@fungible.com>
Date:   Mon, 7 Mar 2022 09:18:10 -0800
Message-ID: <CAOkoqZkCN9SiG41MmaD+Qv-zvTftz=MDJeiuDJfV2Ws+ezBS_g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:45 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (powerpc
> allmodconfig) failed like this:
>
> ERROR: modpost: ".local_memory_node" [drivers/net/ethernet/fungible/funeth/funeth.ko] undefined!

I will take a look at this.

> Caused by commits
>
>   ee6373ddf3a9 ("net/funeth: probing and netdev ops")
>   db37bc177dae ("net/funeth: add the data path")
>
> --
> Cheers,
> Stephen Rothwell
