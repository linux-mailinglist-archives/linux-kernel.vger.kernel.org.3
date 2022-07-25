Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2757FB94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiGYImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiGYImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:42:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0747A454
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 833B9B80DDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1302C341C6;
        Mon, 25 Jul 2022 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658738560;
        bh=d49xwXBPs8TT9cthWSGkVdlc6drKCSOxy13qF8fQ+3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzCf6QbDsJ53SG2VeL3jtiFHFp4XzSTyAS8xNhubTn16uD0YGSthsPBXEN7Bep9jI
         EfijAk/Ao65fxXqklpicbh/A/nEf59Bf/tMv0GOb5LticTWbgom5hvSbOC7zlyvR7g
         lCOmptOmJsWfQYuwsRbLEUvAFohMtCqmb5/Ge0QE=
Date:   Mon, 25 Jul 2022 10:42:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Yu <renyu@nfschina.com>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
Subject: Re: [PATCH 3/3] lkdtm/heap: Check possible NULL pointer returned by
 vzalloc()
Message-ID: <Yt5Xe4iZeH3/uTW4@kroah.com>
References: <20220725081331.21014-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725081331.21014-1-renyu@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:13:31PM +0800, Ren Yu wrote:
> As the possible alloc failure of the vzalloc(),the
> return pointer could be NULL.therefore it should be better to check it.

Odd punctuation and wrapping :(

greg k-h
