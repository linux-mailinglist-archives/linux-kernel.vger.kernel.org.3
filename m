Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF84BB6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiBRKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:31:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiBRKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:31:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772F2B3562;
        Fri, 18 Feb 2022 02:30:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 5FE561F466E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645180241;
        bh=H7kO/4vrxYAqqmrH76Tul3nNx3Ly6WDoH9V/Wue96Dw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KdKNRkHDbRgYP1kAyhlwzlddsCTHjSMoJIFdixYjW/bTkkXzbTPe4x8tZxQSnWp+n
         mBWQHwGgtM5U+5etj1z0hir0ldgWRuQL8sslLNUKLvuYZA/z2u5DcJdi5pqeAaGF/8
         yBgPF+2AjAeFvyci+kKTPQP8lnJOroZD9KJZq97DJjwhy49IjhzoxXIU5GkPKPnH6S
         Wyd9XLKyJ5oJRzbwhzVnEMY4PtRjYWKMj9o17/XM3yxgcNzA5O9FozAkhMExb/wnme
         xnBw2bl3C1E5Oa+7vX9GrnEFSQsyvyggbxU027AJiIqZONZPGtIoTu6UfOf+DmqSmn
         jlCR15BW9O5Xw==
Message-ID: <762faf1b-0443-5ddf-4430-44a20cf2ec4d@collabora.com>
Date:   Fri, 18 Feb 2022 15:30:35 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lkdtm/usercopy: Expand size of "out of frame" object
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
References: <20220216201743.2088344-1-keescook@chromium.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220216201743.2088344-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/22 1:17 AM, Kees Cook wrote:
> To be sufficient out of range for the usercopy test to see the lifetime
> mismatch, expand the size of the "bad" buffer, which will let it be
> beyond current_stack_pointer regardless of stack growth direction.
> Paired with the recent addition of stack depth checking under
> CONFIG_HARDENED_USERCOPY=y, this will correctly start tripping again.
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
