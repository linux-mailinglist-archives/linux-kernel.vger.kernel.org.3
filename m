Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF54AD642
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiBHLXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355586AbiBHJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:46:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B06C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F44B81990
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86753C004E1;
        Tue,  8 Feb 2022 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644313608;
        bh=8UbAjj/H6avAWOylioig6EnD0MGcFmQgIPkZQYteBMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL4mPYiCgOPwGpLfECYMdrXx3UnBrMG1x8wFtDUHy63Yp9jTV2gbwD65NwdCBr+LQ
         yDQuC8cCfuCJtkdD1Dehs3YIBY8/jAa4RrVpIyyA/S3OQf3zj1e8gjf86MmYGwHXtu
         gn/ibnf871eQ+VlCXDQLN1HXJ1z5Fhb5yxcdFvDU=
Date:   Tue, 8 Feb 2022 10:46:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, insop.song@gainspeed.com,
        devel@driverdev.osuosl.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] staging: drop fpgaboot driver
Message-ID: <YgI8BQlUa671AvkY@kroah.com>
References: <Yf025dphJw2rUVR5@kroah.com>
 <20220204190847.3809405-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204190847.3809405-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:08:35AM -0800, Tong Zhang wrote:
> The gs_fpgaboot driver is totally broken since 2014 and no one even
> noticed the driver is not probing. Given the quality of the driver
> and its current state it makes sense to drop it.
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Thanks, now dropped!

