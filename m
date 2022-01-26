Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D399E49C14B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiAZC0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiAZC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:26:05 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E897C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:26:05 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id f11-20020a4abb0b000000b002e9abf6bcbcso1910086oop.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4BdSQcYkI7Tg6m9Z/JRw5Xx2nGZP7Dqic5XeVsukdg=;
        b=J1FFAFb7vBaVzRQ23VWBQWxT47F+6OcV2pTl6aUARYldxGriME6fiNscI5fFMa28IN
         pyxFvIIToDnYSS+s78DW11HZxDxhkFLhHjM2JMFikfPlA2b12yLRFoSKIxQFqvhZ0vuw
         d+7D8xE78U4f7M9t85Jbe7MQR86VHvEEF0wZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4BdSQcYkI7Tg6m9Z/JRw5Xx2nGZP7Dqic5XeVsukdg=;
        b=SUAmkx25L0XNbeIN0cz/18ZavAhdlGRshEa0CccnEQCgJMO+Y6c0SfsNt4YQMCP1pV
         bOgUe0A5Qnck2nrQPx65B9WT1zV+BjhrbT9DnLGaKBX3sddx9zqZX2ILLwBncw6RuDQU
         oi3sm1U10naa4KzEQJxnF0VZVhXxUYtxSFIbCdWIqtzGM79dPZURyEZe/Id5RnK4XI4e
         WgN22qdcvkfrA3m1Q0SW8yZfXne51kWzs14a68ry6HaikU6ankhXK415Af7eA+SwAEkI
         ggw+1J9N/X659QNlBW9a8S/3PSZMnQFnWQj2k/rXAafbjlJY8rV8L9+NSwC3INhTF6g3
         UHgA==
X-Gm-Message-State: AOAM531rvW2W76OzL55F5AngWNNMQAlkVqtszd5S8BB1El0NpG4hi1Im
        Kicoi4776F2gzJsUShZ1JFzEZA==
X-Google-Smtp-Source: ABdhPJw+nrU/qkapwjf3gFM4N0QgVLATa/twB7tT6hkq5TfgdIPM2W6n+AGTrmA4cDAHBJ1mStiy/g==
X-Received: by 2002:a4a:dc16:: with SMTP id p22mr14546157oov.85.1643163964828;
        Tue, 25 Jan 2022 18:26:04 -0800 (PST)
Received: from fedora64.linuxtx.org (104-189-158-32.lightspeed.rcsntx.sbcglobal.net. [104.189.158.32])
        by smtp.gmail.com with ESMTPSA id g4sm7544923otl.1.2022.01.25.18.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 18:26:04 -0800 (PST)
Date:   Tue, 25 Jan 2022 20:26:02 -0600
From:   Justin Forbes <jmforbes@linuxtx.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.16 0000/1033] 5.16.3-rc2 review
Message-ID: <YfCxOpu4fTON5ded@fedora64.linuxtx.org>
References: <20220125155447.179130255@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125155447.179130255@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 05:33:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.16.3 release.
> There are 1033 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jan 2022 15:52:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.16.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Tested rc2 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
