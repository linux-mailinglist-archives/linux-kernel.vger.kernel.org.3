Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F750E1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiDYNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiDYNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:38:31 -0400
X-Greylist: delayed 4063 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 06:35:26 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E58F3BF48;
        Mon, 25 Apr 2022 06:35:25 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id D9F421401A7;
        Mon, 25 Apr 2022 13:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1650893725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlwvbe+Z2OQ/7mh2RTFrn+ryjaf4NWqAjeVDFWGwoXU=;
        b=hQErJoU0gKx6hFJvdwE4BElpEDlyNYSM+UeLDgCY/k4DNgCiu7qe8HAfexH0BvxBQZj/y5
        YZhSlZsqNGibx158AY9S5xL4wdCL+UUmP5YAIpzT/rryn1GCXe4ZEiFiIqeS/jt5cA5cUs
        eVfyrv0lhFay7PgQ3olX8yDg0GZ1k6w=
Message-ID: <dbc168d8-5f37-7f75-16d0-18f3b8df4bd9@postmarketos.org>
Date:   Mon, 25 Apr 2022 14:35:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: Fixes tags need some work in the pinctrl tree
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220421091055.12d6465c@canb.auug.org.au>
 <CACRpkdaD1G9J+jTJH4oGrcF_dinMjBjHCGMJqRZh8FC0dy+Xfw@mail.gmail.com>
 <bf90c37b-0184-845c-dd6a-c2f4a038b075@postmarketos.org>
 <CACRpkday2DXDNJJJ7srC5-Fj_d9iiqX-nqY9np1TnsBsOG6sCg@mail.gmail.com>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <CACRpkday2DXDNJJJ7srC5-Fj_d9iiqX-nqY9np1TnsBsOG6sCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 14:33, Linus Walleij wrote:
> On Mon, Apr 25, 2022 at 2:27 PM Caleb Connolly <kc@postmarketos.org> wrote:
> 
>> The patch shouldn't be backported to stable as it will introduce a bug if ported
>> without the second patch (and as above, I don't think this series should be
>> backported at all). Could you let me know how to get this dropped from backporting?
> 
> If Greg or Sasha etc propose the patch for stable (which will not happen
> automatically unless you explicitly add Cc: stable@vger.kernel.org)
> they send out a proposal "I will add this patch to stable", with CC to the
> author, and then you can say you don't want it backported.
> 
> Many Fixes:-tagged patches do not get picked up for stable, it is not
> what the tag means, if you want things to be picked for stable, the
> rule is Cc: stable@, it's just that sometimes the stable maintainers
> (and an AI!) pick some Fixes: patches anyways.
Ah ok, that's a relief. Thanks for the explanation!
> 
> Yours,
> Linus Walleij
