Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2194AB5F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiBGHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiBGHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:31:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23672C043181;
        Sun,  6 Feb 2022 23:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD93060F5F;
        Mon,  7 Feb 2022 07:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B610C340ED;
        Mon,  7 Feb 2022 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644219106;
        bh=044XCOe3oWa3p3fqjeFMcPejFZFulHMKIhQv9WXNbEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIzrO78BKHLEb6vhLF5dCZYxetAHA9QVISpz0SdlaDDKGQBnAHdPKQ/4GUk/jYMhv
         Be03jEb7+xbWDa9stQxIuvVuMnPs2ywalckeme1vInjFU+9cZbhEi2vVaqM5tZ/vVE
         /LKwfMhFZoxc5+c4FIusLV08PtKwOO/viLMcpYPU=
Date:   Mon, 7 Feb 2022 08:31:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 2/2] usb: typec: tcpm: Enable limit_src_current_set
 callback
Message-ID: <YgDK3VtDKlgKh9XQ@kroah.com>
References: <20220207043907.2758424-1-badhri@google.com>
 <20220207043907.2758424-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207043907.2758424-2-badhri@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:39:07PM -0800, Badhri Jagan Sridharan wrote:
> This change allows TCPM to support limit_src_current_set
> callback. When limit_src_current_set is enabled, tcpm
> updates the local source capabilities to only publish
> vSafe5V fixed pdo with the current limit passed through
> limit_src_current_set callback. When limit_src_current_set
> is disabled, tcpm revert back to publishing the default
> source caps.
> 
> This patch is co-authored with kyletso@google.com and
> also uses some of parts of the code that was reverted
> by c17c7cf147ac56312156eaaaf8b2e19c9a59a71a.

Please use the standard format for commits as described in the
documentation.

thanks,

greg k-h
