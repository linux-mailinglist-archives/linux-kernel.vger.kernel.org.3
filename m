Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B153A940
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiFAOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiFAOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:35:44 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592C222BA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:35:43 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l1so1596234qvh.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PV8wB1DGk+ovpxW0ZzDEp3iwz6LskTQ2PLaIigSoOEc=;
        b=cSdHfsPPQ0N3oKJI7iCBrmxP1LrZKyTUgBJ+MU8mYFCPVlXqZMm/O62CuGhF+6bf7U
         +aRhSZuXjicqKdiwsN7l6iNBLVQ7suzO3ndC/FHqw240P48L8uR9HD399VfxsuponpAH
         ZCkqGShCC2wXuXysdRgJqfc5cluXsvs4VOiRoPSt7B/nYxuhJoN2ok6p2GG8CbuFiv8C
         jejpSZJ9oiBlvg51Rsj/62H+7jlczrnnRu5bi+O0gjGM4W79M+Q3quILTOs5iArUxJwp
         0/Q0OZ8qbXr0vTnnfcfW9ziZQCWzpTAlk6oRc871Tilwf0YrexG/05OMntE7UK3WXCVq
         RPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PV8wB1DGk+ovpxW0ZzDEp3iwz6LskTQ2PLaIigSoOEc=;
        b=5jIP0xzPbLXCZfsMJouL59uHaj12K2468YKJBySF0V4//ehkP686XjzfYlGswarUhO
         ot8sgGCIzN794WB3ROM7tylYYz5HTFA8dXEuQcpHVFKOzJ2Y44TLZUu9HBScXjHQSVOF
         sf07PmmW8roS9fvjK8ocmKNWpCg/owlEJgJm4Hn1Tt+nNbz5TR0czYmh7i/BPucBTmbC
         5lkfdN2h8f7CIYdcEn/7/KHL8QEGXzKpFfzDNh95hNYEJ7/b6W0ccgl4BFgDoszEodhZ
         SgfMTGFVvLE5tvIYLcF6Pu+0v02YJHP88Ca94KQJ7u29pwqJvcHN/7/wALbUkqfYICir
         v8Pg==
X-Gm-Message-State: AOAM531t4lofKyEZIZxX09N6qGPYx1Uhel/ExaX6/zaqMD1uYJwjFoE/
        1fpsEgoJQzq7V85XNO8tc6Tq13rimYgiUA==
X-Google-Smtp-Source: ABdhPJyTgpXeY8vG9pTLoy81tlD47fvDP5nCgZI+M73tdmCOWdXI+5a0gAGYPWQD+cSBfqea7t6rSA==
X-Received: by 2002:a05:6214:3006:b0:462:5472:86d6 with SMTP id ke6-20020a056214300600b00462547286d6mr35739826qvb.43.1654094142180;
        Wed, 01 Jun 2022 07:35:42 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a205b00b0069fc13ce235sm1276028qka.102.2022.06.01.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:35:41 -0700 (PDT)
Date:   Wed, 1 Jun 2022 10:35:38 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coda: remove unused variable
Message-ID: <20220601143538.e232rih7wndlofd7@cs.cmu.edu>
References: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654070283-7216-1-git-send-email-baihaowen@meizu.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but I cannot ack this patch.

Clearly there is a lack of clarity in this particular bit of code
because this suggestion seems to reappear every few years,

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2269222.html

The insize variable is in fact used by the UPARG macro that follows, and
once this patch is applied you end up with an obvious compilation error.

Jan


On Wed, Jun 01, 2022 at 03:58:03PM +0800, Haowen Bai wrote:
> The variable insize is initialized but never used otherwise.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  fs/coda/upcall.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index 59f6cfd06f96..c214b424426d 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -477,10 +477,9 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
>  {
>          union inputArgs *inp;
>          union outputArgs *outp;  
> -	int insize, outsize, error;
> +	int outsize, error;
>  	int iocsize;
>  
> -	insize = VC_MAXMSGSIZE;
>  	UPARG(CODA_IOCTL);
>  
>          /* build packet for Venus */
> -- 
> 2.7.4
> 
> 
