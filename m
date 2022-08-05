Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFED58A542
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 06:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiHEEVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 00:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHEEVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 00:21:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7C205D9;
        Thu,  4 Aug 2022 21:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DA9B827D4;
        Fri,  5 Aug 2022 04:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC41C433C1;
        Fri,  5 Aug 2022 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659673271;
        bh=IDgm74XCW7agRV4h7Bb9bHSULjnnigmzvUl77NFsex0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1f9V8o3YN+FSl4bBIRRaGIzHK2FgQM1wVUxuVHv55kbRPpKqRO6umsEqs+IG0d5S
         VrwOPbcz+N/a1l9Abhz2kfJEetOeYRr5Q8xbHAZes6I2ZZgya3rU68zqx+GVKHU9VC
         akRg7br92/QVoDH9nv9DXOGMehUhd1d51+z34RPI=
Date:   Fri, 5 Aug 2022 06:21:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mazin Al Haddad <mazinalhaddad05@gmail.com>
Cc:     linux-media@vger.kernel.org,
        syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com,
        mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: dvb-usb: fix memory leak in
 dvb_usb_adapter_init()
Message-ID: <YuyasvdntQp4mEt1@kroah.com>
References: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
 <CLXMEQRZRKJH.196H3FP8VFR8B@Arch-Desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CLXMEQRZRKJH.196H3FP8VFR8B@Arch-Desktop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:07:51AM +0300, Mazin Al Haddad wrote:
> Hi, did anyone have the opportunity to review this?

What is "this"?  There is no context here.

Also please realize this is the middle of the merge window, maintainers
can not accept anything until after -rc1 is out.  Normally you should
wait at least 2 weeks before resubmitting if you have not gotten a
response, but during the merge window, you should wait a bit longer.

thanks,

greg k-h
