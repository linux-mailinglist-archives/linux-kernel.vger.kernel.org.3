Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4B58F7D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiHKGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiHKGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:45:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65A219F;
        Wed, 10 Aug 2022 23:45:15 -0700 (PDT)
Received: from [192.168.231.132] (unknown [213.194.152.135])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52AE666015AC;
        Thu, 11 Aug 2022 07:45:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660200312;
        bh=jM6AiP2SN47ZqYg/7BuDiQQKFZaEHE0h63tXokKQuHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kNKYuG55u1269ihCw3pSztKie6FDmdvVsodjgOk8akrfIDeRP5Lcgh+1kDFB5k7hs
         tlx8XCHR1TePfCmMPvPQ7u4VieqJVTNA5BAKdZ1Q/1INZGOaoe9i1JUr9RbCsRl16x
         FqX7neFIvt9CN/BCxU3IaUc4Frog6EZDgjT77DhnWns5fqC9q5Mh27fFUYV7uUMLdM
         pZXhSEvPVc6DmftqPxk1FDpep9WreRe37XsjKnmlyY1hecZHUjmKWddtZXbTpk2UKV
         JADIHc/RydY9pSMIB6HvSorzmWaLvpgGCPddQ1KUd7niiMfr2IfIQ4ww0HeR8kkod8
         yEQvfYu1ctPMg==
Message-ID: <d74f15ba-8b76-3a76-a1f5-10855bf459b0@collabora.com>
Date:   Thu, 11 Aug 2022 08:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: build warning after merge of the vhost tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220811115917.1b5c9a57@canb.auug.org.au>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <20220811115917.1b5c9a57@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Michael,

On 11/8/22 3:59, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/driver-api/index.rst:14: WARNING: toctree contains reference to nonexisting document 'driver-api/virtio/index'
> 
> Introduced by commit
> 
>    6355eeb59129 ("docs: driver-api: virtio: virtio on Linux")
> 

The patch that ended up in the vhost tree is only a part of the
complete patch:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=6355eeb59129a31aed0adb60d174df63a5630f8e

The full patch is this:
https://lore.kernel.org/linux-doc/20220810094004.1250-1-ricardo.canuelo@collabora.com/T/#t

Cheers,
Ricardo
