Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46264B557F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbiBNQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:01:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiBNQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:01:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375FB7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69AAFB811AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD8BC340E9;
        Mon, 14 Feb 2022 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644854477;
        bh=Auo7Cg0RrboQ/3ilj3zVSYW9FJo29/Mr7GjZm7lSSCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyChHdScdrPE7fAmHjd9XY1pjbFj9WwmfeCtAYL2KgVwGPi4Bd9TiFqn+rI07Ks/3
         rnMT0hCSOJhZy8JyyEDyBYfXAyIjoNUukN8bNVnOik91X9AekuXQ4MDNwx7eHaOebX
         U2A/ko7JGYqLfzutBfMf8i7PfYo+PHiot3n92Nh0=
Date:   Mon, 14 Feb 2022 17:01:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     longman@redhat.com, dave@stgolabs.net, hdanton@sina.com,
        linux-kernel@vger.kernel.org, mazhenhua@xiaomi.com,
        mingo@redhat.com, peterz@infradead.org, quic_aiquny@quicinc.com,
        will@kernel.org
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <Ygp8yl0LA4K5+JlT@kroah.com>
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214154741.12399-1-chenguanyou@xiaomi.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:47:41PM +0800, chenguanyou wrote:
> Hi Waiman, Greg,
> This patch has been merged in branch linux-5.16.y.
> Can we take it to the linux-5.10.y LTS version?

What is "this patch"?

To have patches applied to the stable kernel tree, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h
