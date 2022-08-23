Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077AF59D133
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiHWGU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiHWGU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:20:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBE0491D7;
        Mon, 22 Aug 2022 23:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AD5B816BF;
        Tue, 23 Aug 2022 06:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456F7C433C1;
        Tue, 23 Aug 2022 06:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661235653;
        bh=K4n5U8Ku8HdJgTN/+cafpwXcsbx9WYqlkA5qGQNUk8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2dMCy9BuMRVGC0u33aaAWpR5K5P0p0w5LGsJJeRosSl1qNC2lptfFKn53Wymdn1F
         OL8EvLmh9uwAyro8Of1ZS1GmLCfh8Osg2eRzSZvZHYVWYE66iHk5Qbzok05bl/c1XO
         3RXd4n3PJe1/P2CXdnD58eB97D4/bxDkwDgqhwbE=
Date:   Tue, 23 Aug 2022 08:20:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lily <floridsleeves@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH v1] drivers/tty/serial: check the return value of
 uart_port_check()
Message-ID: <YwRxwr2J9ba/Agio@kroah.com>
References: <20220823055739.1451419-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823055739.1451419-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:57:39PM -0700, lily wrote:
> uart_port_check() can return NULL pointer.

It can?  How will that happen?

> Check its return value
> before dereference it.

How do you trigger this issue, and how was this change you made tested?

thanks,

greg k-h
