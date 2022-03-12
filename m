Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747414D6D22
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiCLHBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiCLHBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C02FFF0;
        Fri, 11 Mar 2022 23:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5477060BAC;
        Sat, 12 Mar 2022 07:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B385C340EB;
        Sat, 12 Mar 2022 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647068406;
        bh=4uN+7f/qFhBahHeSyeOv6MveYXUDbTPad9CTKrm+XcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgRO9gGr+fz1ZKDe3NhHNmISgHyEOCV926uyxreZcR3JCFpoRIGESE/QvBZYCjJ1D
         c68Z3a88ZQh2H9HKc58eFiCSQd8GDGBVrxh04FgmMxRj7ump7EZmiyF7hCS0sJYf8e
         FMTZJ4sXsR3RY/cNX/EIeFhD76/CQnOJNHb6O1s0=
Date:   Sat, 12 Mar 2022 07:59:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@qq.com
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
Message-ID: <YixE4K3ScGL3v5yQ@kroah.com>
References: <20220304100315.6732-1-wanjiabing@vivo.com>
 <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
 <87mthw2o93.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mthw2o93.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:06:00PM -0700, Jonathan Corbet wrote:
> Jiri Slaby <jirislaby@kernel.org> writes:
> 
> > On 04. 03. 22, 11:03, Wan Jiabing wrote:
> >> Fix the following 'make refcheckdocs' warning:
> >> Warning: Documentation/driver-api/serial/driver.rst references a file
> >> that doesn't exist: Documentation/driver-api/serial/tty.rst
> >> 
> >> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> >
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> I've applied this.  But I have to wonder why Documentation/tty exists at
> all; is there any reason not to move it all under driver-api?

No reason at all, it should probably be moved someday.

thanks,

greg k-h
