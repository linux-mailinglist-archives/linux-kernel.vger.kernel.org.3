Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3449E5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbiA0PSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243140AbiA0PRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:52 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E706C061753
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:17:52 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id o15so2067709vki.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3L9dijJzC3e3/PCe51KV9pEonuhgRM2pwbe2CRq/cZg=;
        b=Hi1EbSU3KfSYW6t3mHRqxA7YFt5tK95/PMV+AHZgPTzxlY/b12QKGs6RJbVAjhZepz
         ew/eQOgDvEriqLoJCwiLplxCz38HtJ0hU4P4NWAM4y5pbab4xYnzI0PcHrwhFintDOYQ
         tv5e32a18VVXRITOk9uUvNVBPXt/8K6rgI9Xkx9B4B7hgjRJS+vLFs1KE9t6Dj9vCoDw
         ibRBOqQW5x5fbUqTNxKx1a3g5UEnnYGfvDp4lHuHsm7cQAORMeOiRnvrDvD6PG3tHYpG
         PqvgPRfPCIucMcs63yIol5xLAe2MbrIZojEv8AB+VP1cm3n2ZzCsWLWRa+ys+wdCGAld
         pw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3L9dijJzC3e3/PCe51KV9pEonuhgRM2pwbe2CRq/cZg=;
        b=BuGWQeMg5TMzhoeReCoGn+X6uYXV/t6cOugIuMr6S4apqohG6aqOUfovYiwZjCOZQy
         0/Uot4CVV5uYlJ2ALK616JIVZlWvnFpZsR74iNbZDqZuBgnHlEoa19+I/+ZInERpZJsy
         EGUlU994ir4CqDRmq6bhdk25KEFSsU+SSmEZExjq2zBASYJb/xuyiZIZA6i6mo/jFGye
         qXHE4HGySa7mkxBL82aQdr5cTDONAdtzzhK0DYLzY76HPs3sglSO2MHoIQsQgOyPTwoj
         93h9CsgK8kwp8TEug+/SGMokl9+CorJV9Gn3XDMPVVFw1NLhMNFE7PLa6dsuf4dIFus4
         Hk2Q==
X-Gm-Message-State: AOAM533DXpn3t1EERvzQqSlmnU5kFCvhx7q6L157JBFsJrqtJYcrCRbN
        VcKhBEenNWfp+r7DCkceiegWgbagDfE=
X-Google-Smtp-Source: ABdhPJyjiIlzgGCtbk84BcDb/DcnAiaFOK7aQjfzB2cooxpKWdiGGJHSHMHqHrGS70hrOri7eecG2A==
X-Received: by 2002:a1f:640e:: with SMTP id y14mr1852642vkb.2.1643296671278;
        Thu, 27 Jan 2022 07:17:51 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id r11sm1445066uaw.7.2022.01.27.07.17.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:17:50 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id o15so2067674vki.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:17:50 -0800 (PST)
X-Received: by 2002:a05:6122:1811:: with SMTP id ay17mr1708154vkb.2.1643296669982;
 Thu, 27 Jan 2022 07:17:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643243772.git.asml.silence@gmail.com>
In-Reply-To: <cover.1643243772.git.asml.silence@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 27 Jan 2022 10:17:13 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdp-ueFOSSsX2+wCFK2PwdVuRx=8WCV8GjKGOORiwHeSA@mail.gmail.com>
Message-ID: <CA+FuTSdp-ueFOSSsX2+wCFK2PwdVuRx=8WCV8GjKGOORiwHeSA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] udp/ipv6 optimisations
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 7:36 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> Shed some weight from udp/ipv6. Zerocopy benchmarks over dummy showed
> ~5% tx/s improvement, should be similar for small payload non-zc
> cases.
>
> The performance comes from killing 4 atomics and a couple of big struct
> memcpy/memset. 1/10 removes a pair of atomics on dst refcounting for
> cork->skb setup, 9/10 saves another pair on cork init. 5/10 and 8/10
> kill extra 88B memset and memcpy respectively.
>
> v2: add a comment about setting dst early in ip6_setup_cork()
>     drop non-udp patches for now
>     add patch 10
>
> Pavel Begunkov (10):
>   ipv6: optimise dst refcounting on skb init
>   udp6: shuffle up->pending AF_INET bits
>   ipv6: remove daddr temp buffer in __ip6_make_skb
>   ipv6: clean up cork setup/release
>   ipv6: don't zero inet_cork_full::fl after use
>   ipv6: pass full cork into __ip6_append_data()
>   udp6: pass flow in ip6_make_skb together with cork
>   udp6: don't make extra copies of iflow
>   ipv6: optimise dst refcounting on cork init
>   ipv6: partially inline ipv6_fixup_options
>
>  include/net/ipv6.h    |  14 ++++--
>  net/ipv6/exthdrs.c    |   8 ++--
>  net/ipv6/ip6_output.c |  99 ++++++++++++++++++++++------------------
>  net/ipv6/udp.c        | 103 ++++++++++++++++++++----------------------
>  4 files changed, 118 insertions(+), 106 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

Iterative review vs v1, where I only had one small comment, which was
addressed. NB: Due to some subject line changes, it wasn't immediately
clear to me that this was just a range-diff over the first 10 patches
in both series.
