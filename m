Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932155467A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiFJNtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiFJNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE583701D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6D961BEA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29442C34114;
        Fri, 10 Jun 2022 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654868970;
        bh=wHtwYyPgUt58voO96nG2HAAXty3aJt4cYSYt0GOwafM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eyM6Paq16QKPgUOWyYbTUZ+KqNoUVYGvu+SlhWQv2or1Y7KPknO6GlcWIaRRiKuCV
         J6jFeXekb6YMPPJTnItWniuiOZhjd4hdIBjJ52mJzWpDLHETzNuSnGa9+CChUkjsbr
         geYrqQtK7DLdxXrDcI53HQ8fh3T7ZW3hRF24iKk4=
Date:   Fri, 10 Jun 2022 15:49:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] driver core: fix deadlock in __driver_attach
Message-ID: <YqNL6NPgP+cLOy/I@kroah.com>
References: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608094355.3298420-1-zhangwensheng5@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:43:55PM +0800, Zhang Wensheng wrote:
> In __driver_attach function, There are also potential AA deadlock
> problem, like the commit b232b02bf3c2 ("driver core: fix deadlock
> in __device_attach").

Potential, but real?

And the codepaths for drivers being added is much different than
devices, please provide the full information like you did in the other
commit.

Also, have you triggered this problem successfully and proven that this
change fixes the issue?

thanks,

greg k-h
