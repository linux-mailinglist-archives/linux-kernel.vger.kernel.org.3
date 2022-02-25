Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975374C4332
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiBYLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiBYLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:19:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23C21DF18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A69B82EFF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA52C340E7;
        Fri, 25 Feb 2022 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645787916;
        bh=yGeADlUf/GwnDwnfss5U4rjOm/5Hw8ZtdbZUbqTQpnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGIWT/DHEoml6mKCTCZzR6j27N5fNRlzG6C4PnE/pSYlzXQWrtzg8b9ZjnxaPM7ph
         pkkOmJCODZ/9F/fRAqQ+VbltVtbYPp+LlSFJFPlJYDbjWsbQlnRLu/sRstMhiChWIt
         kZ8+4pFBwoasqOao2dCaOKb9oZK2bXWbAhjRMziU=
Date:   Fri, 25 Feb 2022 12:18:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nvmem: patches (set 2) for 5.18
Message-ID: <Yhi7CYxCyZdf8jct@kroah.com>
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
 <35d2d1b2-07b1-ba54-c804-9622a0f94d4c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d2d1b2-07b1-ba54-c804-9622a0f94d4c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:52:59AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> On 23/02/2022 22:34, Srinivas Kandagatla wrote:
> > Hi Greg,
> > 
> > Here is final set of nvmem patches for 5.18 which includes
> > 
> > - Add new Sunplus nvmem provider and bindings.
> > - fix in qfprom to increase blow timeout.
> > 
> > Can you please queue them up for 5.18.
> > 
> > thanks for you help,
> > srini
> > 
> > Knox Chiou (1):
> >    nvmem: qfprom: Increase fuse blow timeout to prevent write fail
> > 
> > Vincent Shih (2):
> >    nvmem: Add driver for OCOTP in Sunplus SP7021
> >    dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
> 
> Sorry for inconvenience, but can you please ignore this set if you have not
> already applied them.

I already applied them :(

> There seems to be a issue with yaml file which fails dt-bindings check and
> there are few more patches that can go for 5.18.
> 
> I will a send new set soon.

Send a fixup patch?

thanks,

greg k-h
