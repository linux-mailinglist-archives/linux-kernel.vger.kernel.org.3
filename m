Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E24EC862
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiC3Pj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348276AbiC3PjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBED5BE73
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01CD616F5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE2C340EE;
        Wed, 30 Mar 2022 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648654657;
        bh=RvGSrHfLJfpTbs3Ho41Zt/SklOEmkN76AbpAlx2jjQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNHPNkCK84WCxlQWy1aWbD86y++YAuEhpkE1Kwi/lOAGKFchd2S7CQ8saRjgdh8AB
         x2Ygsqu51iPrAOa2kWb9eM0hqmlGtOBKNJDv2ImlDuKYBx449Z0xWetqUjkcaC60VE
         ygoOpuE3HiiaOGUjoeQlU02XEJx2maY1rSAF1p6o=
Date:   Wed, 30 Mar 2022 17:37:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZC05L+K5paH?= <wudaemon@163.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] char: misc:use DEFINE_PROC_SHOW_ATTRIBUTE micro
 to simplify misc proc_fops
Message-ID: <YkR5PkJq27NIdY52@kroah.com>
References: <20220327143254.226844-1-wudaemon@163.com>
 <YkFM2Ko21j8Ehca8@kroah.com>
 <4ac4969e.8288.17fdb6206ea.Coremail.wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ac4969e.8288.17fdb6206ea.Coremail.wudaemon@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:11:48PM +0800, 吴俊文 wrote:
> Dear Greg:
> It means I should list  the reason  why I ptach a new verson?like this:

I do not know what you are referring to, sorry.  Also, html email is
rejected by the mailing list and out tools, please fix.

thanks,

greg k-h
