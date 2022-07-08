Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4E56BB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiGHNxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbiGHNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023A2C1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC11260B63
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD34FC341C0;
        Fri,  8 Jul 2022 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657288405;
        bh=3LA0Rgq1HsUpGHRfvLb3NyoQ/vc9lNU/5cei4B9c+OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcFuxaVbnWOgUPqHHSoFJrBAQFydMOGm69Dy4o0T7t94t1FvkO3fps5Qj3Nmlm8sZ
         zcjiWyOtPjW5Mweruur0WzwRU64J69ArXAQ8FJGyQO3zRdHs5N+JpS/4Oxt/uTfP8K
         zVkpXcYs0x3k4DI4ymSSzOi9o4PfQ82SYGBf/YWw=
Date:   Fri, 8 Jul 2022 15:53:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: PROBLEM: dmesg tracedumps on rtsx_usb module loading during boot
Message-ID: <Ysg20t2t/S11idyx@kroah.com>
References: <20220708134942.r3nhwzgh4nchaebi@artix.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708134942.r3nhwzgh4nchaebi@artix.localdomain>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 03:49:42PM +0200, Aleksa Vučković wrote:
> [1.] One line summary of the problem:
> dmesg tracedumps on rtsx_usb module loading during boot

This should be fixed in linux-next now, right?

Shuah (on cc:) send in some commits to resolve this, look at this
thread:
	https://lore.kernel.org/all/cover.1656642167.git.skhan@linuxfoundation.org/

If you could test those 2 patches, that would be great.

thanks,

greg k-h
