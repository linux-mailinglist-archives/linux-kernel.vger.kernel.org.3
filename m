Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC25A30B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbiHZU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiHZU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F7AE1144;
        Fri, 26 Aug 2022 13:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54396B832A1;
        Fri, 26 Aug 2022 20:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AE8C433C1;
        Fri, 26 Aug 2022 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661547521;
        bh=kOT3h1fXn5VcvlbdUWZYyaMr2lhtbcir1WJpCLzv9bQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HccudtiEYwuEtln5AEZGpFzPWY52pCh72p5qw8fgDo6OyiFElG4CxtPbpwLp1P76u
         AzWmOMuq14UEEF5v9fVpUTIdGtd/O+HwATv4tsd4R7OjUiRLX9UXN1DWR2+WaKmbgL
         pv8vCx3NL3oHlq6kYEiasREI8Fg8618lI5kXozMZxq+JdCilfHEW0m1M6NF87Aw5Qk
         u1VhxS0U5VnNnPh5qNTIa+XtW7RmaSP6NyQsM6/dz3PbFC6NXsfUE+bK7PQhafFmqF
         MpQKmmw4rRrBzx9nncvlSmujMI6XLAfq5QiLIxqkFEQU1vGvpIlqXErnjTwLli6QOL
         mlsen36sbZpbQ==
Date:   Fri, 26 Aug 2022 13:58:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     sfr@canb.auug.org.au, bagasdotme@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
Message-ID: <20220826135839.39c7711f@kernel.org>
In-Reply-To: <20220826160150.834639-1-imagedong@tencent.com>
References: <20220826160150.834639-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 00:01:50 +0800 menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Stephen Rothwell reported htmldocs warning when merging net-next:
> 
> Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
> Invalid C declaration: Expecting "(" in parameters. [error at 19]
>   void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
>   -------------------^
> 
> Add __fix_address keyword to c_id_attributes array in conf.py to fix
> the warning.

You'll need to CC netdev@ for the patch to get into the net-next tree.
Since this is a pure Documentation/ patch get_maintainer.pl did not
produce netdev@ in the recommended addresses.

Please wait for a review/ack from Jon before reposting, we need his
permission to apply this patch.
