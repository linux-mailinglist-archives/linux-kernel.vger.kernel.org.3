Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585F53F31F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiFGAzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiFGAzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86362BF8A7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FD7D60ECA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DC2C34119;
        Tue,  7 Jun 2022 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563336;
        bh=NRUQsLYrMXbJ6K3FojmmsbXnxoKX1prtQJUYfKxhNn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUHsfyWZoPGYX7H0pjNAAxuTQ15yAph7bjwH6LWHAGSfkxt4pLBmyER7sacp4Vzsm
         mpoJKT+MZIcRPlpoQpDdFRJ0jxY33LUqu8+QXI6PFTDBQcbczFx/32JaE8qbB7XoxN
         5e9m54B1CEp7rCyrBbm3dc/AUpOyc5luxbosFOy2ZZy7t83LmmUm/pcRu0i2K35iyY
         /eTegYRJ7jRg8jY4vS387Lzp8LaiQJ8KZ1h2EQ598YkqkVc+8fHMl0pXKoIb5X+ACo
         RY37XjgRaZDJqZhLpdzZ+poFwTxpNKOuLRaL/pLcuGTsA0OHh+hXMntz1jDVdY+9Ox
         bMKI3Hp4KvJEQ==
Date:   Tue, 7 Jun 2022 00:55:33 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] platform/chrome: cros_ec_proto: arrange
 get_host_command_version_mask()
Message-ID: <Yp6iBStcJCOwqjiT@google.com>
References: <20220606141051.285823-1-tzungbi@kernel.org>
 <20220606141051.285823-11-tzungbi@kernel.org>
 <CABXOdTdPwvcS2eSrXsT8dNd1XnGNugD6ub-x2qscT8YRwwK0SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTdPwvcS2eSrXsT8dNd1XnGNugD6ub-x2qscT8YRwwK0SQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:09:25AM -0700, Guenter Roeck wrote:
> On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > - cros_ec_get_host_command_version_mask() is a private (static) function.
> >   Rename it to get_host_command_version_mask().
> 
> Personally I prefer to still have prefixes, even for static functions.
> If the idea is to have a shorter function name, maybe shorten the rest
> of the function name a bit.

Ack, will fix in next version.
