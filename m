Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F559D030
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiHWEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiHWEnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:43:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCD27CCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5A3BB81AD8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E94C433D6;
        Tue, 23 Aug 2022 04:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661229825;
        bh=6Vyw8BYGrG+iktjczxYnN1/G60ET433IyUoR2MBCNBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNTsxqll+R6yY0S7tCQr/Kxqed6UWnDJYVfhVvDbsX0yMoiH6ah7df0wllncVZ4eg
         ctarixg+tZLp8nb1mDi5IMHzVD+YTIqoB5kR/JDDoISMxOlRTbv7TTAvpzEUImWoao
         OlsBU46G9tgQ6ioGloRAl8wQVIaIT8XFo8l/Y/Vnn4WtJMnv7M/aRMhxaoUIQn6udn
         hg4h9pQOZJDWBoJsfeQtUw6PD8tt6I4AV9rC+ARZ4YNxKaU/fsr6bjVtaSBS3LXbbo
         bVJDaacXqxEOOSUd5LzJz9x9NmOrGpXX5qXZmwWa2BzWQ4t4ohFTFCj9Jrd+dMVw6N
         Jtf7V+DqwggOA==
Date:   Tue, 23 Aug 2022 04:43:41 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Stash port driver
 info
Message-ID: <YwRa/QxA/RRtxU3P@google.com>
References: <20220819190807.1275937-1-pmalani@chromium.org>
 <20220819190807.1275937-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819190807.1275937-4-pmalani@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 07:08:04PM +0000, Prashant Malani wrote:
> Stash port number and a pointer to the driver-specific struct in the
> local Type-C port struct.
> 
> These can be useful to the port driver to figure out how to communicate
> with the ChromeOS EC when an altmode driver related callback is invoked
> from the Type-C class code.

The patch looks good to me.  But I would suggest to send it in later series
that uses the driver-specific struct (e.g. in altmode driver related callbacks)
to make the usage clear.
